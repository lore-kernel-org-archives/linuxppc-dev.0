Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 4845DDE0EF
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 04:37:28 +1100 (EST)
Message-ID: <47EBDBAA.2020308@ru.mvista.com>
Date: Thu, 27 Mar 2008 20:38:50 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 15/18] ide: remove broken/dangerous HDIO_[UNREGISTER,
	SCAN]_HWIF ioctls
References: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
	<20080208004606.17746.90799.sendpatchset@localhost.localdomain>
In-Reply-To: <20080208004606.17746.90799.sendpatchset@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Bartlomiej Zolnierkiewicz wrote:

> hdparm explicitely marks HDIO_[UNREGISTER,SCAN]_HWIF ioctls as DANGEROUS
> and given the number of bugs we can assume that there are no real users:

> * DMA has no chance of working because DMA resources are released by
>   ide_unregister() and they are never allocated again.

> * Since ide_init_hwif_ports() is used for ->io_ports[] setup the ioctls
>   don't work for almost all hosts with "non-standard" (== non ISA-like)
>   layout of IDE taskfile registers (there is a lot of such host drivers).

> * ide_port_init_devices() is not called when probing IDE devices so:
>   - drive->autotune is never set and IDE host/devices are not programmed
>     for the correct PIO/DMA transfer modes (=> possible data corruption)
>   - host specific I/O 32-bit and IRQ unmasking settings are not applied
>     (=> possible data corruption)
>   - host specific ->port_init_devs method is not called (=> no luck with
>     ht6560b, qd65xx and opti621 host drivers)

> * ->rw_disk method is not preserved (=> no HPT3xxN chipsets support).

> * ->serialized flag is not preserved (=> possible data corruption when
>    using icside, aec62xx (ATP850UF chipset), cmd640, cs5530, hpt366
>    (HPT3xxN chipsets), rz1000, sc1200, dtc2278 and ht6560b host drivers).

> * ->ack_intr method is not preserved (=> needed by ide-cris, buddha,
>   gayle and macide host drivers).

> * ->sata_scr[] and sata_misc[] is cleared by ide_unregister() and it
>   isn't initialized again (SiI3112 support needs them).

> * To issue an ioctl() there need to be at least one IDE device present
>   in the system.

> * ->cable_detect method is not preserved + it is not called when probing
>   IDE devices so cable detection is broken (however since DMA support is
>   also broken it doesn't really matter ;-).

> * Some objects which may have already been freed in ide_unregister()
>   are restored by ide_hwif_restore() (i.e. ->hwgroup).

> * ide_register_hw() may unregister unrelated IDE ports if free ide_hwifs[]
>   slot cannot be found.

> * When IDE host drivers are modular unregistered port may be re-used by
>   different host driver that owned it first causing subtle bugs.

> Since we now have a proper warm-plug support remove these ioctls,
> then remove no longer needed:
> - ide_register_hw() and ide_hwif_restore() functions
> - 'init_default' and 'restore' arguments of ide_unregister()
> - zeroeing of hwif->{dma,extra}_* fields in ide_unregister()

> As an added bonus IDE core code size shrinks by ~3kB (x86-32).

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> Index: b/drivers/ide/ide-pnp.c
> ===================================================================
> --- a/drivers/ide/ide-pnp.c
> +++ b/drivers/ide/ide-pnp.c
[...]
> @@ -655,52 +530,6 @@ void ide_init_port_hw(ide_hwif_t *hwif, 
>  }
>  EXPORT_SYMBOL_GPL(ide_init_port_hw);
>  
> -/**
> - *	ide_register_hw		-	register IDE interface
> - *	@hw: hardware registers
> - *	@quirkproc: quirkproc function
> - *	@hwifp: pointer to returned hwif
> - *
> - *	Register an IDE interface, specifying exactly the registers etc.
> - *
> - *	Returns -1 on error.
> - */
> -
> -static int ide_register_hw(hw_regs_t *hw, void (*quirkproc)(ide_drive_t *),
> -			   ide_hwif_t **hwifp)
> -{
> -	int index, retry = 1;
> -	ide_hwif_t *hwif;
> -	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
> -
> -	do {
> -		hwif = ide_find_port(hw->io_ports[IDE_DATA_OFFSET]);
> -		index = hwif->index;
> -		if (hwif)
> -			goto found;

    Hm, I remember there was a patch that fixed the above bug where hwif is 
dereferenced before being checked for NULL, I wonder how come it was lost?

WBR, Sergei
