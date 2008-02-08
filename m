Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound4-wa4-R.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 00B09DDEBF
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Feb 2008 09:54:23 +1100 (EST)
Message-ID: <47ACDD47.7080805@am.sony.com>
Date: Fri, 08 Feb 2008 14:52:55 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 4/6] PS3: Use system reboot on restart
References: <20080208224723.029462363@am.sony.com>
In-Reply-To: <20080208224723.029462363@am.sony.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The PS3 Other OS boot flag is not checked when an LPAR reboot is done,
so the ps3-boot-game-os utility fails to reboot the system into the
Game OS.  This fix changes the PS3 restart handler from requesting an
PS3_SM_NEXT_OP_LPAR_REBOOT to requesting an PS3_SM_NEXT_OP_SYS_REBOOT.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 drivers/ps3/ps3-sys-manager.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/ps3/ps3-sys-manager.c
+++ b/drivers/ps3/ps3-sys-manager.c
@@ -622,7 +622,7 @@ static void ps3_sys_manager_final_restar
 	ps3_vuart_cancel_async(dev);
 
 	ps3_sys_manager_send_attr(dev, 0);
-	ps3_sys_manager_send_next_op(dev, PS3_SM_NEXT_OP_LPAR_REBOOT,
+	ps3_sys_manager_send_next_op(dev, PS3_SM_NEXT_OP_SYS_REBOOT,
 		PS3_SM_WAKE_DEFAULT);
 	ps3_sys_manager_send_request_shutdown(dev);
 

-- 
