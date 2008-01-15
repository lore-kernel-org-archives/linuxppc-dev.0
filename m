Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4F161DDED6
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 02:04:22 +1100 (EST)
Message-ID: <478CCB44.3000805@freescale.com>
Date: Tue, 15 Jan 2008 09:03:32 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [SERIAL] qe-uart: add support for Freescale QUICCEngine
	UART
References: <11999217062265-git-send-email-timur@freescale.com>
	<11999217072674-git-send-email-timur@freescale.com>
	<119992170854-git-send-email-timur@freescale.com>
	<1CFD37C9-F06C-4C7E-836D-31C94EF464DF@kernel.crashing.org>
In-Reply-To: <1CFD37C9-F06C-4C7E-836D-31C94EF464DF@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

> what is the define for?  you commented all the others :)

I thought you said there were no more issues? :-)

>> +#define UCC_WAIT_CLOSING 100

This is how long to wait after receiving a close request for characters to be 
sent out before actually closing the device.  I just used the same value as the 
CPM serial driver.


>> +    u16 tx_state;       /* 0xC6, TX state */
> 
> __be16?

Oops.

>> +/*
>> + * Set the modem control lines
>> + *
>> + * We currently don't support setting modem control lines, but this 
>> function
>> + * needs to exist, otherwise the kernel will panic.
>> + */
>> +void qe_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
>> +{
>> +}
> 
> What's the issue w/support of this?  (maybe a comment related to why its 
> not supported -- if not here in the git commit message)

I didn't want to add any serial functionality that wasn't in the CPM serial 
driver, mostly because I don't really understand the technical details of serial 
communication at this level.  I figured if it's okay for the CPM driver not to 
handle modem control, then the QE driver doesn't have to do it either.

>> +static void qe_uart_enable_ms(struct uart_port *port)
>> +{
> 
> same question as above.

Same answer!

I suppose you want me to post another version of this patch?

-- 
Timur Tabi
Linux kernel developer at Freescale
