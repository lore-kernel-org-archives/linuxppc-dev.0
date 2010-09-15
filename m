Return-Path: <nacc@us.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 456E110CCB3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 04:13:28 +1000 (EST)
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e4.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8FHw47k013298
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2010 13:58:04 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8FIDOe8373892
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2010 14:13:24 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o8FIDM8m008879
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2010 14:13:24 -0400
Date: Wed, 15 Sep 2010 11:13:19 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: nacc@us.ibm.com
Subject: [PATCH 01/15] ppc: fix return type of BUID_{HI,LO} macros
Message-ID: <20100915181319.GB3683@us.ibm.com>
References: <1284573958-8397-1-git-send-email-nacc@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1284573958-8397-1-git-send-email-nacc@us.ibm.com>
Cc: Milton Miller <miltonm@bga.com>, Paul Mackerras <paulus@samba.org>,
	Linas Vepstas <linasvepstas@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Breno Leitao <leitao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

BUID_HI and BUID_LO are used to pass data to call_rtas, which expects
ints or u32s. But the macro doesn't cast the return, so the result is
still u64. Use the upper_32_bits and lower_32_bits macros that have been
added to kernel.h.

Found by getting printf format errors trying to debug print the args, no
actual code change for 64 bit kernels where the macros are actually
used.

Signed-off-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
---
 arch/powerpc/include/asm/ppc-pci.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
index 42fdff0..43268f1 100644
--- a/arch/powerpc/include/asm/ppc-pci.h
+++ b/arch/powerpc/include/asm/ppc-pci.h
@@ -28,8 +28,8 @@ extern void find_and_init_phbs(void);
 extern struct pci_dev *isa_bridge_pcidev;	/* may be NULL if no ISA bus */

 /** Bus Unit ID macros; get low and hi 32-bits of the 64-bit BUID */
-#define BUID_HI(buid) ((buid) >> 32)
-#define BUID_LO(buid) ((buid) & 0xffffffff)
+#define BUID_HI(buid) upper_32_bits(buid)
+#define BUID_LO(buid) lower_32_bits(buid)

 /* PCI device_node operations */
 struct device_node;
-- 
1.7.0.4
