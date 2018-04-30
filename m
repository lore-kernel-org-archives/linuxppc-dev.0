Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40ZSKk4BnQzF2QG
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 May 2018 00:56:26 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id c10so6919405pfi.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2018 07:56:26 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 04/15] powerpc/powernv: opal-kmsg use flush fallback from
 console code
Date: Tue,  1 May 2018 00:55:47 +1000
Message-Id: <20180430145558.4308-5-npiggin@gmail.com>
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

Use the more refined and tested event polling loop from opal_put_chars
as the fallback console flush in the opal-kmsg path. This loop is used
by the console driver today, whereas the opal-kmsg fallback is not
likely to have been used for years.

Use WARN_ONCE rather than a printk when the fallback is invoked to
prepare for moving the console flush into a common function.

Reviewed-by: Russell Currey <ruscur@russell.cc>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/platforms/powernv/opal-kmsg.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-kmsg.c b/arch/powerpc/platforms/powernv/opal-kmsg.c
index f8f41ccce75f..fd2bbf4fd6dc 100644
--- a/arch/powerpc/platforms/powernv/opal-kmsg.c
+++ b/arch/powerpc/platforms/powernv/opal-kmsg.c
@@ -51,20 +51,17 @@ static void force_opal_console_flush(struct kmsg_dumper *dumper,
 		} while (rc == OPAL_PARTIAL); /* More to flush */
 
 	} else {
-		int i;
+		__be64 evt;
 
+		WARN_ONCE(1, "opal: OPAL_CONSOLE_FLUSH missing.\n");
 		/*
 		 * If OPAL_CONSOLE_FLUSH is not implemented in the firmware,
 		 * the console can still be flushed by calling the polling
-		 * function enough times to flush the buffer.  We don't know
-		 * how much output still needs to be flushed, but we can be
-		 * generous since the kernel is in panic and doesn't need
-		 * to do much else.
+		 * function while it has OPAL_EVENT_CONSOLE_OUTPUT events.
 		 */
-		printk(KERN_NOTICE "opal: OPAL_CONSOLE_FLUSH missing.\n");
-		for (i = 0; i < 1024; i++) {
-			opal_poll_events(NULL);
-		}
+		do {
+			opal_poll_events(&evt);
+		} while (be64_to_cpu(evt) & OPAL_EVENT_CONSOLE_OUTPUT);
 	}
 }
 
-- 
2.17.0
