Message-ID: <18150-78623@sneakemail.com>
Date: Wed, 16 Jun 2004 07:46:34 -0700
From: "Stephen Williams" <612dlag102@sneakemail.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Configure tweaks for SystemACE without CONFIG_XILINX_OCP
References: <27972-80808@sneakemail.com> <1087388724.17025.4.camel@pavement.sandburst.com>
In-Reply-To: <1087388724.17025.4.camel@pavement.sandburst.com>
Content-Type: multipart/mixed;
 boundary="------------080007030305090405090307"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------080007030305090405090307
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Travis B. Sawyer tsawyer-at-sandburst.com |PPC Linux Embedded| wrote:
> Steve:
>
> I'm working on getting sysace to come up on our custom hw.
>
> Where did you put the definitions that the driver code needs, eg:
> #if defined(CONFIG_XILINX_SYSACE)
> #define XPAR_XSYSACE_NUM_INSTANCES	1
> #define XPAR_SYSACE_0_BASEADDR		0xe8100000
> #define XPAR_SYSACE_0_HIGHADDR		0xe8100FFF
> #define XPAR_SYSACE_0_DEVICE_ID		160
> #define XPAR_INTC_0_SYSACE_0_VEC_ID	51  /* UIC1:20, IRQ9 */
> #endif
>
> Am I way off base with these?  I dropped them in my board specific
> header file...  Or, should I be using:
>
> #define XPAR_SYSACE_0_BASEADDR		0x0000000148100000ULL
> #define XPAR_SYSACE_0_HIGHADDR		0x0000000148100FFFULL

First, you'll need the attached sysace-without-virtexii patch, which
has not been pushed to the linuxppc-2.4 tree yet. This fixes some
V2PRO dependencies when XILINX_OCP is activated.


I started by editing the file platforms/xilinx_ocp/xparameters.h:

===== arch/ppc/platforms/xilinx_ocp/xparameters.h 1.1 vs edited =====
--- 1.1/arch/ppc/platforms/xilinx_ocp/xparameters.h	2003-03-12 08:35:10 -08:00
+++ edited/arch/ppc/platforms/xilinx_ocp/xparameters.h	2004-06-10 13:53:02 -07:00
@@ -16,3 +16,7 @@
  #if defined(CONFIG_XILINX_ML300)
  #include "xparameters_ml300.h"
  #endif
+
+#if defined(CONFIG_JSE)
+#include "xparameters_jse.h"
+#endif

The CONFIG_JSE is for my board. I then added the xparameters_jse.h
file next to the xparameters_ml300.h that has the pertinent values
for my system. I've attached mine as a working example.


I also edited the arch/ppc/config.in so that the right defines
are enabled:

===== arch/ppc/config.in 1.69 vs edited =====
--- 1.69/arch/ppc/config.in	2004-03-25 16:39:48 -08:00
+++ edited/arch/ppc/config.in	2004-06-10 14:29:58 -07:00
@@ -79,6 +79,7 @@
  	 CPCI405	CONFIG_CPCI405 		\
  	 EP405/EP405PC	CONFIG_EP405 		\
  	 405EP-eval	CONFIG_EVB405EP		\
+	 JSE		CONFIG_JSE              \
  	 Oak		CONFIG_OAK 		\
  	 Rainier	CONFIG_RAINIER		\
  	 Redwood-4	CONFIG_REDWOOD_4 	\
@@ -321,6 +322,11 @@
      define_bool CONFIG_405GPR y
      define_bool CONFIG_BIOS_FIXUP y
      define_bool CONFIG_IBM_OPENBIOS y
+  fi
+
+  if [ "$CONFIG_JSE" = "y" ]; then
+    define_bool CONFIG_405GPR y
+    define_bool CONFIG_XILINX_OCP y
    fi

    if [ "$CONFIG_EBONY" = "y" ]; then

This activates CONFIG_XILINX_OCP when I config the JSE board,
and that allows the XILINX_SYSACE to be selected. From here,
make sure CONFIG_XILINX_SYSACE=y in your .config and you are
set.

--
Steve Williams                "The woods are lovely, dark and deep.
steve at XXXXXXXXXX           But I have promises to keep,
http://www.XXXXXXXXXX         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."

--------------080007030305090405090307
Content-Type: text/plain;
 name="sysace-without-virtex.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sysace-without-virtex.patch"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/06/10 18:45:08-07:00 steve@wing.XXXXXXXXXX
#   Condition Xilinx on-chip processor config with
#   CONFIG_VIRTEX_II_PRO
#
# arch/ppc/kernel/ppc405_pci.c
#   2004/06/10 18:45:06-07:00 steve@wing.XXXXXXXXXX +1 -1
#   Condition Xilinx on-chip processor support with
#   CONFIG_VIRTEX_II_PRO
#
# arch/ppc/kernel/Makefile
#   2004/06/10 18:45:06-07:00 steve@wing.XXXXXXXXXX +1 -1
#   Condition Xilinx on-chip processor support with
#   CONFIG_VIRTEX_II_PRO
#
# BitKeeper/etc/ignore
#   2004/06/10 18:45:06-07:00 steve@wing.XXXXXXXXXX +4 -0
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

--------------080007030305090405090307
Content-Type: text/plain;
 name="xparameters_jse.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xparameters_jse.h"


  /* The SystemACE chip is on CS1#, mapped here. */
#define XPAR_SYSACE_0_BASEADDR 0xf0000000
#define XPAR_SYSACE_0_HIGHADDR 0xf00001FF

  /* On the JSE board, the SystemACE chip is wired to IRQ 29 */
#define XPAR_INTC_0_SYSACE_0_VEC_ID 2

#define XPAR_XSYSACE_NUM_INSTANCES 1
#define XPAR_OPB_SYSACE_0_MEM_WIDTH 8
#define XPAR_OPB_SYSACE_0_DEVICE_ID 0
#define XPAR_OPB_SYSACE_0_BASEADDR XPAR_SYSACE_0_BASEADDR

--------------080007030305090405090307--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
