Content-Type: text/plain;
  charset="iso-8859-1"
From: Leonardo Pereira Santos <lsantos@pd3.com.br>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: problems ..to boot linux 2.4.4 on fads mpc860 please help!!!!!!!! 
Date: Wed, 6 Nov 2002 12:43:08 -0200
MIME-Version: 1.0
Message-Id: <200211061243.08201.lsantos@pd3.com.br>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there! I hope this helps...
First of all, a coleague managed to make a 850FADS board work properly, so the
credit is his. We're using PPCBoot 1.2 and kernel-2.4.20pre1. The first thing
is to make sure that the ppcboot environment variable "clocks_in_mhz" IS NOT
DEFINED. It would NOT exist, not be defined as 0 or 1. It changes the clock
dividers in the processor that is not good. This should make the kernel boot
at least with a ramdisk.
If you have trouble to make the ethernet interface work, as we did, you should
edit the include/asm-ppc/commproc.h and arch/ppc/platforms/fads.h files. In
the first file, you should add the following:

/***  FADS  ********************************************************/

#ifdef CONFIG_FADS
/* This ENET stuff is for the MPC850SAR with ethernet on SCC2.  Some of
 * this may be unique to the FADS850SAR configuration.
 * Note TENA is on Port B.
 */
#define PA_ENET_RXD     ((ushort)0x0004)        /* PA 13 */
#define PA_ENET_TXD     ((ushort)0x0008)        /* PA 12 */
#define PA_ENET_RCLK    ((ushort)0x0200)        /* PA 6 */
#define PA_ENET_TCLK    ((ushort)0x0800)        /* PA 4 */
#define PB_ENET_TENA    ((uint)0x00002000)      /* PB 18 */
#define PC_ENET_CLSN    ((ushort)0x0040)        /* PC 9 */
#define PC_ENET_RENA    ((ushort)0x0080)        /* PC 8 */

#define SICR_ENET_MASK  ((uint)0x0000ff00)
#define SICR_ENET_CLKRT ((uint)0x00002f00)      /* RCLK-CLK2, TCLK-CLK4 */
#endif	/* CONFIG_FADS */

It should be put together with the other boards' definitions.
The fads.h file shoud be edited in these definitions:

< /***  defines taken from PPCBoot 1.2   ***/
< #define BCSR_ADDR               ((uint) 0x02100000)
< #define BCSR_SIZE               ((uint)(64 * 1024))
< #define BCSR0                   ((uint) (BCSR_ADDR + 00))
< #define BCSR1                   ((uint) (BCSR_ADDR + 0x04))
< #define BCSR2                   ((uint) (BCSR_ADDR + 0x08))
< #define BCSR3                   ((uint) (BCSR_ADDR + 0x0c))
< #define BCSR4                   ((uint) (BCSR_ADDR + 0x10))
< /***  ***/

That should do the trick. Again, we are using a FADS850SAR board, which is not
the same you have, but the spirit of the whole thing is to take the info from
a working ppcboot to the kernel. Hope it helps.

--
"All things are ready, if our minds be so"
The Life Of King Henry V - William Sharespeare

Leonardo Pereira Santos
Engenheiro de Projetos
PD3 Tecnologia
av. Pará 330/202
(51) 3337 1237

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
