Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id A1C75DE2F7
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 09:04:36 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org,
 benh@kernel.crashing.org
Subject: Re: lockdep badness
Date: Fri, 25 Jul 2008 01:04:29 +0200
References: <20080724192300.GE9594@localdomain>
	<1216939496.11188.58.camel@pasglop>
In-Reply-To: <1216939496.11188.58.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807250104.29968.arnd@arndb.de>
Cc: Brian King <brking@linux.vnet.ibm.com>, Nathan Lynch <ntl@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 25 July 2008, Benjamin Herrenschmidt wrote:
> > Call Trace:
> > [c00000000fffbb10] [c00000000fffbbb0] 0xc00000000fffbbb0 (unreliable)
> > [c00000000fffbbb0] [c0000000005d8824] ._spin_unlock_irq+0x40/0x68
> > [c00000000fffbc40] [c000000000426708] .ipr_ioa_reset_done+0x218/0x2ac
> > [c00000000fffbd00] [c00000000041bdb8] .ipr_reset_ioa_job+0xc8/0xf4
> > [c00000000fffbd90] [c000000000424ffc] .ipr_isr+0x280/0x628
> > [c00000000fffbe50] [c0000000000ccc70] .handle_IRQ_event+0x58/0xd4
> > [c00000000fffbef0] [c0000000000cef4c] .handle_fasteoi_irq+0x128/0x1c8
> > [c00000000fffbf90] [c000000000029918] .call_handle_irq+0x1c/0x2c
> > [c000000000a63a20] [c00000000000d9cc] .do_IRQ+0x138/0x248
> > [c000000000a63ad0] [c000000000004ca8] hardware_interrupt_entry+0x28/0x2c
> > --- Exception: 501 at .raw_local_irq_restore+0x8c/0xa4
> > =A0 =A0 LR =3D .cpu_idle+0x140/0x210
> > [c000000000a63e60] [c0000000005da07c] .rest_init+0x7c/0x98
> > [c000000000a63ee0] [c000000000866f10] .start_kernel+0x488/0x4b0
> > [c000000000a63f90] [c000000000008584] .start_here_common+0x4c/0xc8
> > Instruction dump:
>=20
> This one is new to me. I will have a look. What machine is this ?
>=20
> I suspect the error is to do spin_lock/unlock_irq rather than
> save/restore variants at IRQ time, which would be an IPR bug... or
> rather something legal that Ingo decided shouldn't be anymore :-)

Almost: The ipr_ioa_reset_done function does

	spin_unlock_irq(ioa_cfg->host->host_lock);
	scsi_unblock_requests(ioa_cfg->host);
	spin_lock_irq(ioa_cfg->host->host_lock);

It seem that it is always called with interrupts disabled and
ioa_cfg->host->host_lock held (otherwise we would get a different
warning), so to get rid of the lockdep warning, it should be
replaced with

	spin_unlock(ioa_cfg->host->host_lock);
	scsi_unblock_requests(ioa_cfg->host);
	spin_lock(ioa_cfg->host->host_lock);

I.e. leave the interrupts off, but still give up the lock. It
still feels wrong to do this, but I don't understand much about
the driver either.

	Arnd <><
