Date: Fri, 20 Dec 2002 18:46:58 +0100
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: New invalidate/clean/flush_dcache functions
In-reply-to: <3E034380.1080404@tataelxsi.co.in>
To: linuxppc-embedded@lists.linuxppc.org
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLKEPPFIAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


How about adding new xxx_dcache_range() functions functions to PPC.
Below is my suggestion which is more logical and more efficient:


static inline void invalidate_dcache_region(void *adr, unsigned long len)
{
	if(len == 0) return;
	len = ((len-1) >> LG_L1_CACHE_LINE_SIZE) +1;
	do {
		asm  ("dcbi     0,%0" : : "r" (adr));
		adr += L1_CACHE_LINE_SIZE;
	} while(--len > 0);
}

static inline void clean_dcache_region(void *adr, unsigned long len)
{
	if(len == 0) return;
	len = ((len-1) >> LG_L1_CACHE_LINE_SIZE) +1;
	do {
		asm  ("dcbst     0,%0" : : "r" (adr));
		adr += L1_CACHE_LINE_SIZE;
	} while(--len > 0);
	asm  ("sync" : : );
}

static inline void flush_dcache_region(void *adr, unsigned long len)
{
	if(len == 0) return;
	len = ((len-1) >> LG_L1_CACHE_LINE_SIZE) +1;
	do {
		asm  ("dcbf     0,%0" : : "r" (adr));
		adr += L1_CACHE_LINE_SIZE;
	} while(--len > 0);
	asm  ("sync" : : );
}

int *ptr1;
char *ptr2;
void *ptr3;

main()
{
	unsigned long len1 = 1600;
	unsigned long len2 = 900;
	unsigned long len3 = 702;

	invalidate_dcache_region(ptr1, len1);
	clean_dcache_region(ptr2, len2);
	flush_dcache_region(ptr3, len3);
}

/* Assembler output:
ppc_8xx-gcc -O2 -S inv_dcache.c -mregnames inv_dcache.c

        .file   "inv_dcache.c"
gcc2_compiled.:
        .section        ".text"
        .align 2
        .globl main
        .type    main,@function
main:
        li %r0,100
        mtctr %r0
        lis %r9,ptr1@ha
        lwz %r9,ptr1@l(%r9)
.L39:
        dcbi     0,%r9
        addi %r9,%r9,16
        bdnz .L39
        li %r0,57
        mtctr %r0
        lis %r9,ptr2@ha
        lwz %r9,ptr2@l(%r9)
.L30:
        dcbst     0,%r9
        addi %r9,%r9,16
        bdnz .L30
        sync
        li %r0,44
        mtctr %r0
        lis %r9,ptr3@ha
        lwz %r9,ptr3@l(%r9)
.L36:
        dcbf     0,%r9
        addi %r9,%r9,16
        bdnz .L36
        sync
        blr
.Lfe1:
        .size    main,.Lfe1-main
        .comm   ptr1,4,4
        .comm   ptr2,4,4
        .comm   ptr3,4,4
        .ident  "GCC: (GNU) 2.95.3 20010315 (release/MontaVista)"

*/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
