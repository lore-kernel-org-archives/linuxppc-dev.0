Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2B5512C00B6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Sep 2013 13:17:03 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 3 Sep 2013 23:16:59 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id D00536E8028
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Sep 2013 23:16:57 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22036.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r843GvGU29294796
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Sep 2013 03:16:57 GMT
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r843GuHT023340
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Sep 2013 00:16:57 -0300
Date: Wed, 4 Sep 2013 11:16:51 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH 3/7] powerpc/pci: use pci_is_pcie() to simplify code
Message-ID: <20130904031651.GA6991@shangw.(null)>
References: <1378193715-25328-1-git-send-email-wangyijing@huawei.com>
 <1378193715-25328-3-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1378193715-25328-3-git-send-email-wangyijing@huawei.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>, Hanjun Guo <guohanjun@huawei.com>,
 linux-kernel@vger.kernel.org,
 "James E.J. Bottomley" <JBottomley@parallels.com>,
 Paul Mackerras <paulus@samba.org>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>Use pci_is_pcie() to simplify code.
>
>Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
>Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>Cc: Paul Mackerras <paulus@samba.org>
>Cc: linuxppc-dev@lists.ozlabs.org
>Cc: linux-kernel@vger.kernel.org

It looks good to me:

Reviewed-by: Gavin Shan <shangw@linux.vnet.ibm.com>

Thanks,
Gavin

>---
> arch/powerpc/kernel/eeh.c     |    3 +--
> arch/powerpc/sysdev/fsl_pci.c |    2 +-
> 2 files changed, 2 insertions(+), 3 deletions(-)
>
>diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
>index 39954fe..b0bd41a 100644
>--- a/arch/powerpc/kernel/eeh.c
>+++ b/arch/powerpc/kernel/eeh.c
>@@ -189,8 +189,7 @@ static size_t eeh_gather_pci_data(struct eeh_dev *edev, char * buf, size_t len)
> 	}
>
> 	/* If PCI-E capable, dump PCI-E cap 10, and the AER */
>-	cap = pci_find_capability(dev, PCI_CAP_ID_EXP);
>-	if (cap) {
>+	if (pci_is_pcie(dev)) {
> 		n += scnprintf(buf+n, len-n, "pci-e cap10:\n");
> 		printk(KERN_WARNING
> 		       "EEH: PCI-E capabilities and status follow:\n");
>diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
>index 46ac1dd..5402a1d 100644
>--- a/arch/powerpc/sysdev/fsl_pci.c
>+++ b/arch/powerpc/sysdev/fsl_pci.c
>@@ -41,7 +41,7 @@ static void quirk_fsl_pcie_header(struct pci_dev *dev)
> 	u8 hdr_type;
>
> 	/* if we aren't a PCIe don't bother */
>-	if (!pci_find_capability(dev, PCI_CAP_ID_EXP))
>+	if (!pci_is_pcie(dev))
> 		return;
>
> 	/* if we aren't in host mode don't bother */
>-- 
>1.7.1
>
>
