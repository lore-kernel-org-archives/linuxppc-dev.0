Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYVrB2SvwzDq5c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 11:43:54 +1000 (AEST)
Date: Mon, 20 Jun 2016 20:43:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org,
 bhelgaas@google.com, alex.williamson@redhat.com, aik@ozlabs.ru,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 corbet@lwn.net, warrier@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 gwshan@linux.vnet.ibm.com
Subject: Re: [RESEND PATCH v2 1/4] PCI: Ignore resource_alignment if
 PCI_PROBE_ONLY was set\\
Message-ID: <20160621014346.GA30307@localhost>
References: <1464846411-16895-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1464846411-16895-2-git-send-email-xyjxie@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1464846411-16895-2-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 02, 2016 at 01:46:48PM +0800, Yongji Xie wrote:
> The resource_alignment will releases memory resources allocated
> by firmware so that kernel can reassign new resources later on.
> But this will cause the problem that no resources can be
> allocated by kernel if PCI_PROBE_ONLY was set, e.g. on pSeries
> platform because PCI_PROBE_ONLY force kernel to use firmware
> setup and not to reassign any resources.
> 
> To solve this problem, this patch ignores resource_alignment
> if PCI_PROBE_ONLY was set.
> 
> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
> ---
>  drivers/pci/pci.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index c8b4dbd..a259394 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4761,6 +4761,12 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
>  	spin_lock(&resource_alignment_lock);
>  	p = resource_alignment_param;
>  	while (*p) {
> +		if (pci_has_flag(PCI_PROBE_ONLY)) {
> +			printk(KERN_ERR "PCI: Ignore resource_alignment parameter: %s with PCI_PROBE_ONLY set\n",
> +					p);
> +			*p = 0;
> +			break;

Wouldn't it be simpler to make pci_set_resource_alignment_param() fail
if PCI_PROBE_ONLY is set?

> +		}
>  		count = 0;
>  		if (sscanf(p, "%d%n", &align_order, &count) == 1 &&
>  							p[count] == '@') {
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
