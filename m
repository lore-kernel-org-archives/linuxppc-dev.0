Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8C0FAB707D
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jun 2010 09:16:25 +1000 (EST)
Subject: Re: [PATCH 3/5] of/address: Merge all of the bus translation code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <AANLkTin5sMa-imgNeY4kM8wofnxUyQOtOT-gLILL7rlj@mail.gmail.com>
References: <20100608140917.25879.67745.stgit@angua>
	<20100608141008.25879.2050.stgit@angua>
	<1276152212.1962.59.camel@pasglop>
	<AANLkTiltEWJQa5FL0Pjpd8JeQdo-ECBSM5EJHruIAJK0@mail.gmail.com>
	<AANLkTin5sMa-imgNeY4kM8wofnxUyQOtOT-gLILL7rlj@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 22 Jun 2010 09:16:05 +1000
Message-ID: <1277162165.8826.219.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	Michal Simek <monstr@monstr.eu>, microblaze-uclinux@itee.uq.edu.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-06-21 at 15:06 -0600, Grant Likely wrote:
> On Thu, Jun 10, 2010 at 8:26 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> > On Thu, Jun 10, 2010 at 12:43 AM, Benjamin Herrenschmidt
> > <benh@kernel.crashing.org> wrote:
> >> On Tue, 2010-06-08 at 08:10 -0600, Grant Likely wrote:
> >>> Microblaze and PowerPC share a large chunk of code for translating
> >>> OF device tree data into usable addresses.  There aren't many differences
> >>                                                           ^^^^
> >> Care to comment on these differences ?
> >
> > Purely cosmetic IIRC, but I will go back and double check.  Things
> > like printk vs. pr_info and some style differences.  I looked at them
> > side-by-side and fixed each difference individually until they were
> > identical.
> >
> >>> between the two, so merge the codebase wholesale rather than trying to
> >>> work out the independent bits.
> >>
> >> Well, I don't see ifdef's in the resulting code (but I'm a bit blind),
> >> so what did you do with the differences ?
> >>
> >> This is complex and fragile code, so any change to it must be very
> >> carefully scrutinized.
> 
> Hi Ben,
> 
> I've double checked side-by-side.  The changes are all cosmetic expect
> for the addition of dma-ranges support on the powerpc version that
> hadn't been applied to microblaze.  This patch takes the powerpc code
> plus the cosmetic changes (spaces, pr_debug vs DBG, etc) from the
> microblaze side.  There should be no functional changes to either
> platform since microblaze doesn't currently use dma-ranges anyway.
> 
> Here's the new commit text:

Ok.

Cheers
,Ben.

> ----
>     of/address: Merge all of the bus translation code
> 
>     Microblaze and PowerPC share a large chunk of code for translating
>     OF device tree data into usable addresses.  Differences between the two
>     consist of cosmetic differences, and the addition of dma-ranges support
>     to powerpc but not microblaze.  This patch moves the powerpc
>     version into common code and applies many of the cosmetic (non-functional)
>     changes from the microblaze version.
> ----
> 
> I've only changed the commit text.  The patch remains unchanged.  Are
> you okay with this patch?
> 
> Cheers,
> g.
> 
> 
> >>
> >> Cheers,
> >> Ben.
> >>
> >>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> >>> CC: Michal Simek <monstr@monstr.eu>
> >>> CC: Wolfram Sang <w.sang@pengutronix.de>
> >>> CC: Stephen Rothwell <sfr@canb.auug.org.au>
> >>> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >>> CC: microblaze-uclinux@itee.uq.edu.au
> >>> CC: linuxppc-dev@ozlabs.org
