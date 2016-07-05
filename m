Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkCJ24nLKzDrYq
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 15:34:42 +1000 (AEST)
In-Reply-To: <20160628031139.12500-1-sam@mendozajonas.com>
To: Sam Mendoza-Jonas <sam@mendozajonas.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, "# 4 . 1 . x-" <stable@vger.kernel.org>,
 Alistair Popple <alistair@popple.id.au>,
 Samuel Mendoza-Jonas <sam@mendozajonas.com>
Subject: Re: [1/2] tty/hvc: Use IRQF_SHARED for OPAL hvc consoles
Message-Id: <3rkCJ22Wwpz9sBl@ozlabs.org>
Date: Tue,  5 Jul 2016 15:34:42 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-28-06 at 03:11:38 UTC, Sam Mendoza-Jonas wrote:
> Commit 2def86a7200c
> ("hvc: Convert to using interrupts instead of opal events")
> enabled the use of interrupts in the hvc_driver for OPAL platforms.
> However on machines with more than one hvc console, any console after
> the first will fail to register an interrupt handler in
> notifier_add_irq() since all consoles share the same IRQ number but do
> not set the IRQF_SHARED flag:
> 
> [   51.179907] genirq: Flags mismatch irq 31. 00000000 (hvc_console) vs.
> 00000000 (hvc_console)
> [   51.180010] hvc_open: request_irq failed with rc -16.
> 
> This error propagates up to hvc_open() and the console is closed, but
> OPAL will still generate interrupts that are not handled, leading to
> rcu_sched stall warnings.
> 
> Set IRQF_SHARED when calling request_irq, allowing additional consoles
> to start properly. This is only set for consoles handled by
> hvc_opal_probe(), leaving other types unaffected.
> 
> Signed-off-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>

Acked-by: Michael Ellerman <mpe@ellerman.id.au>


Greg I'm assuming you'll take this unless you tell me otherwise.

cheers
