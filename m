Subject: Software Cache Coherency and the MPC745x G4 Procs
Date: Thu, 27 Jun 2002 16:44:00 -0400
Message-ID: <CC2BE26A9E9CF84EBEA5565C43B3FF0F8F08D5@morpheus.pirus.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
From: "Boerner, Brian" <bmb@pirus.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Everyone. First Time Caller.. Short Time Listener.

I have a question about doing software cache coherency on the MPC745x G4 processors. It appears MOT in all it's infinite wisdom has removed the dcbi, or rather changed the dcbi, instruction. The old instruction simply used to invalidate the cache line. Now it appears to do the same thing as the dcbf instruction. So, rather than simply invalidating the cache, it flushes it and the reader gets the invalid cache line.

I'm just getting my feet wet again in the embedded Linux space and was wondering how Linux is handling this? Looking in the source tree, I have found the following routine that appears to be used for software cache coherency:

/*
 * Like above, but invalidate the D-cache.  This is used by the 8xx
 * to invalidate the cache so the PPC core doesn't get stale data
 * from the CPM (no cache snooping here :-).
 *
 * invalidate_dcache_range(unsigned long start, unsigned long stop)
 */
_GLOBAL(invalidate_dcache_range)
        li      r5,L1_CACHE_LINE_SIZE-1
        andc    r3,r3,r5
        subf    r4,r3,r4
        add     r4,r4,r5
        srwi.   r4,r4,LG_L1_CACHE_LINE_SIZE
        beqlr
        mtctr   r4

1:      dcbi    0,r3
        addi    r3,r3,L1_CACHE_LINE_SIZE
        bdnz    1b
        sync                            /* wait for dcbi's to get to ram */
        blr


This too is using the dcbi instruction, which simply isn't going to do what the author intended it to do. According to Motorola, there is no replacement for dcbi. Does anyone have a theory on how to do software cache coherency. I know that some of the memory controllers will maintain cache coherency through snooping, but in certain applications, I need to control it from software.

Thanks.
-Brian

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
