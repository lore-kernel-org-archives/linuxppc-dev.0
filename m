Return-Path: <cbouatmailru@gmail.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.189])
	by ozlabs.org (Postfix) with ESMTP id 464F2DDF00
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jan 2008 10:54:19 +1100 (EST)
Received: by fk-out-0910.google.com with SMTP id z22so8666072fkz.9
	for <linuxppc-dev@ozlabs.org>; Thu, 03 Jan 2008 15:54:18 -0800 (PST)
Date: Fri, 4 Jan 2008 02:41:50 +0300
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v2] ucc_uart: add support for Freescale QUICCEngine UART
Message-ID: <20080103234150.GA24052@zarina>
References: <11970458703666-git-send-email-timur@freescale.com>
	<20071226165816.GB11449@localhost.localdomain>
	<4776C5EE.70004@freescale.com>
	<20080102181226.GA4486@loki.buserror.net>
	<477D28D3.3000102@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <477D28D3.3000102@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
Reply-To: cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 03, 2008 at 12:26:27PM -0600, Timur Tabi wrote:
> Scott Wood wrote:
> 
> >>>> +static struct of_platform_driver ucc_uart_of_driver = {
> >>>> +	.owner  	= THIS_MODULE,
> >>>> +	.name   	= "ucc_uart",
> >>> Maybe better fsl,ucc_uart?
> > 
> > fsl,qe-uart is defined by Documentation/powerpc/booting-without-of.txt.
> 
> Wait, I'm confused.  What does the of_platform_driver.name string have to do 
> with the compatible field in the device tree?  Like I said earlier, I'm just 

Eh, initially I meant compatible stuff, not the driver name. I've quoted
wrong code snippet, thus the confusion.

You're using "ucc_uart" for compatible matching:

> +static struct of_device_id ucc_uart_match[] = {
> +       {
> +               .type = "serial",
> +               .compatible = "ucc_uart",

here "fsl,qe-uart" will look better, no?

> +       },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, ucc_uart_match);

Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
