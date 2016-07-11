Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rnwDJ6KGBzDr0L
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 16:29:20 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Samuel Mendoza-Jonas <sam@mendozajonas.com>, linuxppc-dev@ozlabs.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, Alistair Popple <alistair@popple.id.au>,
 Samuel Mendoza-Jonas <sam@mendozajonas.com>,
 "# 4 . 1 . x-" <stable@vger.kernel.org>
Subject: Re: [PATCH V2 1/2] tty/hvc: Use IRQF_SHARED for OPAL hvc consoles
In-Reply-To: <20160711033858.16172-1-sam@mendozajonas.com>
References: <20160711033858.16172-1-sam@mendozajonas.com>
Date: Mon, 11 Jul 2016 16:29:20 +1000
Message-ID: <87y458it6n.fsf@@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Samuel Mendoza-Jonas <sam@mendozajonas.com> writes:

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
> Cc: <stable@vger.kernel.org> # 4.1.x-
> ---
>  drivers/tty/hvc/hvc_console.h | 1 +
>  drivers/tty/hvc/hvc_irq.c     | 7 +++++--
>  drivers/tty/hvc/hvc_opal.c    | 3 +++
>  3 files changed, 9 insertions(+), 2 deletions(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

Greg are you happy to take these two?

cheers
