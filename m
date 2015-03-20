Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C66CC1A0DAA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 14:09:48 +1100 (AEDT)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Fri, 20 Mar 2015 13:09:48 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 0731F2BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 14:09:45 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2K39aer28311580
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 14:09:44 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2K39AqE003513
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 14:09:11 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com
Subject: [PATCH V14 04/21] PCI: Print PF SR-IOV resource that contains all
 VF(n) BAR space
Date: Fri, 20 Mar 2015 11:06:20 +0800
Message-Id: <1426820797-6267-5-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1426820797-6267-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1426820797-6267-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, Wei Yang <weiyang@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When we size VF BAR0, VF BAR1, etc., from the SR-IOV Capability of a PF, we
learn the alignment requirement and amount of space consumed by a single
VF.  But when VFs are enabled, *each* of the NumVFs consumes that amount of
space, so the total size of the PF resource is "VF BAR size * NumVFs".

Add a printk of the total space consumed by the VFs corresponding to what
we already do for normal non-IOV BARs.

No functional change; new message only.

[bhelgaas: split out into its own patch]
Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 drivers/pci/iov.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index c4c33ea..05f9d97 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -372,6 +372,8 @@ found:
 			goto failed;
 		}
 		res->end = res->start + resource_size(res) * total - 1;
+		dev_info(&dev->dev, "VF(n) BAR%d space: %pR (contains BAR%d for %d VFs)\n",
+			 i, res, i, total);
 		nres++;
 	}
 
-- 
1.7.9.5
