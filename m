Message-ID: <410563B7.2050101@icarus.com>
Date: Mon, 26 Jul 2004 13:04:07 -0700
From: Stephen Williams <steve@icarus.com>
MIME-Version: 1.0
To: Andrei Konovalov <akonovalov@ru.mvista.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Patch for SystemACE without CONFIG_XILINX_OCP
References: <41055881.6000707@icarus.com>
In-Reply-To: <41055881.6000707@icarus.com>
Content-Type: multipart/mixed;
 boundary="------------080707050004010801050508"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------080707050004010801050508
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Stephen Williams wrote:
|
|
|
| hI,
|
| I passed around the attached patch in hopes that it could be
| integrated into the linuxppc-2.4 bitkeeper tree, assuming that
| is the best place to maintain linux 2.4 for PPC. But I don't
| see it showing up in the repository.

And of course I forgot to attach the patch. This time, it
really is attached.

- --
Steve Williams                "The woods are lovely, dark and deep.
steve at icarus.com           But I have promises to keep,
http://www.icarus.com         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."

--------------080707050004010801050508
Content-Type: text/plain;
 name="sysace-without-virtex.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sysace-without-virtex.patch"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/06/10 18:45:08-07:00 steve@wing.icarus.com
#   Condition Xilinx on-chip processor config with
#   CONFIG_VIRTEX_II_PRO
#
# arch/ppc/kernel/ppc405_pci.c
#   2004/06/10 18:45:06-07:00 steve@wing.icarus.com +1 -1
#   Condition Xilinx on-chip processor support with
#   CONFIG_VIRTEX_II_PRO
#
# arch/ppc/kernel/Makefile
#   2004/06/10 18:45:06-07:00 steve@wing.icarus.com +1 -1
#   Condition Xilinx on-chip processor support with
#   CONFIG_VIRTEX_II_PRO
#
# BitKeeper/etc/ignore
#   2004/06/10 18:45:06-07:00 steve@wing.icarus.com +4 -0
#   Added arch/ppc/boot/images/uImage arch/ppc/boot/images/vmlinux.UBoot arch/ppc/boot/images/vmlinux.gz arch/ppc/kernel/ppc_defs.h to the ignore list
#
diff -Nru a/arch/ppc/kernel/Makefile b/arch/ppc/kernel/Makefile
--- a/arch/ppc/kernel/Makefile	2004-06-10 19:57:40 -07:00
+++ b/arch/ppc/kernel/Makefile	2004-06-10 19:57:40 -07:00
@@ -61,7 +61,7 @@
 obj-$(CONFIG_PPC_OCP)		+= ocp.o
 obj-$(CONFIG_40x)		+= ppc4xx_setup.o
 obj-$(CONFIG_4xx)		+= todc_time.o idle_4xx.o
-ifeq ($(CONFIG_XILINX_OCP),y)
+ifeq ($(CONFIG_XILINX_OCP)$(CONFIG_VIRTEX_II_PRO),yy)
 obj-$(CONFIG_40x)		+= xilinx_pic.o
 else
 obj-$(CONFIG_40x)		+= ppc4xx_pic.o
diff -Nru a/arch/ppc/kernel/ppc405_pci.c b/arch/ppc/kernel/ppc405_pci.c
--- a/arch/ppc/kernel/ppc405_pci.c	2004-06-10 19:57:40 -07:00
+++ b/arch/ppc/kernel/ppc405_pci.c	2004-06-10 19:57:40 -07:00
@@ -132,7 +132,7 @@
 	setup_indirect_pci(hose_a, PPC405_PCI_CONFIG_ADDR,
 			   PPC405_PCI_CONFIG_DATA);

-#ifdef CONFIG_XILINX_OCP
+#if defined(CONFIG_XILINX_OCP) && defined(CONFIG_VIRTEX_II_PRO)
 	/* Eliminate "unused variable" warning for pcip.  Optimizer removes. */
 	pcip = NULL;
 	new_pmm_min = PPC405_PCI_LOWER_MEM;

--------------080707050004010801050508--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
