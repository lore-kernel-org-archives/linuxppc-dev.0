Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 7A80AB70A8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Nov 2010 18:30:40 +1100 (EST)
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net
	[192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id EC541180597F
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Nov 2010 08:30:36 +0100 (CET)
Received: from mail.denx.de (host-82-135-33-74.customer.m-online.net
	[82.135.33.74])
	by smtp-auth.mnet-online.de (Postfix) with ESMTPA id 0569F1C001BD
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Nov 2010 08:30:36 +0100 (CET)
Received: from pollux.denx.de (pollux [192.168.1.1])
	by mail.denx.de (Postfix) with ESMTP id DB6B540C32AF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Nov 2010 08:30:35 +0100 (CET)
From: Heiko Schocher <hs@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc, time: printk time stamp init not correct
Date: Tue, 23 Nov 2010 08:30:33 +0100
Message-Id: <1290497433-20058-1-git-send-email-hs@denx.de>
Cc: Heiko Schocher <hs@denx.de>, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

problem:

I see sometimes on my mpc5200 based board such printk timing
information:

[    0.000000] NR_IRQS:512 nr_irqs:512 16
[    0.000000] MPC52xx PIC is up and running!
[    0.000000] clocksource: timebase mult[79364d9] shift[22] registered
[    0.000000] console [ttyPSC0] enabled
[  130.300633] pid_max: default: 32768 minimum: 301
[  130.305647] Mount-cache hash table entries: 512
[  130.315818] NET: Registered protocol family 16

reason:
if the tbu not starts from 0 when linux boots, boot_tb
maybe could not store the real 64 bit tbu value, because
boot_tp is only a 32 bit unsigned long.

solution:
change boot_tb to unsigned long long

Signed-off-by: Heiko Schocher <hs@denx.de>
cc: Wolfgang Denk <wd@denx.de>
---
 arch/powerpc/kernel/time.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index fa91732..a66df7d 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -155,7 +155,7 @@ EXPORT_SYMBOL_GPL(rtc_lock);
 
 static u64 tb_to_ns_scale __read_mostly;
 static unsigned tb_to_ns_shift __read_mostly;
-static unsigned long boot_tb __read_mostly;
+static unsigned long long boot_tb __read_mostly;
 
 extern struct timezone sys_tz;
 static long timezone_offset;
-- 
1.7.2.3
