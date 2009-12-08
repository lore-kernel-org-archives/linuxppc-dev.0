Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id E6340B6F1B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Dec 2009 23:39:57 +1100 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id 26AD2AC853
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Dec 2009 13:39:51 +0100 (CET)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] PowerPC: const intspec pointers
MIME-Version: 1.0
Message-ID: <200912081339.50722.roman.fietze@telemotive.de>
Date: Tue, 8 Dec 2009 13:39:50 +0100
Content-Type: text/plain;
  charset="iso-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

Writing a driver using SCLPC on the MPC5200B I detected, that the
intspec arrays to map irqs to Linux virq cannot be const, because the
mapping and xlate functions only take non const pointers. All those
functions do not modify the intspec, so a const pointer could be used.

I tried to compile that patch on different platforms and got no
compiler errors, so I'd like to ask you to review that patch, and
check if it's worth using it.


Signed-off-by: Roman Fietze <roman.fietze@telemotive.de>
=2D--
 arch/powerpc/include/asm/irq.h                  |    4 ++--
 arch/powerpc/kernel/irq.c                       |    2 +-
 arch/powerpc/platforms/52xx/media5200.c         |    2 +-
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c       |    2 +-
 arch/powerpc/platforms/52xx/mpc52xx_pic.c       |    2 +-
 arch/powerpc/platforms/85xx/socrates_fpga_pic.c |    2 +-
 arch/powerpc/platforms/86xx/gef_pic.c           |    2 +-
 arch/powerpc/platforms/cell/beat_interrupt.c    |    4 ++--
 arch/powerpc/platforms/cell/interrupt.c         |    2 +-
 arch/powerpc/platforms/cell/spider-pic.c        |    2 +-
 arch/powerpc/platforms/powermac/pic.c           |    2 +-
 arch/powerpc/platforms/pseries/xics.c           |    2 +-
 arch/powerpc/sysdev/cpm2_pic.c                  |    2 +-
 arch/powerpc/sysdev/i8259.c                     |    2 +-
 arch/powerpc/sysdev/ipic.c                      |    2 +-
 arch/powerpc/sysdev/mpc8xx_pic.c                |    2 +-
 arch/powerpc/sysdev/mpic.c                      |    2 +-
 arch/powerpc/sysdev/qe_lib/qe_ic.c              |    2 +-
 arch/powerpc/sysdev/tsi108_pci.c                |    2 +-
 arch/powerpc/sysdev/uic.c                       |    2 +-
 arch/powerpc/sysdev/xilinx_intc.c               |    2 +-
 21 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/irq.h
index bbcd1aa..a0bcafc 100644
=2D-- a/arch/powerpc/include/asm/irq.h
+++ b/arch/powerpc/include/asm/irq.h
@@ -99,7 +99,7 @@ struct irq_host_ops {
 	 * interrupt controller has for that line)
 	 */
 	int (*xlate)(struct irq_host *h, struct device_node *ctrler,
=2D		     u32 *intspec, unsigned int intsize,
+		     const u32 *intspec, unsigned int intsize,
 		     irq_hw_number_t *out_hwirq, unsigned int *out_type);
 };
=20
@@ -313,7 +313,7 @@ extern void irq_free_virt(unsigned int virq, unsigned i=
nt=20
count);
  * of the of_irq_map_*() functions.
  */
 extern unsigned int irq_create_of_mapping(struct device_node *controller,
=2D					  u32 *intspec, unsigned int intsize);
+					  const u32 *intspec, unsigned int intsize);
=20
 /**
  * irq_of_parse_and_map - Parse and Map an interrupt into linux virq space
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index e5d1211..6e294e0 100644
=2D-- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -699,7 +699,7 @@ unsigned int irq_create_mapping(struct irq_host *host,
 EXPORT_SYMBOL_GPL(irq_create_mapping);
=20
 unsigned int irq_create_of_mapping(struct device_node *controller,
=2D				   u32 *intspec, unsigned int intsize)
+				   const u32 *intspec, unsigned int intsize)
 {
 	struct irq_host *host;
 	irq_hw_number_t hwirq;
diff --git a/arch/powerpc/platforms/52xx/media5200.c=20
b/arch/powerpc/platforms/52xx/media5200.c
index 68e4f16..b1ec9bb 100644
=2D-- a/arch/powerpc/platforms/52xx/media5200.c
+++ b/arch/powerpc/platforms/52xx/media5200.c
@@ -127,7 +127,7 @@ static int media5200_irq_map(struct irq_host *h, unsign=
ed=20
int virq,
 }
=20
 static int media5200_irq_xlate(struct irq_host *h, struct device_node *ct,
=2D				 u32 *intspec, unsigned int intsize,
+				 const u32 *intspec, unsigned int intsize,
 				 irq_hw_number_t *out_hwirq,
 				 unsigned int *out_flags)
 {
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c=20
b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
index bfbcd41..78f0ab6 100644
=2D-- a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
@@ -182,7 +182,7 @@ static int mpc52xx_gpt_irq_map(struct irq_host *h,=20
unsigned int virq,
 }
=20
 static int mpc52xx_gpt_irq_xlate(struct irq_host *h, struct device_node *c=
t,
=2D				 u32 *intspec, unsigned int intsize,
+				 const u32 *intspec, unsigned int intsize,
 				 irq_hw_number_t *out_hwirq,
 				 unsigned int *out_flags)
 {
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c=20
b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
index 480f806..53d44f6 100644
=2D-- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
@@ -355,7 +355,7 @@ static int mpc52xx_is_extirq(int l1, int l2)
  * mpc52xx_irqhost_xlate - translate virq# from device tree interrupts=20
property
  */
 static int mpc52xx_irqhost_xlate(struct irq_host *h, struct device_node *c=
t,
=2D				 u32 *intspec, unsigned int intsize,
+				 const u32 *intspec, unsigned int intsize,
 				 irq_hw_number_t *out_hwirq,
 				 unsigned int *out_flags)
 {
diff --git a/arch/powerpc/platforms/85xx/socrates_fpga_pic.c=20
b/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
index 60edf63..380858a 100644
=2D-- a/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
+++ b/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
@@ -253,7 +253,7 @@ static int socrates_fpga_pic_host_map(struct irq_host *=
h,=20
unsigned int virq,
 }
=20
 static int socrates_fpga_pic_host_xlate(struct irq_host *h,
=2D		struct device_node *ct,	u32 *intspec, unsigned int intsize,
+		struct device_node *ct,	const u32 *intspec, unsigned int intsize,
 		irq_hw_number_t *out_hwirq, unsigned int *out_flags)
 {
 	struct socrates_fpga_irq_info *fpga_irq =3D &fpga_irqs[intspec[0]];
diff --git a/arch/powerpc/platforms/86xx/gef_pic.c=20
b/arch/powerpc/platforms/86xx/gef_pic.c
index 50d0a2b..8d4479f 100644
=2D-- a/arch/powerpc/platforms/86xx/gef_pic.c
+++ b/arch/powerpc/platforms/86xx/gef_pic.c
@@ -170,7 +170,7 @@ static int gef_pic_host_map(struct irq_host *h, unsigne=
d=20
int virq,
 }
=20
 static int gef_pic_host_xlate(struct irq_host *h, struct device_node *ct,
=2D			    u32 *intspec, unsigned int intsize,
+			    const u32 *intspec, unsigned int intsize,
 			    irq_hw_number_t *out_hwirq, unsigned int *out_flags)
 {
=20
diff --git a/arch/powerpc/platforms/cell/beat_interrupt.c=20
b/arch/powerpc/platforms/cell/beat_interrupt.c
index 7225484..1f2fd65 100644
=2D-- a/arch/powerpc/platforms/cell/beat_interrupt.c
+++ b/arch/powerpc/platforms/cell/beat_interrupt.c
@@ -166,11 +166,11 @@ static void beatic_pic_host_remap(struct irq_host *h,=
=20
unsigned int virq,
  * Note: We have only 1 entry to translate.
  */
 static int beatic_pic_host_xlate(struct irq_host *h, struct device_node *c=
t,
=2D				 u32 *intspec, unsigned int intsize,
+				 const u32 *intspec, unsigned int intsize,
 				 irq_hw_number_t *out_hwirq,
 				 unsigned int *out_flags)
 {
=2D	u64 *intspec2 =3D (u64 *)intspec;
+	const u64 *intspec2 =3D (const u64 *)intspec;
=20
 	*out_hwirq =3D *intspec2;
 	*out_flags |=3D IRQ_TYPE_LEVEL_LOW;
diff --git a/arch/powerpc/platforms/cell/interrupt.c=20
b/arch/powerpc/platforms/cell/interrupt.c
index 882e470..d9d33cb 100644
=2D-- a/arch/powerpc/platforms/cell/interrupt.c
+++ b/arch/powerpc/platforms/cell/interrupt.c
@@ -297,7 +297,7 @@ static int iic_host_map(struct irq_host *h, unsigned in=
t=20
virq,
 }
=20
 static int iic_host_xlate(struct irq_host *h, struct device_node *ct,
=2D			   u32 *intspec, unsigned int intsize,
+			   const u32 *intspec, unsigned int intsize,
 			   irq_hw_number_t *out_hwirq, unsigned int *out_flags)
=20
 {
diff --git a/arch/powerpc/platforms/cell/spider-pic.c=20
b/arch/powerpc/platforms/cell/spider-pic.c
index 4e56556..37c2e4e 100644
=2D-- a/arch/powerpc/platforms/cell/spider-pic.c
+++ b/arch/powerpc/platforms/cell/spider-pic.c
@@ -187,7 +187,7 @@ static int spider_host_map(struct irq_host *h, unsigned=
=20
int virq,
 }
=20
 static int spider_host_xlate(struct irq_host *h, struct device_node *ct,
=2D			   u32 *intspec, unsigned int intsize,
+			   const u32 *intspec, unsigned int intsize,
 			   irq_hw_number_t *out_hwirq, unsigned int *out_flags)
=20
 {
diff --git a/arch/powerpc/platforms/powermac/pic.c=20
b/arch/powerpc/platforms/powermac/pic.c
index d212006..da6b4b9 100644
=2D-- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -303,7 +303,7 @@ static int pmac_pic_host_map(struct irq_host *h, unsign=
ed=20
int virq,
 }
=20
 static int pmac_pic_host_xlate(struct irq_host *h, struct device_node *ct,
=2D			       u32 *intspec, unsigned int intsize,
+			       const u32 *intspec, unsigned int intsize,
 			       irq_hw_number_t *out_hwirq,
 			       unsigned int *out_flags)
=20
diff --git a/arch/powerpc/platforms/pseries/xics.c=20
b/arch/powerpc/platforms/pseries/xics.c
index b9bf0ee..1821eae 100644
=2D-- a/arch/powerpc/platforms/pseries/xics.c
+++ b/arch/powerpc/platforms/pseries/xics.c
@@ -434,7 +434,7 @@ static int xics_host_map(struct irq_host *h, unsigned i=
nt=20
virq,
 }
=20
 static int xics_host_xlate(struct irq_host *h, struct device_node *ct,
=2D			   u32 *intspec, unsigned int intsize,
+			   const u32 *intspec, unsigned int intsize,
 			   irq_hw_number_t *out_hwirq, unsigned int *out_flags)
=20
 {
diff --git a/arch/powerpc/sysdev/cpm2_pic.c b/arch/powerpc/sysdev/cpm2_pic.c
index 78f1f7c..3d2be56 100644
=2D-- a/arch/powerpc/sysdev/cpm2_pic.c
+++ b/arch/powerpc/sysdev/cpm2_pic.c
@@ -216,7 +216,7 @@ static int cpm2_pic_host_map(struct irq_host *h, unsign=
ed=20
int virq,
 }
=20
 static int cpm2_pic_host_xlate(struct irq_host *h, struct device_node *ct,
=2D			    u32 *intspec, unsigned int intsize,
+			    const u32 *intspec, unsigned int intsize,
 			    irq_hw_number_t *out_hwirq, unsigned int *out_flags)
 {
 	*out_hwirq =3D intspec[0];
diff --git a/arch/powerpc/sysdev/i8259.c b/arch/powerpc/sysdev/i8259.c
index a96584a..ccc9a3b 100644
=2D-- a/arch/powerpc/sysdev/i8259.c
+++ b/arch/powerpc/sysdev/i8259.c
@@ -198,7 +198,7 @@ static void i8259_host_unmap(struct irq_host *h, unsign=
ed=20
int virq)
 }
=20
 static int i8259_host_xlate(struct irq_host *h, struct device_node *ct,
=2D			    u32 *intspec, unsigned int intsize,
+			    const u32 *intspec, unsigned int intsize,
 			    irq_hw_number_t *out_hwirq, unsigned int *out_flags)
 {
 	static unsigned char map_isa_senses[4] =3D {
diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
index cb7689c..27259f4 100644
=2D-- a/arch/powerpc/sysdev/ipic.c
+++ b/arch/powerpc/sysdev/ipic.c
@@ -697,7 +697,7 @@ static int ipic_host_map(struct irq_host *h, unsigned i=
nt=20
virq,
 }
=20
 static int ipic_host_xlate(struct irq_host *h, struct device_node *ct,
=2D			   u32 *intspec, unsigned int intsize,
+			   const u32 *intspec, unsigned int intsize,
 			   irq_hw_number_t *out_hwirq, unsigned int *out_flags)
=20
 {
diff --git a/arch/powerpc/sysdev/mpc8xx_pic.c=20
b/arch/powerpc/sysdev/mpc8xx_pic.c
index 5d2d552..72544a1 100644
=2D-- a/arch/powerpc/sysdev/mpc8xx_pic.c
+++ b/arch/powerpc/sysdev/mpc8xx_pic.c
@@ -130,7 +130,7 @@ static int mpc8xx_pic_host_map(struct irq_host *h,=20
unsigned int virq,
=20
=20
 static int mpc8xx_pic_host_xlate(struct irq_host *h, struct device_node *c=
t,
=2D			    u32 *intspec, unsigned int intsize,
+			    const u32 *intspec, unsigned int intsize,
 			    irq_hw_number_t *out_hwirq, unsigned int *out_flags)
 {
 	static unsigned char map_pic_senses[4] =3D {
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 30c44e6..1452a4e 100644
=2D-- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -994,7 +994,7 @@ static int mpic_host_map(struct irq_host *h, unsigned i=
nt=20
virq,
 }
=20
 static int mpic_host_xlate(struct irq_host *h, struct device_node *ct,
=2D			   u32 *intspec, unsigned int intsize,
+			   const u32 *intspec, unsigned int intsize,
 			   irq_hw_number_t *out_hwirq, unsigned int *out_flags)
=20
 {
diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.c=20
b/arch/powerpc/sysdev/qe_lib/qe_ic.c
index 3faa42e..8192f58 100644
=2D-- a/arch/powerpc/sysdev/qe_lib/qe_ic.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_ic.c
@@ -271,7 +271,7 @@ static int qe_ic_host_map(struct irq_host *h, unsigned =
int=20
virq,
 }
=20
 static int qe_ic_host_xlate(struct irq_host *h, struct device_node *ct,
=2D			    u32 * intspec, unsigned int intsize,
+			    const u32 * intspec, unsigned int intsize,
 			    irq_hw_number_t * out_hwirq,
 			    unsigned int *out_flags)
 {
diff --git a/arch/powerpc/sysdev/tsi108_pci.c=20
b/arch/powerpc/sysdev/tsi108_pci.c
index cf244a4..a23223d 100644
=2D-- a/arch/powerpc/sysdev/tsi108_pci.c
+++ b/arch/powerpc/sysdev/tsi108_pci.c
@@ -384,7 +384,7 @@ static struct irq_chip tsi108_pci_irq =3D {
 };
=20
 static int pci_irq_host_xlate(struct irq_host *h, struct device_node *ct,
=2D			    u32 *intspec, unsigned int intsize,
+			    const u32 *intspec, unsigned int intsize,
 			    irq_hw_number_t *out_hwirq, unsigned int *out_flags)
 {
 	*out_hwirq =3D intspec[0];
diff --git a/arch/powerpc/sysdev/uic.c b/arch/powerpc/sysdev/uic.c
index 466ce9a..1c315d8 100644
=2D-- a/arch/powerpc/sysdev/uic.c
+++ b/arch/powerpc/sysdev/uic.c
@@ -202,7 +202,7 @@ static int uic_host_map(struct irq_host *h, unsigned in=
t=20
virq,
 }
=20
 static int uic_host_xlate(struct irq_host *h, struct device_node *ct,
=2D			  u32 *intspec, unsigned int intsize,
+			  const u32 *intspec, unsigned int intsize,
 			  irq_hw_number_t *out_hwirq, unsigned int *out_type)
=20
 {
diff --git a/arch/powerpc/sysdev/xilinx_intc.c=20
b/arch/powerpc/sysdev/xilinx_intc.c
index 40edad5..368db32 100644
=2D-- a/arch/powerpc/sysdev/xilinx_intc.c
+++ b/arch/powerpc/sysdev/xilinx_intc.c
@@ -148,7 +148,7 @@ static struct irq_chip xilinx_intc_edge_irqchip =3D {
  * xilinx_intc_xlate - translate virq# from device tree interrupts property
  */
 static int xilinx_intc_xlate(struct irq_host *h, struct device_node *ct,
=2D				u32 *intspec, unsigned int intsize,
+				const u32 *intspec, unsigned int intsize,
 				irq_hw_number_t *out_hwirq,
 				unsigned int *out_flags)
 {
=2D-=20
1.6.5.3


Thanks a lot for your help


Roman

=2D-=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
