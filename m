Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qfVVJ0n46zDqML
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Apr 2016 23:45:28 +1000 (AEST)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Tue, 5 Apr 2016 23:45:26 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 4066D3578058
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Apr 2016 23:45:11 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u35Dj0Cd17825972
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Apr 2016 23:45:11 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u35DiZQu006637
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Apr 2016 23:44:36 +1000
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-doc@vger.kernel.org
Cc: bhelgaas@google.com, corbet@lwn.net, aik@ozlabs.ru,
 alex.williamson@redhat.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, warrier@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 gwshan@linux.vnet.ibm.com, Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: [RFC v5 1/7] PCI: Ignore resource_alignment if PCI_PROBE_ONLY was set
Date: Tue,  5 Apr 2016 21:43:29 +0800
Message-Id: <1459863813-2830-2-git-send-email-xyjxie@linux.vnet.ibm.com>
In-Reply-To: <1459863813-2830-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1459863813-2830-1-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The resource_alignment will releases memory
resources allocated by firmware so that kernel
can reassign new resources later on. But this
will cause the problem that no resources can be
allocated by kernel if PCI_PROBE_ONLY was set,
e.g. on pSeries platform because PCI_PROBE_ONLY
force kernel to use firmware setup and not to
reassign any resources.

To solve this problem, this patch ignores
resource_alignment if PCI_PROBE_ONLY was set.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 drivers/pci/pci.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 602eb42..1db9267 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4607,6 +4607,12 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
 	spin_lock(&resource_alignment_lock);
 	p = resource_alignment_param;
 	while (*p) {
+		if (pci_has_flag(PCI_PROBE_ONLY)) {
+			printk(KERN_ERR "PCI: Ignore resource_alignment parameter: %s with"
+					" PCI_PROBE_ONLY set\n", p);
+			*p = 0;
+			break;
+		}
 		count = 0;
 		if (sscanf(p, "%d%n", &align_order, &count) == 1 &&
 							p[count] == '@') {
-- 
1.7.9.5
