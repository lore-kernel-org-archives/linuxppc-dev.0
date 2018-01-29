Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zV9P912sSzDqhW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jan 2018 11:29:17 +1100 (AEDT)
Date: Mon, 29 Jan 2018 11:29:08 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Bjorn Helgaas <bhelgaas@google.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, "Bryant G. Ly"
 <bryantly@linux.vnet.ibm.com>
Subject: linux-next: manual merge of the pci tree with the powerpc tree
Message-ID: <20180129112908.2906da58@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Bjorn,

Today's linux-next merge of the pci tree got a conflict in:

  include/linux/pci.h

between commit:

  856e1eb9bdd4 ("PCI/AER: Add uevents in AER and EEH error/resume")

from the powerpc tree and commit:

  0aa0f5d1084c ("PCI: Clean up whitespace in linux/pci.h, pci/pci.h")

from the pci tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc include/linux/pci.h
index 881006c7a5d7,a1e10ba7b612..000000000000
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@@ -2280,43 -2267,19 +2269,55 @@@ static inline bool pci_is_thunderbolt_a
  	return false;
  }
  
 +/**
 + * pci_uevent_ers - emit a uevent during recovery path of pci device
 + * @pdev: pci device to check
 + * @err_type: type of error event
 + *
 + */
 +static inline void pci_uevent_ers(struct pci_dev *pdev,
 +				  enum  pci_ers_result err_type)
 +{
 +	int idx = 0;
 +	char *envp[3];
 +
 +	switch (err_type) {
 +	case PCI_ERS_RESULT_NONE:
 +	case PCI_ERS_RESULT_CAN_RECOVER:
 +		envp[idx++] = "ERROR_EVENT=BEGIN_RECOVERY";
 +		envp[idx++] = "DEVICE_ONLINE=0";
 +		break;
 +	case PCI_ERS_RESULT_RECOVERED:
 +		envp[idx++] = "ERROR_EVENT=SUCCESSFUL_RECOVERY";
 +		envp[idx++] = "DEVICE_ONLINE=1";
 +		break;
 +	case PCI_ERS_RESULT_DISCONNECT:
 +		envp[idx++] = "ERROR_EVENT=FAILED_RECOVERY";
 +		envp[idx++] = "DEVICE_ONLINE=0";
 +		break;
 +	default:
 +		break;
 +	}
 +
 +	if (idx > 0) {
 +		envp[idx++] = NULL;
 +		kobject_uevent_env(&pdev->dev.kobj, KOBJ_CHANGE, envp);
 +	}
 +}
 +
- /* provide the legacy pci_dma_* API */
+ /* Provide the legacy pci_dma_* API */
  #include <linux/pci-dma-compat.h>
  
+ #define pci_printk(level, pdev, fmt, arg...) \
+ 	dev_printk(level, &(pdev)->dev, fmt, ##arg)
+ 
+ #define pci_emerg(pdev, fmt, arg...)	dev_emerg(&(pdev)->dev, fmt, ##arg)
+ #define pci_alert(pdev, fmt, arg...)	dev_alert(&(pdev)->dev, fmt, ##arg)
+ #define pci_crit(pdev, fmt, arg...)	dev_crit(&(pdev)->dev, fmt, ##arg)
+ #define pci_err(pdev, fmt, arg...)	dev_err(&(pdev)->dev, fmt, ##arg)
+ #define pci_warn(pdev, fmt, arg...)	dev_warn(&(pdev)->dev, fmt, ##arg)
+ #define pci_notice(pdev, fmt, arg...)	dev_notice(&(pdev)->dev, fmt, ##arg)
+ #define pci_info(pdev, fmt, arg...)	dev_info(&(pdev)->dev, fmt, ##arg)
+ #define pci_dbg(pdev, fmt, arg...)	dev_dbg(&(pdev)->dev, fmt, ##arg)
+ 
  #endif /* LINUX_PCI_H */
