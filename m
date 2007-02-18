Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id CAAF0DDE23
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Feb 2007 01:19:58 +1100 (EST)
Date: Sun, 18 Feb 2007 08:29:26 -0600
To: Andy Fleming <afleming@freescale.com>
Subject: Re: [RFC 5/7] Unite all PCI-e on 85xx and 86xx under one codebase
Message-ID: <20070218142926.GA29002@lixom.net>
References: <Pine.LNX.4.61.0702152045190.9034@ld0175-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.61.0702152045190.9034@ld0175-tx32.am.freescale.net>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 15, 2007 at 08:46:03PM -0600, Andy Fleming wrote:
>  	if (devfn != 0x0 && bus->number == 0xff)
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  
> +	PCI_CFG_OUT(hose->cfg_addr, 0x80000000 | 0x4 << 24
> +		| (0 << 16) | (0x4 & 0xfc));
> +	link_training_stat = in_le32(hose->cfg_data);
> +	if ((link_training_stat & 0x5f) < 0x16)  /* Training failure */
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +

Huh? (0x4 & 0xfc) doesn't make much sense, neither does 0 << 16. Can't
you just hardcode the full hex value there, if you're not going to
use symbolic constants, there's not much use in or:ing stuff together
anyway. I.e. 0x84000004


[...]
> @@ -97,8 +105,14 @@ indirect_write_config_pcie(struct pci_bu
>  	if (devfn != 0x0 && bus->number == 0xff)
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  
> +	PCI_CFG_OUT(hose->cfg_addr, 0x80000000 | 0x4 << 24
> +		| (0 << 16) | (0x4 & 0xfc));
> +	link_training_stat = in_le32(hose->cfg_data);
> +	if ((link_training_stat & 0x5f) < 0x16)  /* Training failure */
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +

Same here.


-Olof
