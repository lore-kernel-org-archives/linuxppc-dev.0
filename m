Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 1567BDDEEF
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 11:54:14 +1100 (EST)
Date: Wed, 7 Mar 2007 17:54:43 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Scott Wood <scottwood@freescale.com>, "Mark A. Greer" <mgreer@mvista.com>,
	linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 11/15] zImage wrapper for Ebony
Message-ID: <20070308005443.GA21039@mag.az.mvista.com>
References: <20070305032307.GB31417@localhost.localdomain>
	<20070305032452.EDB2BDDF1D@ozlabs.org>
	<20070305171053.GC32672@mag.az.mvista.com>
	<20070306000905.GC4728@localhost.localdomain>
	<20070307194732.GB30721@ld0162-tx32.am.freescale.net>
	<20070308002400.GB3950@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070308002400.GB3950@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 08, 2007 at 11:24:00AM +1100, David Gibson wrote:
> On Wed, Mar 07, 2007 at 01:47:32PM -0600, Scott Wood wrote:
> > On Tue, Mar 06, 2007 at 11:09:05AM +1100, David Gibson wrote:
> > > On Mon, Mar 05, 2007 at 10:10:53AM -0700, Mark A. Greer wrote:

> > > Actually, longer term what I think might be a better option is to
> > > build *all* the dts files into asm (with different symbolic names) and
> > > fold them into the wrapper library.
> > 
> > I can see potential benefit in allowing multiple dtbs to be included, to
> > be chosen at runtime (such as from a board ID passed from the bootloader,
> > or based on detection of how the board is configured (such as detecting
> > whether an MDS board is plugged into a PCI backplane, or is acting as a
> > PCI agent, or is standalone)).  But why all of them?
> 
> Simplicity, and a better chance to pick up syntax errors at least for
> obscure platforms.  Note that they'd be going as separate modules into
> a .a, so only the relevant ones would be included in the final zImage.

This seems like overkill to me.  I believe Paul's intention was that
you could run the wrapper script any time (e.g., well after you built
the zImage).  I don't really see the benefit of building them all and
now you have to worry about stale .S' in the .a file when it so easy to
just run the wrapper script with whatever .dts file you want.

My $0.02.

Mark
