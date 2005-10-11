Return-Path: <tnt@246tNt.com>
Received: from outmx016.isp.belgacom.be (outmx016.isp.belgacom.be
	[195.238.2.115])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8FC7A683CF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Oct 2005 09:18:23 +1000 (EST)
Received: from outmx016.isp.belgacom.be (localhost [127.0.0.1])
	by outmx016.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j9BNIFAt026855
	for <linuxppc-embedded@ozlabs.org>; Wed, 12 Oct 2005 01:18:16 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <434C4919.7030007@246tNt.com>
Date: Wed, 12 Oct 2005 01:22:01 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
References: <20051010193700.67266353ADC@atlas.denx.de>
In-Reply-To: <20051010193700.67266353ADC@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] MPC5200 - Make PCI work in 2.6 with the IceCube 5200
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Wolfgang,


Weird, I would have thought the usage of in_be out_be macro ensured
that. But after checking, they only include a isync instruction which
doesn't guarantee memory access will be done while mb() uses sync that
does guarantee that.

Any one can comment on that ? Wasn't the purpose of the in_be out_be to
ensure that ?



	Sylvain



Wolfgang Denk wrote:
> Hello,
> 
> the following patch is against the current 2.6 kernel.org tree
> (commit f96c3bbe91117402f13119ce9e609db9087ed58f):
> 
> As a prerequisite for a working system, the  following  two  poatches
> are needed, too:
> 
> http://patchwork.ozlabs.org/linuxppc/patch?id=2018
> http://patchwork.ozlabs.org/linuxppc/patch?id=2017
> 
> 
> !-------------------------------------------------------------flip-
> 
> [patch] making PCI work in the MPC5200
> Patch by Alessandro Rubini, 08 Oct 2005
> 
> Make PCI work in 2.6 with the IceCube 5200.
> 
> Without the memory barriers all PCI config reads returned 0xffffffff
> (actually, there may be more mb() than needed). Using wmb(); was not
> enough to be able to read configuration registers.
> 
> Signed-off by Alessandro Rubini <rubini@gnudd.com>
> Signed-off by Wolfgang Denk <wd@denx.de>
> 
> ---
> commit cdd7fdf10b3cbb7eb82cacc7ba5dba3553020f49
> tree 97d045b44c87c00a4b3fe5bca57b479be87e68b6
> parent 509b5c9fcbfe7fcae7d4f98946e4dc9794d68645
> author Wolfgang Denk <wd@pollux.denx.de> Sat, 08 Oct 2005 22:41:53 +0200
> committer Wolfgang Denk <wd@pollux.denx.de> Sat, 08 Oct 2005 22:41:53 +0200
> 
>  arch/ppc/syslib/mpc52xx_pci.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/ppc/syslib/mpc52xx_pci.c b/arch/ppc/syslib/mpc52xx_pci.c
> --- a/arch/ppc/syslib/mpc52xx_pci.c
> +++ b/arch/ppc/syslib/mpc52xx_pci.c
> @@ -39,6 +39,7 @@ mpc52xx_pci_read_config(struct pci_bus *
>  		((bus->number - hose->bus_offset) << 16) |
>  		(devfn << 8) |
>  		(offset & 0xfc));
> +	mb();
>  
>  	value = in_le32(hose->cfg_data);
>  
> @@ -70,6 +71,7 @@ mpc52xx_pci_write_config(struct pci_bus 
>  		((bus->number - hose->bus_offset) << 16) |
>  		(devfn << 8) |
>  		(offset & 0xfc));
> +	mb();
>  
>  	if (len != 4) {
>  		value = in_le32(hose->cfg_data);
> @@ -80,9 +82,11 @@ mpc52xx_pci_write_config(struct pci_bus 
>  
>  		value &= ~mask;
>  		val = value | ((val << offset) & mask);
> +		mb();
>  	}
>  
>  	out_le32(hose->cfg_data, val);
> +	mb();
>  
>  	out_be32(hose->cfg_addr, 0);
>  
> 
> 
> 
> !-------------------------------------------------------------flip-
> 
> 
> 
> Best regards,
> 
> Wolfgang Denk
> 
