Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 07203DE462
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 05:29:04 +1000 (EST)
Message-ID: <4831D527.2020907@freescale.com>
Date: Mon, 19 May 2008 14:29:43 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Rune Torgersen <runet@innovsys.com>
Subject: Re: Oops with PREEMPT-RT on 2.6.25.4
References: <DCEAAC0833DD314AB0B58112AD99B93B0469010C@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B0469010C@ismail.innsys.innovsys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rune Torgersen wrote:
> Hi 
> I get the following oops when trying to boot a arch/powerpc kernel with
> preempt-rt installed (v2.6.25.4-rt1)
> The board is using a Freescale 8280 as the main CPU and a Silicon Image
> SII3124 SATA controller. The oops seems to happen on fileaccess right
> after init starts.
[snip]
> NIP [c0249618] rt_spin_lock_slowlock+0x9c/0x200
> LR [c02495ec] rt_spin_lock_slowlock+0x70/0x200
> Call Trace:
> [ef29d600] [c02495ec] rt_spin_lock_slowlock+0x70/0x200 (unreliable)
> [ef29d670] [c00277d0] lock_timer_base+0x2c/0x64
> [ef29d690] [c00285e8] del_timer+0x2c/0x78
> [ef29d6b0] [c019d108] scsi_delete_timer+0x1c/0x3c
> [ef29d6d0] [c01992d0] scsi_done+0x18/0x4c
> [ef29d6f0] [c01b19dc] ata_scsi_qc_complete+0x364/0x380
> [ef29d720] [c01a8708] __ata_qc_complete+0xd8/0xec
> [ef29d740] [c01b011c] ata_qc_complete_multiple+0xc4/0xec
> [ef29d760] [c01bcaf4] sil24_interrupt+0x46c/0x52c
> [ef29d7a0] [c0048954] handle_IRQ_event+0x64/0x100
> [ef29d7d0] [c0048b30] __do_IRQ+0x140/0x1bc
> [ef29d7f0] [c00166c4] apmax_int_irq_demux+0x8c/0xb0
> [ef29d810] [c0006448] do_IRQ+0x68/0xa8
> [ef29d820] [c0010388] ret_from_except+0x0/0x14
> --- Exception: 501 at __spin_unlock_irqrestore+0x28/0x4c
>     LR = __spin_unlock_irqrestore+0x20/0x4c
> [ef29d8f0] [c0249600] rt_spin_lock_slowlock+0x84/0x200
> [ef29d960] [c00277d0] lock_timer_base+0x2c/0x64

You're recursively entering lock_timer_base, which does a 
spin_lock_irqsave().  Either interrupts are enabled when they should not 
be, or an interrupt was supposed to be threaded that isn't.

-Scott
