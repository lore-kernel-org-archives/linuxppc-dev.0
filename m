Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0CC51140293
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 11:28:00 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 5 May 2014 11:27:58 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 856452BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 11:27:56 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4516nuc21037266
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 11:06:49 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s451RtLT013749
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 11:27:56 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 10/22] powerpc/eeh: Introduce kvmppc_eeh_format_addr()
Date: Mon,  5 May 2014 11:27:59 +1000
Message-Id: <1399253291-3975-11-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1399253291-3975-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1399253291-3975-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, alex.williamson@redhat.com, qiudayu@linux.vnet.ibm.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The guest will pass 2 kinds of addresses: tranditional bus/device/
function combo, and guest sensitive PE address returned from host.
The patch introduces function kvmppc_eeh_format_addr() to convert
the guest address information from RTAS call argument (struct rtas_args)
and retrieve the EEH device or PE instance if necessary. The function
will be used by subsequent patches.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-rtas.c | 52 +++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/eeh-rtas.c b/arch/powerpc/platforms/powernv/eeh-rtas.c
index fded461..f04b820 100644
--- a/arch/powerpc/platforms/powernv/eeh-rtas.c
+++ b/arch/powerpc/platforms/powernv/eeh-rtas.c
@@ -39,6 +39,58 @@
 #include "powernv.h"
 #include "pci.h"
 
+/*
+ * Guest is passing 2 types of addresses. First one would be
+ * traditional bus/device/function combo and another one is
+ * PE address, which starts from 0x10000
+ */
+static int kvmppc_eeh_format_addr(struct kvm_vcpu *vcpu,
+				  struct rtas_args *args,
+				  struct eeh_vfio_pci_addr *addr,
+				  bool is_legacy,
+				  struct eeh_dev **pedev,
+				  struct eeh_pe **ppe)
+{
+	struct eeh_dev *edev;
+	struct eeh_pe *pe;
+
+	if (pedev) *pedev = NULL;
+	if (ppe) *ppe = NULL;
+
+	addr->kvm       = vcpu->kvm;
+	addr->buid_hi   = args->args[1];
+	addr->buid_lo   = args->args[2];
+	if (is_legacy) {
+		addr->bus   = (args->args[0] >> 16) & 0xFF;
+		addr->devfn = (args->args[0] >> 8) & 0xFF;
+
+		edev = eeh_vfio_dev_get(addr);
+		if (!edev) {
+			pr_warn("%s: Can't find VFIO device "
+				"(%08x-%08x-%02x-%02x)\n",
+				__func__, addr->buid_hi,
+				addr->buid_lo, addr->bus, addr->devfn);
+			return -EEXIST;
+		}
+
+		if (pedev) *pedev = edev;
+		if (ppe)   *ppe = edev->pe;
+	} else {
+		addr->pe_addr = args->args[0];
+		pe = eeh_vfio_pe_get(addr);
+		if (!pe) {
+			pr_warn("%s: Can't find PE (%08x-%08x-%x)\n",
+				__func__, addr->buid_hi,
+				addr->buid_lo, addr->pe_addr);
+			return -EEXIST;
+		}
+
+		if (ppe) *ppe = pe;
+	}
+
+	return 0;
+}
+
 /**
  * kvmppc_eeh_rtas - Backend for EEH RTAS emulation
  * @vcpu: KVM virtual CPU
-- 
1.8.3.2
