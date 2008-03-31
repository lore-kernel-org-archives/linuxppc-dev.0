Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E5B35DE6C6
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 05:10:52 +1000 (EST)
Message-ID: <47F13735.40207@freescale.com>
Date: Mon, 31 Mar 2008 14:10:45 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCHv3 2/4] cpm-serial: Relocate CPM buffer descriptors and
	SMC parameter ram.
References: <200803311834.42327.laurentp@cse-semaphore.com>
	<200803311836.08142.laurentp@cse-semaphore.com>
In-Reply-To: <200803311836.08142.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Laurent Pinchart wrote:
> This patch relocates the buffer descriptors and the SMC parameter RAM at the
> end of the first CPM muram chunk, as described in the device tree. This allows
> device trees to stop excluding SMC parameter ram allocated by the boot loader
> from the CPM muram node.

It's usually a good idea to state that something is untested if that's 
the case. :-)

This patch cannot work as is.

> +static int cpm_get_virtual_address(void *devp, void **addr, int ncells)
> +{
> +	unsigned long xaddr;
> +	int n;
> +
> +	n = getprop(devp, "virtual-reg", addr, ncells * sizeof *addr);
> +	if (n < ncells * sizeof *addr) {

You must cast the sizeof to a signed int; otherwise, a negative return 
from getprop will be "bigger" than the unsigned size, and you'll return 
garbage as the address.

> +		for (n = 0; n < ncells; n++) {
> +			if (!dt_xlate_reg(devp, n, &xaddr, NULL))
> +				return -1;
> +
> +			addr[n] = (void*)xaddr;

(void *)

> +		}
> +	}
> +
> +	return ncells;
> +}

This could be a generic bootwrapper function.  It should return the 
number of resources (ncells is a misnomer) actually found, though, 
rather than failing if there are fewer than asked for.  Let the caller 
decide if it's fatal.

> @@ -202,63 +243,62 @@ int cpm_console_init(void *devp, struct serial_console_data *scdp)
>  	else
>  		do_cmd = cpm1_cmd;
>  
> -	n = getprop(devp, "fsl,cpm-command", &cpm_cmd, 4);
> -	if (n < 4)
> +	if (getprop(devp, "fsl,cpm-command", &cpm_cmd, 4) < sizeof cpm_cmd)
>  		return -1;

Standard kernel style is sizeof(foo), not sizeof foo.

Plus, if you're going to replace 4 with sizeof(cpm_cmd), do it both 
places.  I don't really see the need, though; a cell is always 4 bytes.

> -	n = getprop(parent, "virtual-reg", reg_virt, sizeof(reg_virt));
> -	if (n < (int)sizeof(reg_virt)) {
> -		if (!dt_xlate_reg(parent, 0, &reg_phys, NULL))
> -			return -1;
> -
> -		reg_virt[0] = (void *)reg_phys;
> -	}
> -
> -	cpcr = reg_virt[0];
> +	if (cpm_get_virtual_address(devp, &cpcr, 1) < 0)
> +		return -1;

s/devp/parent/

>  	muram = finddevice("/soc/cpm/muram/data");
>  	if (!muram)
>  		return -1;
>  
>  	/* For bootwrapper-compatible device trees, we assume that the first
> -	 * entry has at least 18 bytes, and that #address-cells/#data-cells
> +	 * entry has at least 128 bytes, and that #address-cells/#data-cells
>  	 * is one for both parent and child.
>  	 */
>  
> -	n = getprop(muram, "virtual-reg", reg_virt, sizeof(reg_virt));
> -	if (n < (int)sizeof(reg_virt)) {
> -		if (!dt_xlate_reg(muram, 0, &reg_phys, NULL))
> -			return -1;
> +	if (cpm_get_virtual_address(devp, &muram_addr, 1) < 0)
> +		return -1;

s/devp/muram/

> +	
> +	if (getprop(muram, "reg", reg, sizeof reg) < sizeof reg)
> +		return -1;

Should read into array of u32, not void *.

> +	if (is_cpm2 && is_smc) {
> +		u16 *smc_base = (u16*)param;

(u16 *)

> +		u16 pram_offset;
>  
> -	muram_start = reg_virt[0];
> +		pram_offset = cbd_offset - 64;
> +		pram_offset = _ALIGN_DOWN(pram_offset, 64);
> +		*smc_base = pram_offset;

Use out_be16().

The SMC should be stopped before you do this.

-Scott
