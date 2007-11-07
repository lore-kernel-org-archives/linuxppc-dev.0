Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id E8479DDDF6
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 15:45:12 +1100 (EST)
Date: Tue, 6 Nov 2007 22:54:31 -0600
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Remove sysctl warning about writable directory
Message-ID: <20071107045431.GA24266@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Getting this when booting 2.6.24-rc2:

sysctl table check failed: /kernel .1 Writable sysctl directory
Call Trace:
[c000000002047b60] [c00000000000e204] .show_stack+0x54/0x1f0 (unreliable)
[c000000002047c10] [c00000000006ea50] .set_fail+0x60/0x90
[c000000002047ca0] [c00000000006ef64] .sysctl_check_table+0x4e4/0x730
[c000000002047d80] [c000000000055860] .register_sysctl_table+0x80/0x120
[c000000002047e20] [c0000000005de924] .register_powersave_nap_sysctl+0x14/0x30
[c000000002047e90] [c0000000005d58c8] .kernel_init+0x1f8/0x450
[c000000002047f90] [c000000000023bac] .kernel_thread+0x4c/0x68


Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/arch/powerpc/kernel/idle.c b/arch/powerpc/kernel/idle.c
index abd2957..c3cf0e8 100644
--- a/arch/powerpc/kernel/idle.c
+++ b/arch/powerpc/kernel/idle.c
@@ -122,7 +122,7 @@ static ctl_table powersave_nap_sysctl_root[] = {
 	{
 		.ctl_name	= CTL_KERN,
 		.procname	= "kernel",
-		.mode		= 0755,
+		.mode		= 0555,
 		.child		= powersave_nap_ctl_table,
 	},
 	{}
