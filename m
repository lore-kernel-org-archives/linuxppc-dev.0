Content-Type: text/plain;
  charset="us-ascii"
From: "S. Hebbar" <shebbar@tejasnetworks.com>
To: laurent.mohin@acterna.com
Subject: Re: [U-Boot-Users] hang up after start_here 
Date: Mon, 18 Aug 2003 18:21:32 +0530
Cc: linuxppc-embedded@lists.linuxppc.org,
	u-boot-users@lists.sourceforge.net, shebbar@tejasnetworks.com
MIME-Version: 1.0
Message-Id: <200308181821.32832.shebbar@tejasnetworks.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I am having the exact same problem. It doesn't return to start_here label
after executing RFI instruction. (linux-2.4.20)

linux-2.4.20/arch/ppc/kernel/start.S ==>

turn_on_mmu:
  mfmsr r0
  ori r0,r0,MSR_DR|MSR_IR
  mtspr SRR1,r0
  lis r0,start_here@h
  ori r0,r0,start_here@l
  mtspr SRR0,r0
  SYNC
  RFI       /* enables MMU */

I have 128Meg or SDRAM  on a MPC8260 board.
The initialization sequence in U-BOOT is as follows.

void initdram()
{
#define CFG_SDRAM_BASE 0x0
#define CFG_IMMR 0x60000000

  int i;
  int      size;
  int      cpu_type=0;
  volatile immap_t *immap  = (immap_t *)CFG_IMMR;
  volatile memctl8260_t *memctl = &immap->im_memctl;
  volatile uchar c = 0;
  volatile uchar *ramaddr = (uchar *)(CFG_SDRAM_BASE) + 0x110;

/* Set OR1 and OR2 values */
memctl->memc_or1 = 0xf8002940;
memctl->memc_br1 = 0x00000041;

/*
* Quote from 8260 UM (10.4.2 SDRAM Power-On Initialization, 10-35):
*
* "At system reset, initialization software must set up the
*  programmable parameters in the memory controller banks registers
*  (ORx, BRx, P/LSDMR). After all memory parameters are configured,
*  system software should execute the following initialization sequence
*  for each SDRAM device.
*
*  1. Issue a PRECHARGE-ALL-BANKS command
*  2. Issue eight CBR REFRESH commands
*  3. Issue a MODE-SET command to initialize the mode register
*
*  The initial commands are executed by setting P/LSDMR[OP] and
*  accessing the SDRAM with a single-byte transaction."
*
* The appropriate BRx/ORx registers have already been set when we
* get here. The SDRAM can be accessed at the address CFG_SDRAM_BASE.
*/

  memctl->memc_psrt = psrt;
  memctl->memc_mptpr = mptpr;;

  memctl->memc_psdmr = (ulong) psdmr | PSDMR_OP_PREA;
  *ramaddr = c;

  memctl->memc_psdmr = (ulong) psdmr | PSDMR_OP_CBRR;
  for (i = 0; i < 8; i++)
    *ramaddr = c;

  memctl->memc_psdmr = (ulong) psdmr | PSDMR_OP_MRW;
  *ramaddr = c;

 memctl->memc_psdmr = (ulong) psdmr | PSDMR_OP_NORM | PSDMR_RFEN;
 *ramaddr = c;

I have turned off Data cache in U-BOOT. If I enabel D-CACHE, the code hangs
in U-BOOT itself.

Any help is very much appreciated.

Regards,
Hebbar.

\ <OFE8EA1A87.9A7B8A06-ONC1256D86.0028950A-C1256D86.002D5CE3@se.wavetek.com>
you wrote:
>
> I've debugged and found that the board hangs in start_here function and
> doesn't reach the early_init function.
>
> Because the problem appears on only one of my boards out of 16, I suspect
> a hardware problem, and because it occurs just after mmu initialisation
> and caches enabling, I suspect more especially sdram accesses.
>
> I want to know if anybody has encountered a similar problem and if the
> diagnostic was the same.

This is a standard problem, which can show up in many forms.  My  bet
is  that  your  SDRAM initialization sequence is incomplete / broken.
Remember that it is NOT sufficient to set up the  mmeory  controller,
you must also intialize the SDRAM chips themself.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
