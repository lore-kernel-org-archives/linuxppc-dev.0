Return-Path: <aik@ozlabs.ru>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z0Rpq4SjSzDr23
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 14:48:50 +1100 (AEDT)
Received: by mail-pl0-x244.google.com with SMTP id 1so2616468plv.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Dec 2017 19:48:50 -0800 (PST)
Subject: Re: [PATCH v1 1/7] platform/pseries: Update VF config space after EEH
To: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: seroyer@linux.vnet.ibm.com, jjalvare@linux.vnet.ibm.com,
 alex.williamson@redhat.com, helgaas@kernel.org, ruscur@russell.cc,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 bodong@mellanox.com, eli@mellanox.com, saeedm@mellanox.com
References: <20171213153242.98015-1-bryantly@linux.vnet.ibm.com>
 <20171213153242.98015-2-bryantly@linux.vnet.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <bc7caa8a-f13b-b3e8-36ee-191a7d541425@ozlabs.ru>
Date: Mon, 18 Dec 2017 14:48:41 +1100
MIME-Version: 1.0
In-Reply-To: <20171213153242.98015-2-bryantly@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 14/12/17 02:32, Bryant G. Ly wrote:
> Add EEH platform operations for pseries to update VF
> config space. With this change after EEH, the VF
> will have updated config space for pseries platform.
> 
> Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
> Signed-off-by: Juan J. Alvarez <jjalvare@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/eeh_pseries.c | 85 +++++++++++++++++++++++++++-
>  1 file changed, 84 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
> index 2295f117e2d3..1a9a6fa91151 100644
> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
> @@ -708,6 +708,89 @@ static int pseries_eeh_write_config(struct pci_dn *pdn, int where, int size, u32
>  	return rtas_write_config(pdn, where, size, val);
>  }
>  
> +static int pseries_eeh_restore_vf_config(struct pci_dn *pdn)


This particular function is just a copy of its powernv counterpart -
pnv_eeh_restore_vf_config(), it could go to arch/powerpc/kernel/eeh.c, for
example. Or I am missing something here?




> +{
> +	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
> +	u32 devctl, cmd, cap2, aer_capctl;
> +	int old_mps;
> +
> +	if (edev->pcie_cap) {
> +		/* Restore MPS */
> +		old_mps = (ffs(pdn->mps) - 8) << 5;
> +		eeh_ops->read_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL,
> +				     2, &devctl);
> +		devctl &= ~PCI_EXP_DEVCTL_PAYLOAD;
> +		devctl |= old_mps;
> +		eeh_ops->write_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL,
> +				      2, devctl);
> +
> +		/* Disable Completion Timeout */
> +		eeh_ops->read_config(pdn, edev->pcie_cap + PCI_EXP_DEVCAP2,
> +				     4, &cap2);
> +		if (cap2 & 0x10) {
> +			eeh_ops->read_config(pdn,
> +					     edev->pcie_cap + PCI_EXP_DEVCTL2,
> +					     4, &cap2);
> +			cap2 |= 0x10;
> +			eeh_ops->write_config(pdn,
> +					      edev->pcie_cap + PCI_EXP_DEVCTL2,
> +					      4, cap2);
> +		}
> +	}
> +
> +	/* Enable SERR and parity checking */
> +	eeh_ops->read_config(pdn, PCI_COMMAND, 2, &cmd);
> +	cmd |= (PCI_COMMAND_PARITY | PCI_COMMAND_SERR);
> +	eeh_ops->write_config(pdn, PCI_COMMAND, 2, cmd);
> +
> +	/* Enable report various errors */
> +	if (edev->pcie_cap) {
> +		eeh_ops->read_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL,
> +				     2, &devctl);
> +		devctl &= ~PCI_EXP_DEVCTL_CERE;
> +		devctl |= (PCI_EXP_DEVCTL_NFERE |
> +			   PCI_EXP_DEVCTL_FERE |
> +			   PCI_EXP_DEVCTL_URRE);
> +		eeh_ops->write_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL,
> +				      2, devctl);
> +	}
> +
> +	/* Enable ECRC generation and check */
> +	if (edev->pcie_cap && edev->aer_cap) {
> +		eeh_ops->read_config(pdn, edev->aer_cap + PCI_ERR_CAP,
> +				     4, &aer_capctl);
> +		aer_capctl |= (PCI_ERR_CAP_ECRC_GENE | PCI_ERR_CAP_ECRC_CHKE);
> +		eeh_ops->write_config(pdn, edev->aer_cap + PCI_ERR_CAP,
> +				      4, aer_capctl);
> +	}
> +
> +	return 0;
> +}
> +
> +static int pseries_eeh_restore_config(struct pci_dn *pdn)
> +{
> +	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
> +	s64 ret;
> +
> +	if (!edev)
> +		return -EEXIST;
> +
> +	/*
> +	 * FIXME: The MPS, error routing rules, timeout setting are worthy
> +	 * to be exported by firmware in extendible way.
> +	 */
> +	if (edev->physfn)
> +		ret = pseries_eeh_restore_vf_config(pdn);
> +
> +	if (ret) {
> +		pr_warn("%s: Can't reinit PCI dev 0x%x (%lld)\n",
> +			__func__, edev->pe_config_addr, ret);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
>  static struct eeh_ops pseries_eeh_ops = {
>  	.name			= "pseries",
>  	.init			= pseries_eeh_init,
> @@ -723,7 +806,7 @@ static struct eeh_ops pseries_eeh_ops = {
>  	.read_config		= pseries_eeh_read_config,
>  	.write_config		= pseries_eeh_write_config,
>  	.next_error		= NULL,
> -	.restore_config		= NULL
> +	.restore_config		= pseries_eeh_restore_config
>  };
>  
>  /**
> 


-- 
Alexey
