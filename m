Date: Wed, 17 Nov 1999 20:03:00 -0800
From: "David N. Welton" <davidw@linuxcare.com>
To: Linux -Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: again 2.3.28
Message-ID: <19991117200300.B4647@bassano.linuxcare.com>
References: <3832F9AD.9CD1B9E5@pop.agri.ch> <19991117110116.B4281@bassano.linuxcare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19991117110116.B4281@bassano.linuxcare.com>; from David N. Welton on Wed, Nov 17, 1999 at 11:01:16AM -0800
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ok... hmmm, this may mean something, but I'll leave it to others to
tell me if I've found something or if I'm just on crack.

copy_and_flush:
	addi	r5,r5,-4
	addi	r6,r6,-4
4:	li	r0,8
	mtctr	r0
3:	addi	r6,r6,4			/* copy a cache line */
	lwzx	r0,r6,r4
	stwx	r0,r6,r3
	bdnz	3b
	dcbst	r6,r3			/* write it to memory */
	sync
	icbi	r6,r3			/* flush the icache line */
	cmplw	0,r6,r5
	bl	davidw_debug	   <<<<<<<<< POSITION 1	
	blt	4b
	bl	davidw_debug	   <<<<<<<<< POSITION 2
	isync
	addi	r5,r5,4
	addi	r6,r6,4
	blr

When davidw_debug is in position 1, it actually exits the boot load
back into the firmware with a 'default catch' or something like that.
If it is in position 2, it just hangs and does nothing (possibly
continuing with this loop forever?).

Is this significant?  Or am I just messing up something else?

Ciao,
-- 
David N. Welton, Developer, Linuxcare, Inc.
415.354.4878 x241 tel, 415.701.7457 fax
davidw@linuxcare.com, http://www.linuxcare.com/
Linuxcare. At the center of Linux.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
