Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tjXk40qBWzDwRr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 20:36:59 +1100 (AEDT)
Date: Tue, 20 Dec 2016 10:37:09 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org,
 #v4.9+@gwshan.ozlabs.ibm.com
Subject: Re: [PATCH] drivers/pci/hotplug: Handle presence detection change
 properly
Message-ID: <20161220093709.GA12938@kroah.com>
References: <1482216573-21487-1-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1482216573-21487-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 20, 2016 at 05:49:33PM +1100, Gavin Shan wrote:
> The surprise hotplug is driven by interrupt in PowerNV PCI hotplug
> driver. In the interrupt handler, pnv_php_interrupt(), we bail when
> pnv_pci_get_presence_state() returns zero wrongly. It causes the
> presence change event is always ignored incorrectly.
> 
> This fixes the issue by bailing on error (non-zero value) returned
> from pnv_pci_get_presence_state().
> 
> Fixes: 360aebd85a4 ("drivers/pci/hotplug: Support surprise hotplug in powernv driver")
> Cc: stable@vger.kernel.org #v4.9+
> Reported-by: Hank Chang <hankmax0000@gmail.com>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Tested-by: Willie Liauw <williel@supermicro.com.tw>
> ---
>  drivers/pci/hotplug/pnv_php.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
> index 56efaf7..38a2309 100644
> --- a/drivers/pci/hotplug/pnv_php.c
> +++ b/drivers/pci/hotplug/pnv_php.c
> @@ -707,8 +707,12 @@ static irqreturn_t pnv_php_interrupt(int irq, void *data)
>  		added = !!(lsts & PCI_EXP_LNKSTA_DLLLA);
>  	} else if (sts & PCI_EXP_SLTSTA_PDC) {
>  		ret = pnv_pci_get_presence_state(php_slot->id, &presence);
> -		if (!ret)
> +		if (ret) {
> +			dev_warn(&pdev->dev, "PCI slot [%s] error %d handling PDC event (0x%04x)\n",
> +				php_slot->name, ret, sts);

What can a user do with this warning?
