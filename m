Return-Path: <r58472@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe005.messaging.microsoft.com [213.199.154.143])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 60DE9B6F62
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2012 02:49:46 +1000 (EST)
From: Li Yang-R58472 <r58472@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH v5 4/5] fsl_pmc: Add API to enable device as wakeup
 event source
Date: Tue, 5 Jun 2012 16:49:37 +0000
Message-ID: <94F013E7935FF44C83EBE7784D62AD3F093360C1@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1336737235-15370-1-git-send-email-chenhui.zhao@freescale.com>
 <1336737235-15370-4-git-send-email-chenhui.zhao@freescale.com>
 <4FC93D74.3090200@freescale.com>
 <20120604113609.GC20676@localhost.localdomain>
 <4FCD3E8B.30805@freescale.com>
 <94F013E7935FF44C83EBE7784D62AD3F09335D27@039-SN2MPN1-022.039d.mgd.msft.net>
 <4FCE2FB8.9080307@freescale.com>
In-Reply-To: <4FCE2FB8.9080307@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Zhao Chenhui-B35336 <B35336@freescale.com>
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
> Sent: Wednesday, June 06, 2012 12:12 AM
> To: Li Yang-R58472
> Cc: Wood Scott-B07421; Zhao Chenhui-B35336; linuxppc-dev@lists.ozlabs.org=
;
> linux-kernel@vger.kernel.org; galak@kernel.crashing.org
> Subject: Re: [PATCH v5 4/5] fsl_pmc: Add API to enable device as wakeup
> event source
>=20
> On 06/04/2012 11:08 PM, Li Yang-R58472 wrote:
> >
> >
> >> -----Original Message-----
> >> From: Wood Scott-B07421
> >> Sent: Tuesday, June 05, 2012 7:03 AM
> >> To: Zhao Chenhui-B35336
> >> Cc: linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.org;
> >> galak@kernel.crashing.org; Li Yang-R58472
> >> Subject: Re: [PATCH v5 4/5] fsl_pmc: Add API to enable device as
> >> wakeup event source
> >>
> >> On 06/04/2012 06:36 AM, Zhao Chenhui wrote:
> >>> On Fri, Jun 01, 2012 at 05:08:52PM -0500, Scott Wood wrote:
> >>>> On 05/11/2012 06:53 AM, Zhao Chenhui wrote:
> >>>>> +int mpc85xx_pmc_set_wake(struct platform_device *pdev, bool
> >>>>> +enable)
> >>>>
> >>>> Why does it have to be a platform_device?  Would a bare device_node
> >> work
> >>>> here?  If it's for stuff like device_may_wakeup() that could be in
> >>>> a platform_device wrapper function.
> >>>
> >>> It does not have to be a platform_device. I think it can be a struct
> >> device.
> >>
> >> Why does it even need that?  The low level mechanism for influencing
> >> PMCDR should only need a device node, not a Linux device struct.
> >
> > It does no harm to pass the device structure and makes more sense for
> object oriented interface design.
>=20
> It does do harm if you don't have a device structure to pass, if for some
> reason you found the device by directly looking for it rather than going
> through the device model.

Whether or not a device is a wakeup source not only depends on the SoC spec=
ification but also the configuration and current state for the device.  I o=
nly expect the device driver to have this knowledge and call this function =
rather than some standalone platform code.  Therefore I don't think your co=
ncern matters.
=20
>=20
> >>>> Who is setting can_wakeup for these devices?
> >>>
> >>> The device driver is responsible to set can_wakeup.
> >>
> >> How would the device driver know how to set it?  Wouldn't this depend
> >> on the particular SoC and low power mode?
> >
> > It is based on the "fsl,magic-packet" and "fsl,wake-on-filer" device
> tree properties.
>=20
> fsl,magic-packet was a mistake.  It is equivalent to checking the
> compatible for etsec.  It does not convey any information about whether

It can be described either by explicit feature property or by the compatibl=
e.  I don't think it is a problem that we choose one against another.

> the eTSEC is still active in a given low power mode.

Whether or not the eTSEC is still active in both sleep and deep sleep is on=
ly depending on if we set it to be a wakeup source.  If it behaves differen=
tly for low power modes in the future, we could address that by adding addi=
tional property.

>=20
> How is fsl,wake-os-filer relevant to this decision?  When will it be set
> but not fsl,magic-packet?

I mean either fsl,magic-packet or fsl,wake-on-filer shows it can be a wakeu=
p source.  Currently we don't have an SoC to have wake-on-filer while not w=
ake-on-magic.  But I think it's better to consider both as they are indepen=
dent features.

>=20
> What about devices other than ethernet?  What about differences between
> ordinary sleep and deep sleep?

There is no difference for sleep and deep sleep for all wakeup sources curr=
ently.  We can address the problem if it is not the case in the future.

Leo
