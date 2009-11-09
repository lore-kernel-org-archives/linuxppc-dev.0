Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F3B7BB7334
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Nov 2009 18:00:06 +1100 (EST)
Date: Mon, 9 Nov 2009 17:00:04 -0600
From: Scott Wood <scottwood@freescale.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH 0/8] 8xx: Misc fixes for buggy insn
Message-ID: <20091109230004.GA24671@loki.buserror.net>
References: <1257341920-29277-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20091106003305.GA15814@loki.buserror.net>
	<OF2C4359C9.0EB89938-ONC1257666.00299975-C1257666.002C206F@transmode.se>
	<OFBF62CE94.BC53D847-ONC1257666.0033CF65-C1257666.0034293A@transmode.se>
	<20091109215321.GA4351@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091109215321.GA4351@loki.buserror.net>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 09, 2009 at 03:53:21PM -0600, Scott Wood wrote:
> On Fri, Nov 06, 2009 at 10:29:44AM +0100, Joakim Tjernlund wrote:
> > > > With this, the kernel hangs after "Mount-cache hash table entries: 512".
> > >
> > > Somewhat surprising result. I didn't expect you would even hit this
> > > condition now as we haven't enabled the use of dcbX insn yet.
> > > The only thing I can think of is the you hit the 0x00f0 due to other
> > > dcbX insn use and the kernel managed to fixup this in the page fault handler
> > > by pure luck before.
> 
> It's bizarre -- it still happens even if I revert the branch to FixupDAR. 
> However, if I comment out the final "b 151b", it stops happening.  It also
> stops happening sometimes depending on where I stick printk()s to debug
> this.
> 
> So it may be an unrelated issue that just got perturbed somehow.

OK, figured it out.  The fixup code pushed things around so that in
syscall_exit_cont, SRR0/SRR1 were being loaded immediately prior to a page
boundary, with the rfi after the page boundary.  On crossing the boundary,
we take an ITLB miss (which goes from possibility to certainty with the
CPU15 workaround), and SRR0/SRR1 get clobbered.

I suppose we'll need to find all places where we do rfi with the MMU
enabled, and ensure acceptable alignment. :-(

Either that, or require that the kernel text be pinned, though that does not
interact well with CPU15.

-Scott
