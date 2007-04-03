Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id 97C39DDE3A
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 16:05:03 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so172422ugf
	for <linuxppc-dev@ozlabs.org>; Mon, 02 Apr 2007 23:05:01 -0700 (PDT)
Message-ID: <528646bc0704022305s307c299hcdab589fa7e1776b@mail.gmail.com>
Date: Tue, 3 Apr 2007 00:05:01 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Igor Marnat" <marny@rambler.ru>
Subject: Re: [PATCH] ppchameleon_early_serial_map hidden under #ifdef
	CONFIG_SERIAL_8250
In-Reply-To: <05625250.20070403092134@rambler.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <05625250.20070403092134@rambler.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 4/2/07, Igor Marnat <marny@rambler.ru> wrote:
> Hello List!
>
> Having selected PPChameleonEVB as a platform and having turned off
> seral driver (CONFIG_SERIAL_8250 is not set) I got the following error
> message during kernel compilation:
>
> arch/ppc/platforms/4xx/built-in.o: In function `board_setup_arch':
> : undefined reference to `early_serial_setup'
>
>
> Perhaps the following patch will be ok?

In general looks okay, but one comment below.  This code is going to
need to be moved over to arch/powerpc fairly soon.

> diff --git a/arch/ppc/platforms/4xx/ppchameleon.c b/arch/ppc/platforms/4xx/ppchameleon.c
> index 6d8b7ad..159d4a6 100644
> --- a/arch/ppc/platforms/4xx/ppchameleon.c
> +++ b/arch/ppc/platforms/4xx/ppchameleon.c
> @@ -45,7 +45,9 @@
>  void *ppchameleon_rtc_base;
>
>  extern void gen550_init(int, struct uart_port *);
> +#ifdef CONFIG_SERIAL_8250
>  extern int early_serial_setup(struct uart_port *port);
> +#endif /* CONFIG_SERIAL_8250 */

This is just ugly, but not because of your patch.  External function
prototypes that aren't pulled from header files can lead to all kinds
of wierdness.  Since the code is already ugly and dangerous, I
wouldn't even bother with adding the #ifdef around it.

>
>  /* Some IRQs unique to the board
>   * Used by the generic 405 PCI setup functions in ppc4xx_pci.c
> @@ -75,6 +77,7 @@ ppc405_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
>   * Calculate the proper input baud rate and setup the serial driver.
>   */
>
> +#ifdef CONFIG_SERIAL_8250
>  static void __init
>  ppchameleon_early_serial_map (void)
>  {
> @@ -105,7 +108,9 @@ ppchameleon_early_serial_map (void)
>                 printk ("Early serial init of port 0 failed\n");
>         }
>  }
> -
> +#else /* CONFIG_SERIAL_8250 */
> +#define ppchameleon_early_serial_map()
> +#endif /* CONFIG_SERIAL_8250 */
>
>  void __init board_setup_arch (void)
>  {
> --

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
