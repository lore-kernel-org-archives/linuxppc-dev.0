Return-Path: <Kim.Phillips@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0138.outbound.protection.outlook.com [157.56.110.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2FC3A1A0E72
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2015 11:26:21 +1100 (AEDT)
Date: Thu, 22 Jan 2015 18:20:56 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/fsl_pci: Fix pci stack build bug with FRAME_WARN
Message-ID: <20150122182056.cc3436bd90a6cbba70da538a@freescale.com>
In-Reply-To: <1421895747.4961.232.camel@freescale.com>
References: <20150120140349.a7a9885065c241b555b91717@freescale.com>
 <1421800292.4961.215.camel@freescale.com>
 <20150121204844.fda3d4ab23a8226b6cdfdaf6@freescale.com>
 <1421895747.4961.232.camel@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Wang Dongsheng <dongsheng.wang@freescale.com>, linux-kernel@vger.kernel.org,
 Himangi Saraogi <himangi774@gmail.com>, Anton Blanchard <anton@samba.org>,
 Paul Mackerras <paulus@samba.org>, Aaron Sierra <asierra@xes-inc.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 21 Jan 2015 21:02:27 -0600
Scott Wood <scottwood@freescale.com> wrote:

> On Wed, 2015-01-21 at 20:48 -0600, Kim Phillips wrote:
> > On Tue, 20 Jan 2015 18:31:32 -0600
> > Scott Wood <scottwood@freescale.com> wrote:
> > 
> > > On Tue, 2015-01-20 at 14:03 -0600, Kim Phillips wrote:
> > > > Fix this:
> > > > 
> > > >   CC      arch/powerpc/sysdev/fsl_pci.o
> > > > arch/powerpc/sysdev/fsl_pci.c: In function 'fsl_pcie_check_link':
> > > > arch/powerpc/sysdev/fsl_pci.c:91:1: error: the frame size of 1360 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> > > > 
> > > > when configuring FRAME_WARN, by converting the allocation from the
> > > > stack to the heap.  We use GFP_ATOMIC since this function can be
> > > > called with interrupts disabled.
> > > > 
> > > > Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> > > > ---
> > > >  arch/powerpc/sysdev/fsl_pci.c | 12 +++++++-----
> > > >  1 file changed, 7 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
> > > > index 6455c1e..635d743 100644
> > > > --- a/arch/powerpc/sysdev/fsl_pci.c
> > > > +++ b/arch/powerpc/sysdev/fsl_pci.c
> > > > @@ -69,11 +69,13 @@ static int fsl_pcie_check_link(struct pci_controller *hose)
> > > >  
> > > >  	if (hose->indirect_type & PPC_INDIRECT_TYPE_FSL_CFG_REG_LINK) {
> > > >  		if (hose->ops->read == fsl_indirect_read_config) {
> > > > -			struct pci_bus bus;
> > > > -			bus.number = hose->first_busno;
> > > > -			bus.sysdata = hose;
> > > > -			bus.ops = hose->ops;
> > > > -			indirect_read_config(&bus, 0, PCIE_LTSSM, 4, &val);
> > > > +			struct pci_bus *bus;
> > > > +			bus = kmalloc(sizeof(*bus), GFP_ATOMIC);
> > > > +			bus->number = hose->first_busno;
> > > 
> > > Missing check for allocation failure.
> > 
> > thanks.
> > 
> > > Do we not have a real struct pci_bus we can use here?  Or refactor
> > > indirect_read_config() to take hose and bus number instead?
> > 
> > indirect_read_config() can't be refactored because it is also used
> > in the generic struct pci_ops.  Unless you mean making an
> > __indirect_read_config that the original would call, 
> 
> Yes, that's what I mean.
> 
> > but that doesn't look that trivial given it calls pci_exclude_device with a
> > struct pci_controller hose.
> 
> Check for excluded devices in indirect_read_config(), not
> __indirect_read_config().

turns out it wasn't an issue; see below for a v2.

> > > If putting a pci_bus struct on the stack is no longer OK, then
> > > fake_pci_bus() should be fixed as well.  I wonder if GCC is allocating
> > > separate pci_bus structs on the stack for this one and the one that
> > > early_read_config_dword() uses...
> > 
> > fake_pci_bus()' version is static, so it's not on the stack.
> > 
> > given that, maybe fsl_pcie_check_link()'s should be static too?
> 
> Oh.  How would you ensure that it's only called once at a time?  It
> doesn't look like this is only called during early boot.
> fsl_pcie_check_link() is called every time we do any config read through
> the normal interface.  This is also a concern for the call to
> early_read_config_dword().

I really don't know how that works: that code has been there since
before linux was maintained in git.

Below is the v2.

Thanks,

Kim.

>From aac5aa245949ea3dadae9ea913d67c456f558a0c Mon Sep 17 00:00:00 2001
From: Kim Phillips <kim.phillips@freescale.com>
Date: Tue, 20 Jan 2015 14:03:49 -0600
Subject: [PATCH v2] powerpc/fsl_pci: Fix pci stack build bug with FRAME_WARN

Fix this:

  CC      arch/powerpc/sysdev/fsl_pci.o
arch/powerpc/sysdev/fsl_pci.c: In function 'fsl_pcie_check_link':
arch/powerpc/sysdev/fsl_pci.c:91:1: error: the frame size of 1360 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]

when configuring FRAME_WARN, by refactoring indirect_read_config()
to take hose and bus number instead of the 1344-byte struct pci_bus.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
v2: refactor indirect_read_config() instead of kmalloc'ing a struct
pci_bus.

 arch/powerpc/include/asm/pci-bridge.h |  4 ++++
 arch/powerpc/sysdev/fsl_pci.c         | 11 ++++-------
 arch/powerpc/sysdev/indirect_pci.c    | 25 +++++++++++++++++--------
 3 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 725247b..546d036 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -119,6 +119,10 @@ extern void setup_indirect_pci(struct pci_controller* hose,
 extern int indirect_read_config(struct pci_bus *bus, unsigned int devfn,
 				int offset, int len, u32 *val);
 
+extern int __indirect_read_config(struct pci_controller *hose,
+				  unsigned char bus_number, unsigned int devfn,
+				  int offset, int len, u32 *val);
+
 extern int indirect_write_config(struct pci_bus *bus, unsigned int devfn,
 				 int offset, int len, u32 val);
 
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 6455c1e..7cc215e 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -68,13 +68,10 @@ static int fsl_pcie_check_link(struct pci_controller *hose)
 	u32 val = 0;
 
 	if (hose->indirect_type & PPC_INDIRECT_TYPE_FSL_CFG_REG_LINK) {
-		if (hose->ops->read == fsl_indirect_read_config) {
-			struct pci_bus bus;
-			bus.number = hose->first_busno;
-			bus.sysdata = hose;
-			bus.ops = hose->ops;
-			indirect_read_config(&bus, 0, PCIE_LTSSM, 4, &val);
-		} else
+		if (hose->ops->read == fsl_indirect_read_config)
+			__indirect_read_config(hose, hose->first_busno, 0,
+					       PCIE_LTSSM, 4, &val);
+		else
 			early_read_config_dword(hose, 0, 0, PCIE_LTSSM, &val);
 		if (val < PCIE_LTSSM_L0)
 			return 1;
diff --git a/arch/powerpc/sysdev/indirect_pci.c b/arch/powerpc/sysdev/indirect_pci.c
index 1f6c570..692de9d 100644
--- a/arch/powerpc/sysdev/indirect_pci.c
+++ b/arch/powerpc/sysdev/indirect_pci.c
@@ -20,31 +20,31 @@
 #include <asm/pci-bridge.h>
 #include <asm/machdep.h>
 
-int indirect_read_config(struct pci_bus *bus, unsigned int devfn,
-			 int offset, int len, u32 *val)
+int __indirect_read_config(struct pci_controller *hose,
+			   unsigned char bus_number, unsigned int devfn,
+			   int offset, int len, u32 *val)
 {
-	struct pci_controller *hose = pci_bus_to_host(bus);
 	volatile void __iomem *cfg_data;
 	u8 cfg_type = 0;
 	u32 bus_no, reg;
 
 	if (hose->indirect_type & PPC_INDIRECT_TYPE_NO_PCIE_LINK) {
-		if (bus->number != hose->first_busno)
+		if (bus_number != hose->first_busno)
 			return PCIBIOS_DEVICE_NOT_FOUND;
 		if (devfn != 0)
 			return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 
 	if (ppc_md.pci_exclude_device)
-		if (ppc_md.pci_exclude_device(hose, bus->number, devfn))
+		if (ppc_md.pci_exclude_device(hose, bus_number, devfn))
 			return PCIBIOS_DEVICE_NOT_FOUND;
 
 	if (hose->indirect_type & PPC_INDIRECT_TYPE_SET_CFG_TYPE)
-		if (bus->number != hose->first_busno)
+		if (bus_number != hose->first_busno)
 			cfg_type = 1;
 
-	bus_no = (bus->number == hose->first_busno) ?
-			hose->self_busno : bus->number;
+	bus_no = (bus_number == hose->first_busno) ?
+			hose->self_busno : bus_number;
 
 	if (hose->indirect_type & PPC_INDIRECT_TYPE_EXT_REG)
 		reg = ((offset & 0xf00) << 16) | (offset & 0xfc);
@@ -77,6 +77,15 @@ int indirect_read_config(struct pci_bus *bus, unsigned int devfn,
 	return PCIBIOS_SUCCESSFUL;
 }
 
+int indirect_read_config(struct pci_bus *bus, unsigned int devfn,
+			 int offset, int len, u32 *val)
+{
+	struct pci_controller *hose = pci_bus_to_host(bus);
+
+	return __indirect_read_config(hose, bus->number, devfn, offset, len,
+				      val);
+}
+
 int indirect_write_config(struct pci_bus *bus, unsigned int devfn,
 			  int offset, int len, u32 val)
 {
-- 
2.2.2
