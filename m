Return-Path: <qiang.zhao@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0141.outbound.protection.outlook.com [207.46.163.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 424CC2C00CE
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Mar 2014 20:24:46 +1100 (EST)
From: "qiang.zhao@freescale.com" <qiang.zhao@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH] Corenet: Add QE platform support for Corenet
Date: Tue, 4 Mar 2014 09:09:27 +0000
Message-ID: <ef9ee88dd9e548f380abb7512dc1814c@BLUPR03MB341.namprd03.prod.outlook.com>
References: <1393577309-41445-1-git-send-email-B45475@freescale.com>
 <62FC0C4F-26FD-44B4-BC07-BDF1904AE637@kernel.crashing.org>
In-Reply-To: <62FC0C4F-26FD-44B4-BC07-BDF1904AE637@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Xiaobo Xie <X.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mar 3, 2014, at 11:51 PM, Kumar Gala [galak@kernel.crashing.org] wrote:



> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Monday, March 03, 2014 11:51 PM
> To: Zhao Qiang-B45475
> Cc: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421; Xie Xiaobo-R63061
> Subject: Re: [PATCH] Corenet: Add QE platform support for Corenet
>=20
>=20
> On Feb 28, 2014, at 2:48 AM, Zhao Qiang <B45475@freescale.com> wrote:
>=20
> > There is QE on platform T104x, add support.
> > Call funcs qe_ic_init and qe_init if CONFIG_QUICC_ENGINE is defined.
> >
> > Signed-off-by: Zhao Qiang <B45475@freescale.com>
> > ---
> > arch/powerpc/platforms/85xx/corenet_generic.c | 32
> > +++++++++++++++++++++++++++
> > 1 file changed, 32 insertions(+)
>=20
> Can you use mpc85xx_qe_init() instead?


mpc85xx_qe_init() is for old QE which is different from new QE.
New QE has no par_io, and it is not correct to init=20
par_io(par_io_init() called in mpc85xx_qe_init()) for new QE.=20

>=20
> >
> > diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c
> > b/arch/powerpc/platforms/85xx/corenet_generic.c
> > index fbd871e..f8c8e0c 100644
> > --- a/arch/powerpc/platforms/85xx/corenet_generic.c
> > +++ b/arch/powerpc/platforms/85xx/corenet_generic.c
> >
> > /*
> > @@ -52,11 +68,24 @@ void __init corenet_gen_pic_init(void)  */ void
> > __init corenet_gen_setup_arch(void) {
> > +#ifdef CONFIG_QUICC_ENGINE
> > +	struct device_node *np;
> > +#endif
> > 	mpc85xx_smp_init();
> >
> > 	swiotlb_detect_4g();
> >
> > 	pr_info("%s board from Freescale Semiconductor\n", ppc_md.name);
> > +
> > +#ifdef CONFIG_QUICC_ENGINE
> > +	np =3D of_find_compatible_node(NULL, NULL, "fsl,qe");
> > +	if (!np) {
> > +		pr_err("%s: Could not find Quicc Engine node\n", __func__);
> > +		return;
>=20
> This doesn't seem like an reasonable error message for common corenet
> platform.  It seems reasonable to build QE support but boot on a chip w/o
> QE.
>=20
> > +	}
> > +	qe_reset();
> > +	of_node_put(np);
> > +#endif
> > }
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
>=20
>=20


Regards,
Zhao Qiang
