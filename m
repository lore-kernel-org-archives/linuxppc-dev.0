Return-Path: <jwboyer@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by ozlabs.org (Postfix) with ESMTP id 6E8B8DDE16
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Dec 2007 01:17:34 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so4748511wag
	for <linuxppc-dev@ozlabs.org>; Sun, 02 Dec 2007 06:17:33 -0800 (PST)
Date: Sun, 2 Dec 2007 08:17:23 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 12/24] powerpc: 4xx PLB to PCI Express support
Message-ID: <20071202081723.7bb6a7f4@vader.jdub.homelinux.org>
In-Reply-To: <200712021332.29074.sr@denx.de>
References: <20071130061155.41D71DDF5F@ozlabs.org>
	<200712021332.29074.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2 Dec 2007 13:32:28 +0100
Stefan Roese <sr@denx.de> wrote:

> Hi Ben,
> 
> On Friday 30 November 2007, Benjamin Herrenschmidt wrote:
> > This adds to the previous 2 patches the support for the 4xx PCI Express
> > cells as found in the 440SPe revA, revB and 405EX.
> >
> > Unfortunately, due to significant differences between these, and other
> > interesting "features" of those pieces of HW, the code isn't as simple
> > as it is for PCI and PCI-X and some of the functions differ significantly
> > between the 3 implementations. Thus, not only this code can only support
> > those 3 implementations for now and will refuse to operate on any other,
> > but there are added ifdef's to avoid the bloat of building a fairly large
> > amount of code on platforms that don't need it.
> >
> > Also, this code currently only supports fully initializing root complex
> > nodes, not endpoint. Some more code will have to be lifted from the
> > arch/ppc implementation to add the endpoint support, though it's mostly
> > differences in memory mapping, and the question on how to represent
> > endpoint mode PCI in the device-tree is thus open.
> >
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > ---
> >
> > 440SPeA is untested, 440SPeB is slightly tested (with a sky2 network card
> > on port 0 only for now) and 405EX is untested.
> 
> As already mentioned I'm experiencing some problems with this current version. 
> At least what's available in Josh's 2.6.25-candidates branch. The kernel 
> crashes in the first ppc4xx_pciex_read_config() call upon (after I fixed the 
> small problem mentioned further down below):
> 
> 	BUG_ON(hose != port->hose);
> 
> So before digging into this deeper, I wanted to check if you don't have a 
> slightly "better" version which passed your tests with the sky2 PCIe card.

These should be the latest versions that Ben sent out.  I plan on
applying newer versions to that branch as they come out, which means
the git branch will probably reset often for a bit.

I have some other patches I want to pull into there as well anyway.

josh
