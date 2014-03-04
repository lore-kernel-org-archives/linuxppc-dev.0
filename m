Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0204.outbound.protection.outlook.com [207.46.163.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 255B02C0092
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2014 05:53:52 +1100 (EST)
Message-ID: <1393959220.2697.177.camel@snotra.buserror.net>
Subject: Re: [PATCH] Corenet: Add QE platform support for Corenet
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang-B45475 <qiang.zhao@freescale.com>
Date: Tue, 4 Mar 2014 12:53:40 -0600
In-Reply-To: <ef9ee88dd9e548f380abb7512dc1814c@BLUPR03MB341.namprd03.prod.outlook.com>
References: <1393577309-41445-1-git-send-email-B45475@freescale.com>
 <62FC0C4F-26FD-44B4-BC07-BDF1904AE637@kernel.crashing.org>
 <ef9ee88dd9e548f380abb7512dc1814c@BLUPR03MB341.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Xie Xiaobo-R63061 <X.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-03-04 at 03:09 -0600, Zhao Qiang-B45475 wrote:
> On Mar 3, 2014, at 11:51 PM, Kumar Gala [galak@kernel.crashing.org] wrote:
> 
> 
> 
> > -----Original Message-----
> > From: Kumar Gala [mailto:galak@kernel.crashing.org]
> > Sent: Monday, March 03, 2014 11:51 PM
> > To: Zhao Qiang-B45475
> > Cc: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421; Xie Xiaobo-R63061
> > Subject: Re: [PATCH] Corenet: Add QE platform support for Corenet
> > 
> > 
> > On Feb 28, 2014, at 2:48 AM, Zhao Qiang <B45475@freescale.com> wrote:
> > 
> > > There is QE on platform T104x, add support.
> > > Call funcs qe_ic_init and qe_init if CONFIG_QUICC_ENGINE is defined.
> > >
> > > Signed-off-by: Zhao Qiang <B45475@freescale.com>
> > > ---
> > > arch/powerpc/platforms/85xx/corenet_generic.c | 32
> > > +++++++++++++++++++++++++++
> > > 1 file changed, 32 insertions(+)
> > 
> > Can you use mpc85xx_qe_init() instead?
> 
> 
> mpc85xx_qe_init() is for old QE which is different from new QE.
> New QE has no par_io, and it is not correct to init 
> par_io(par_io_init() called in mpc85xx_qe_init()) for new QE. 

So split that function into mpc85xx_qe_init() and
mpc85xx_qe_par_io_init().

> > >
> > > diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c
> > > b/arch/powerpc/platforms/85xx/corenet_generic.c
> > > index fbd871e..f8c8e0c 100644
> > > --- a/arch/powerpc/platforms/85xx/corenet_generic.c
> > > +++ b/arch/powerpc/platforms/85xx/corenet_generic.c
> > >
> > > /*
> > > @@ -52,11 +68,24 @@ void __init corenet_gen_pic_init(void)  */ void
> > > __init corenet_gen_setup_arch(void) {
> > > +#ifdef CONFIG_QUICC_ENGINE
> > > +	struct device_node *np;
> > > +#endif
> > > 	mpc85xx_smp_init();
> > >
> > > 	swiotlb_detect_4g();
> > >
> > > 	pr_info("%s board from Freescale Semiconductor\n", ppc_md.name);
> > > +
> > > +#ifdef CONFIG_QUICC_ENGINE
> > > +	np = of_find_compatible_node(NULL, NULL, "fsl,qe");
> > > +	if (!np) {
> > > +		pr_err("%s: Could not find Quicc Engine node\n", __func__);
> > > +		return;
> > 
> > This doesn't seem like an reasonable error message for common corenet
> > platform.  It seems reasonable to build QE support but boot on a chip w/o
> > QE.

mpc85xx_qe_init() has a similar problem regarding the error message, but
the above is worse because it does an early return from
corenet_gen_setup_arch() rather than just from mpc85xx_qe_init() -- what
if someone added non-QE things after this point?

-Scott
