Message-ID: <3E5650A4.39677CB0@tataelxsi.co.in>
Date: Fri, 21 Feb 2003 21:45:32 +0530
From: "Kamalesh B" <kamal@tataelxsi.co.in>
MIME-Version: 1.0
To: Coray Tate <ctate@metrowerks.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Problem porting 2.4.17 linux to MPC8260ADS
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

Iam porting Linux 2.4.17 on MPC8260ADS. I had already working
Linux-2.4.1 version on MPC8260ADS board.

I have patched all the board specific changes to 2.4.17 and compiled.
When i loaded the image on board using PPCBOOT and run it, it hangs in
function "MMU_init_hw" (arch/ppc/mm/ppc_mmu.c) which is called from
MMU_init (arch/ppc/mm/init.c). And MMU_init is called from "_start_here"
subroutine in head.S file.

I had rather taken an tedious process of identifying the problem by
glowing LEDs present on the board. I have identify the location of the
problem.

Problem:
In "MMU_init_hw" function, it checks for this condition
"cur_cpu_spec[0]->cpu_features & CPU_FTR_HPTE_TABLE" and panics by
blinking leds in specific pattern after accessing the structure.

--- Code begins ---
 if ((cur_cpu_spec[0]->cpu_features & CPU_FTR_HPTE_TABLE) == 0) {
  /*
   * Put a blr (procedure return) instruction at the
   * start of hash_page, since we can still get DSI
   * exceptions on a 603.
   */
  hash_page[0] = 0x4e800020;
  flush_icache_range((unsigned long) &hash_page[0],
       (unsigned long) &hash_page[1]);
  return;
 }
--- Code ends ---

"cur_cpu_spec" is a array of pointer to cpu_spec structure
(include/asm-ppc/cputable.h) containing CPU related informations. I
understand that this is something to do with multiple processors system.
I checked the value of cur_cpu_spec[0] pointer. It was zero. At this
time, MMU would be ON with SDRAM located at 0xc0000000 (Logical
address). So when processor access this sructure which is pointing to 0
(outside physical memory boundary), it throws machine check exception
and calls panic function to display leds in specific pattern. This is
where iam stuck.

I also tried commenting this line as this was not there in 2.4.1
version. Here control went till this point in "head.S" code

--- Code start ---
/*
 * Go back to running unmapped so we can load up new values
 * for SDR1 (hash table pointer) and the segment registers
 * and change to using our exception vectors.
 */
 lis r4,2f@h
 ori r4,r4,2f@l
 tophys(r4,r4)
 li r3,MSR_KERNEL & ~(MSR_IR|MSR_DR)
 FIX_SRR1(r3,r5)
 mtspr SRR0,r4
 mtspr SRR1,r3
 SYNC
 RFI
/* Load up the kernel context */
2:

--- Code ends ---

After RFI instruction executed, it stops or hangs without any
indication. Expected result was control should jumps to label "2:" and
then branch to "load_up_mmu" function and "start_kernel" function.

I suspect cpu setup problem and may be MMU also.

Any help will be appreciated,
thanks in advance,
with rgds,
kamal

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
