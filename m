Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2895ADDF29
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 01:31:32 +1000 (EST)
Subject: Re: [RFC] 85XX: Allow 8259 cascade to share an MPIC interrupt line.
From: Jon Loeliger <jdl@freescale.com>
To: Randy Vinson <rvinson@mvista.com>
In-Reply-To: <466755AC.40201@mvista.com>
References: <466755AC.40201@mvista.com>
Content-Type: text/plain
Message-Id: <1181230255.31686.3.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Thu, 07 Jun 2007 10:30:55 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-06-06 at 19:47, Randy Vinson wrote:
> The Freescale MPC8555CDS and MPC8548CDS reference hardware has a legacy
> 8259 interrupt controller pair contained within a VIA VT82C686B Southbridge
> on the main carrier board. The processor complex plugs into the carrier
> card using a PCI slot which limits the available interrupts to the
> INTA-INTD PCI interrupts. The output of the 8259 cascade pair is routed
> through a gate array and connected to the PCI INTA interrupt line.
> The normal interrupt chaining hook (set_irq_chained_handler) does
> not allow sharing of the chained interrupt which prevents the
> use of PCI INTA by PCI devices. This patch allows the 8259 cascade
> pair to share their interrupt line with PCI devices.
> 
> Signed-off-by: Randy Vinson <rvinson@mvista.com>
> ---
> Note that there may very well be a better way of accomplishing this. If someone
> has a better alternative, I'm open to it. This was just the simplest way I could
> get this to work.
> 
> Also, the addition of the .end routine for the MPIC is not strictly necessary for
> this patch. It's there so this code will run from within the threaded interrupt
> context used by the Real Time patch.


Hmm.  I feel that at least the last paragraph here needs
to be above the --- line for future patch readers.  Otherwise
it's relationship to the rest of the patch details will be
intermixed and lost.

Thanks,
jdl
