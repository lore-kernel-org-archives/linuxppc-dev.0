Date: Sat, 1 Mar 2003 00:17:35 -0500
From: Daniel Jacobowitz <drow@false.org>
To: "Linuxppc-Dev@Lists. Linuxppc. Org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: FW: Improved copy_page() function, about 30% speed up for mpc860!
Message-ID: <20030301051735.GA2466@nevyn.them.org>
References: <IGEFJKJNHJDCBKALBJLLIEKNFKAA.joakim.tjernlund@lumentis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <IGEFJKJNHJDCBKALBJLLIEKNFKAA.joakim.tjernlund@lumentis.se>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Feb 28, 2003 at 11:41:52AM +0100, Joakim Tjernlund wrote:
>
> Hi
>
> hmm, no reply on this on the embedded list. Maybe this list is a better place.

I can't tell you what revs they were, but all of the MPC860's I could
get my hands on here the last time I tried to use dcbz on them were
faulty.  You may just not be triggering the bug.

>  Jocke
>
> -----Original Message-----
> From: Joakim Tjernlund [mailto:joakim.tjernlund@lumentis.se]
> Sent: Thursday, February 27, 2003 14:09
> To: Linuxppc-Embedded@Lists. Linuxppc. Org
> Subject: Improved copy_page() function, about 30% speed up for mpc860!
>
>
> Hi all
>
> I have been playing with the copy_page() function in arch/ppc/kernel/misc.S
> and gained about 30% speed up for my mpc860, rev D4 MHz.
>
> This is what i did:
> - Use dcbz on 8xx but clear ahead one cache line(performance is really crappy
>   if I don't clear ahead). This is the biggest improvement.
> - Use prefetch for 8xx as well.
>
> I know that dcbz is buggy for some 8xx CPUs but I don't know which ones.
> For me works just fine, except in copy_tofrom_user(don't know why).
>
> I would like to get some feedback & test results both for 8xx and non 8xx.
> Please include exact CPU and revision.
>
>  Thanks
>          Jocke
>
> _GLOBAL(copy_page)
> 	addi	r3,r3,-4
> 	addi	r4,r4,-4
> 	li	r5,4
> #if MAX_COPY_PREFETCH > 1
> 	/* This will prefetch past end of page, does not seem to be a problem? */
> 	li	r0,MAX_COPY_PREFETCH
> 	li	r11,4
> 	mtctr	r0
> 11:	dcbt	r11,r4
> 	addi	r11,r11,L1_CACHE_LINE_SIZE
> 	bdnz	11b
> #else /* MAX_L1_COPY_PREFETCH == 1 */
> 	dcbt	r5,r4
> 	li	r11,L1_CACHE_LINE_SIZE+4
> #endif /* MAX_L1_COPY_PREFETCH */
> 	dcbz	r5,r3 /* older 8xx CPUs may have buggy dcbz instructions, if so try "dcbt r5,r3" instead */
> 	addi	r5,r5,L1_CACHE_LINE_SIZE
> 	li	r0,4096/L1_CACHE_LINE_SIZE-1 /* All, but the last cache line of data due dcbz below */
> 	mtctr	r0
> 1:
> 	dcbt	r11,r4
> 	dcbz	r5,r3 /* zero the cache line after the one that is beeing copied
> 		       * older 8xx CPUs may have buggy dcbz instructions, if so try "dcbt r5,r3" instead */
> 	COPY_16_BYTES
> #if L1_CACHE_LINE_SIZE >= 32
> 	COPY_16_BYTES
> #if L1_CACHE_LINE_SIZE >= 64
> 	COPY_16_BYTES
> 	COPY_16_BYTES
> #if L1_CACHE_LINE_SIZE >= 128
> 	COPY_16_BYTES
> 	COPY_16_BYTES
> 	COPY_16_BYTES
> 	COPY_16_BYTES
> #endif
> #endif
> #endif
> 	bdnz	1b
> /* Copy the last cache line of data */
> 	COPY_16_BYTES
> #if L1_CACHE_LINE_SIZE >= 32
> 	COPY_16_BYTES
> #if L1_CACHE_LINE_SIZE >= 64
> 	COPY_16_BYTES
> 	COPY_16_BYTES
> #if L1_CACHE_LINE_SIZE >= 128
> 	COPY_16_BYTES
> 	COPY_16_BYTES
> 	COPY_16_BYTES
> 	COPY_16_BYTES
> #endif
> #endif
> #endif
> 	blr
>
>
>
>

--
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
