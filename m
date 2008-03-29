Return-Path: <bzolnier@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id A61FBDDE1D
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Mar 2008 02:55:48 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so134964uge.0
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 08:55:46 -0700 (PDT)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 15/18] ide: remove broken/dangerous HDIO_[UNREGISTER,
	SCAN]_HWIF ioctls
Date: Sat, 29 Mar 2008 17:03:24 +0100
References: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
	<20080208004606.17746.90799.sendpatchset@localhost.localdomain>
	<47EBDBAA.2020308@ru.mvista.com>
In-Reply-To: <47EBDBAA.2020308@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200803291703.25050.bzolnier@gmail.com>
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

On Thursday 27 March 2008, Sergei Shtylyov wrote:

[...]

> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Thanks for reviewing it.

> > Index: b/drivers/ide/ide-pnp.c
> > ===================================================================
> > --- a/drivers/ide/ide-pnp.c
> > +++ b/drivers/ide/ide-pnp.c
> [...]
> > @@ -655,52 +530,6 @@ void ide_init_port_hw(ide_hwif_t *hwif, 
> >  }
> >  EXPORT_SYMBOL_GPL(ide_init_port_hw);
> >  
> > -/**
> > - *	ide_register_hw		-	register IDE interface
> > - *	@hw: hardware registers
> > - *	@quirkproc: quirkproc function
> > - *	@hwifp: pointer to returned hwif
> > - *
> > - *	Register an IDE interface, specifying exactly the registers etc.
> > - *
> > - *	Returns -1 on error.
> > - */
> > -
> > -static int ide_register_hw(hw_regs_t *hw, void (*quirkproc)(ide_drive_t *),
> > -			   ide_hwif_t **hwifp)
> > -{
> > -	int index, retry = 1;
> > -	ide_hwif_t *hwif;
> > -	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
> > -
> > -	do {
> > -		hwif = ide_find_port(hw->io_ports[IDE_DATA_OFFSET]);
> > -		index = hwif->index;
> > -		if (hwif)
> > -			goto found;
> 
>     Hm, I remember there was a patch that fixed the above bug where hwif is 
> dereferenced before being checked for NULL, I wonder how come it was lost?

It has been already merged into Linus' tree
(commit 0c6025d44448bd688dfd351a09bc620aafa4d1ff).

Thanks,
Bart
