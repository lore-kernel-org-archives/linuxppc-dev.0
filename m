Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (lxorguk.ukuu.org.uk [81.2.110.251])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4C5CAB6EE6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 22:19:13 +1000 (EST)
Date: Wed, 27 Jun 2012 12:52:42 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 3/3] serial/8250: delete WR SBC850 UART quirk handling
Message-ID: <20120627125242.08a3114e@pyramind.ukuu.org.uk>
In-Reply-To: <1340740469-31445-4-git-send-email-paul.gortmaker@windriver.com>
References: <1340740469-31445-1-git-send-email-paul.gortmaker@windriver.com>
 <1340740469-31445-4-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org,
 Alan Cox <alan@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 26 Jun 2012 15:54:29 -0400
Paul Gortmaker <paul.gortmaker@windriver.com> wrote:

> We've are dropping the support for the EOL SBC8560, so we can
> also delete this variant of the Alpha quirk support.
> 
> Cc: Alan Cox <alan@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-serial@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  drivers/tty/serial/8250/8250.h |    7 -------
>  1 files changed, 0 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> index f9719d1..ffd1e6e 100644
> --- a/drivers/tty/serial/8250/8250.h
> +++ b/drivers/tty/serial/8250/8250.h
> @@ -119,13 +119,6 @@ static inline void serial_dl_write(struct uart_8250_port *up, int value)
>   * is cleared, the machine locks up with endless interrupts.
>   */
>  #define ALPHA_KLUDGE_MCR  (UART_MCR_OUT2 | UART_MCR_OUT1)
> -#elif defined(CONFIG_SBC8560)
> -/*
> - * WindRiver did something similarly broken on their SBC8560 board. The
> - * UART tristates its IRQ output while OUT2 is clear, but they pulled
> - * the interrupt line _up_ instead of down, so if we register the IRQ
> - * while the UART is in that state, we die in an IRQ storm. */
> -#define ALPHA_KLUDGE_MCR (UART_MCR_OUT2)
>  #else
>  #define ALPHA_KLUDGE_MCR 0
>  #endif

Would you mind removing all of the crap from this if its going (eg
8250.c) not just the header so it gets missed ? Kill the symbol entirely ?

Alan
