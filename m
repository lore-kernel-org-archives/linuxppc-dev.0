Date: Sun, 7 Oct 2001 20:16:02 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-dev@lists.linuxppc.org
Cc: Cort Dougan <cort@fsmlabs.com>
Subject: [RFC] Remove unnneeded cruft for PReP sound
Message-ID: <20011007201602.A24490@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hey all.  After talking with Sven Dickert a bit, PReP sound seems to
work without the currently ugly hacks we have (CS4232).  So would anyone
object to the following patch getting into the trees?  Cort, what
exactly was the original problem, do you remember?  Is anyone else out
there using a PReP w/ audio?  Does this break things for you?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== arch/ppc/kernel/prep_setup.c 1.48 vs edited =====
--- 1.48/arch/ppc/kernel/prep_setup.c	Tue Oct  2 17:08:51 2001
+++ edited/arch/ppc/kernel/prep_setup.c	Thu Oct  4 14:01:39 2001
@@ -61,11 +61,6 @@
 #include "i8259.h"
 #include "open_pic.h"

-#if defined(CONFIG_SOUND) || defined(CONFIG_SOUND_MODULE)
-#include <../drivers/sound/sound_config.h>
-#include <../drivers/sound/dev_table.h>
-#endif
-
 unsigned char ucSystemType;
 unsigned char ucBoardRev;
 unsigned char ucBoardRevMaj, ucBoardRevMin;
@@ -102,8 +97,6 @@

 /* for the mac fs */
 kdev_t boot_dev;
-/* used in nasty hack for sound - see prep_setup_arch() -- Cort */
-long ppc_cs4232_dma, ppc_cs4232_dma2;

 extern PTE *Hash, *Hash_end;
 extern unsigned long Hash_size, Hash_mask;
@@ -116,11 +109,6 @@
 extern int rd_image_start;	/* starting block # of image */
 #endif

-#ifdef CONFIG_SOUND_MODULE
-EXPORT_SYMBOL(ppc_cs4232_dma);
-EXPORT_SYMBOL(ppc_cs4232_dma2);
-#endif
-
 static int __prep
 prep_get_cpuinfo(char *buffer)
 {
@@ -291,45 +279,6 @@
 			 strcpy(saved_command_line, cmd_line);
 		}
 	}
-
-#ifdef CONFIG_SOUND_CS4232
-	/*
-	 * setup proper values for the cs4232 driver so we don't have
-	 * to recompile for the motorola or ibm workstations sound systems.
-	 * This is a really nasty hack, but unless we change the driver
-	 * it's the only way to support both addrs from one binary.
-	 * -- Cort
-	 */
-	if ( _machine == _MACH_prep )
-	{
-		extern struct card_info snd_installed_cards[];
-		struct card_info *snd_ptr;
-
-		for ( snd_ptr = snd_installed_cards;
-			snd_ptr < &snd_installed_cards[num_sound_cards];
-			snd_ptr++ )
-		{
-			if ( snd_ptr->card_type == SNDCARD_CS4232 )
-			{
-				if ( _prep_type == _PREP_Motorola )
-				{
-					snd_ptr->config.io_base = 0x830;
-					snd_ptr->config.irq = 10;
-					snd_ptr->config.dma = ppc_cs4232_dma = 6;
-					snd_ptr->config.dma2 = ppc_cs4232_dma2 = 7;
-				}
-				if ( _prep_type == _PREP_IBM )
-				{
-					snd_ptr->config.io_base = 0x530;
-					snd_ptr->config.irq = 5;
-					snd_ptr->config.dma = ppc_cs4232_dma = 1;
-					/* this is wrong - but leave it for now */
-					snd_ptr->config.dma2 = ppc_cs4232_dma2 = 7;
-				}
-			}
-		}
-	}
-#endif /* CONFIG_SOUND_CS4232 */

 	/*print_residual_device_info();*/

===== include/asm-ppc/dma.h 1.10 vs edited =====
--- 1.10/include/asm-ppc/dma.h	Tue Jun  5 04:45:21 2001
+++ edited/include/asm-ppc/dma.h	Thu Oct  4 14:04:50 2001
@@ -102,24 +102,6 @@
  *
  */

-/* used in nasty hack for sound - see prep_setup_arch() -- Cort */
-extern long ppc_cs4232_dma, ppc_cs4232_dma2;
-#if defined(CONFIG_CS4232)
-#if defined(CONFIG_ALL_PPC)
-#define SND_DMA1 ppc_cs4232_dma
-#define SND_DMA2 ppc_cs4232_dma2
-#else /* !CONFIG_ALL_PPC */
-#define SND_DMA1 -1
-#define SND_DMA2 -1
-#endif /* CONFIG_ALL_PPC */
-#elif defined(CONFIG_MSS)
-#define SND_DMA1 CONFIG_MSS_DMA
-#define SND_DMA2 CONFIG_MSS_DMA2
-#else
-#define SND_DMA1 -1
-#define SND_DMA2 -1
-#endif
-
 /* 8237 DMA controllers */
 #define IO_DMA1_BASE	0x00	/* 8 bit slave DMA, channels 0..3 */
 #define IO_DMA2_BASE	0xC0	/* 16 bit master DMA, ch 4(=slave input)..7 */
@@ -278,24 +260,15 @@
 			dma_outb(pagenr>>8, DMA_HI_PAGE_3);
 			break;
 	        case 5:
-		        if (SND_DMA1 == 5 || SND_DMA2 == 5)
-				dma_outb(pagenr, DMA_LO_PAGE_5);
-			else
-				dma_outb(pagenr & 0xfe, DMA_LO_PAGE_5);
+			dma_outb(pagenr & 0xfe, DMA_LO_PAGE_5);
                         dma_outb(pagenr>>8, DMA_HI_PAGE_5);
 			break;
 		case 6:
-		        if (SND_DMA1 == 6 || SND_DMA2 == 6)
-				dma_outb(pagenr, DMA_LO_PAGE_6);
-			else
-				dma_outb(pagenr & 0xfe, DMA_LO_PAGE_6);
+			dma_outb(pagenr & 0xfe, DMA_LO_PAGE_6);
 			dma_outb(pagenr>>8, DMA_HI_PAGE_6);
 			break;
 		case 7:
-			if (SND_DMA1 == 7 || SND_DMA2 == 7)
-				dma_outb(pagenr, DMA_LO_PAGE_7);
-			else
-				dma_outb(pagenr & 0xfe, DMA_LO_PAGE_7);
+			dma_outb(pagenr & 0xfe, DMA_LO_PAGE_7);
 			dma_outb(pagenr>>8, DMA_HI_PAGE_7);
 		  break;
 	}
@@ -307,18 +280,12 @@
  */
 static __inline__ void set_dma_addr(unsigned int dmanr, unsigned int phys)
 {
-	if (dmanr <= 3)  {
-	    dma_outb( phys & 0xff, ((dmanr&3)<<1) + IO_DMA1_BASE );
-            dma_outb( (phys>>8) & 0xff, ((dmanr&3)<<1) + IO_DMA1_BASE );
-	}  else  {
-	  if (dmanr == SND_DMA1 || dmanr == SND_DMA2) {
-	    dma_outb( phys  & 0xff, ((dmanr&3)<<2) + IO_DMA2_BASE );
-	    dma_outb( (phys>>8)  & 0xff, ((dmanr&3)<<2) + IO_DMA2_BASE );
-	    dma_outb( (dmanr&3), DMA2_EXT_REG);
-	  } else {
-	    dma_outb( (phys>>1) & 0xff, ((dmanr&3)<<2) + IO_DMA2_BASE );
-	    dma_outb( (phys>>9) & 0xff, ((dmanr&3)<<2) + IO_DMA2_BASE );
-	  }
+	if (dmanr <= 3) {
+		dma_outb( phys & 0xff, ((dmanr&3)<<1) + IO_DMA1_BASE );
+		dma_outb( (phys>>8) & 0xff, ((dmanr&3)<<1) + IO_DMA1_BASE );
+	} else {
+		dma_outb( (phys>>1) & 0xff, ((dmanr&3)<<2) + IO_DMA2_BASE );
+		dma_outb( (phys>>9) & 0xff, ((dmanr&3)<<2) + IO_DMA2_BASE );
 	}
 	set_dma_page(dmanr, phys>>16);
 }
@@ -339,17 +306,11 @@
 	    dma_outb( count & 0xff, ((dmanr&3)<<1) + 1 + IO_DMA1_BASE );
 	    dma_outb( (count>>8) & 0xff, ((dmanr&3)<<1) + 1 + IO_DMA1_BASE );
         } else {
-	  if (dmanr == SND_DMA1 || dmanr == SND_DMA2) {
-	    dma_outb( count & 0xff, ((dmanr&3)<<2) + 2 + IO_DMA2_BASE );
-	    dma_outb( (count>>8) & 0xff, ((dmanr&3)<<2) + 2 + IO_DMA2_BASE );
-	  } else {
 	    dma_outb( (count>>1) & 0xff, ((dmanr&3)<<2) + 2 + IO_DMA2_BASE );
 	    dma_outb( (count>>9) & 0xff, ((dmanr&3)<<2) + 2 + IO_DMA2_BASE );
-	  }
         }
 }

-
 /* Get DMA residue count. After a DMA transfer, this
  * should return zero. Reading this while a DMA transfer is
  * still in progress will return unpredictable results.
@@ -369,8 +330,7 @@
 	count = 1 + dma_inb(io_port);
 	count += dma_inb(io_port) << 8;

-	return (dmanr <= 3 || dmanr == SND_DMA1 || dmanr == SND_DMA2)
-	  ? count : (count<<1);
+	return (dmanr <= 3) ? count : (count<<1);
 }

 /* These are in kernel/dma.c: */

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
