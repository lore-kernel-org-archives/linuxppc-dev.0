Return-Path: <geert@linux-m68k.org>
Received: from witte.sonytel.be (witte.sonytel.be [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 67C50685DE
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Oct 2005 18:23:48 +1000 (EST)
Date: Sun, 23 Oct 2005 10:23:32 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@sonycom.com
To: Olaf Hering <olh@suse.de>
In-Reply-To: <20051022213037.GA6097@suse.de>
Message-ID: <Pine.LNX.4.62.0510231021070.16077@numbat.sonytel.be>
References: <20051022213037.GA6097@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@osdl.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] hide pmac specific drivers if CONFIG_ADB is not set
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 22 Oct 2005, Olaf Hering wrote:
> SCSI_MESH exists on old Macs, but the PB Lombard has an external connector

And on some CHRP.

> --- linux-2.6.14-rc5.orig/drivers/scsi/Kconfig
> +++ linux-2.6.14-rc5/drivers/scsi/Kconfig
> @@ -1529,7 +1529,7 @@ config SCSI_DEBUG
>  
>  config SCSI_MESH
>  	tristate "MESH (Power Mac internal SCSI) support"
> -	depends on PPC32 && PPC_PMAC && SCSI
> +	depends on PPC32 && PPC_PMAC && SCSI && (ADB_CUDA || ADB_PMU)
>  	help
>  	  Many Power Macintoshes and clones have a MESH (Macintosh Enhanced
>  	  SCSI Hardware) SCSI bus adaptor (the 7200 doesn't, but all of the

You can no longer enable MESH when compiling for CHRP or when disabling ADB?

It's clearly visible my LongTrail died last year... :-(

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
