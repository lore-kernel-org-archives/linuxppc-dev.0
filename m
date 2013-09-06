Return-Path: <bhelgaas@google.com>
Received: from mail-yh0-x230.google.com (mail-yh0-x230.google.com
 [IPv6:2607:f8b0:4002:c01::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B75352C00EE
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Sep 2013 06:30:43 +1000 (EST)
Received: by mail-yh0-f48.google.com with SMTP id f10so1385307yha.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Sep 2013 13:30:39 -0700 (PDT)
Date: Fri, 6 Sep 2013 14:30:35 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH v2 3/6] powerpc/pci: use pci_is_pcie() to simplify code
Message-ID: <20130906203035.GA27940@google.com>
References: <1378367730-25996-1-git-send-email-wangyijing@huawei.com>
 <1378367730-25996-3-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1378367730-25996-3-git-send-email-wangyijing@huawei.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "James E.J. Bottomley" <JBottomley@parallels.com>,
 Paul Mackerras <paulus@samba.org>, Hanjun Guo <guohanjun@huawei.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 05, 2013 at 03:55:27PM +0800, Yijing Wang wrote:
> Use pci_is_pcie() to simplify code.
> 
> Acked-by: Kumar Gala <galak@kernel.crashing.org>
> Reviewed-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/powerpc/kernel/eeh.c     |    3 +--
>  arch/powerpc/sysdev/fsl_pci.c |    2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)

Ben, Paul, this has no dependencies on anything new to PCI or any
other patches in this series, so you can take it through the POWERPC
tree.  If you don't want to do that, let me know and I can take it.

If you want it:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> index 55593ee..6ebbe54 100644
> --- a/arch/powerpc/kernel/eeh.c
> +++ b/arch/powerpc/kernel/eeh.c
> @@ -189,8 +189,7 @@ static size_t eeh_gather_pci_data(struct eeh_dev *edev, char * buf, size_t len)
>  	}
>  
>  	/* If PCI-E capable, dump PCI-E cap 10, and the AER */
> -	cap = pci_find_capability(dev, PCI_CAP_ID_EXP);
> -	if (cap) {
> +	if (pci_is_pcie(dev)) {
>  		n += scnprintf(buf+n, len-n, "pci-e cap10:\n");
>  		printk(KERN_WARNING
>  		       "EEH: PCI-E capabilities and status follow:\n");
> diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
> index 46ac1dd..5402a1d 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -41,7 +41,7 @@ static void quirk_fsl_pcie_header(struct pci_dev *dev)
>  	u8 hdr_type;
>  
>  	/* if we aren't a PCIe don't bother */
> -	if (!pci_find_capability(dev, PCI_CAP_ID_EXP))
> +	if (!pci_is_pcie(dev))
>  		return;
>  
>  	/* if we aren't in host mode don't bother */
> -- 
> 1.7.1
> 
> 
