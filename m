Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 58365DDF12
	for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2007 12:39:38 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l4V2dVX6006043
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 19:39:32 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l4V2dUHq029654
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 21:39:31 -0500 (CDT)
Subject: Re: [PATCH v2]: Fix e500 v2 core reboot bug
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <19325B38-202C-4837-9BE8-0ACA482F2605@kernel.crashing.org>
References: <1180406209.8139.13.camel@localhost.localdomain>
	<BA0C2035-FCAD-4B34-A622-F79432079F10@kernel.crashing.org>
	<1180492466.12577.6.camel@localhost.localdomain>
	<A78C881D-26C3-4545-85CA-80C05085C039@kernel.crashing.org>
	<1180503967.12577.20.camel@localhost.localdomain>
	<19325B38-202C-4837-9BE8-0ACA482F2605@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1180579138.16155.16.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 31 May 2007 10:38:59 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-05-30 at 20:25, Kumar Gala wrote:
> On May 30, 2007, at 12:46 AM, Zang Roy-r61911 wrote:
> 
> > On Wed, 2007-05-30 at 10:40, Kumar Gala wrote:
> >> On May 29, 2007, at 9:34 PM, Zang Roy-r61911 wrote:
> >>
> >>> On Wed, 2007-05-30 at 03:29, Kumar Gala wrote:
> >>>> On May 28, 2007, at 9:36 PM, Zang Roy-r61911 wrote:
> >>>>
> >>>>> Fix the e500 v2 core reset bug.
> >>>>> For e500 v2 core, a new reset control register is added to
> >>>>> reset the core.
> >>>>> On 85xx CDS board with e500 v2 core, normal reboot code will
> >>>>> induce DDR block in u-boot. This patch fixes this bug. It is
> >>>>> also tested on legacy e500 v1 core.
> >>>>
> >>>> what happens on an e500 based 85xx system?
> >>>
> >>> Without this patch on MPC8548CDS board, after key in "reboot"
> >> command,
> >>> the u-boot will hang at DDR init. See the following log without
> this
> >>> patch:
> >>
> >> Sorry I meant what happens on a e500 v1 based 85xx system w/this
> >> patch.
> >
> > E500 V1 core can boot up normally with/without this patch. Such as
> > 8555CDS system.
> 
> Sure, but what happens when you reboot on e500v1 based part?
Sorry, Maybe I do not understand clearly.
The u-boot boot up correctly, when I reboot on a e500v1 based part.
This patch do not affect the e500v1 core boot up. Current code is enough
for e500v1 core. While for E500 v2 core, the u-boot will block without
this patch as I posted before.

Is it clear?

> 
> [snip]
> 
> >>>> I'm not terrible happy with blindly writing to rstcr.
> >>>>
> >>> I can understand you.
> >>> But I jut want to make things simple and workable.
> >>> Any idea?
> >>
> >> one idea would be for us to add a property on the soc node.
> >> Something like has-rstcr or something similar in a guts node?
> > I have seen your suggestion before to add a property in device tree.
> > But I still think the current implementation is simple.
> 
> While it simple you are depending on the fact that a given  
> implementation may or may not have something at the particular  
> offset.  Who knows if 8599 or some future part could put the 'cause  
> my part to smoke and self-destruct' at the same offset in the future
> :)
I do not know the future, but I think the 85xx processor should have a
compatible register define. I do not think the future 85xx processor
will use this offset for other usage. It will cause big confusion.
If you study the road map of 85xx processor register define, you can see
that next generation processors only use reserved offset for expanded
usage.

> 
> > Anyway, I can try your suggestion.
> 
> I'm thinking have a guts block and putting a property in it makes the 
> most sense.
> 
> - k
> 
