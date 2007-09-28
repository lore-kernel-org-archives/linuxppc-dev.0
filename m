Return-Path: <dgibson@ozlabs.org>
Date: Fri, 28 Sep 2007 12:40:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 8/15] bootwrapper: convert flatdevtree to version 16
Message-ID: <20070928024052.GA18840@localhost.localdomain>
References: <boot-8-00.miltonm@bga.com> <boot-8-08.miltonm@bga.com>
	<20070924033612.GI8058@localhost.localdomain>
	<5e71423247aef068d82b84166102fd7d@bga.com>
	<20070925034616.GB2525@localhost.localdomain>
	<69f1ad37eec293a4c4616d04c8400ca4@bga.com>
	<20070927024535.GC14030@localhost.localdomain>
	<41180fced14196db80f261d2ac1909e0@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <41180fced14196db80f261d2ac1909e0@bga.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 27, 2007 at 10:44:27AM -0500, Milton Miller wrote:
> 
> On Sep 26, 2007, at 9:45 PM, David Gibson wrote:
[snip]
> >> What's your souce for saying the were supposed to be backwards
> >> compatable?  That dtc fills out the struct header so?
> >
> > Sitting next to BenH and knowing he always intended them to be so.
> >
> >> My source is my involvment when v2 was defined (they were discovered
> >> while writing my device tree generation code):
> >>
> >> The actual binary structure is compatable, just not the contents of  
> >> the
> >> properties nor how any slave cpus wait (for some trees it doesn't
> >> matter).
> >>
> >> http://git.kernel.org/?p=linux/kernel/git/horms/kexec-tools-
> >> testing.git;a=blob;f=kexec/arch/ppc64/fs2dt.c;
> >> hb=b84b87747a16f0afbef6f6802bb794a94f4961d9
> >
> > An old version of fs2dt is hardly definitive.  It could just be Plain
> > Wrong, nothing to do with the dt version.
> 
> Sorry, copy and paste error.  I was tring to point out this changelog  
> in 2.6.10:
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/old-2.6-bkcvs.git; 
> a=commitdiff;h=e1b47549d1588ccea1fa5726eb430aae4e80f8ed

Hrm, I see, yes that seems conclusive enough.  Yuck.

In which case, I think we should try to forget that v1 ever existed.
I don't think anyone ever generated v1 trees other than kernels which
also consumed them, and I doubt current kernels will correctly deal
with v1 trees in this form.

In any case, this is all rather beside the point.  My basic point is
that this bootwrapper stuff should not attempt to be a general
backwards compatibility layer for every broken early dt format that
ever existed.  In general we should try to make sure nothing ever uses
<v16 trees.  We want, here, to do the minimum we can get away with to
support the specific v2 trees produced by kexec-tools, as an interim
measure while kexec-tools itself is fixed to produce v17 trees (say,
by replacing fs2dt with dtc plus a libfdt based post-processing
program).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
