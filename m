Message-Id: <200004111843.OAA19252@hoover.gilbarco.com>
From: "Wohlgemuth, Jason" <jason_wohlgemuth@gilbarco.com>
To: "Wohlgemuth, Jason" <jason_wohlgemuth@gilbarco.com>,
        "'Marcus Sundberg'"
	 <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Cc: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>,
        "Royal, Bill"
	 <bill_royal@gilbarco.com>,
        "Banks, Kelly" <kelly_banks@gilbarco.com>
Subject: RE: Low Memory / Software Emulation Exception / Performance
Date: Tue, 11 Apr 2000 14:43:21 -0400
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Marcus,

Okay... The performance issue has been resolved... I had to patch the head.S
in several places.  I should have looked into this before mailing the list.

head.S-non-cllf didn't contain all of the patch, and head.S-patch didn't
work.  With a combination of the two, the issue has been resolved.  Here is
a diff from the normal head.S distributed from mpc8xx-2.2.13

4c4
<  *  $Id: head.S,v 1.1.1.1 2000/01/03 15:56:48 jason Exp $
---
>  *  $Id: head.S,v 1.3 2000/04/10 14:52:26 jason Exp $
904,905c904,913
<       mfspr   r21, MD_TWC     /* ....and get the pte address */
<       lwz     r21, 0(r21)     /* Get the pte */
---
>       /* mfspr        r21, MD_TWC     */ /* ....and get the pte address */
>       /* lwz  r21, 0(r21)     */ /* Get the pte */
>       mfspr   r20, MD_TWC             /* ....and get the pte address */
>       lwz     r21, 0(r20)                     /* Get the pte */
>       andi.   r21, r21, _PAGE_PRESENT         /* Set cr0 if it's invalid
*/
>       lwz     r21, 0(r20)                     /* Get the pte again */
>       beq     3f                              /* Skip update if invalid */
>       ori     r21, r21, _PAGE_ACCESSED        /* Set the accessed flag */
>       stw     r21, 0(r20)                     /* Update the pte */
> 3:
1026a1035,1046
>       lwz     r20, 0(r21)                     /* Get the pte */
>       andi.   r20, r20, _PAGE_PRESENT         /* Set cr0 if it's invalid
*/
>       beq     4f                              /* Skip update if invalid */
>       mfspr   r20, DSISR                      /* Check for store op */
>       andis.  r20, r20, 0x0200                /* If set, indicates store
*/
>       lwz     r20, 0(r21)                     /* Get the pte again */
>       beq     3f
>       ori     r20, r20, _PAGE_DIRTY|_PAGE_HWWRITE /* Set the dirty flags
*/
> 3:
>       ori     r20, r20, _PAGE_ACCESSED        /* Set the accessed flag */
>       stw     r20, 0(r21)                     /* Update the pte */
> 4:
1116c1136,1137
<       ori     r21, r21, _PAGE_DIRTY   /* Update changed bit */
---
>       /* ori  r21, r21, _PAGE_DIRTY */        /* Update changed bit */
>       ori     r21, r21, _PAGE_DIRTY|_PAGE_HWWRITE|_PAGE_ACCESSED



-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of
Wohlgemuth, Jason
Sent: Tuesday, April 11, 2000 1:21 PM
To: 'Marcus Sundberg'
Cc: 'linuxppc-embedded@lists.linuxppc.org'; Royal, Bill; Banks, Kelly
Subject: RE: Low Memory / Software Emulation Exception / Performance



Marcus,

We are mapping memory that is above RAM, it has worked without any problems
until I applied the dirty page fix.  After that doing a memset on 96k of
/dev/mem mapped memory takes several minutes.  I will do some more
experiments and get back to you.

Jason

-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Marcus
Sundberg
Sent: Tuesday, April 11, 2000 12:41 PM
To: Wohlgemuth, Jason
Cc: 'linuxppc-embedded@lists.linuxppc.org'; Royal, Bill
Subject: Re: Low Memory / Software Emulation Exception / Performance



"Wohlgemuth, Jason" <jason_wohlgemuth@gilbarco.com> writes:

> Just a few more questions.  After applying the head.S patch our software
> emulation exceptions have gone away, although, I intend to go back and
trip
> the exception with a logic analyzer attached to verify everything with our
> hardware engineer.  However, this patch seems to induce ultra-slow
> performance in areas where we map physical memory down to the user-level
> with /dev/mem, my guess is that it has something to do with this:

Tring to map in RAM via /dev/mem is equivalent to mapping /dev/zero -
you'll get anonymous private pages (which are cached). Don't ask me
why it is done like that... Trying to map in memory above RAM via
/dev/mem will work as intended, and will always give you caching
inhibited pages.

The dirty page fix should not alter this behaviour afaikt.

Which is it that you are doing?

> Specifically, the part regarding _PAGE_WRITETHRU being redefined to
> _PAGE_NO_CACHE, is this a correct assumption?

Yes, but _PAGE_WRITETHRU is not used by anything in the standard
kernel so it shouldn't make any difference.

>  Is anyone else running into performance related issues with this
> patch applied?

I haven't noted anything like that, but on the other hand we have
no apps mapping /dev/mem.

//Marcus
--
Signature under construction, please come back later.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
