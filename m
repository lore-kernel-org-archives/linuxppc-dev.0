Return-Path: <will.deacon@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 46A121A0259
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2015 02:45:17 +1000 (AEST)
Date: Fri, 14 Aug 2015 17:45:12 +0100
From: Will Deacon <will.deacon@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 "grant.likely@linaro.org" <grant.likely@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, "agraf@suse.de" <agraf@suse.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] PCI: pci-host-generic: Fix lookup of
 linux,pci-probe-only property
Message-ID: <20150814164512.GD22809@arm.com>
References: <1439569159-10051-1-git-send-email-marc.zyngier@arm.com>
 <1439569159-10051-3-git-send-email-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1439569159-10051-3-git-send-email-marc.zyngier@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 14, 2015 at 05:19:17PM +0100, Marc Zyngier wrote:
> When pci-host-generic looks for the probe-only property, it seems
> to trust the DT to be correctly written, and assumes that there
> is a parameter to the property.
> 
> Unfortunately, this is not always the case, and some firmware expose
> this property naked. The driver ends up making a decision based on
> whatever the property pointer points to, which is likely to be junk.
> 
> Switch to the common of_pci.c implementation that doesn't suffer
> from this problem.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/pci/host/pci-host-generic.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
> index 265dd25..545ff4e 100644
> --- a/drivers/pci/host/pci-host-generic.c
> +++ b/drivers/pci/host/pci-host-generic.c
> @@ -210,7 +210,6 @@ static int gen_pci_probe(struct platform_device *pdev)
>  	int err;
>  	const char *type;
>  	const struct of_device_id *of_id;
> -	const int *prop;
>  	struct device *dev = &pdev->dev;
>  	struct device_node *np = dev->of_node;
>  	struct gen_pci *pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
> @@ -225,13 +224,7 @@ static int gen_pci_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	prop = of_get_property(of_chosen, "linux,pci-probe-only", NULL);
> -	if (prop) {
> -		if (*prop)
> -			pci_add_flags(PCI_PROBE_ONLY);
> -		else
> -			pci_clear_flags(PCI_PROBE_ONLY);
> -	}
> +	of_pci_check_probe_only(of_chosen);

You could probably just make this take void, as the probe-only property
is always in the /chosen node.

Either way:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
