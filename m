Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40ZSKx5TMxzF2QH
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 May 2018 00:56:37 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id a11so6921214pfn.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2018 07:56:37 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 07/15] powerpc/powernv: move opal console flushing to udbg
Date: Tue,  1 May 2018 00:55:50 +1000
Message-Id: <20180430145558.4308-8-npiggin@gmail.com>
In-Reply-To: <20180430145558.4308-1-npiggin@gmail.com>
References: <20180430145558.4308-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

OPAL console writes do not have to synchronously flush firmware /
hardware buffers unless they are going through the udbg path.

Remove the unconditional flushing from opal_put_chars. Flush if
there was no space in the buffer as an optimisation (callers loop
waiting for success in that case). udbg flushing is moved to
udbg_opal_putc.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/platforms/powernv/opal.c | 12 +++++++-----
 drivers/tty/hvc/hvc_opal.c            |  5 +++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 0ddb63226695..55d4b1983110 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -400,12 +400,14 @@ int opal_put_chars(uint32_t vtermno, const char *data, int total_len)
 out:
 	spin_unlock_irqrestore(&opal_write_lock, flags);
 
-	/* This is a bit nasty but we need that for the console to
-	 * flush when there aren't any interrupts. We will clean
-	 * things a bit later to limit that to synchronous path
-	 * such as the kernel console and xmon/udbg
+	/* In the -EAGAIN case, callers loop, so we have to flush the console
+	 * here in case they have interrupts off (and we don't want to wait
+	 * for async flushing if we can make immediate progress here). If
+	 * necessary the API could be made entirely non-flushing if the
+	 * callers had a ->flush API to use.
 	 */
-	opal_flush_console(vtermno);
+	if (written == -EAGAIN)
+		opal_flush_console(vtermno);
 
 	return written;
 }
diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
index 2ed07ca6389e..af122ad7f06d 100644
--- a/drivers/tty/hvc/hvc_opal.c
+++ b/drivers/tty/hvc/hvc_opal.c
@@ -275,6 +275,11 @@ static void udbg_opal_putc(char c)
 			count = hvc_opal_hvsi_put_chars(termno, &c, 1);
 			break;
 		}
+
+		/* This is needed for the cosole to flush
+		 * when there aren't any interrupts.
+		 */
+		opal_flush_console(termno);
 	} while(count == 0 || count == -EAGAIN);
 }
 
-- 
2.17.0
