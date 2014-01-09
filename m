Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0188.outbound.protection.outlook.com [207.46.163.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F3BD32C0079
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jan 2014 08:19:41 +1100 (EST)
Message-ID: <1389302368.14390.33.camel@snotra.buserror.net>
Subject: Re: =?UTF-8?Q?=E7=AD=94=E5=A4=8D=3A?= [v7] clk: corenet: Adds the
 clock binding
From: Scott Wood <scottwood@freescale.com>
To: Tang Yuantian-B29983 <Yuantian.Tang@freescale.com>
Date: Thu, 9 Jan 2014 15:19:28 -0600
In-Reply-To: <e15511a79a9d4446a826da8d9ceec229@BL2PR03MB115.namprd03.prod.outlook.com>
References: <1384938289-24713-1-git-send-email-Yuantian.Tang@freescale.com>
 <20140108002115.GA19801@home.buserror.net>
 <375c32b2f4e34589ae336af61468a51b@BL2PR03MB115.namprd03.prod.outlook.com>
 <20140108093046.GB6701@e106331-lin.cambridge.arm.com>
 <1389206619.25654.9.camel@snotra.buserror.net>
 <e15511a79a9d4446a826da8d9ceec229@BL2PR03MB115.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-01-08 at 20:57 -0600, Tang Yuantian-B29983 wrote:
> Thanks for you review.
> See my response inline.
> 
> Thanks,
> Yuantian
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: 2014年1月9日 星期四 2:44
> > To: Mark Rutland
> > Cc: Tang Yuantian-B29983; galak@kernel.crashing.org;
> > devicetree@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> > Subject: Re: 答复: [v7] clk: corenet: Adds the clock binding
> > 
> > On Wed, 2014-01-08 at 09:30 +0000, Mark Rutland wrote:
> > > On Wed, Jan 08, 2014 at 08:53:56AM +0000, Yuantian Tang wrote:
> > > >
> > > > ________________________________________
> > > > 发件人: Wood Scott-B07421
> > > > 发送时间: 2014年1月8日 8:21
> > > > 收件人: Tang Yuantian-B29983
> > > > 抄送: galak@kernel.crashing.org; mark.rutland@arm.com;
> > > > devicetree@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> > > > 主题: Re: [v7] clk: corenet: Adds the clock binding
> > > >
> > > > On Wed, Nov 20, 2013 at 05:04:49PM +0800, tang yuantian wrote:
> > > > > +Recommended properties:
> > > > > +- ranges: Allows valid translation between child's address space
> > and
> > > > > +     parent's. Must be present if the device has sub-nodes.
> > > > > +- #address-cells: Specifies the number of cells used to represent
> > > > > +     physical base addresses.  Must be present if the device has
> > > > > +     sub-nodes and set to 1 if present
> > > > > +- #size-cells: Specifies the number of cells used to represent
> > > > > +     the size of an address. Must be present if the device has
> > > > > +     sub-nodes and set to 1 if present
> > > >
> > > > Why are we specifying #address-cells/#size-cells here?
> > > >
> > > > A: it has sub-nodes which have REG property, don't we need to
> > > > specify #address-cells/#size-cells?
> > >
> > > If a node has a reg entry, its parent should have #size-cells and
> > > #address-cells to allow it to be parsed properly.
> > 
> > Yes, but why do we need to specify in this binding how many cells there
> > will be, especially since this binding only addresses the clock provider
> > aspect of the clockgen nodes (e.g. it doesn't describe the reg)?  Or
> > rather, it's partially describing the non-clock aspect, and doesn't
> > address the clock aspect at all AFAICT.
> > 
> First of all, they are not "Required properties", they are optional.
> If present, we should give them a value of 1.

Why does it matter, so long as the values translate properly?  It's not
as if you're defining a special reg format.  It's not that big of a
deal, but it seems unnecessary.

> Then, yes, this binding describes clockgen node which is "CLOCK BLOCK".

Sorry, I missed where "reg" was documented due to the
required/recommended split.

> > Where does the actual input clock frequency go?  U-Boot puts it in the
> > clockgen node itself as clock-frequency, but that isn't described in the
> > binding.  How does that relate to the sysclk node?  If "fsl,qoriq-sysclk-
> > 1.0" is supposed to indicate that clock-frequency can be found in the
> > parent node, that isn't specified by the binding, nor is clock-frequency
> > shown in the example.
> > 
> clock-frequency is a wired property.

Do you mean "weird"?

> It is in clockgen node right now.
> But it should be placed somewhere in clock nodes.

If we were doing this from scratch, yes, but there's existing U-Boot
code that we want to be compatible with.

> If I describe here, I would be asked why it is related to clockgen node?

That's not a good reason to leave it undocumented.

> > What is the difference between "fsl,qoriq-sysclk-1.0" and "fsl,qoriq-
> > sysclk-2.0"?  How does the concept of a fixed input clock change?
> >
> Technically, there is no difference between *sysclk-1.0 and *-2.0, just like
> Clockgen-2.0 and 1.0. Naming like this just to indicate they belong to chassis 2.0 
> and 1.0 respectively.

I guess it's OK if it encourages people to consider switching to the
standard fixed-clock for future chassis.

So the only thing that really needs to be fixed is the missing
clock-frequency documentation.

-Scott
