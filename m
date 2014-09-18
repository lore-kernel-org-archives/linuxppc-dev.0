Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 961981A0507
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Sep 2014 09:40:23 +1000 (EST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 amodra@gmail.com, torvalds@linux-foundation.org
Subject: [PATCH 0/3] DCACHE_WORD_ACCESS support for ppc64le
Date: Fri, 19 Sep 2014 09:40:18 +1000
Message-Id: <1411083621-12064-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series adds an optimised version of word-at-a-time.h for ppc64le.
It uses the cmpb instruction which compares each byte in two 64 bit
values and for each matching byte places 0xff in the target and 0x00
otherwise.

The intermediate functions diverge a bit from what might have been 
intended (eg create_zero_mask returns the number of bits to the NULL),
but it makes find_zero and zero_bytemask simpler:

static inline unsigned long has_zero(unsigned long a, unsigned long *bits, const struct word_at_a_time *c)
{
        unsigned long ret;
        unsigned long zero = 0;

        asm("cmpb %0,%1,%2" : "=r" (ret) : "r" (a), "r" (zero));
        *bits = ret;

        return ret;
}

static inline unsigned long prep_zero_mask(unsigned long a, unsigned long bits, const struct word_at_a_time *c)
{
        return bits;
}

/* Alan Modra's little-endian strlen tail for 64-bit */
static inline unsigned long create_zero_mask(unsigned long bits)
{
        unsigned long leading_zero_bits;
        long trailing_zero_bit_mask;

        asm("addi       %1,%2,-1\n\t"
            "andc       %1,%1,%2\n\t"
            "popcntd    %0,%1"
                : "=r" (leading_zero_bits), "=&r" (trailing_zero_bit_mask)
                : "r" (bits));

        return leading_zero_bits;
}

static inline unsigned long find_zero(unsigned long mask)
{
        return mask >> 3;
}

/* This assumes that we never ask for an all 1s bitmask */
static inline unsigned long zero_bytemask(unsigned long mask)
{
        return (1UL << mask) - 1;
}

Anton Blanchard (3):
  powerpc: Implement load_unaligned_zeropad
  powerpc: ppc64le optimised word at a time
  powerpc: Enable DCACHE_WORD_ACCESS on ppc64le

 arch/powerpc/Kconfig                      |   1 +
 arch/powerpc/include/asm/word-at-a-time.h | 101 +++++++++++++++++++++++++-----
 2 files changed, 88 insertions(+), 14 deletions(-)

-- 
1.9.1
