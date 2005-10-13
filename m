Return-Path: <rolandd@cisco.com>
Received: from ams-iport-1.cisco.com (ams-iport-1.cisco.com [144.254.224.140])
	by ozlabs.org (Postfix) with ESMTP id 407C76855E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Oct 2005 06:05:26 +1000 (EST)
To: linuxppc-embedded@ozlabs.org, mporter@kernel.crashing.org
From: Roland Dreier <rolandd@cisco.com>
Date: Thu, 13 Oct 2005 13:05:20 -0700
Message-ID: <5264s12nen.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: What is OCP_FUNC_OPB ??
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

While merging Ruslan Sushko's fix for GPIO and IIC addresses into my
440SPe tree, I noticed that ocp_core[] has an entry for a function
OCP_FUNC_OPB.  I'd like to get this correct for the 440SPe port, but I
don't see any users in the tree.

Is this field just used to create an entry in sysfs -- if so what does
userspace use it for??  Or is it just completely obsolete?  What is
the .paddr member supposed to represent?  Is it just the base address
of the whole OPB region?

Is it worth applying the patch below (according to the 440SP manual,
the OPB region starts at 0x1 f000 0000), or should we just get rid of
these entries entirely?

Thanks,
  Roland

[PPC32] Correct OPB base address for PowerPC 440SP

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

diff --git a/arch/ppc/platforms/4xx/ibm440sp.c b/arch/ppc/platforms/4xx/ibm440sp.c
index feb17e4..0b7e462 100644
--- a/arch/ppc/platforms/4xx/ibm440sp.c
+++ b/arch/ppc/platforms/4xx/ibm440sp.c
@@ -60,7 +60,7 @@ struct ocp_def core_ocp[] = {
 	{ .vendor	= OCP_VENDOR_IBM,
 	  .function	= OCP_FUNC_OPB,
 	  .index	= 0,
-	  .paddr	= 0x0000000140000000ULL,
+	  .paddr	= 0x00000001f0000000ULL,
 	  .irq		= OCP_IRQ_NA,
 	  .pm		= OCP_CPM_NA,
 	},
