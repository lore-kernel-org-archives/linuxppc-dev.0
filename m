Return-Path: <cmetcalf@ezchip.com>
Received: from emea01-am1-obe.outbound.protection.outlook.com
 (mail-am1on0096.outbound.protection.outlook.com [157.56.112.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CD91A1A066A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 May 2015 03:27:11 +1000 (AEST)
From: Chris Metcalf <cmetcalf@ezchip.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jslaby@suse.cz>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH] drivers/tty/hvc/hvc_tile.c: properly return -EAGAIN
Date: Tue, 5 May 2015 13:11:28 -0400
Message-ID: <1430845888-22164-1-git-send-email-cmetcalf@ezchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Chris Metcalf <cmetcalf@ezchip.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We were returning zero if no bytes could be written to the Tilera
hypervisor console device, but this causes the output to be truncated.
By returning -EAGAIN the tty hvc driver will come back and try again,
which gives the semantics we want, and avoids dropping console output.

Signed-off-by: Chris Metcalf <cmetcalf@ezchip.com>
---
I have queued this in the tile tree as a tile-specific device, but
if someone would prefer to pick it up for a tty or tty/hvc tree,
that's fine too; just let me know.

 drivers/tty/hvc/hvc_tile.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/hvc/hvc_tile.c b/drivers/tty/hvc/hvc_tile.c
index 3f6cd3102db5..9da1e842bbe9 100644
--- a/drivers/tty/hvc/hvc_tile.c
+++ b/drivers/tty/hvc/hvc_tile.c
@@ -51,7 +51,8 @@ int tile_console_write(const char *buf, int count)
 			      _SIM_CONTROL_OPERATOR_BITS));
 		return 0;
 	} else {
-		return hv_console_write((HV_VirtAddr)buf, count);
+		/* Translate 0 bytes written to EAGAIN for hvc_console_print. */
+		return hv_console_write((HV_VirtAddr)buf, count) ?: -EAGAIN;
 	}
 }
 
-- 
2.1.2
