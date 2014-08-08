Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 474481A0A4E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Aug 2014 13:55:23 +1000 (EST)
Message-ID: <1407469812.4508.1.camel@pasglop>
Subject: Re: [PATCH v4 2/5] powerpc/eeh: Add warning message in eeh_dev_open()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Date: Fri, 08 Aug 2014 13:50:12 +1000
In-Reply-To: <1407379640-13065-3-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1407379640-13065-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1407379640-13065-3-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@ozlabs.ru, alex.williamson@redhat.com, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-08-07 at 12:47 +1000, Gavin Shan wrote:
> The patch adds one warning message in eeh_dev_open() in case the
> PCI device can't be marked as passed through.
> 
> Suggested-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Alex, are you taking this or should I ?

>  arch/powerpc/kernel/eeh.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> index 59a64f8..5d73a49 100644
> --- a/arch/powerpc/kernel/eeh.c
> +++ b/arch/powerpc/kernel/eeh.c
> @@ -1162,8 +1162,11 @@ int eeh_dev_open(struct pci_dev *pdev)
>  
>  	/* No EEH device or PE ? */
>  	edev = pci_dev_to_eeh_dev(pdev);
> -	if (!edev || !edev->pe)
> +	if (!edev || !edev->pe) {
> +		pr_warn_once("%s: PCI device %s not supported\n",
> +			     __func__, pci_name(pdev));
>  		goto out;
> +	}
>  
>  	/* Increase PE's pass through count */
>  	atomic_inc(&edev->pe->pass_dev_cnt);
