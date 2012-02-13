Return-Path: <B04825@freescale.com>
Received: from DB3EHSOBE006.bigfish.com (db3ehsobe006.messaging.microsoft.com
 [213.199.154.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7F9C91007D1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2012 03:24:57 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Fan Zhicheng-B32736 <B32736@freescale.com>
Subject: Re: [PATCH 2/2 v3] powerpc/85xx: Abstract common define of signal
 multiplex control for qe
Date: Mon, 13 Feb 2012 16:24:08 +0000
Message-ID: <CAOZdJXVn305FN3co9wYR0HEptz3vp2UxOKYCn8JyDCvwtBtuuA@mail.gmail.com>
References: <1329111208-5320-1-git-send-email-B32736@freescale.com>
 <1329111208-5320-2-git-send-email-B32736@freescale.com>
In-Reply-To: <1329111208-5320-2-git-send-email-B32736@freescale.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Feb 12, 2012 at 11:33 PM, Zhicheng Fan <B32736@freescale.com> wrote=
:=0A=
=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (np) {=0A=
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pmuxcr =3D of_iomap(np, 0) =
+ MPC85xx_PMUXCR_OFFSET;=0A=
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 guts =3D of_iomap(np, 0);=
=0A=
>=0A=
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!pmuxcr)=0A=
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN=
_EMERG "Error: Alternate function"=0A=
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 " signal multiplex control register not"=0A=
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 " mapped!\n");=0A=
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!guts)=0A=
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("mpc=
85xx-rdb: could not map global utilties register!\n");=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* P1021 has pins muxed fo=
r QE and other functions. To=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * enable QE UEC mode, we =
need to set bit QE0 for UCC1=0A=
> @@ -291,11 +286,11 @@ static void __init mpc85xx_mds_qe_init(void)=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * and QE12 for QE MII man=
agement signals in PMUXCR=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * register.=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */=0A=
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 setbits32(p=
muxcr, MPC85xx_PMUXCR_QE0 |=0A=
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 setbits32(&=
guts->pmuxcr, MPC85xx_PMUXCR_QE0 |=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0MPC85xx_PMUXCR_QE3 |=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0MPC85xx_PMUXCR_QE9 |=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0MPC85xx_PMUXCR_QE12);=0A=
> -=0A=
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(guts);=0A=
=0A=
This needs to move into the "else" statement:=0A=
=0A=
else {=0A=
   setbits(...=0A=
   iounmap( ...)=0A=
}=0A=
=0A=
=0A=
-- =0A=
Timur Tabi=0A=
Linux kernel developer at Freescale=0A=
