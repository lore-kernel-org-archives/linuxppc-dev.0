From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15337.7275.266062.777161@cargo.ozlabs.ibm.com>
Date: Wed, 7 Nov 2001 22:35:07 +1100 (EST)
To: linuxppc-dev@lists.linuxppc.org
Subject: The Plan
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


(to reduce the arch/ppc/kernel clutter, that is)

This is what I am thinking of; I have implemented it locally here and
I'm doing test compiles with arch/ppc/configs/*.

- arch/ppc/kernel/ppc_asm.h moves to include/asm-ppc, and the contents
  of ppc_asm.tmpl get folded into it, with corresponding changes to
  arch/ppc/*/*.S.

- Files which relate only to one platform, or a small number of
  platforms, move to arch/ppc/platforms.  (There are some minor
  exceptions to this rule which we can discuss if people are
  concerned.)  We end up with:

bash-2.05$ ls kernel/
total 888
   4 Makefile	         8 l2cr.S	       4 ppc8xx_pic.h
  12 align.c	         8 m8260_setup.c       4 ppc_defs.head
   4 bitops.c	        12 m8xx_setup.c       16 ppc_htab.c
  40 btext.c	        24 misc.S	      12 ppc_ksyms.c
   4 checks.c	        12 mk_defs.c	      24 proc_rtas.c
   8 cputable.c         12 mpc10x_common.c    16 process.c
  12 entry.S	         8 oak_setup.c	      56 prom.c
   8 error_log.c         4 oak_setup.h	       8 ptrace.c
   4 error_log.h        24 open_pic.c	      12 qspan_pci.c
   4 find_name.c         8 open_pic_defs.h    28 residual.c
   4 galaxy_pci.c        4 pci-dma.c	       4 semaphore.c
  48 head.S	        36 pci.c	      24 setup.c
  32 head_4xx.S         12 pci_auto.c	      20 signal.c
  24 head_8xx.S         20 ppc-stub.c	      16 smp.c
   8 i8259.c	        20 ppc405_dma.c        4 softemu8xx.c
   4 iSeries_asm.h       8 ppc405_pci.c        8 syscalls.c
  40 iSeries_head.S      8 ppc4xx_pic.c        8 temp.c
  12 iSeries_misc.S      8 ppc4xx_serial.c    16 time.c
   4 iSeries_setup.h    12 ppc4xx_setup.c*    12 todc_time.c
  12 idle.c	         4 ppc8260_pic.c      12 traps.c
   4 indirect_pci.c      4 ppc8260_pic.h
  28 irq.c	         8 ppc8xx_pic.c

bash-2.05$ ls platforms/
total 732
   4 Makefile	         4 iSeries_smp.c       16 pmac_smp.c
   4 adir.h	         8 iSeries_time.c       8 pmac_time.c
  12 adir_pci.c          4 k2.h		       12 powerpmc250.c
   4 adir_pic.c         12 k2_pci.c	        4 pplus.h
   8 adir_setup.c       12 k2_setup.c	       12 pplus_common.c
   8 apus_pci.c          4 lopec_pci.c	        4 prep_nvram.c
   4 apus_pci.h          8 lopec_setup.c       40 prep_pci.c
  28 apus_setup.c        4 mcpn765.h	       24 prep_setup.c
  12 chrp_pci.c          4 mcpn765_pci.c        8 prep_time.c
  16 chrp_setup.c       12 mcpn765_setup.c      8 prpmc750_pci.c
   4 chrp_smp.c          4 menf1.h	        8 prpmc750_setup.c
   8 chrp_time.c         4 menf1_pci.c	        4 prpmc800_pci.c
   4 cpc700.h	         8 menf1_setup.c       12 prpmc800_setup.c
   8 cpc700_pic.c        4 mvme5100_pci.c       4 redwood.c
   4 cpc710.h	         8 mvme5100_setup.c     4 sandpoint.h
   4 cpci405.c	         4 pcore.h	        8 sandpoint_pci.c
   4 ep405.c	         4 pcore_pci.c	       20 sandpoint_setup.c
   4 gemini_pci.c        8 pcore_setup.c        8 sleep.S
   4 gemini_prom.S       4 pmac_backlight.c     4 spruce_pci.c
  16 gemini_setup.c     60 pmac_feature.c       8 spruce_setup.c
   8 harrier.c	        12 pmac_nvram.c         8 walnut.c*
   4 harrier.h	        20 pmac_pci.c	        4 zx4500.h
  32 iSeries_dma.c      16 pmac_pic.c	        4 zx4500_pci.c
   4 iSeries_pic.c       4 pmac_pic.h	       12 zx4500_setup.c
  24 iSeries_setup.c    24 pmac_setup.c

- The appropriate changes to various Makefiles, of course.

We can discuss variations on this theme, for example we could possibly
move platforms/iSeries* to iSeries/, since it already has its own
directory.  As the number of platforms grows, we can consider moving
other groups of platforms into their own directories as well.

Thoughts?  Objections?  Comments?

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
