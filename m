Return-Path: <miltonm@bga.com>
Received: from kcout01.prserv.net (kcout01.prserv.net [12.154.55.31])
	by ozlabs.org (Postfix) with ESMTP id 13D61DDE2E
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 15:55:55 +1000 (EST)
In-Reply-To: <1180720142.14219.68.camel@ld0161-tx32>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <bfe9571d7d435aa6f52ae8d9ec61a1d5@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 8/8] Wrote quirk_mpc8641_transparent() to initialize
	bridge resources.
Date: Mon, 4 Jun 2007 00:55:47 -0500
To: Jon Loeliger <jdl@freescale.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> The 8641 RC poses as a transparent bridge, but does not implement the
> IO_BASE or IO_LIMIT registers in the config space.  This means that
> the code which initializes the bridge resources ends up setting the
> IO resources erroneously.
>
> This change sets RC of mpc8641 to be a transparent bridge
> for legacy I/O access and initializes the RC bridge resources
> from the device tree.
>
> Note: The 0x7010 is the device ID of host bridge for MPC8641
>       and 0x7011 is the device ID of host bridge fro MPC8641D.
>
...
>
> @@ -339,6 +403,8 @@ static void __devinit early_uli5249(struct pci_dev 
> *dev)
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x1575, quirk_uli1575);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5288, quirk_uli5288);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5229, quirk_uli5229);
> +DECLARE_PCI_FIXUP_EARLY(0x1957, 0x7010, quirk_mpc8641_transparent);
> +DECLARE_PCI_FIXUP_EARLY(0x1957, 0x7011, quirk_mpc8641_transparent);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AL, 0x5249, early_uli5249);
>  #endif /* CONFIG_PCI */

This is totally unreadable.  include/linux/pci_ids.h exists for a 
reason,
please use it.   At least the vendor should be in there.

If you want to define the device id with the same naming convention
but in the local source file, I won't object.


Looking back at the rest of the patch:
>
> +#define GET_64BIT(prop, i)     ((((u64) (prop)[(i)]) << 32) | 
> (prop)[(i)+1])

Please use the (new) helper of_read_number in prom.h.


milton

PS: how about create instead of wrote in the subject?
