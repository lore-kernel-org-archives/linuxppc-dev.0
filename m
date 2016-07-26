Return-Path: <gregkh@linuxfoundation.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rz4qN18KbzDqdj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 14:28:00 +1000 (AEST)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rz4qM614vz9s0M
 for <linuxppc-dev@ozlabs.org>; Tue, 26 Jul 2016 14:27:59 +1000 (AEST)
Date: Mon, 25 Jul 2016 21:28:14 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Alistair Popple <alistair@popple.id.au>, Jiri Slaby <jslaby@suse.com>,
 Samuel Mendoza-Jonas <sam@mendozajonas.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH V2 1/2] tty/hvc: Use IRQF_SHARED for OPAL hvc consoles
Message-ID: <20160726042814.GA20815@kroah.com>
References: <20160711033858.16172-1-sam@mendozajonas.com>
 <87y458it6n.fsf@@concordia.ellerman.id.au>
 <146950627136.13887.1548506149694212821@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <146950627136.13887.1548506149694212821@concordia>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 26, 2016 at 02:11:11PM +1000, Michael Ellerman wrote:
> Quoting Michael Ellerman (2016-07-11 16:29:20)
> > Samuel Mendoza-Jonas <sam@mendozajonas.com> writes:
> > 
> > > Commit 2def86a7200c
> > > ("hvc: Convert to using interrupts instead of opal events")
> > > enabled the use of interrupts in the hvc_driver for OPAL platforms.
> > > However on machines with more than one hvc console, any console after
> > > the first will fail to register an interrupt handler in
> > > notifier_add_irq() since all consoles share the same IRQ number but do
> > > not set the IRQF_SHARED flag:
> > >
> > > [   51.179907] genirq: Flags mismatch irq 31. 00000000 (hvc_console) vs.
> > > 00000000 (hvc_console)
> > > [   51.180010] hvc_open: request_irq failed with rc -16.
> > >
> > > This error propagates up to hvc_open() and the console is closed, but
> > > OPAL will still generate interrupts that are not handled, leading to
> > > rcu_sched stall warnings.
> > >
> > > Set IRQF_SHARED when calling request_irq, allowing additional consoles
> > > to start properly. This is only set for consoles handled by
> > > hvc_opal_probe(), leaving other types unaffected.
> > >
> > > Signed-off-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>
> > > Cc: <stable@vger.kernel.org> # 4.1.x-
> > > ---
> > >  drivers/tty/hvc/hvc_console.h | 1 +
> > >  drivers/tty/hvc/hvc_irq.c     | 7 +++++--
> > >  drivers/tty/hvc/hvc_opal.c    | 3 +++
> > >  3 files changed, 9 insertions(+), 2 deletions(-)
> > 
> > Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> > 
> > Greg are you happy to take these two?
> 
> Hi Greg,
> 
> I don't see this series anywhere, do you mind if I take them via the
> powerpc tree for 4.8 ? Or do you want to pick them up.

You can take them, I'm not touching patches now until 4.8-rc1 is out,
sorry.

thanks,

greg k-h
