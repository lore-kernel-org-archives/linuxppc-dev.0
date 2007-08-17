Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id A4C74DDE33
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Aug 2007 00:33:00 +1000 (EST)
Date: Fri, 17 Aug 2007 16:33:11 +0200
From: Olaf Hering <olaf@aepfle.de>
To: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH] advertise correct IDE mode on Pegasos2
Message-ID: <20070817143311.GA32390@aepfle.de>
References: <20070404111635.GA1855@aepfle.de>
	<20070817131048.GA31192@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20070817131048.GA31192@aepfle.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 17, Olaf Hering wrote:

Still not 100% perfect.

> +		prom_printf("Fixing up IDE class-code on Pegasos...\n");
> +		rc = prom_getprop(ph, "class-code", prop, sizeof(u32));
> +		if (rc == sizeof(u32)) {
> +			prop[0] &= ~0x5;
> +			prom_setprop(ph, name, "class-code", prop, sizeof(u32));
> +		}

This updates the class code in the device-tree, but sysfs still shows
the old value.

> +	pci_read_config_byte(viaide, PCI_CLASS_PROG, &progif);
> +	pci_write_config_byte(viaide, PCI_CLASS_PROG, progif & ~0x5);

Is this a readonly register by any chance?
Appending a 'viaide->class &= ~0x5;' changes the code paths in
do_ide_setup_pci_device(), now IDE prints 'not 100%% native mode,
will probe irqs later'. Where are the irqs supposed to come from?

> -#ifdef CONFIG_PPC_CHRP
> -	if(machine_is(chrp) && _chrp_type == _CHRP_Pegasos) {
> -		hwif->irq = hwif->channel ? 15 : 14;
> -	}
> -#endif

Maybe we should just leave this in and dont bother about the arch
specific tweak?
