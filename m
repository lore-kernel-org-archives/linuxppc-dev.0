Date: Wed, 5 Sep 2001 09:11:11 -0500 (CDT)
Message-Id: <200109051411.f85EBBP12390@pacific.somerset.sps.mot.com>
From: Edward Swarthout <swarthou@ibmoto.com>
To: dan@mvista.com
Cc: linuxppc-dev@lists.linuxppc.org
In-reply-to: <3B954F7D.38D91654@mvista.com> (message from Dan Malek on Tue, 04
	Sep 2001 18:02:37 -0400)
Subject: Re: Assorted patches - number one
References: <200108311711.f7VHBxS14716@pacific.somerset.sps.mot.com> <15251.459.153586.712142@cargo.ozlabs.ibm.com> <3B954F7D.38D91654@mvista.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


From: Dan Malek:
>
> Paul Mackerras wrote:
>
> > These are the 4xx registers, aren't they?  We had definitions in like
> > this before, does anyone remember why they were removed?
>
> The 7450 has a 'software TLB' mode, which would use these registers.
> I didn't plan on ever using that mode in Linux, so there really isn't
> any need for them to be defined.

For software TLB the 7450 re-uses three of the 603 sprs:
#define	SPRN_TLBMISS	0x3D4	/* 980 7450 TLB Miss Register */
#define	SPRN_PTEHI	0x3D5	/* 981 7450 PTEHI */
#define	SPRN_PTELO	0x3D6	/* 982 7450 PTELO */

As for a software TLB mode for 7450, the Book-E processors only have a
software managed TLB, so I'm real interested in the performance
tradeoffs here.  I think an option for 7450 would be useful.

> I'm also a minimalist programmer.....why do we define all of this crap
> if we don't use it?  If you want to know how _all_ of the registers and
> bits are used, read the programming manual for the processor.......

I'd prefer if some authority defined all the SPR bits and verified
they did what the documentation claims they do.  Then if a bit is
needed (say to work around some errata), it could just be referenced.
This could also be used to automate the display of spr decodes via
/proc/sys/kernel/SPR interface instead of the current l2cr/l3cr proc
implementation.

Ed

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
