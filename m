Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Improved copy_page() function, about 30% speed up for mpc860!
Date: Thu, 27 Feb 2003 14:08:32 +0100
Message-ID: <IGEFJKJNHJDCBKALBJLLOEKGFKAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all

I have been playing with the copy_page() function in arch/ppc/kernel/misc.S
and gained about 30% speed up for my mpc860, rev D4 MHz.

This is what i did:
- Use dcbz on 8xx but clear ahead one cache line(performance is really crappy
  if I don't clear ahead). This is the biggest improvement.
- Use prefetch for 8xx as well.

I know that dcbz is buggy for some 8xx CPUs but I don't know which ones.
For me works just fine, except in copy_tofrom_user(don't know why).

I would like to get some feedback & test results both for 8xx and non 8xx.
Please include exact CPU and revision.

 Thanks
         Jocke

_GLOBAL(copy_page)
	addi	r3,r3,-4
	addi	r4,r4,-4
	li	r5,4
#if MAX_COPY_PREFETCH > 1
	/* This will prefetch past end of page, does not seem to be a problem? */
	li	r0,MAX_COPY_PREFETCH
	li	r11,4
	mtctr	r0
11:	dcbt	r11,r4
	addi	r11,r11,L1_CACHE_LINE_SIZE
	bdnz	11b
#else /* MAX_L1_COPY_PREFETCH == 1 */
	dcbt	r5,r4
	li	r11,L1_CACHE_LINE_SIZE+4
#endif /* MAX_L1_COPY_PREFETCH */
	dcbz	r5,r3 /* older 8xx CPUs may have buggy dcbz instructions, if so try "dcbt r5,r3" instead */
	addi	r5,r5,L1_CACHE_LINE_SIZE
	li	r0,4096/L1_CACHE_LINE_SIZE-1 /* All, but the last cache line of data due dcbz below */
	mtctr	r0
1:
	dcbt	r11,r4
	dcbz	r5,r3 /* zero the cache line after the one that is beeing copied
		       * older 8xx CPUs may have buggy dcbz instructions, if so try "dcbt r5,r3" instead */
	COPY_16_BYTES
#if L1_CACHE_LINE_SIZE >= 32
	COPY_16_BYTES
#if L1_CACHE_LINE_SIZE >= 64
	COPY_16_BYTES
	COPY_16_BYTES
#if L1_CACHE_LINE_SIZE >= 128
	COPY_16_BYTES
	COPY_16_BYTES
	COPY_16_BYTES
	COPY_16_BYTES
#endif
#endif
#endif
	bdnz	1b
/* Copy the last cache line of data */
	COPY_16_BYTES
#if L1_CACHE_LINE_SIZE >= 32
	COPY_16_BYTES
#if L1_CACHE_LINE_SIZE >= 64
	COPY_16_BYTES
	COPY_16_BYTES
#if L1_CACHE_LINE_SIZE >= 128
	COPY_16_BYTES
	COPY_16_BYTES
	COPY_16_BYTES
	COPY_16_BYTES
#endif
#endif
#endif
	blr


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
