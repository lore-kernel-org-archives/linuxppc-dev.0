Message-ID: <395AC781.EA314718@m2tech.co.nz>
Date: Thu, 29 Jun 2000 15:50:25 +1200
From: ben bodley <benb@m2tech.co.nz>
MIME-Version: 1.0
To: Wentao Xu <xuwentao@yahoo.com>
CC: mailing list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: why open("dev/console",O_RDWR,0) get stuck
References: <20000629032315.6048.qmail@web2102.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wentao Xu wrote:

> ben,
> Thanks for your help. That error does not appear
> now, after doing what you told me.
> BTW, can you tell me what toolkit you are using
> with the ppc401, the one from Monta Vista?
>
> I have been haunted by the bad PTE error for 2 weeks.
> I
> dont know if I shall make some modification of the MMU
> code before running the 405 code on the redwood 3. Can
> you give me a hint? Thanks
>

my kernel is based on grant ericksons latest patch + some montavisa mods
+ my mods..

here is my slightly hacked 4xx_tlb.c if you find it of any help... i am
having some problems with the romeo bus at pres. hence hacking out the
_PAGE_GUARDED..

/*
 *
 *    Copyright (c) 1999 Grant Erickson <grant@lcse.umn.edu>
 *    copyright (c) 2000 m2 technology ltd <benb@m2tech.co.nz>
 *
 *    Module name: 4xx_tlb.c
 *
 *    Description:
 *      Routines for manipulating the TLB on PowerPC 400-class
processors.
 *
 */

#include <linux/mm.h>

#include <asm/processor.h>
#include <asm/io.h>
#include <asm/mmu.h>
#include <asm/pgtable.h>
#include <asm/system.h>


/* Preprocessor Defines */

#if !defined(TRUE) || TRUE != 1
#define TRUE    1
#endif

#if !defined(FALSE) | FALSE != 0
#define FALSE   0
#endif


/* Global Variables */

static int pinned = 0;


/* Function Prototypes */

static int PPC4xx_tlb_miss(struct pt_regs *, unsigned long, int);

extern void do_page_fault(struct pt_regs *, unsigned long, unsigned
long);


/*
 * ()
 *
 * Description:
 *   This routine...
 *
 * Input(s):
 *
 *
 * Output(s):
 *
 *
 * Returns:
 *
 *
 */
static inline void
PPC4xx_tlb_write(unsigned long tag, unsigned long data, unsigned int
index)
{
        asm("tlbwe %0,%1,1" : : "r" (data), "r" (index));
        asm("tlbwe %0,%1,0" : : "r" (tag), "r" (index));
}

/*
 * ()
 *
 * Description:
 *   This routine...
 *
 * Input(s):
 *
 *
 * Output(s):
 *
 *
 * Returns:
 *
 *
 */
void
PPC4xx_tlb_flush_all(void)
{
        int i;
        unsigned long flags, pid;

        save_flags(flags);
        cli();

        pid = mfspr(SPRN_PID);
        mtspr(SPRN_PID, 0);

        for (i = pinned; i < PPC4XX_TLB_SIZE; i++) {
                PPC4xx_tlb_write(0, 0, i);
        }
        asm("sync;isync");

        mtspr(SPRN_PID, pid);
        restore_flags(flags);
}

void
PPC4xx_tlb_flush_page(int pid, unsigned long va)
{
        unsigned long flags, opid, tag, i;
        unsigned int found = 1;

        save_flags(flags);
        cli();

        opid = mfspr(SPRN_PID);

        /* set our new context as the one we want to flush */

        mtspr(SPRN_PID, pid);

        /* guess at a valid 4k page */

        tag = (va & PAGE_MASK) | TLB_VALID | TLB_PAGESZ(PAGESZ_4K);

        /* Attempt to match the tag to an existing entry in the TLB. */

        asm("tlbsx. %0,0,%2;"
            "beq 1f;"
            "li %1,0;1:" : "=r" (i), "=r" (found) : "r" (tag));

        if (found) {
                /* modify the tag portion to indicate an invalid tlb
entry */

                asm("tlbre %0,%1,0" : "=r" (tag) : "r" (i));
                tag &= ~TLB_VALID;
                asm("tlbwe %0,%1,0" : : "r" (tag), "r" (i));

                /* and now resync the tlb table */

                asm("isync;sync");
        }

        /* restore old pid (context) */

        mtspr(SPRN_PID, opid);
        restore_flags(flags);
}

/*
 * ()
 *
 * Description:
 *   This routine...
 *
 * Input(s):
 *
 *
 * Output(s):
 *
 *
 * Returns:
 *
 *
 */
void
PPC4xx_dtlb_miss(struct pt_regs *regs)
{
        unsigned long addr = mfspr(SPRN_DEAR);
        int write = mfspr(SPRN_ESR) & ESR_DST;

        if (PPC4xx_tlb_miss(regs, addr, write) < 0) {
                sti();
                do_page_fault(regs, addr, write);
                cli();
                PPC4xx_tlb_miss(regs, addr, write);
        }

#if 0
        printk("attempted data access at %08lx from %08lx\n", addr,
regs->nip);
#endif
}

/*
 * ()
 *
 * Description:
 *   This routine...
 *
 * Input(s):
 *
 *
 * Output(s):
 *
 *
 * Returns:
 *
 *
 */
void
PPC4xx_itlb_miss(struct pt_regs *regs)
{
        unsigned long addr = regs->nip;

#if 0
        printk("attempted instruction access at %08lx\n", addr);
#endif

        if (PPC4xx_tlb_miss(regs, addr, 0) < 0) {
                sti();
                do_page_fault(regs, addr, 0);
                cli();
                PPC4xx_tlb_miss(regs, addr, 0);
        }
}

/*
 * ()
 *
 * Description:
 *   This routine...
 *
 * Input(s):
 *
 *
 * Output(s):
 *
 *
 * Returns:
 *
 *
 */
void
PPC4xx_tlb_pin(unsigned long va, unsigned long pa, int pagesz, int
cache)
{
        unsigned long tag, data;
        unsigned long opid;

        if (pinned >= PPC4XX_TLB_SIZE)
                return;

        opid = mfspr(SPRN_PID);
        mtspr(SPRN_PID, 0);

        data = (pa & TLB_RPN_MASK) | TLB_WR;

        if (cache)
                data |= (TLB_EX);
        else
                data |= (TLB_G | TLB_I);

        tag = (va & TLB_EPN_MASK) | TLB_VALID | pagesz;

        PPC4xx_tlb_write(tag, data, pinned++);

        asm("isync; sync");

        mtspr(SPRN_PID, opid);
        return;
}

/*
 * ()
 *
 * Description:
 *   This routine...
 *
 * Input(s):
 *
 *
 * Output(s):
 *
 *
 * Returns:
 *
 *
 */
void
PPC4xx_tlb_unpin(unsigned long va, unsigned long pa, int size)
{
        /* XXX - To be implemented. */
}

/*
 * ()
 *
 * Description:
 *   This routine...
 *
 * Input(s):
 *
 *
 * Output(s):
 *
 *
 * Returns:
 *
 *
 */
static inline void
PPC4xx_tlb_update(unsigned long addr, pte_t *pte)
{
        unsigned long data, tag, rand;
        int i, found = 1;

        /* Construct the hardware TLB entry from the Linux-style PTE */

        tag = tag = (addr & PAGE_MASK) | TLB_VALID |
TLB_PAGESZ(PAGESZ_4K);
        data = data = (pte_val(*pte) & PAGE_MASK);

        if (pte_val(*pte) & _PAGE_RW)
                data |= TLB_WR;

        if (pte_val(*pte) & _PAGE_NO_CACHE)
                data |= TLB_I | TLB_G;
        else
                data |= TLB_EX;

/*        if (pte_val(*pte) & _PAGE_GUARDED)
                data |= TLB_G; */

        if (pte_val(*pte) & _PAGE_USER)
                data |= TLB_ZSEL(1);

        /* Attempt to match the new tag to an existing entry in the TLB.
*/

        asm("tlbsx. %0,0,%2;"
            "beq 1f;"
            "li %1,0;1:" : "=r" (i), "=r" (found) : "r" (tag));

        /*
         * If we found a match for the tag, reuse the entry index and
update
         * the tag and data portions. Otherwise, we did not find a
match. Use
         * the lower 5 bits of the lower time base register as a
pseudo-random
         * index into the TLB and replace the entry at that index.
         */

        if (found) {
                PPC4xx_tlb_write(tag, data, i);
        } else {
                rand = mfspr(SPRN_TBLO) & (PPC4XX_TLB_SIZE - 1);
                rand += pinned;
                if (rand >= PPC4XX_TLB_SIZE)
                        rand -= pinned;

                PPC4xx_tlb_write(tag, data, rand);
        }

        asm("isync; sync");
}

/*
 * ()
 *
 * Description:
 *   This routine...
 *
 * Input(s):
 *
 *
 * Output(s):
 *
 *
 * Returns:
 *
 *
 */
static int
PPC4xx_tlb_miss(struct pt_regs *regs, unsigned long addr, int write)
{
        unsigned long spid, ospid;
        struct mm_struct *mm;
        pgd_t *pgd;
        pmd_t *pmd;
        pte_t *pte;

        if (!user_mode(regs) && (addr >= KERNELBASE)) {
                mm = &init_mm;
                spid = 0;
        } else {
                mm = current->mm;
                spid = mfspr(SPRN_PID);
        }

        pgd = pgd_offset(mm, addr);
        if (pgd_none(*pgd))
                goto bad;

        pmd = pmd_offset(pgd, addr);
        if (pmd_none(*pmd))
                goto bad;

        pte = pte_offset(pmd, addr);
        if (pte_none(*pte) || !pte_present(*pte))
                goto bad;

        if (write) {
                if (!pte_write(*pte))
                        goto bad;

                set_pte(pte, pte_mkdirty(*pte));
        }
        set_pte(pte, pte_mkyoung(*pte));

        ospid = mfspr(SPRN_PID);
        mtspr(SPRN_PID, spid);
        PPC4xx_tlb_update(addr, pte);
        mtspr(SPRN_PID, ospid);

        return (0);
bad:
        return (-1);
}

cheers,

ben

--
/\\------------------------------------------------------------------
:::::::::::..ben.b..m2technologyltd.nz..64.9.4448307.130..:::::::::::

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
