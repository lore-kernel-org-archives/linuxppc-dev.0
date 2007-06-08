Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id F1D6FDDF43
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Jun 2007 03:20:39 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Fri, 8 Jun 2007 10:20:37 -0700
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Add Marvell mv64x60 udbg putc/getc functions
Message-ID: <20070608172037.GA9192@xyzzy.farnsworth.org>
References: <20070523220518.GA2312@xyzzy.farnsworth.org>
	<18022.20173.857845.49576@cargo.ozlabs.ibm.com>
	<20070606172900.GA29951@xyzzy.farnsworth.org>
	<1181268915.6026.5.camel@concordia.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1181268915.6026.5.camel@concordia.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jun 08, 2007 at 12:15:15PM +1000, Michael Ellerman wrote:
> On Wed, 2007-06-06 at 10:29 -0700, Dale Farnsworth wrote:
> > On Wed, Jun 06, 2007 at 04:06:05PM +1000, Paul Mackerras wrote:
> > > Dale Farnsworth writes:
> > > 
> > > > Paul, this patch is unchanged from the one I posted 10 days ago.
> > > > At that time, I saw no discussion, other than Mark's ACK.  I'd 
> > > > argue that this is a bugfix, and hope that it could go into 2.6.22.
> > > 
> > > Um, it seems rather large, and in particular adds a fair bit of
> > > completely new code.  Is there a simpler way of getting to an
> > > acceptable point - e.g. just not use the udbg console on these boards?
> > 
> > Yeah, that was the first approach I took.  Unfortunately, currently the
> > udbg console is included unconditionally on arch/powerpc.  I created the
> > patch below to conditionalize the use of udbg console.  I thought it a
> > bit risky for 2.6.22, but I think it's the right approach long term.
> > 
> > > If we don't have udbg support for them then the udbg console would
> > > seem a bit pointless, no?
> > 
> > There is value in that with the udbg console we do see console output
> > much earlier.  While there's some new code (I didn't think it was all
> > that much), the impact is limited to the single platform now using the
> > mv64x60 console port, the prpmc2800.
> 
> You don't select PPC_UDBG for any of the cell platforms, which AFAICT
> means you'll break early debugging on those.

Actually, I do select PPC_UDBG for PPC_IBM_CELL_BLADE (via
PPC_UDBG_16550) and for PPC_CELLEB (via PPC_UDBG_BEAT).  I couldn't
figure out which console PPC_PS3 uses, but that support is noted as
incomplete, so I didn't spend much time researching it.

Still, it's difficult to be sure I caught them all; that's why I
decided to defer the patch until the next merge window.

> I think you should be able to do this in terms of
> CONFIG_PPC_EARLY_DEBUG, which already exists.

Nope.  Many platforms use the udbg console early on without enabling
CONFIG_PPC_EARLY_DEBUG.

-Dale
