Return-Path: <r58472@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 17F4AB6F77
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2012 14:08:33 +1000 (EST)
From: Li Yang-R58472 <r58472@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>, Zhao Chenhui-B35336
 <B35336@freescale.com>
Subject: RE: [PATCH v5 4/5] fsl_pmc: Add API to enable device as wakeup
 event source
Date: Tue, 5 Jun 2012 04:08:25 +0000
Message-ID: <94F013E7935FF44C83EBE7784D62AD3F09335D27@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1336737235-15370-1-git-send-email-chenhui.zhao@freescale.com>
 <1336737235-15370-4-git-send-email-chenhui.zhao@freescale.com>
 <4FC93D74.3090200@freescale.com>
 <20120604113609.GC20676@localhost.localdomain> <4FCD3E8B.30805@freescale.com>
In-Reply-To: <4FCD3E8B.30805@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Tuesday, June 05, 2012 7:03 AM
> To: Zhao Chenhui-B35336
> Cc: linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.org;
> galak@kernel.crashing.org; Li Yang-R58472
> Subject: Re: [PATCH v5 4/5] fsl_pmc: Add API to enable device as wakeup
> event source
>=20
> On 06/04/2012 06:36 AM, Zhao Chenhui wrote:
> > On Fri, Jun 01, 2012 at 05:08:52PM -0500, Scott Wood wrote:
> >> On 05/11/2012 06:53 AM, Zhao Chenhui wrote:
> >>> Add APIs for setting wakeup source and lossless Ethernet in low power
> modes.
> >>> These APIs can be used by wake-on-packet feature.
> >>>
> >>> Signed-off-by: Dave Liu <daveliu@freescale.com>
> >>> Signed-off-by: Li Yang <leoli@freescale.com>
> >>> Signed-off-by: Jin Qing <b24347@freescale.com>
> >>> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> >>> ---
> >>>  arch/powerpc/sysdev/fsl_pmc.c |   71
> ++++++++++++++++++++++++++++++++++++++++-
> >>>  arch/powerpc/sysdev/fsl_soc.h |    9 +++++
> >>>  2 files changed, 79 insertions(+), 1 deletions(-)
> >>>
> >>> diff --git a/arch/powerpc/sysdev/fsl_pmc.c
> b/arch/powerpc/sysdev/fsl_pmc.c
> >>> index 1dc6e9e..c1170f7 100644
> >>> --- a/arch/powerpc/sysdev/fsl_pmc.c
> >>> +++ b/arch/powerpc/sysdev/fsl_pmc.c
> >>> @@ -34,6 +34,7 @@ struct pmc_regs {
> >>>  	__be32 powmgtcsr;
> >>>  #define POWMGTCSR_SLP		0x00020000
> >>>  #define POWMGTCSR_DPSLP		0x00100000
> >>> +#define POWMGTCSR_LOSSLESS	0x00400000
> >>>  	__be32 res3[2];
> >>>  	__be32 pmcdr;
> >>>  };
> >>> @@ -43,6 +44,74 @@ static unsigned int pmc_flag;
> >>>
> >>>  #define PMC_SLEEP	0x1
> >>>  #define PMC_DEEP_SLEEP	0x2
> >>> +#define PMC_LOSSLESS	0x4
> >>> +
> >>> +/**
> >>> + * mpc85xx_pmc_set_wake - enable devices as wakeup event source
> >>> + * @pdev: platform device affected
> >>> + * @enable: True to enable event generation; false to disable
> >>> + *
> >>> + * This enables the device as a wakeup event source, or disables it.
> >>> + *
> >>> + * RETURN VALUE:
> >>> + * 0 is returned on success
> >>> + * -EINVAL is returned if device is not supposed to wake up the
> system
> >>> + * Error code depending on the platform is returned if both the
> platform and
> >>> + * the native mechanism fail to enable the generation of wake-up
> events
> >>> + */
> >>> +int mpc85xx_pmc_set_wake(struct platform_device *pdev, bool enable)
> >>
> >> Why does it have to be a platform_device?  Would a bare device_node
> work
> >> here?  If it's for stuff like device_may_wakeup() that could be in a
> >> platform_device wrapper function.
> >
> > It does not have to be a platform_device. I think it can be a struct
> device.
>=20
> Why does it even need that?  The low level mechanism for influencing
> PMCDR should only need a device node, not a Linux device struct.

It does no harm to pass the device structure and makes more sense for objec=
t oriented interface design.=20

>=20
> >> Where does this get called from?  I don't see an example user in this
> >> patchset.
> >
> > It will be used by a gianfar related patch. I plan to submit that patch
> > after these patches accepted.
>=20
> It would be nice to see how this is used when reviewing this.
>=20
> >>> +{
> >>> +	int ret =3D 0;
> >>> +	struct device_node *clk_np;
> >>> +	u32 *prop;
> >>> +	u32 pmcdr_mask;
> >>> +
> >>> +	if (!pmc_regs) {
> >>> +		pr_err("%s: PMC is unavailable\n", __func__);
> >>> +		return -ENODEV;
> >>> +	}
> >>> +
> >>> +	if (enable && !device_may_wakeup(&pdev->dev))
> >>> +		return -EINVAL;
> >>
> >> Who is setting can_wakeup for these devices?
> >
> > The device driver is responsible to set can_wakeup.
>=20
> How would the device driver know how to set it?  Wouldn't this depend on
> the particular SoC and low power mode?

It is based on the "fsl,magic-packet" and "fsl,wake-on-filer" device tree p=
roperties.

Leo
