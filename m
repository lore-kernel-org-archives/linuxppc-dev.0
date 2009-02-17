Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 15313DDDA0
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2009 21:16:55 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n1HAGoUn021608
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2009 03:16:51 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n1HAGnMg012945
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2009 04:16:50 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Subject: RE: PROBLEM: incorrect interrupt ack lead to interrupt loss on
	freescale powerpc
Date: Tue, 17 Feb 2009 18:16:46 +0800
Message-ID: <3A45394FD742FA419B760BB8D398F9ED246D03@zch01exm26.fsl.freescale.net>
In-Reply-To: <D728AD1FA2543948B89DE29C5BF4CD0716A9ADD8@bjmail1.bj.datangmobile.com>
References: <D728AD1FA2543948B89DE29C5BF4CD0716A9ADD8@bjmail1.bj.datangmobile.com>
From: "Li Yang-R58472" <LeoLi@freescale.com>
To: <dayu@datangmobile.cn>, <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: dayu@datangmobile.cn [mailto:dayu@datangmobile.cn]=20
> Sent: Tuesday, February 17, 2009 4:34 PM
> To: linux-kernel@vger.kernel.org
> Cc: Li Yang-R58472
> Subject: PROBLEM: incorrect interrupt ack lead to interrupt=20
> loss on freescale powerpc
>=20
> =20
> [1.] One line summary of the problem: incorrect interrupt ack=20
>  lead to interrupt loss

Acked-by: Li Yang <leoli@freescale.com>

However, please resend the patch with a brief description and =
Signed-off-by at the top of the patch.  You can read the =
Documentation/SubmittiongPatches for more information, or even a Chinese =
version under Documentation/zh_CN/.

Here are some small comments about the patch itself,

--- a/arch/powerpc/sysdev/ipic.c	2009-02-17 15:10:18.000000000 +0800
+++ b/arch/powerpc/sysdev/ipic.c	2009-02-17 15:10:24.000000000 +0800
@@ -9,6 +9,7 @@
  * under  the terms of  the GNU General  Public License as published by =
the
  * Free Software Foundation;  either version 2 of the  License, or (at =
your
  * option) any later version.
+ * Da Yu <dayu@datangmobile.cn> fixed the interrupt loss problem on =
powerpc IPIC


It's not recommended to add changelog in the source now.  Please =
describe in the patch description area.

  */
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -561,8 +562,7 @@
=20
 	spin_lock_irqsave(&ipic_lock, flags);
=20
-	temp =3D ipic_read(ipic->regs, ipic_info[src].pend);
-	temp |=3D (1 << (31 - ipic_info[src].bit));
+	temp =3D (1 << (31 - ipic_info[src].bit));


Remove unneeded brackets.


 	ipic_write(ipic->regs, ipic_info[src].pend, temp);
=20
 	spin_unlock_irqrestore(&ipic_lock, flags);
@@ -581,8 +581,7 @@
 	temp &=3D ~(1 << (31 - ipic_info[src].bit));
 	ipic_write(ipic->regs, ipic_info[src].mask, temp);
=20
-	temp =3D ipic_read(ipic->regs, ipic_info[src].pend);
-	temp |=3D (1 << (31 - ipic_info[src].bit));
+	temp =3D (1 << (31 - ipic_info[src].bit));

Same as above.


 	ipic_write(ipic->regs, ipic_info[src].pend, temp);
=20
 	spin_unlock_irqrestore(&ipic_lock, flags);
