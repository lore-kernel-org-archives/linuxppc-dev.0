Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6C04ADDE33
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 02:13:39 +1100 (EST)
Message-Id: <F8E95D9D-F904-4D69-A83D-B29229768A6B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <478CCB44.3000805@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] [SERIAL] qe-uart: add support for Freescale QUICCEngine
	UART
Date: Tue, 15 Jan 2008 09:13:28 -0600
References: <11999217062265-git-send-email-timur@freescale.com>
	<11999217072674-git-send-email-timur@freescale.com>
	<119992170854-git-send-email-timur@freescale.com>
	<1CFD37C9-F06C-4C7E-836D-31C94EF464DF@kernel.crashing.org>
	<478CCB44.3000805@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 15, 2008, at 9:03 AM, Timur Tabi wrote:

> Kumar Gala wrote:
>
>> what is the define for?  you commented all the others :)
>
> I thought you said there were no more issues? :-)

I lied, get use to it ;)

(I was going to apply the patch and thus scanned over it).

>
>
>>> +#define UCC_WAIT_CLOSING 100
>
> This is how long to wait after receiving a close request for  
> characters to be sent out before actually closing the device.  I  
> just used the same value as the CPM serial driver.

Yeah, I just meant a comment to this fact would be nice.

>
>
>
>>> +    u16 tx_state;       /* 0xC6, TX state */
>> __be16?
>
> Oops.
>
>>> +/*
>>> + * Set the modem control lines
>>> + *
>>> + * We currently don't support setting modem control lines, but  
>>> this function
>>> + * needs to exist, otherwise the kernel will panic.
>>> + */
>>> +void qe_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
>>> +{
>>> +}
>> What's the issue w/support of this?  (maybe a comment related to  
>> why its not supported -- if not here in the git commit message)
>
> I didn't want to add any serial functionality that wasn't in the CPM  
> serial driver, mostly because I don't really understand the  
> technical details of serial communication at this level.  I figured  
> if it's okay for the CPM driver not to handle modem control, then  
> the QE driver doesn't have to do it either.

This is fine, can we make it clear that we aren't implementing them  
because we didn't need them not because of some board issue.  (Looking  
at the 8250.c driver it looks like this has to do with CTS support --  
which the QE UCC supports, we just aren't using).

>>> +static void qe_uart_enable_ms(struct uart_port *port)
>>> +{
>> same question as above.
>
> Same answer!
>
> I suppose you want me to post another version of this patch?

yes.

- k
