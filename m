Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x22a.google.com (mail-pa0-x22a.google.com
 [IPv6:2607:f8b0:400e:c03::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpzRx03SlzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 18:57:47 +1000 (AEST)
Received: by mail-pa0-x22a.google.com with SMTP id zm5so4753148pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 01:57:46 -0700 (PDT)
Subject: Re: [PATCH v8 34/45] powerpc/powernv: Exclude root bus in
 pnv_pci_reset_secondary_bus()
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-35-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dja@axtens.net,
 bhelgaas@google.com, robherring2@gmail.com, grant.likely@linaro.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <5715F301.6030902@ozlabs.ru>
Date: Tue, 19 Apr 2016 18:57:37 +1000
MIME-Version: 1.0
In-Reply-To: <1455680668-23298-35-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/17/2016 02:44 PM, Gavin Shan wrote:
> The function pnv_pci_reset_secondary_bus() is called like below.
> It's impossible for call the function on root bus. So it's safe
> to remove the root bus case in the function. No functional changes
> introduced.
>
>     pci_parent_bus_reset() / pci_bus_reset() / pci_try_reset_bus()
>     pci_reset_bridge_secondary_bus()
>     pcibios_reset_secondary_bus()
>     pnv_pci_reset_secondary_bus()
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Reviewed-by: Daniel Axtens <dja@axtens.net>



Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>


> ---
>   arch/powerpc/platforms/powernv/eeh-powernv.c | 12 ++----------
>   1 file changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
> index 9226df1..593b8dc 100644
> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
> @@ -868,16 +868,8 @@ static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
>
>   void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
>   {
> -	struct pci_controller *hose;
> -
> -	if (pci_is_root_bus(dev->bus)) {
> -		hose = pci_bus_to_host(dev->bus);
> -		pnv_eeh_root_reset(hose, EEH_RESET_HOT);
> -		pnv_eeh_root_reset(hose, EEH_RESET_DEACTIVATE);
> -	} else {
> -		pnv_eeh_bridge_reset(dev, EEH_RESET_HOT);
> -		pnv_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE);
> -	}
> +	pnv_eeh_bridge_reset(dev, EEH_RESET_HOT);
> +	pnv_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE);
>   }
>
>   static void pnv_eeh_wait_for_pending(struct pci_dn *pdn, const char *type,
>


-- 
Alexey
