Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 313E5DDE3A
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 03:59:54 +1000 (EST)
Subject: Re: [PATCH 3/5] Float the pci bus number on MPC8641HPCN board.
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: Zhang Wei <wei.zhang@freescale.com>
In-Reply-To: <1179805110278-git-send-email-wei.zhang@freescale.com>
References: <11798051102658-git-send-email-wei.zhang@freescale.com>
	<11798051101543-git-send-email-wei.zhang@freescale.com>
	<1179805110272-git-send-email-wei.zhang@freescale.com>
	<1179805110278-git-send-email-wei.zhang@freescale.com>
Content-Type: text/plain
Date: Tue, 22 May 2007 10:59:52 -0700
Message-Id: <1179856792.27985.22.camel@rhino>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-05-22 at 11:38 +0800, Zhang Wei wrote:
>  int mpc86xx_exclude_device(u_char bus, u_char devfn)
>  {
> +	struct pci_controller *hose;
> +
> +	hose = pci_bus_to_hose(bus);
> +	if (unlikely(!hose))
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +	/* Correcting the hose->bus_offset value. */
> +	out_be32(hose->cfg_addr, 0x80000000 | ((hose->first_busno
> +					- hose->bus_offset) << 16));
> +	if (unlikely(in_le32(hose->cfg_data) == 0xffffffff))
> +		hose->bus_offset = hose->bus_offset ? 0 : hose->first_busno;
> +
>  	return PCIBIOS_SUCCESSFUL;
>  }

What is the purpose of this code and why put it in
mpc86xx_exclude_device?

--Wade
