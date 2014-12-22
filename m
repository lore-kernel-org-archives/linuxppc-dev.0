Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0147.outbound.protection.outlook.com [157.56.110.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 06D5B1A0C95
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Dec 2014 08:26:06 +1100 (AEDT)
Message-ID: <1419283551.5581.172.camel@freescale.com>
Subject: Re: [PATCH] [v2] power/fsl: add MDIO dt binding for FMan
From: Scott Wood <scottwood@freescale.com>
To: Emil Medve <Emilian.Medve@Freescale.com>
Date: Mon, 22 Dec 2014 15:25:51 -0600
In-Reply-To: <5497FBAB.4010206@Freescale.com>
References: <1415958800-9867-1-git-send-email-shh.xie@gmail.com>
 <1416966592.15957.172.camel@freescale.com>
 <DM2PR0301MB08641FB289DBA17AD59FBEA0E26A0@DM2PR0301MB0864.namprd03.prod.outlook.com>
 <1418940078.5581.143.camel@freescale.com>
 <DM2PR0301MB0864AA31CD1A7438F476020FE26B0@DM2PR0301MB0864.namprd03.prod.outlook.com>
 <1419030955.5581.154.camel@freescale.com>
 <DM2PR0301MB086427C10254A0A749CD1326E2560@DM2PR0301MB0864.namprd03.prod.outlook.com>
 <5497D466.9090804@Freescale.com> <1419237176.5581.159.camel@freescale.com>
 <5497E645.7010500@Freescale.com> <1419241330.5581.162.camel@freescale.com>
 <5497FBAB.4010206@Freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Xie Shaohui-B21989 <Shaohui.Xie@Freescale.com>, Liberman
 Igal-B31950 <Igal.Liberman@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-12-22 at 05:08 -0600, Emil Medve wrote:
> Hello Scott,
> 
> 
> On 12/22/2014 03:42 AM, Scott Wood wrote:
> > On Mon, 2014-12-22 at 03:37 -0600, Emil Medve wrote:
> >> Hello Scott,
> >>
> >>
> >> On 12/22/2014 02:32 AM, Scott Wood wrote:
> >>> On Mon, 2014-12-22 at 02:20 -0600, Emil Medve wrote:
> >>>> For the purpose of an example in the binding document, I suggest we just
> >>>> stick with the IEEE standard frequency.
> >>>
> >>> The whole reason for this property existing in the device tree is
> >>> non-standard frequencies.
> >>
> >> While the standard claims 2.5 MHz, most MDIO controllers and PHY devices
> >> support frequencies well beyond the standard. Specifying a lower then
> >> the standard frequency for the benefit of some errata is just one side
> >> of this property
> > 
> > The erratum was (until now) the only claimed reason for it.  If there
> > are other reasons why one would specify a different frequency (in
> > particular, that relate to hardware description), please elaborate.
> 
> From memory, the 1 Gb/s Vitesse PHY(s) we have on some of our DS boards
> support 12.5 MHz. I can dig out more specs for specifics on other PHY(s)
> 
> 2.5 MHz is slow and even more so for high speed interfaces. With both
> polling and interrupts (both MDIO and/or PHY) we've noticed (or blamed)
> in the past some Ethernet performance issues on this very slowness
> 
> As of right now I'm not aware of another way to specify/coordinate the
> MDC speed so setting a default (common denominator) in the DT that is
> different then the IEEE standard seems ok
>
> >>>> We can continue this conversation about errata handling when we submit
> >>>> the code relevant to this binding (and the FMan v3 support)
> >>>
> >>> It affects the binding, so let's discuss it now please.
> >>
> >> I think this specific (unpublished yet) errata has less bearing on the
> >> binding then you might believe. This is mostly about providing a
> >> common/default frequency supported by all the devices on some board
> > 
> > What reason other than an erratum would there be for the standard
> > frequency not being supported?
> 
> This is not about not supporting the standard frequency. This is about
> the default frequency being different then the standard

OK, though rather than talk about defaults I'd phrase it as indicating
that a higher frequency than standard is supported, or that a lower
frequency than standard is required.

-Scott
