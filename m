Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5B5E32C008C
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Nov 2013 01:29:44 +1100 (EST)
Date: Sat, 16 Nov 2013 15:29:33 +0100
From: Anatolij Gustschin <agust@denx.de>
To: neorf3k <neorf3k@gmail.com>
Subject: Re: Problem reading and programming memory location...
Message-ID: <20131116152933.276f9939@crub>
In-Reply-To: <51E043E6-19FB-4655-9B3C-3B81F868DC47@gmail.com>
References: <985685C7-0122-4D45-96D1-4412E9774A5D@gmail.com>
 <20131113083259.1b69ed18@crub>
 <50EBA514-5BB1-40B3-B27B-309A829D2E05@gmail.com>
 <20131113190606.2a5d08fb@crub>
 <5DC55309-D920-44CE-8F89-AB7FA6BD383A@gmail.com>
 <20131114100917.31f674d7@crub>
 <51E043E6-19FB-4655-9B3C-3B81F868DC47@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Lorenzo,

see my comments below.

On Fri, 15 Nov 2013 17:27:30 +0100
neorf3k <neorf3k@gmail.com> wrote:

> Hello again, I=E2=80=99ve tried this code, but we are not able to
> change cs4 reg value=E2=80=A6 what could be?
>=20
> =E2=80=94
>=20
> #define MALab_DEVICE_NAME	"MALab"
> #define MPC5xxx_MM_CS4_START	(MBAR_BASE + 0x0024)
> #define MPC5xxx_MM_CS4_STOP	(MBAR_BASE + 0x0028)
> #define MPC5xxx_MM_IPBI	 (MBAR_BASE + 0x0054)
>=20
> #define MALab_MM_START	 0x10020000U
> #define MALab_MM_END	 0x10020FFFU

Please change MALab_MM_END to 0x10030000U.

> #define MALab_MM_SIZE	 0x00001000U
>=20
> int init_module(void) { ...
>     u16 cs4_start_value;
>     u16 cs4_stop_value;
>     u32 cs4_enable_value;
>    =20
>     u8 rvoice_ioaddr_value;
>=20
>    =20
>     // reserve a page of memory for our hardware /proc/iomem
>     if ( check_region(MALab_MM_START,MALab_MM_SIZE) ) {
>         printk (KERN_ALERT "LED init_module: memory already in use\n");
>         return -EBUSY;
>     }
>=20
>    =20
>     request_mem_region(MALab_MM_START,MALab_MM_SIZE,MALab_DEVICE_NAME);
>=20
>    =20
>     void __iomem *cs0_reg   =3D ioremap ((volatile unsigned long)(MBAR_BA=
SE + 0x0300), 4);
>     void __iomem *cs3_reg   =3D ioremap ((volatile unsigned long)(MBAR_BA=
SE + 0x030C), 4);
>
>     void __iomem *ipbi_cr =3D ioremap ((volatile unsigned long)(MPC5xxx_M=
M_IPBI), 4);
>     void __iomem *cs4_start  =3D ioremap ((volatile unsigned long)(MPC5xx=
x_MM_CS4_START + 2), 2);
>     void __iomem *cs4_stop   =3D ioremap ((volatile unsigned long)(MPC5xx=
x_MM_CS4_STOP + 2), 2);
>    =20
>     void __iomem *cs4_enable   =3D ioremap ((volatile unsigned long)(MBAR=
_BASE + 0x0310), 4);
>     void __iomem *cs_ctrl_reg   =3D ioremap ((volatile unsigned long)(MBA=
R_BASE + 0x0318), 4);


this might work, but this is not how ioremap() supposed to be used.
The mapping is done in 4k-page granularity, so it would be better
to just map the internal register range my one ioremap() call, i.e.

    reg_base =3D ioremap(MBAR_BASE, 0x400);

and then to calculate the register offsets, i.e.

   cs0_reg =3D reg_base + 0x0300;
   cs0_reg =3D reg_base + 0x030C;
   ...
   ipbi_cr =3D reg_base + 0x0054;
   cs4_start =3D reg_base + 0x0026;
   cs4_stop =3D reg_base + 0x002a;
   ...

For FPGA mapping you need a separate ioremap() call of course.

>     void __iomem *rvoice_ioaddr   =3D ioremap ((volatile unsigned long)(M=
ALab_MM_START), MALab_MM_SIZE);
>
>     //disable CSO
>=20
>     out_be32(cs0_reg, 0x0004ed00);
>=20
>    =20
>     //disable CS3
>=20
>     out_be32(cs3_reg, 0x0002cf00);
>=20
>     // enable LocalBus chip select CS4
>     out_be32(ipbi_cr, 0x00290001);

The comment and the code doesn't match here, the code disables
CS4 to configure the its range, so the comment is confusing.

>     cs4_start_value=3Din_be16(cs4_start);
>     cs4_start_value=3DMALab_MM_START >>16;
>     out_be16(cs4_start, cs4_start_value);
>     cs4_stop_value=3Din_be16(cs4_stop);
>     cs4_stop_value=3DMALab_MM_END >>16;
>     out_be16(cs4_stop, cs4_stop_value);

Here is the problem. The _minimal_ chip select range _must_
be 64 KiB, otherwise the register access can't work. Your
current chip select 4 range is less then 1 KiB:

  0x10020FFF - 0x10020000 =3D 0xFFF

Since you right-shift the start and stop values by 16,
the chip select start and stop registers are both 0x1002.
The resulting chip select address range is 0. Therefore
please set MALab_MM_END value to 0x10030000.

Thanks,
Anatolij
