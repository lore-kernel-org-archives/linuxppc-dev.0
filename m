To: Peter Allworth <linsol@zeta.org.au>
Cc: duncanp@research.canon.com.au, linuxppc-embedded@lists.linuxppc.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Low memory problems in 8xx Linux
References: <20000201235813.4F5611B51A@elph.research.canon.com.au> <38977960.40E014A1@zeta.org.au>
From: Jesper Skov <jskov@redhat.com>
Date: 08 Feb 2000 11:01:55 +0100
In-Reply-To: Peter Allworth's message of "Wed, 02 Feb 2000 11:25:04 +1100"
Message-ID: <ot1z6of1ws.fsf@thinktwice.zoftcorp.dk>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "Peter" == Peter Allworth <linsol@zeta.org.au> writes:

Peter> duncanp@research.canon.com.au wrote:
>>  Dan,
>>
>> On 1 Feb, Dan Malek wrote: > I have already incorporated most of
>> these into 2.3.xx > kernel, and a 2.2.13 version that I will update
>> as a tar file > on a server.
>>
>> would you mind posting a diff against the current 2.2.13 kernel on
>> the ftp server when you do this as well? we've got a kernel in CVS
>> here (i imagine plently of others are doing this too), and it would
>> be easier for us if we can patch it.
>>
>> Dunk.

Peter> Dunk,

Peter> If you need the MMU patches straight-away, I've put them on

Peter> http://www.zeta.org.au/~linsol

Peter> They only work against cllf-2.2.13 for now. Marcus Sundberg has
Peter> sent me a revised patch which should work for other 2.2 kernels
Peter> (caveat emptor).  I'll try to add that asap.

Peter and Duncan,

The 2.2.13 patch you posted was slightly (but critically) wrong, if
I'm not mistaken. The value updated in memory was not reloaded into
r21 which is where the code below this snipped expects to find the
value.

This patch should do the trick. At least my kernel seems to work.


--- head.S.orig	Sat Oct 23 00:18:03 1999
+++ head.S	Tue Feb  8 10:34:02 2000
@@ -1024,6 +1024,18 @@
 	ori	r21, r21, 1	/* Set valid bit in physical L2 page */
 	mtspr	MD_TWC, r21	/* Load pte table base address */
 	mfspr	r21, MD_TWC	/* ....and get the pte address */
+	lwz	r20, 0(r21)			/* Get the pte */
+	andi.	r20, r20, _PAGE_PRESENT		/* Set cr0 if it's invalid */
+	beq	4f				/* Skip update if invalid */
+	mfspr	r20, DSISR			/* Check for store op */
+	andis.	r20, r20, 0x0200		/* If set, indicates store */
+	lwz	r20, 0(r21)			/* Get the pte again */
+	beq	3f
+	ori	r20, r20, _PAGE_DIRTY|_PAGE_HWWRITE /* Set the dirty flags */
+3:
+	ori	r20, r20, _PAGE_ACCESSED	/* Set the accessed flag */
+	stw	r20, 0(r21)			/* Update the pte */
+4:
 	lwz	r21, 0(r21)	/* Get the pte */

 	/* Set four subpage valid bits (24, 25, 26, and 27).


An alternative and slighly faster implementation might be to skip the
_PAGE_PRESENT check. Any reason something like this wouldn't work?


 	ori	r21, r21, 1	/* Set valid bit in physical L2 page */
 	mtspr	MD_TWC, r21	/* Load pte table base address */
 	mfspr	r21, MD_TWC	/* ....and get the pte address */
	mfspr	r20, DSISR			/* Check for store op */
	andis.	r20, r20, 0x0200		/* If set, indicates store */
	lwz	r20, 0(r21)			/* Get the pte again */
	beq	3f
	ori	r20, r20, _PAGE_DIRTY|_PAGE_HWWRITE /* Set the dirty flags */
3:
	ori	r20, r20, _PAGE_ACCESSED	/* Set the accessed flag */
	stw	r20, 0(r21)			/* Update the pte */
 	mr	r21, r20	/* Get the pte */


Cheers,
Jesper

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
