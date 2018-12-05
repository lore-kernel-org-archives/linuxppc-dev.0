Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E852C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 22:43:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3467420879
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 22:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZZFG9Zp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3467420879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439DKK6HWpzDqYX
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 09:43:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CZZFG9Zp";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::342; helo=mail-wm1-x342.google.com;
 envelope-from=f.fainelli@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="CZZFG9Zp"; 
 dkim-atps=neutral
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439DGG2t4ZzDr4C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2018 09:40:38 +1100 (AEDT)
Received: by mail-wm1-x342.google.com with SMTP id r24so12792584wmh.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Dec 2018 14:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FrQmy0gz5YyZHFmssJi82beDt/t1L0r1M6YBALXTIMM=;
 b=CZZFG9ZpPhD/W1V1bBchDQZwVVgXrbgsTbikPwKOSA9aDqfK7U0/wfsxoVmI2DIMjN
 lffMcLJkHE52PuoOP79tCnKO/BBLme5t4X+tiFfvhE7MLVij9oEZGLPp5O/rtMO6PEbm
 DME/MkXKMJ2YnimiFuyMEp/lRTXNFeG134fYaEtH7fT5EgCjyZA5n46uMiZrXAddAy8o
 s+1qOxEcfTOL6ozGEXDbODYlvWqQL5LOA6Rlx+kisQ+9++ZgCu5B2hYKuaENrVeAwz5O
 opSPMQ07c5fV0OAKZTiFASx/I8vbl3YPTkZ4sZ8lTHKAbY4Ez3CQWtVnuaT21FhOLRua
 DJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=FrQmy0gz5YyZHFmssJi82beDt/t1L0r1M6YBALXTIMM=;
 b=SAjlRikuCnCW40/u9zQalD7JllDwgSpupba0qNjRcRmGVvQt6Pu2Q3R0Dfbq5ERUoW
 y+52oNldhza0/Xpn0vm76nxkvqALlKaYwmj6OsRrd3oho5lUuIJAzr1AQcVuUk2xr4sd
 h6Ant9DDtBADzuU8whGvocnmiHef8ZAKLhhvvYSNoujC4XAxTtb/jOQ3aCqx/WCLFuwW
 joLi35nnnM6jQSI8BMBU3kNb9Hyzw4vc+XWjJBxgHGa88Jaqd9Bkc0PII3X7vhyi7uSQ
 BU4753hYp4gUxC7rt9tx9IhQxwZQEjNzoj3aiYFPcKp/BH0+KVt15srjDYgmZ1Tmjqry
 w3xw==
X-Gm-Message-State: AA+aEWYEfXLX/wxiSYCcmQ7kclxfevrgzwxMVR0FywBQV5BEgRxIDEVA
 l74cyIiARgkSGqg1OMmBoA9hEa0U
X-Google-Smtp-Source: AFSGD/XSsIMR4LybN9mZf6P/RJG0U8ipKkB4AUQIlJypEBxtUKLs2Q4do3jUnnJVFmFIjMqWEKcSfg==
X-Received: by 2002:a1c:9e4a:: with SMTP id h71mr14707192wme.82.1544049635000; 
 Wed, 05 Dec 2018 14:40:35 -0800 (PST)
Received: from [10.67.49.9] ([192.19.223.250])
 by smtp.googlemail.com with ESMTPSA id
 g201sm11546333wme.43.2018.12.05.14.40.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 14:40:34 -0800 (PST)
Subject: Re: [PATCH] serial: 8250: Default SERIAL_OF_PLATFORM to SERIAL_8250
To: Michael Ellerman <mpe@ellerman.id.au>, Guenter Roeck <linux@roeck-us.net>
References: <20181115011125.GA32556@roeck-us.net>
 <29E7A6C0-7829-4650-93C6-7220FECAA6EF@gmail.com>
 <20181115053836.GA7606@roeck-us.net>
 <27ed27d3-220e-963f-7d2c-64df10421580@gmail.com>
 <20181115172535.GA26922@roeck-us.net>
 <5937b814-ca5f-5786-93a1-3334df8c92dc@gmail.com>
 <20181116011656.GA21813@roeck-us.net>
 <ffff966c-d6ae-1487-5269-b86df0824d1c@gmail.com>
 <20181119205050.GA1933@roeck-us.net> <20181123182023.GA10080@roeck-us.net>
 <5a13dfac-adcb-b0b2-0114-90f9d1eabe8b@gmail.com>
 <87pnugh6e2.fsf@concordia.ellerman.id.au>
From: Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <9b06ce8f-887f-b977-d277-6d0a8e04a2dc@gmail.com>
Date: Wed, 5 Dec 2018 14:40:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <87pnugh6e2.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: arnd@arndb.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 12/4/18 9:47 PM, Michael Ellerman wrote:
> Hi Florian,
> 
> Florian Fainelli <f.fainelli@gmail.com> writes:
>> +PPC folks
>>
>> On 11/23/18 10:20 AM, Guenter Roeck wrote:
>>> On Mon, Nov 19, 2018 at 12:50:50PM -0800, Guenter Roeck wrote:
>>>> On Mon, Nov 19, 2018 at 10:44:30AM -0800, Florian Fainelli wrote:
>>>>> On 11/15/18 5:16 PM, Guenter Roeck wrote:
>>>>>> On Thu, Nov 15, 2018 at 11:48:20AM -0800, Florian Fainelli wrote:
>>>>>>>
>>>>>>> OK, would you mind testing this below? It seems to me that 8250_of.c is
>>>>>>> incompatible with arch/powerpc/kernel/legacy_serial.c and that is what
>>>>>>> is causing the issue here.
>>>>>>>
>>>>>>> diff --git a/drivers/tty/serial/8250/Kconfig
>>>>>>> b/drivers/tty/serial/8250/Kconfig
>>>>>>> index d7737dca0e48..21cb14cbd34a 100644
>>>>>>> --- a/drivers/tty/serial/8250/Kconfig
>>>>>>> +++ b/drivers/tty/serial/8250/Kconfig
>>>>>>> @@ -483,7 +483,7 @@ config SERIAL_8250_PXA
>>>>>>>
>>>>>>>  config SERIAL_OF_PLATFORM
>>>>>>>         tristate "Devicetree based probing for 8250 ports"
>>>>>>> -       depends on SERIAL_8250 && OF
>>>>>>> +       depends on SERIAL_8250 && OF && !(PPC && PPC_UDBG_16550)
>>>>>>>         default SERIAL_8250
>>>>>>>         help
>>>>>>>           This option is used for all 8250 compatible serial ports that
>>>>>>
>>>>>> 44x/virtex5_defconfig has both PPC_UDBG_16550 and SERIAL_OF_PLATFORM enabled
>>>>>> and fails to boot (or display anything on the console) with this patch applied.
>>>>>
>>>>> Thanks for trying, can you either share or provide a link to the mpc85xx
>>>>> and ml507 qemu command lines that you use? I spent a good chunk of my
>>>>> time trying to get a kernel to boot but has failed so far.
>>>>>
>>>>
>>>
>>> Any update ? I still see the boot failures in next-20181123.
>>
>> Yes, took most of last week's off sorry for the delay. I have finally
>> been able to boot a kernel using your instructions, thanks. The problem
>> is the following call chain:
>>
>> of_platform_serial_probe()
>>  -> serial8250_register_8250_port()
>>     -> up->port.uartclk == 0, return -EINVAL
>> 	-> irq_dispose_mapping()
>>
>> and then we basically unwind what we just did with
>> of_platform_serial_probe() including disabling the UART's IRQ, comment
>> out the irq_dispose_mapping() and you will have a functional console
>> again. 8250_of.c is clearly not a full replacement for legacy_serial.c
>> (that was a first attempt), so we need to keep that code around. Making
>> the depends even more conditional also does not sound too appealing,
>> because while we have identified mpc85xx as being problematic, who knows
>> about other platforms. So the best I have that does not involve a revert
>> is this below.
>>
>> Ben, Michael, would that sound reasonable to you? It seems to me that
>> there is a million ways to shoot the legacy_serial 8250 registration in
>> the foot in any cases, and having CONFIG_SERIAL_OF_PLATFORM just made it
>> painfully obvious.
> 
> We generally try to avoid changing the device tree from inside Linux,
> it's meant to describe the hardware as we're given it, not the state of
> Linux drivers etc. Perhaps this is an exceptional case but it still
> seems fishy.

Technically this is changing the Linux internal representation of a
Device Tree node reference (device_node), which is a bit away from
actual HW representation.

> 
> I also worry that marking the device node disabled might break something
> else, but that's maybe me being paranoid.

The code as it is today only makes use of device_node pointers/Device
Tree to find out about the UART base address and a bunch of properties,
but it registers the UART as platform_device without making use of the
existing OF infrastructure to do that (historical reasons really).

> 
> I guess I don't really understand how things are supposed to work
> though. We have the 8250 driver and also the OF platform driver, the
> former has already setup the device and then the OF driver just comes
> along and takes over?

When the OF platform driver comes along it tries to register the same
device instance, fails to do so because the port->clk is 0, which the
8250 core thinks is an error, and then it starts unwinding the 8250 port
structure, which in turns steps on the instance that was registered
manually by legacy_serial.c

> 
> eg. in the boot log from the mpc8544ds you see:
> 
>   serial8250.0: ttyS0 at MMIO 0xe0004500 (irq = 42, base_baud = 115200) is a 16550A
>   printk: console [ttyS0] enabled
>   printk: console [ttyS0] enabled
>   printk: bootconsole [udbg0] disabled
>   printk: bootconsole [udbg0] disabled
>   of_serial: probe of e0004500.serial failed with error -22
> 
> ie. the 8250 core has already setup the device, so there should really
> be nothing to do?
> 
> If the 8250 code could detect that it already has this port registered
> then maybe things would work.
> 
> The patch below works for me with mpc8544ds. Whether it's worth changing
> the 8250 code this much to accomodate legacy_serial I'm not sure.

Not sure either, that was the route I initially took, but I was worried
about the impact and the inability to test that across a variety of
systems to make sure we would not be breaking 8250, which is really
ubiquitous. Your patch looks very reasonable though, so this might be an
appropriate course of action to take. It's not like we are supposed to
do what is happening here :)

The change in legacy_serial.c was self contained an while a hack, which
quite frankly, that whole file is as well, did the job ;)



> 
> cheers
> 
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index 94f3e1c64490..c7d7858fdb3d 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -905,7 +905,7 @@ static struct platform_device *serial8250_isa_devs;
>   */
>  static DEFINE_MUTEX(serial_mutex);
>  
> -static struct uart_8250_port *serial8250_find_match_or_unused(struct uart_port *port)
> +static struct uart_8250_port *serial8250_find_existing(struct uart_port *port)
>  {
>  	int i;
>  
> @@ -921,10 +921,17 @@ static struct uart_8250_port *serial8250_find_match_or_unused(struct uart_port *
>  	if (i < nr_uarts && serial8250_ports[i].port.type == PORT_UNKNOWN &&
>  			serial8250_ports[i].port.iobase == 0)
>  		return &serial8250_ports[i];
> +
> +	return NULL;
> +}
> +
> +static struct uart_8250_port *serial8250_find_unused(struct uart_port *port)
> +{
> +	int i;
> +
>  	/*
> -	 * We didn't find a matching entry, so look for the first
> -	 * free entry.  We look for one which hasn't been previously
> -	 * used (indicated by zero iobase).
> +	 * Look for the first free entry. We look for one which hasn't been
> +	 * previously used (indicated by zero iobase).
>  	 */
>  	for (i = 0; i < nr_uarts; i++)
>  		if (serial8250_ports[i].port.type == PORT_UNKNOWN &&
> @@ -960,12 +967,18 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
>  	struct uart_8250_port *uart;
>  	int ret = -ENOSPC;
>  
> -	if (up->port.uartclk == 0)
> -		return -EINVAL;
> -
>  	mutex_lock(&serial_mutex);
>  
> -	uart = serial8250_find_match_or_unused(&up->port);
> +	uart = serial8250_find_existing(&up->port);
> +	if (!uart) {
> +		if (up->port.uartclk == 0) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +
> +		uart = serial8250_find_unused(&up->port);
> +	}
> +
>  	if (uart && uart->port.type != PORT_8250_CIR) {
>  		if (uart->port.dev)
>  			uart_remove_one_port(&serial8250_reg, &uart->port);
> @@ -974,7 +987,10 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
>  		uart->port.membase      = up->port.membase;
>  		uart->port.irq          = up->port.irq;
>  		uart->port.irqflags     = up->port.irqflags;
> -		uart->port.uartclk      = up->port.uartclk;
> +
> +		if (up->port.uartclk != 0)
> +			uart->port.uartclk      = up->port.uartclk;
> +
>  		uart->port.fifosize     = up->port.fifosize;
>  		uart->port.regshift     = up->port.regshift;
>  		uart->port.iotype       = up->port.iotype;
> @@ -1056,6 +1072,7 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
>  			ret = 0;
>  		}
>  	}
> +out:
>  	mutex_unlock(&serial_mutex);
>  
>  	return ret;
> 


-- 
Florian
