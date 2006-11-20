Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 60885679E9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Nov 2006 00:26:39 +1100 (EST)
Message-ID: <4561AD63.1060201@ru.mvista.com>
Date: Mon, 20 Nov 2006 16:28:03 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Stefan Roese <ml@stefan-roese.de>
Subject: Re: [PATCH] serial: Use real irq on UART0 (IRQ = 0) on PPC4xx systems
References: <200611201200.36780.ml@stefan-roese.de>
In-Reply-To: <200611201200.36780.ml@stefan-roese.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello.

Stefan Roese wrote:
> This patch fixes a problem seen on multiple 4xx platforms, where
> the UART0 interrupt number is 0. The macro "is_real_interrupt" lead
> on those systems to not use an real interrupt but the timer based
> implementation.

> This problem was detected and fixed by
> Charles Gales <cgales@amcc.com> and John Baxter <jbaxter@amcc.com>
> from AMCC.

> Signed-off-by: Stefan Roese <sr@denx.de>

> ---
> commit f83094acd3258575c9a5cdb1d65e241c16eff03a
> tree 72582c5eeb2a9c8ea57287616d51e42fff8ed641
> parent f56f68c4e1977f0e884a304af4c617bed4909417
> author Stefan Roese <sr@denx.de> Sat, 18 Nov 2006 10:28:50 +0100
> committer Stefan Roese <sr@denx.de> Sat, 18 Nov 2006 10:28:50 +0100

>  drivers/serial/8250.c |   22 ++++++++++++++--------
>  1 files changed, 14 insertions(+), 8 deletions(-)

> diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
> index e34bd03..a51679e 100644
> --- a/drivers/serial/8250.c
> +++ b/drivers/serial/8250.c
> @@ -76,8 +76,14 @@ static unsigned int nr_uarts = CONFIG_SE
>   * We default to IRQ0 for the "no irq" hack.   Some
>   * machine types want others as well - they're free
>   * to redefine this in their header file.
> + * NOTE:  Some PPC4xx use IRQ0 for a UART Interrupt, so
> + * we will assume that the IRQ is always real
>   */
> +#ifdef CONFIG_4xx
> +#define is_real_interrupt(irq)	(1)
> +#else
>  #define is_real_interrupt(irq)	((irq) != 0)
> +#endif

    This should have been done in <asm/serial.h> instead, like this:

#undef is_real_interrupt(irq)
#define is_real_interrupt(irq)	1

    Not too smart as well,but at least this wasy you won't be pulluting the 
generic code...

WBR, Sergei
