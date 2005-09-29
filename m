Return-Path: <sun.zhitai@jp.fujitsu.com>
Received: from fgwmail8.fujitsu.co.jp (fgwmail8.fujitsu.co.jp [192.51.44.38])
	by ozlabs.org (Postfix) with ESMTP id 031D468412
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Sep 2005 12:33:07 +1000 (EST)
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
	by fgwmail8.fujitsu.co.jp (Fujitsu Gateway)
	id j8T27djc020297 for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Sep 2005 11:07:39 +0900
	(envelope-from sun.zhitai@jp.fujitsu.com)
Received: from m1.gw.fujitsu.co.jp ([10.0.50.71])
	by fgwmail6.fujitsu.co.jp (Fujitsu Gateway)
	id j8T27boj015127 for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Sep 2005 11:07:37 +0900
	(envelope-from sun.zhitai@jp.fujitsu.com)
Received: from s1.gw.fujitsu.co.jp by m1.gw.fujitsu.co.jp (8.12.10/Fujitsu
	Domain Master) id j8T27a4K007487 for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Sep 2005 11:07:36 +0900
	(envelope-from sun.zhitai@jp.fujitsu.com)
Received: from s1.gw.fujitsu.co.jp (s1 [127.0.0.1])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 6BBFB1780BB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Sep 2005 11:07:36 +0900 (JST)
Received: from fjm505.ms.jp.fujitsu.com (fjm505.ms.jp.fujitsu.com
	[10.56.99.83])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 1D20A17813D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Sep 2005 11:07:36 +0900 (JST)
Message-ID: <011901c5c49a$9aa01fc0$3f13180a@utsfd.cs.fujitsu.co.jp>
From: "sun" <sun.zhitai@jp.fujitsu.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Thu, 29 Sep 2005 11:07:54 +0900
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0116_01C5C4E6.0A5CE730"
Subject: fix-up GIANFAR driver timer bug
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_0116_01C5C4E6.0A5CE730
Content-Type: text/plain; format=flowed; charset="iso-2022-jp";
	reply-type=original
Content-Transfer-Encoding: 7bit

Repeat executing a command series like the attached descript will cause
system hanging or kernel panic shown below on a GIANFAR used system.
The attached patch is for fix the above issue.
The issue and the solution have been confirmed on
MPC8560ADS and MPC85555CDS evaluation boards.

----------
-sh-3.00# ./net_setting.sh
eth1 setting start
###set ip-address

###net Trying to free free IRQ103
down

###set MAC address

###net up
kernel BUG in cascade at kernel/timer.c:419!
Oops: Exception in kernel mode, sig: 5 [#1]
NIP: C0029090 LR: C00290A0 SP: CCD69B20 REGS: ccd69a70 TRAP: 0700    Not tainted
MSR: 00021000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
TASK = cde58080[170] 'ifconfig' THREAD: ccd68000
Last syscall: 54
GPR00: 00000001 CCD69B20 CDE58080 C0311DD4 C031269C FFFBD700 C0311F4C C0311E94
GPR08: FFFBD869 00003B60 00000169 00003B5F FFFBD700 1010A204 00000000 00000000
GPR16: 00000000 1001C094 00000000 00000000 C07D2400 FFFF8914 C03092C0 C0310000
GPR24: C0310000 C0310000 C0280000 C0311DD4 00000017 C0311DD4 C0312694 C031269C
NIP [c0029090] cascade+0x40/0x78
LR [c00290a0] cascade+0x50/0x78
Call trace:
 [c002923c] run_timer_softirq+0x174/0x1d8
 [c0024b4c] __do_softirq+0x80/0xf4
 [c0024c18] do_softirq+0x58/0x60
 [c0003930] timer_interrupt+0xa0/0x208
 [c0002598] ret_from_except+0x0/0x18
 [c001f694] release_console_sem+0xc4/0x234
 [c001f95c] vprintk+0x158/0x1c0
 [c001fa14] printk+0x50/0x60
 [c014d91c] get_phy_info+0xcc/0xe4
 [c014b30c] gfar_enet_open+0x2ec/0x390
 [c01a7630] dev_open+0xb0/0xd8
 [c01a8dc4] dev_change_flags+0x6c/0x144
 [c01e6eec] devinet_ioctl+0x618/0x764
 [c01e8250] inet_ioctl+0x10c/0x120
 [c019dbcc] sock_ioctl+0x1ac/0x288
Kernel panic - not syncing: Aiee, killing interrupt handler!
 <0>Rebooting in 1 seconds..U-Boot 1.1.2 (Aug 19 2005 - 09:55:23)

------=_NextPart_000_0116_01C5C4E6.0A5CE730
Content-Type: application/octet-stream;
	name="fixIFCONFIGpanic.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="fixIFCONFIGpanic.patch"

--- old_kernel/drivers/net/gianfar.c	2005-06-21 10:57:29.000000000 +0900=0A=
+++ new_kernel/drivers/net/gianfar.c	2005-09-26 17:05:46.116951768 +0900=0A=
@@ -541,6 +541,14 @@=0A=
 				MII_INTERRUPT_DISABLED);=0A=
 	}=0A=
 =0A=
+/* following 2 steps is a attempting to prevent system hanging/panic=0A=
+   when executing ifconfig command. by Sun Zhitai, Sep. 26 2005 */ =0A=
+=0A=
+	cancel_delayed_work(&priv->tq);=0A=
+	del_timer_sync(&priv->phy_info_timer);=0A=
+=0A=
+/* appended end */=0A=
+=0A=
 	spin_unlock_irqrestore(&priv->lock, flags);=0A=
 =0A=
 	/* Free the IRQs */=0A=
@@ -770,7 +778,7 @@=0A=
 	init_timer(&priv->phy_info_timer);=0A=
 	priv->phy_info_timer.function =3D &gfar_phy_startup_timer;=0A=
 	priv->phy_info_timer.data =3D (unsigned long) priv->mii_info;=0A=
-	mod_timer(&priv->phy_info_timer, jiffies + HZ);=0A=
+	__mod_timer(&priv->phy_info_timer, jiffies + HZ);=0A=
 =0A=
 	/* Configure the coalescing support */=0A=
 	if (priv->txcoalescing)=0A=
@@ -1500,7 +1508,7 @@=0A=
 =0A=
 	schedule_work(&priv->tq);=0A=
 =0A=
-	mod_timer(&priv->phy_info_timer, jiffies +=0A=
+	__mod_timer(&priv->phy_info_timer, jiffies +=0A=
 			GFAR_PHY_CHANGE_TIME * HZ);=0A=
 }=0A=
 =0A=
@@ -1523,7 +1531,7 @@=0A=
 	/* If autonegotiation failed to start, and=0A=
 	 * we haven't timed out, reset the timer, and return */=0A=
 	if (result && secondary--) {=0A=
-		mod_timer(&priv->phy_info_timer, jiffies + HZ);=0A=
+		__mod_timer(&priv->phy_info_timer, jiffies + HZ);=0A=
 		return;=0A=
 	} else if (result) {=0A=
 		/* Couldn't start autonegotiation.=0A=
@@ -1564,7 +1572,7 @@=0A=
 	init_timer(&priv->phy_info_timer);=0A=
 	priv->phy_info_timer.function =3D &gfar_phy_timer;=0A=
 	priv->phy_info_timer.data =3D (unsigned long) mii_info->dev;=0A=
-	mod_timer(&priv->phy_info_timer, jiffies +=0A=
+	__mod_timer(&priv->phy_info_timer, jiffies +=0A=
 			GFAR_PHY_CHANGE_TIME * HZ);=0A=
 }=0A=
 =0A=

------=_NextPart_000_0116_01C5C4E6.0A5CE730
Content-Type: application/octet-stream;
	name="net_setting.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="net_setting.sh"

#! /bin/sh
date
echo "eth1 setting start"
sl(){
        echo
}

echo "###set ip-address"
ifconfig eth1 192.168.0.37 netmask 255.255.255.0
sl
echo "###net down"
ifconfig eth1 down
sl

echo "###set MAC address"
ifconfig eth1 hw ether 00:e0:0c:00:01:fd
sl

echo "###net up"
ifconfig eth1 up
sl

------=_NextPart_000_0116_01C5C4E6.0A5CE730--
