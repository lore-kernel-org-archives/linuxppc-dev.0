Return-Path: <dgibson@ozlabs.org>
Date: Thu, 27 Sep 2007 12:45:35 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 8/15] bootwrapper: convert flatdevtree to version 16
Message-ID: <20070927024535.GC14030@localhost.localdomain>
References: <boot-8-00.miltonm@bga.com> <boot-8-08.miltonm@bga.com>
	<20070924033612.GI8058@localhost.localdomain>
	<5e71423247aef068d82b84166102fd7d@bga.com>
	<20070925034616.GB2525@localhost.localdomain>
	<69f1ad37eec293a4c4616d04c8400ca4@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <69f1ad37eec293a4c4616d04c8400ca4@bga.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 26, 2007 at 11:19:47AM -0500, Milton Miller wrote:
> On Sep 24, 2007, at 10:46 PM, David Gibson wrote:
> > On Mon, Sep 24, 2007 at 01:54:32AM -0500, Milton Miller wrote:
> >> On Sep 23, 2007, at 10:36 PM, David Gibson wrote:
> >>> On Fri, Sep 21, 2007 at 06:05:06PM -0500, Milton Miller wrote:
> > [snip]
> >>>> +#define MIN_VERSION 2
> >>>> +#define OUT_VERSION 16
> >>>
> >>> Should output version 17.  In any case, don't try to be so general -
> >>> just convert v123 (all basically the same) to latest (i.e. v17)
> >>> without all the #if nonsense.
> >>
> >> Outputing v17 instead of 16 requires more words to be added to the
> >> header, and the library does fine with v16.
> >
> > For now.  libfdt will want v17.  Although it will (eventually) have
> > it's own v16->v17 conversion code.
> 
> If libfdt gets merged without supporting v16 input, then that will be a  
> regression.  This code isn't pretending to address that.   The current  
> flat tree code works with v16.

Hrm, true.  Since I'm working on merging libfdt right now, I guess
that moves up my schedule for getting the v16->v17 conversion code
working.

> 
> >>  Actually the v1 trees has
> >> some other differences such as initrd addresses were kernel linear not
> >> real, cpus were assigned logical numbers  ... so while the structure
> >> didn't change except for the header field, the contents did.
> >
> > !? what's your source for this.  v2 and v3 were absolutely supposed to
> > be backwards compatible with v1 which would not be the case with
> > silent semantic changes such as this.
> 
> What's your souce for saying the were supposed to be backwards  
> compatable?  That dtc fills out the struct header so?

Sitting next to BenH and knowing he always intended them to be so.

> My source is my involvment when v2 was defined (they were discovered  
> while writing my device tree generation code):
> 
> The actual binary structure is compatable, just not the contents of the  
> properties nor how any slave cpus wait (for some trees it doesn't  
> matter).
> 
> http://git.kernel.org/?p=linux/kernel/git/horms/kexec-tools- 
> testing.git;a=blob;f=kexec/arch/ppc64/fs2dt.c; 
> hb=b84b87747a16f0afbef6f6802bb794a94f4961d9

An old version of fs2dt is hardly definitive.  It could just be Plain
Wrong, nothing to do with the dt version.

> And some more changes just before that:
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/old-2.6-bkcvs.git; 
> a=history;f=arch/ppc64/kernel/prom_init.c; 
> h=e570799a84cc5328e9f0fd44592cb0b828d8c13a; 
> hb=4ae24c4e8a8f68950a7774ca1cdfe69bfe4e2ffc

I don't know what bit you're referring to in that batch of commits.

> So its mostly when the kernel generated and required v1 trees, it was  
> ppc64 only and had these other content and handoff semantics.  If it  
> were to get a v1 tree, it only copes for the boot cpu determination    
> I'm not aware of any code other than the kernel that would actually  
> generate a v1 tree (other than dtc, which always supporteed v2, and  
> doesn't care about these differences).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
