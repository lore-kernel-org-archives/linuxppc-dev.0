Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ED2B41A04FB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Aug 2014 04:30:45 +1000 (EST)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0144.outbound.protection.outlook.com [207.46.163.144])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3AAA8140140
 for <linuxppc-dev@ozlabs.org>; Fri,  1 Aug 2014 04:30:44 +1000 (EST)
Message-ID: <1406831433.29414.339.camel@snotra.buserror.net>
Subject: Re: [PATCH v2 5/7] powerpc/corenet: Add MDIO bus muxing support to
 the board device tree(s)
From: Scott Wood <scottwood@freescale.com>
To: Emil Medve <Emilian.Medve@Freescale.com>
Date: Thu, 31 Jul 2014 13:30:33 -0500
In-Reply-To: <53D9D893.8090105@Freescale.com>
References: <1405541831-1277-1-git-send-email-Shruti@Freescale.com>
 <1405541831-1277-5-git-send-email-Shruti@Freescale.com>
 <1405982754.29414.33.camel@snotra.buserror.net>
 <loom.20140728T081519-636@post.gmane.org>
 <1406663895.29414.240.camel@snotra.buserror.net>
 <53D96906.1040407@Freescale.com>
 <1406773805.29414.302.camel@snotra.buserror.net>
 <53D9C77D.8070203@Freescale.com>
 <1406784487.29414.328.camel@snotra.buserror.net>
 <53D9D893.8090105@Freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-07-31 at 00:48 -0500, Emil Medve wrote:
> Hello Scott,
> 
> 
> On 07/31/2014 12:28 AM, Scott Wood wrote:
> > On Wed, 2014-07-30 at 23:35 -0500, Emil Medve wrote:
> >> Hello Scott,
> >>
> >>
> >> On 07/30/2014 09:30 PM, Scott Wood wrote:
> >>> On Wed, 2014-07-30 at 16:52 -0500, Emil Medve wrote:
> >>>>>>>> +			mdio0: mdio <at> fc000 {
> >>>>>>>> +			};
> >>>>>>>
> >>>>>>> Why is the empty node needed?
> >>>>>>
> >>>>>> For the label
> >>>>>
> >>>>> For mdio-parent-bus, or is there some other dts layer that makes this
> >>>>> node non-empty?
> >>>>
> >>>> 'powerpc/corenet: Create the dts components for the DPAA FMan' -
> >>>> http://patchwork.ozlabs.org/patch/370872
> >>>
> >>> Why does this patch define the mdio0 label for mdio@e1120, but not
> >>> define a label for any other node?
> >>
> >> Only MDIO controllers that are pinned out have these labels. Only pinned
> >> out MDIO(s) are capable of controlling external PHY(s) via these board
> >> level MDIO buses
> > 
> > Is there any reason to describe non-pinned-out MDIO controllers at all?
> 
> Yes. For the internal TBI PHY(s). Each MAC supporting SGMII has a TBI
> PHY that is attached to the MDIO controller of the respective MAC

OK, so similar to eTSEC.  I didn't know if you were counting aTBI
connection as being (partially) pinned out.

> > Is the lack of pinning out inherent to the silicon, or is it board
> > design/config?
> 
> It's a silicon level decision

So why is it the board file that adds the label, if it's always going to
be the same node?

> > I'm just curious why mdio@e1120 is labelled in a non-board dtsi while
> > others are labelled elsewhere.
> 
> Labels are relevant only in the context of 'powerpc/corenet: Add MDIO
> bus muxing support to the board device tree(s)' -
> http://patchwork.ozlabs.org/patch/370866. Most labels are created and
> used in the board .dts file except b4qds.dtsi which is shared between
> b4420qds.dts and b4860qds.dts

I'm talking about qoriq-fman-0-1g-0.dtsi, not b4qds.dtsi.  It labels
mdio@e1120 as mdio0.

In other words, why is the decision on where to label made differently
for fman v3 than for previous fman versions?

-Scott
