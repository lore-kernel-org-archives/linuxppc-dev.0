Message-ID: <38A0AE0D.2EB99353@zeta.org.au>
Date: Wed, 09 Feb 2000 11:00:13 +1100
From: Peter Allworth <linsol@zeta.org.au>
MIME-Version: 1.0
To: Jesper Skov <jskov@redhat.com>
CC: duncanp@research.canon.com.au, linuxppc-embedded@lists.linuxppc.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Low memory problems in 8xx Linux
References: <20000201235813.4F5611B51A@elph.research.canon.com.au> <38977960.40E014A1@zeta.org.au> <ot1z6of1ws.fsf@thinktwice.zoftcorp.dk>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Jesper Skov wrote:
>
> >>>>> "Peter" == Peter Allworth <linsol@zeta.org.au> writes:

<snip>

> Peter> If you need the MMU patches straight-away, I've put them on
>
> Peter> http://www.zeta.org.au/~linsol
>
> Peter> They only work against cllf-2.2.13 for now. Marcus Sundberg has
> Peter> sent me a revised patch which should work for other 2.2 kernels
> Peter> (caveat emptor).  I'll try to add that asap.
>
> Peter and Duncan,
>
> The 2.2.13 patch you posted was slightly (but critically) wrong, if
> I'm not mistaken. The value updated in memory was not reloaded into
> r21 which is where the code below this snipped expects to find the
> value.
>
> This patch should do the trick. At least my kernel seems to work.

Jesper,

Which kernel are you using and which patch file?
(Please double-check the readme.txt file.)

My http://www.zeta.org.au/~linsol directory contains two versions of the
patch to head.S. If you are using cllf-2.2.13 which includes the use of
r21 as you've described, then use "head.S-patch".

Marcus Sundberg provided the other file "head.S.non-cllf" which is
for older kernels that used r20 for the pte and didn't do the update
of the GUARDED bit. (I need to change the names in the diff headers
to make this clearer.)

You are wise to be cautious, however.
Neither Marcus (as far as I know) nor I have tested "head.S-non-cllf".
(Also, having just taken a second look at the file, I notice it doesn't
include all of the changes so I'd regard it as informational only.)

As for optimising away the _PAGE_PRESENT test, I haven't thought through
whether that can be done or not. It's a couple of weeks since I made the
change and the whole think is definitely a quick-and-dirty fix
(no pun intended). What I was trying to avoid was making a reference
to a second level page table through an invalid entry in the first level
table. You've prompted me to take another look at this code!

Cheers,

PeterA.

> --- head.S.orig Sat Oct 23 00:18:03 1999
> +++ head.S      Tue Feb  8 10:34:02 2000
> @@ -1024,6 +1024,18 @@
>         ori     r21, r21, 1     /* Set valid bit in physical L2 page */
>         mtspr   MD_TWC, r21     /* Load pte table base address */
>         mfspr   r21, MD_TWC     /* ....and get the pte address */
> +       lwz     r20, 0(r21)                     /* Get the pte */
> +       andi.   r20, r20, _PAGE_PRESENT         /* Set cr0 if it's invalid */
> +       beq     4f                              /* Skip update if invalid */
> +       mfspr   r20, DSISR                      /* Check for store op */
> +       andis.  r20, r20, 0x0200                /* If set, indicates store */
> +       lwz     r20, 0(r21)                     /* Get the pte again */
> +       beq     3f
> +       ori     r20, r20, _PAGE_DIRTY|_PAGE_HWWRITE /* Set the dirty flags */
> +3:
> +       ori     r20, r20, _PAGE_ACCESSED        /* Set the accessed flag */
> +       stw     r20, 0(r21)                     /* Update the pte */
> +4:
>         lwz     r21, 0(r21)     /* Get the pte */
>
>         /* Set four subpage valid bits (24, 25, 26, and 27).
>
> An alternative and slighly faster implementation might be to skip the
> _PAGE_PRESENT check. Any reason something like this wouldn't work?
>
>         ori     r21, r21, 1     /* Set valid bit in physical L2 page */
>         mtspr   MD_TWC, r21     /* Load pte table base address */
>         mfspr   r21, MD_TWC     /* ....and get the pte address */
>         mfspr   r20, DSISR                      /* Check for store op */
>         andis.  r20, r20, 0x0200                /* If set, indicates store */
>         lwz     r20, 0(r21)                     /* Get the pte again */
>         beq     3f
>         ori     r20, r20, _PAGE_DIRTY|_PAGE_HWWRITE /* Set the dirty flags */
> 3:
>         ori     r20, r20, _PAGE_ACCESSED        /* Set the accessed flag */
>         stw     r20, 0(r21)                     /* Update the pte */
>         mr      r21, r20        /* Get the pte */
>
> Cheers,
> Jesper

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
