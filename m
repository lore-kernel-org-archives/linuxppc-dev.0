Date: Tue, 24 Oct 2000 20:03:39 +0200
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: ThinkPad 850 Patches for 2.2.16
Message-ID: <20001024200338.A908@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="X1bOJ3K7DJ5YkBrT"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Linar Yusupov did some patches for the Thinkpad 850 to make sound work
on these machines. It fixes also some typos for /proc/cpuinfo.

I'm not sure if the CAROLINA_IRQ_EDGE_MASK_HI change breaks anything else.

The sound stuff should be moved out of arch/ppc into the driver cs4232, you
can't have it as a module right now. xmms works fine, but I have many
dropouts. Any ideas how to finetune that?
That sound-patch will proably break the other PReP machines, I will test
it on the 43p 133 later. We need proably a _PREP_IBM_portable or so.





Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tp850.2.2.16.SuSE.dif"

diff -urN linux-2.2.16.SuSE.orig/arch/ppc/kernel/prep_pci.c linux-2.2.16.SuSE/arch/ppc/kernel/prep_pci.c
--- linux-2.2.16.SuSE.orig/arch/ppc/kernel/prep_pci.c	Fri Oct 21 08:01:53 1994
+++ linux-2.2.16.SuSE/arch/ppc/kernel/prep_pci.c	Tue Oct 25 11:29:08 1994
@@ -560,7 +560,7 @@
  * to either edge or level.
  */
 #define CAROLINA_IRQ_EDGE_MASK_LO   0x00  /* IRQ's 0-7  */
-#define CAROLINA_IRQ_EDGE_MASK_HI   0xA4  /* IRQ's 8-15 [10,13,15] */
+#define CAROLINA_IRQ_EDGE_MASK_HI   0xA0  /* IRQ's 8-15 [10,13,15] */

 /*
  * 8259 edge/level control definitions
@@ -932,7 +932,7 @@
 		switch(inb(0x0852))
 		{
 		case 0xff:
-			Motherboard_map_name = "IBM 850/860 Portable\n";
+			Motherboard_map_name = "IBM 850/860 Portable";
 			Motherboard_map = Nobis_pci_IRQ_map;
 			Motherboard_routes = Nobis_pci_IRQ_routes;
 			break;
diff -urN linux-2.2.16.SuSE.orig/arch/ppc/kernel/prep_setup.c linux-2.2.16.SuSE/arch/ppc/kernel/prep_setup.c
--- linux-2.2.16.SuSE.orig/arch/ppc/kernel/prep_setup.c	Fri Oct 21 08:01:53 1994
+++ linux-2.2.16.SuSE/arch/ppc/kernel/prep_setup.c	Tue Oct 25 11:39:47 1994
@@ -140,7 +140,7 @@
 		}
 		len += sprintf(buffer+len,"%sKb,",
 			       (((*(unsigned char *)0x8000080d)>>2)&1)?"512":"256");
-		len += sprintf(buffer+len,"%sync\n",
+		len += sprintf(buffer+len,"%ssync\n",
 			       ((*(unsigned char *)0x8000080d)>>7) ? "":"a");
 		break;
 	case _PREP_Motorola:
@@ -329,9 +329,9 @@
 				}
 				if ( _prep_type == _PREP_IBM )
 				{
-					snd_ptr->config.io_base = 0x530;
-					snd_ptr->config.irq =  5;
-					snd_ptr->config.dma = ppc_cs4232_dma = 1;
+					snd_ptr->config.io_base = 0x830;
+					snd_ptr->config.irq =  10;
+					snd_ptr->config.dma = ppc_cs4232_dma = 6;
 					/* this is wrong - but leave it for now */
 					snd_ptr->config.dma2 = ppc_cs4232_dma2 = 7;
 				}

--X1bOJ3K7DJ5YkBrT--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
