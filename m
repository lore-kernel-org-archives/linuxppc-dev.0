Date: Thu, 20 Nov 2003 14:43:08 -0500
Subject: 64-bit reads and writes
From: John Whitney <john.whitney@timesys.com>
To: "Mailing List: linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
Message-ID: <BBE2837C.278D%john.whitney@timesys.com>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have a board with 4-way interleaved, 16-bit flash on a 64-bit data bus.  I
need to ensure that I have one 64-bit read or write, not two 32-bit reads or
writes.  To do this, I've used a floating point register in newly created
__raw_readll() and __raw_writell() (code below).

Effectively, I save the current MSR, and OR in MSR_FP to allow floating
point access.  I save off FPR1, load my value into it, and use "stfdx" to
write the value out.  Then I restore FPR1 and MSR to their original values.

Does anyone see any problems with this method, or have a better way of
accomplishing this?

The two routines are coded as follows:

/*
 * For reading and writing 64-bit values, we need to use the floating point
 * registers.  The code will enable MSR_FP in the MSR register, use FPR1 to
 * read from and write to memory, and then restore everything to the
 * previous values.
 */
static inline unsigned long long __raw_readll (int addr)
{
    unsigned long flags;
    unsigned long msr;
    unsigned long msr_save;
    unsigned long long result;
    unsigned long long fp_save;

    local_irq_save (flags);
    asm volatile ("sync\n"
                  "mfmsr    %0\n"
                  "ori        %1,%0,0x2000\n"
                  "mtmsr    %1\n"
                  "isync\n"
                  "stfdx    1,0,%2\n"
                  "lfdx        1,0,%4\n"
                  "stfdx    1,0,%3\n"
                  "sync\n"
                  "lfdx        1,0,%2\n"
                  "mtmsr    %0\n"
                  "sync\n"
                  "isync\n"
                  : "=&r" (msr_save), "=&r" (msr)
                  : "r" (&fp_save), "r" (&result), "r" (addr)
                  : "memory" );
    local_irq_restore (flags);

    return result;
}

static inline void __raw_writell (unsigned long long value, int addr)
{
    unsigned long flags;
    unsigned long msr;
    unsigned long msr_save;
    unsigned long long fp_save;

    local_irq_save (flags);
    asm volatile ("sync\n"
                  "mfmsr    %0\n"
                  "ori        %1,%0,0x2000\n"
                  "mtmsr    %1\n"
                  "isync\n"
                  "stfdx    1,0,%2\n"
                  "lfdx        1,0,%3\n"
                  "stfdx    1,0,%4\n"
                  "sync\n"
                  "lfdx        1,0,%2\n"
                  "mtmsr    %0\n"
                  "sync\n"
                  "isync\n"
                  : "=&r" (msr_save), "=&r" (msr)
                  : "r" (&fp_save), "r" (&value), "r" (addr)
                  : "memory" );
    local_irq_restore (flags);
    return;
}


John Whitney


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
