Return-Path: <dayu@datangmobile.cn>
Received: from mail.datangmobile.cn (mail.datangmobile.cn [219.142.67.62])
	by ozlabs.org (Postfix) with ESMTP id 9E0F2DDE07
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2009 23:56:42 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Subject: [PATCH] fix the interrupt loss problem on powerpc IPIC (2.6.23)
Date: Tue, 17 Feb 2009 20:44:37 +0800
Message-ID: <D728AD1FA2543948B89DE29C5BF4CD0716AC2DDE@bjmail1.bj.datangmobile.com>
From: <dayu@datangmobile.cn>
To: <LeoLi@freescale.com>,
	<linux-kernel@vger.kernel.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Da Yu <dayu@datangmobile.cn>
Date: Tue, 17 Feb 2009 19:58:20 +0800
Subject: [PATCH] fix the interrupt loss problem on powerpc IPIC (2.6.23)

Signed-off-by: Da Yu <dayu@datangmobile.cn>
---

--- a/arch/powerpc/sysdev/ipic.c	2009-02-17 15:10:18.000000000 +0800
+++ b/arch/powerpc/sysdev/ipic.c	2009-02-17 20:05:28.000000000 +0800
@@ -561,8 +561,7 @@ static void ipic_ack_irq(unsigned int vi

 	spin_lock_irqsave(&ipic_lock, flags);

-	temp =3D ipic_read(ipic->regs, ipic_info[src].pend);
-	temp |=3D (1 << (31 - ipic_info[src].bit));
+	temp =3D 1 << (31 - ipic_info[src].bit);
 	ipic_write(ipic->regs, ipic_info[src].pend, temp);

 	spin_unlock_irqrestore(&ipic_lock, flags);
@@ -581,8 +580,7 @@ static void ipic_mask_irq_and_ack(unsign
 	temp &=3D ~(1 << (31 - ipic_info[src].bit));
 	ipic_write(ipic->regs, ipic_info[src].mask, temp);

-	temp =3D ipic_read(ipic->regs, ipic_info[src].pend);
-	temp |=3D (1 << (31 - ipic_info[src].bit));
+	temp =3D 1 << (31 - ipic_info[src].bit);
 	ipic_write(ipic->regs, ipic_info[src].pend, temp);

 	spin_unlock_irqrestore(&ipic_lock, flags);






=20

-----=D3=CA=BC=FE=D4=AD=BC=FE-----
=B7=A2=BC=FE=C8=CB: Li Yang-R58472 [mailto:LeoLi@freescale.com]=20
=B7=A2=CB=CD=CA=B1=BC=E4: 2009=C4=EA2=D4=C217=C8=D5 18:17
=CA=D5=BC=FE=C8=CB: =F3=CE=D3=ED; linux-kernel@vger.kernel.org
=B3=AD=CB=CD: linuxppc-dev@ozlabs.org
=D6=F7=CC=E2: RE: PROBLEM: incorrect interrupt ack lead to interrupt =
loss on freescale powerpc

> -----Original Message-----
> From: dayu@datangmobile.cn [mailto:dayu@datangmobile.cn]
> Sent: Tuesday, February 17, 2009 4:34 PM
> To: linux-kernel@vger.kernel.org
> Cc: Li Yang-R58472
> Subject: PROBLEM: incorrect interrupt ack lead to interrupt loss on=20
> freescale powerpc
>=20
> =20
> [1.] One line summary of the problem: incorrect interrupt ack  lead to =

> interrupt loss

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
+ * Da Yu <dayu@datangmobile.cn> fixed the interrupt loss problem on=20
+ powerpc IPIC


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
 	spin_unlock_irqrestore(&ipic_lock, flags); @@ -581,8 +581,7 @@
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
