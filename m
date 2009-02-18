Return-Path: <dayu@datangmobile.cn>
Received: from mail.datangmobile.cn (mail.datangmobile.cn [219.142.67.62])
	by ozlabs.org (Postfix) with ESMTP id 9E605DDE1F
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2009 16:47:46 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Subject: Re: [PATCH] fix the interrupt loss problem on powerpc
	IPIC(2.6.25-2.6.28)
Date: Wed, 18 Feb 2009 13:47:42 +0800
Message-ID: <D728AD1FA2543948B89DE29C5BF4CD0716AF9623@bjmail1.bj.datangmobile.com>
From: <dayu@datangmobile.cn>
To: <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, leoli@freescale.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

renew description in  the patch,  with this change the 'temp'  is still =
used to make code clear.

___________________________________________

From: Da Yu <dayu@datangmobile.cn>
Date: Wed, 18 Feb 2009 19:58:20 +0800
Subject: [PATCH] fix the interrupt loss problem on powerpc IPIC =
(2.6.25-2.6.28)

Description: The interrupt pending register is write 1 clear.  If there =
are more than one external interrupts pending at the same time, acking =
the first interrupt by reading pending register then OR the =
corresponding bit and write back to pending register will also clear =
other interrupt pending bits.  That will cause loss of interrupt.

Signed-off-by: Da Yu <dayu@datangmobile.cn>
---

--- a/arch/powerpc/sysdev/ipic.c	2009-02-18 09:47:04.000000000 +0800
+++ b/arch/powerpc/sysdev/ipic.c	2009-02-18 09:46:34.000000000 +0800
@@ -568,8 +568,7 @@ static void ipic_ack_irq(unsigned int vi

 	spin_lock_irqsave(&ipic_lock, flags);

-	temp =3D ipic_read(ipic->regs, ipic_info[src].ack);
-	temp |=3D (1 << (31 - ipic_info[src].bit));
+	temp =3D 1 << (31 - ipic_info[src].bit);
 	ipic_write(ipic->regs, ipic_info[src].ack, temp);

 	/* mb() can't guarantee that ack is finished.  But it does finish
@@ -592,8 +591,7 @@ static void ipic_mask_irq_and_ack(unsign
 	temp &=3D ~(1 << (31 - ipic_info[src].bit));
 	ipic_write(ipic->regs, ipic_info[src].mask, temp);

-	temp =3D ipic_read(ipic->regs, ipic_info[src].ack);
-	temp |=3D (1 << (31 - ipic_info[src].bit));
+	temp =3D 1 << (31 - ipic_info[src].bit);
 	ipic_write(ipic->regs, ipic_info[src].ack, temp);

 	/* mb() can't guarantee that ack is finished.  But it does finish



=20
=20

-----=D3=CA=BC=FE=D4=AD=BC=FE-----
=B7=A2=BC=FE=C8=CB: Olof Johansson [mailto:olof@lixom.net]=20
=B7=A2=CB=CD=CA=B1=BC=E4: 2009=C4=EA2=D4=C218=C8=D5 10:43
=CA=D5=BC=FE=C8=CB: =F3=CE=D3=ED
=B3=AD=CB=CD: leoli@freescale.com; galak@kernel.crashing.org; =
linuxppc-dev@ozlabs.org; linux-kernel@vger.kernel.org
=D6=F7=CC=E2: Re: [PATCH] fix the interrupt loss problem on powerpc =
IPIC(2.6.25-2.6.28)

On Wed, Feb 18, 2009 at 10:16:07AM +0800, dayu@datangmobile.cn wrote:
> From: Da Yu <dayu@datangmobile.cn>
> Date: Wed, 18 Feb 2009 19:58:20 +0800
> Subject: [PATCH] fix the interrupt loss problem on powerpc IPIC=20
> (2.6.25-2.6.28)
>=20
> Signed-off-by: Da Yu <dayu@datangmobile.cn>

Still no proper explanation in the patch.

Also, with this change, is 'temp' really needed, or can you just pass in =
the mask by hand?


-Olof

> ---
>=20
> --- a/arch/powerpc/sysdev/ipic.c	2009-02-18 09:47:04.000000000 +0800
> +++ b/arch/powerpc/sysdev/ipic.c	2009-02-18 09:46:34.000000000 +0800
> @@ -568,8 +568,7 @@ static void ipic_ack_irq(unsigned int vi
>=20
>  	spin_lock_irqsave(&ipic_lock, flags);
>=20
> -	temp =3D ipic_read(ipic->regs, ipic_info[src].ack);
> -	temp |=3D (1 << (31 - ipic_info[src].bit));
> +	temp =3D 1 << (31 - ipic_info[src].bit);
>  	ipic_write(ipic->regs, ipic_info[src].ack, temp);
>=20
>  	/* mb() can't guarantee that ack is finished.  But it does finish
