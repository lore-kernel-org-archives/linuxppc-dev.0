Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id A4153DDE20
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Dec 2008 21:01:08 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so553249yxg.39
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Dec 2008 02:01:06 -0800 (PST)
Message-ID: <fa686aa40812210201w7e2c9a63he8ba42d78d44ddd@mail.gmail.com>
Date: Sun, 21 Dec 2008 03:01:05 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "Paul Mackerras" <paulus@samba.org>
Subject: Re: Commits added to powerpc.git next and master branches
In-Reply-To: <18765.58426.49381.986612@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <18765.58426.49381.986612@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

Here are a few more for you.  These are all the MPC5200 patches that
I've currently got in my queue and they are based off of your current
-next tree.

The first commit is Ben's fix for the missing blr instruction in
_tlbia() which is critical to get in ASAP.

Thanks,
g.

The following changes since commit 49e6e3f1aec2d46f5865d3ada38fe9a5d660ef5d=
:
  Scott Wood (1):
        powerpc/bootwrapper: Use the child-bus #address-cells to
decide which range entry to use

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6-mpc52xx next

Benjamin Herrenschmidt (1):
      powerpc: Fix missing 'blr' in _tlbia()

Grant Likely (4):
      powerpc/mpc5200: Document and tidy irq driver
      powerpc/mpc5200: Make internal 5200 PIC the default interrupt control=
ler
      powerpc/mpc5200: Bugfix on handling variable sized buffer descriptors
      powerpc/mpc5200: Disable bestcomm prefetching when ATA DMA enabled

Ren=E9 B=FCrgel (1):
      powerpc/mpc5200: Make PSC UART driver update serial errors counters

Tim Yamin (2):
      powerpc/mpc5200: Bestcomm fixes to ATA support
      powerpc/mpc5200: Add MDMA/UDMA support to MPC5200 ATA driver

Wolfram Sang (3):
      powerpc/mpc5200: Remove obsolete code from mpc5200 MDIO driver
      powerpc/mpc5200: add rts/cts handling in PSC UART driver
      powerpc/mpc5200: fix error paths in PSC UART probe function

 arch/powerpc/include/asm/mpc52xx.h           |   19 +
 arch/powerpc/include/asm/mpc52xx_psc.h       |   11 +-
 arch/powerpc/mm/hash_low_32.S                |    1 +
 arch/powerpc/platforms/52xx/lite5200_pm.c    |    1 -
 arch/powerpc/platforms/52xx/mpc52xx_pic.c    |  237 ++++++++---
 arch/powerpc/platforms/52xx/mpc52xx_pic.h    |   53 ---
 arch/powerpc/platforms/52xx/mpc52xx_pm.c     |    3 -
 arch/powerpc/sysdev/bestcomm/ata.c           |    3 +
 arch/powerpc/sysdev/bestcomm/ata.h           |   19 +-
 arch/powerpc/sysdev/bestcomm/bestcomm.c      |    7 +-
 arch/powerpc/sysdev/bestcomm/bestcomm.h      |   61 ++-
 arch/powerpc/sysdev/bestcomm/bestcomm_priv.h |   20 +-
 drivers/ata/Kconfig                          |    3 +-
 drivers/ata/pata_mpc52xx.c                   |  546 ++++++++++++++++++++++=
+---
 drivers/net/fec_mpc52xx_phy.c                |    5 +-
 drivers/serial/mpc52xx_uart.c                |   74 +++-
 16 files changed, 817 insertions(+), 246 deletions(-)
 delete mode 100644 arch/powerpc/platforms/52xx/mpc52xx_pic.h


On Sat, Dec 20, 2008 at 11:37 PM, Paul Mackerras <paulus@samba.org> wrote:
> Anton Vorontsov (3):
>      of: Minor simplification for the of_parse_phandles_with_args()
>      of: of_parse_phandles_with_args() learns to differentiate 'hole' cel=
ls
>      of/gpio: Implement of_gpio_count()
>
> Benjamin Herrenschmidt (10):
>      powerpc/4xx: Extended DCR support v2
>      powerpc/mm: Split mmu_context handling
>      powerpc/mm: Rework context management for CPUs with no hash table
>      powerpc/mm: Introduce MMU features
>      powerpc/mm: Add SMP support to no-hash TLB handling
>      powerpc/mm: Split low level tlb invalidate for nohash processors
>      powerpc/44x: No need to mask MSR:CE, ME or DE in _tlbil_va on 440
>      powerpc/mm: Runtime allocation of mmu context maps for nohash CPUs
>      powerpc/mm: Rework usage of _PAGE_COHERENT/NO_CACHE/GUARDED
>      powerpc/44x: 44x TLB doesn't need "Guarded" set for all pages
>
> Brian King (2):
>      powerpc: Disable Collaborative Memory Manager for kdump
>      powerpc: Add reboot notifier to Collaborative Memory Manager
>
> David Howells (1):
>      powerpc: Rename struct vm_region to avoid conflict with NOMMU
>
> Grant Erickson (1):
>      powerpc: Const-qualify Device Node Argument to DCR Resource Extent A=
PI
>
> Hendrik Brueckner (1):
>      hvc_console: Escape magic sysrq key
>
> Nathan Lynch (3):
>      powerpc: Add of_find_next_cache_node()
>      powerpc: Convert cpu_to_l2cache() to of_find_next_cache_node()
>      powerpc: Convert sysfs cache code to of_find_next_cache_node()
>
> Scott Wood (1):
>      powerpc/bootwrapper: Use the child-bus #address-cells to decide whic=
h range entry to use
>
> Stephen Rothwell (1):
>      powerpc/iseries: viodasd needs to depend on CONFIG_BLOCK
>
> Tony Breeds (2):
>      powerpc: Protect against NULL pointer deref in phyp-dump code
>      powerpc: Pass a valid token to rtas_call() in phyp-dump code
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
