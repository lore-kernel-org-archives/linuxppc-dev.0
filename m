Return-Path: <ayman@elkhashab.com>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.124]) by ozlabs.org (Postfix) with ESMTP id EE16AB6F54
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jun 2011 04:20:09 +1000 (EST)
Received: from hrndva-omtalb.mail.rr.com ([10.128.143.52])
	by hrndva-qmta02.mail.rr.com with ESMTP
	id <20110629181507825.KHFU5185@hrndva-qmta02.mail.rr.com>
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2011 18:15:07 +0000
Date: Wed, 29 Jun 2011 13:13:58 -0500
From: Ayman El-Khashab <ayman@elkhashab.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: powerpc/4xx: Regression failed on sil24 (and other) drivers
Message-ID: <20110629181358.GA31618@crust.elkhashab.com>
References: <20110625235259.GA18837@crust.elkhashab.com>
	<1309169996.32158.390.camel@pasglop>
	<20110627113137.GA10387@crust.elkhashab.com>
	<1309311723.32158.514.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1309311723.32158.514.camel@pasglop>
Cc: cam@cs.ualberta.ca, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 29, 2011 at 11:42:03AM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2011-06-27 at 06:31 -0500, Ayman El-Khashab wrote:
> > On Mon, Jun 27, 2011 at 08:19:56PM +1000, Benjamin Herrenschmidt wrote:
> > > On Sat, 2011-06-25 at 18:52 -0500, Ayman El-Khashab wrote:
> > > > I noticed during a recent development with the 460SX that a
> > > > simple device that once worked stopped.  I did a bisect to
> > > > find the offending commit and it turns out to be this one:
> > > > 
> > > > 0e52247a2ed1f211f0c4f682dc999610a368903f is the first bad
> > > > commit
> > > > commit 0e52247a2ed1f211f0c4f682dc999610a368903f
> > > > Author: Cam Macdonell <cam@cs.ualberta.ca>
> > > > Date:   Tue Sep 7 17:25:20 2010 -0700
> > > > 
> > > >     PCI: fix pci_resource_alignment prototype
> > > > 
> 
....
> 
> I suspect you don't have CONFIG_PCI_QUIRKS enabled... I think that's the
> cause of your problem.
> 
> It looks like this config option controls both compiling the "generic"
> quirks in from drivers/pci/quirk.c, and the actually mechanism for
> having quirks in the first place (pci_fixup_device() goes away without
> that config option).
> 
> I think we probably want to unconditionally select that if CONFIG_PCI is
> enabled in arch/powerpc...
> 
> Can you try changing it and tell us if that helps ?

Yes, that fixed our problem, thanks for your time.  I am
going to try to get the MSI to work.

Ayman
