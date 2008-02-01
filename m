Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 45755DDF50
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Feb 2008 10:18:40 +1100 (EST)
Date: Fri, 1 Feb 2008 17:18:33 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Steven Hein <ssh@sgi.com>
Subject: Re: 8360 custom board, ucc_geth TX errors on longer(?) packets
Message-Id: <20080201171833.94f32da8.kim.phillips@freescale.com>
In-Reply-To: <47A397D7.30809@sgi.com>
References: <47A36A69.1010809@sgi.com>
	<20080201135324.8372268e.kim.phillips@freescale.com>
	<47A37B8E.5000500@sgi.com> <47A397D7.30809@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 01 Feb 2008 16:06:15 -0600
Steven Hein <ssh@sgi.com> wrote:

> Steven Hein wrote:
> > But we're using GMII to the switch....and that workaround
> > code wasn't in active in my old kernel (it was there, but
> > commented out).
> >
> > Any other thoughts?    Has anyone seen this symptom before?
> >
> > Steve
> >
> Okay....I found it!    Started poking at the UCCE registers
> and found that the FIFO sizes weren't right.   This led me
> to find a bug in my ucc_geth interface to the fixed-link
> PHY driver:  the code to reconfigure the MURAM FIFO's for
> Gigabit operation wasn't being executed for no-phy configs!
> All is well once I changed this.
> 
> Sorry for the noise.....   (glad I found this before
> submitting my patch!   ;-)
> 
yeah ucc_geth should be made aware of fixed-links on startup; UCCs
aren't like TSECs that know what MII type they're on.

setting phy-connection-type to certain strings containing a
'g' in the device tree should do the trick, too..:)

Kim
