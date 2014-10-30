Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CA0E11A00C8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Oct 2014 01:51:36 +1100 (AEDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0102.outbound.protection.outlook.com [157.56.110.102])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C454314007D
 for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2014 01:51:35 +1100 (AEDT)
Message-ID: <1414680683.23458.148.camel@snotra.buserror.net>
Subject: Re: [PATCH 1/4] dt/bindings: Introduce the FSL QorIQ DPAA BMan
From: Scott Wood <scottwood@freescale.com>
To: Emil Medve <Emilian.Medve@Freescale.com>
Date: Thu, 30 Oct 2014 09:51:23 -0500
In-Reply-To: <5451BF49.6050106@Freescale.com>
References: <1413986972-621-1-git-send-email-Emilian.Medve@Freescale.com>
 <EA33D307-CCDA-4A30-9386-46FA832FE0CA@codeaurora.org>
 <1414519738.23458.84.camel__4795.38602890006$1414521743$gmane$org@snotra.buserror.net>
 <54515ECB.70404@Freescale.com>
 <1414620996.23458.141.camel__29590.7804662876$1414621051$gmane$org@snotra.buserror.net>
 <5451BF49.6050106@Freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, pawel.moll@arm.com,
 corbet@lwn.net, Geoff.Thorpe@Freescale.com, ijc+devicetree@hellion.org.uk,
 linux-doc@vger.kernel.org, linuxppc-dev@ozlabs.org, robh+dt@kernel.org,
 Kumar Gala <galak@codeaurora.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-10-29 at 23:32 -0500, Emil Medve wrote:
> Hello Scott,
> 
> 
> On 10/29/2014 05:16 PM, Scott Wood wrote:
> > On Wed, 2014-10-29 at 16:40 -0500, Emil Medve wrote:
> >> Hello Scott,
> >>
> >>
> >> On 10/28/2014 01:08 PM, Scott Wood wrote:
> >>> On Tue, 2014-10-28 at 09:36 -0500, Kumar Gala wrote:
> >>>> On Oct 22, 2014, at 9:09 AM, Emil Medve <Emilian.Medve@freescale.com> wrote:
> >>>>
> >>>>> The Buffer Manager is part of the Data-Path Acceleration Architecture (DPAA).
> >>>>> BMan supports hardware allocation and deallocation of buffers belonging to
> >>>>> pools originally created by software with configurable depletion thresholds.
> >>>>> This binding covers the CCSR space programming model
> >>>>>
> >>>>> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
> >>>>> Change-Id: I3ec479bfb3c91951e96902f091f5d7d2adbef3b2
> >>>>> ---
> >>>>> .../devicetree/bindings/powerpc/fsl/bman.txt       | 98 ++++++++++++++++++++++
> >>>>> 1 file changed, 98 insertions(+)
> >>>>> create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/bman.txt
> >>>>
> >>>> Should these really be in bindings/powerpc/fsl, aren’t you guys using this on ARM SoCs as well?
> >>>
> >>> The hardware on the ARM SoCs is different enough that I'm not sure the
> >>> same binding will cover it.  That said, putting things under <arch>
> >>> should be a last resort if nowhere else fits.
> >>
> >> OTC started ported the driver to the the ARM SoC and the feedback has
> >> been that the driver needed minimal changes. The IOMMU has been the only
> >> area of concern, and a small change to the binding has been suggested
> > 
> > Do we need something in the binding to indicate device endianness?
> 
> As I said, I didn't have enough exposure to the ARM SoC so I can't
> answer that
> 
> > If this binding is going to continue to be relevant to future DPAA
> > generations, I think we really ought to deal with the possibility that
> > there is more than one datapath instance
> 
> I'm unsure how relevant this will be going forward. In LS2 B/QMan is
> abstracted/hidden away behind the MC (firmware).

This is why I was wondering whether the binding would be at all the
same...

>  I wouldn't over-engineer this without a clear picture of what multiple
> data-paths per SoC even means at this point

I don't think it's over-engineering.  Assuming only one instance of
something is generally sloppy engineering.  Linux doesn't need to
actually pay attention to it until and unless it becomes necessary, but
it's good to have the information in the device tree up front.

> > by having phandles and/or a parent container to connect the related
> > components.
> 
> Connecting the related components is beyond the scope of this binding.
> It will soon hit the e-mail list(s) as part of upstreaming the Ethernet
> driver

So you want us to merge this binding without being told how this works?
Or by "soon" do you mean before this binding is accepted?

-Scott
