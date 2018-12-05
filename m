Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3D4C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 05:52:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA32520672
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 05:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA32520672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438ntR3mQ0zDqn5
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 16:51:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 438nn547VVzDqQT
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Dec 2018 16:47:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 438nn40s4lz9sBh;
 Wed,  5 Dec 2018 16:47:20 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Florian Fainelli <f.fainelli@gmail.com>, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] serial: 8250: Default SERIAL_OF_PLATFORM to SERIAL_8250
In-Reply-To: <5a13dfac-adcb-b0b2-0114-90f9d1eabe8b@gmail.com>
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
Date: Wed, 05 Dec 2018 16:47:17 +1100
Message-ID: <87pnugh6e2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Florian,

Florian Fainelli <f.fainelli@gmail.com> writes:
> +PPC folks
>
> On 11/23/18 10:20 AM, Guenter Roeck wrote:
>> On Mon, Nov 19, 2018 at 12:50:50PM -0800, Guenter Roeck wrote:
>>> On Mon, Nov 19, 2018 at 10:44:30AM -0800, Florian Fainelli wrote:
>>>> On 11/15/18 5:16 PM, Guenter Roeck wrote:
>>>>> On Thu, Nov 15, 2018 at 11:48:20AM -0800, Florian Fainelli wrote:
>>>>>>
>>>>>> OK, would you mind testing this below? It seems to me that 8250_of.c is
>>>>>> incompatible with arch/powerpc/kernel/legacy_serial.c and that is what
>>>>>> is causing the issue here.
>>>>>>
>>>>>> diff --git a/drivers/tty/serial/8250/Kconfig
>>>>>> b/drivers/tty/serial/8250/Kconfig
>>>>>> index d7737dca0e48..21cb14cbd34a 100644
>>>>>> --- a/drivers/tty/serial/8250/Kconfig
>>>>>> +++ b/drivers/tty/serial/8250/Kconfig
>>>>>> @@ -483,7 +483,7 @@ config SERIAL_8250_PXA
>>>>>>
>>>>>>  config SERIAL_OF_PLATFORM
>>>>>>         tristate "Devicetree based probing for 8250 ports"
>>>>>> -       depends on SERIAL_8250 && OF
>>>>>> +       depends on SERIAL_8250 && OF && !(PPC && PPC_UDBG_16550)
>>>>>>         default SERIAL_8250
>>>>>>         help
>>>>>>           This option is used for all 8250 compatible serial ports that
>>>>>
>>>>> 44x/virtex5_defconfig has both PPC_UDBG_16550 and SERIAL_OF_PLATFORM enabled
>>>>> and fails to boot (or display anything on the console) with this patch applied.
>>>>
>>>> Thanks for trying, can you either share or provide a link to the mpc85xx
>>>> and ml507 qemu command lines that you use? I spent a good chunk of my
>>>> time trying to get a kernel to boot but has failed so far.
>>>>
>>>
>> 
>> Any update ? I still see the boot failures in next-20181123.
>
> Yes, took most of last week's off sorry for the delay. I have finally
> been able to boot a kernel using your instructions, thanks. The problem
> is the following call chain:
>
> of_platform_serial_probe()
>  -> serial8250_register_8250_port()
>     -> up->port.uartclk == 0, return -EINVAL
> 	-> irq_dispose_mapping()
>
> and then we basically unwind what we just did with
> of_platform_serial_probe() including disabling the UART's IRQ, comment
> out the irq_dispose_mapping() and you will have a functional console
> again. 8250_of.c is clearly not a full replacement for legacy_serial.c
> (that was a first attempt), so we need to keep that code around. Making
> the depends even more conditional also does not sound too appealing,
> because while we have identified mpc85xx as being problematic, who knows
> about other platforms. So the best I have that does not involve a revert
> is this below.
>
> Ben, Michael, would that sound reasonable to you? It seems to me that
> there is a million ways to shoot the legacy_serial 8250 registration in
> the foot in any cases, and having CONFIG_SERIAL_OF_PLATFORM just made it
> painfully obvious.

We generally try to avoid changing the device tree from inside Linux,
it's meant to describe the hardware as we're given it, not the state of
Linux drivers etc. Perhaps this is an exceptional case but it still
seems fishy.

I also worry that marking the device node disabled might break something
else, but that's maybe me being paranoid.

I guess I don't really understand how things are supposed to work
though. We have the 8250 driver and also the OF platform driver, the
former has already setup the device and then the OF driver just comes
along and takes over?

eg. in the boot log from the mpc8544ds you see:

  serial8250.0: ttyS0 at MMIO 0xe0004500 (irq = 42, base_baud = 115200) is a 16550A
  printk: console [ttyS0] enabled
  printk: console [ttyS0] enabled
  printk: bootconsole [udbg0] disabled
  printk: bootconsole [udbg0] disabled
  of_serial: probe of e0004500.serial failed with error -22

ie. the 8250 core has already setup the device, so there should really
be nothing to do?

If the 8250 code could detect that it already has this port registered
then maybe things would work.

The patch below works for me with mpc8544ds. Whether it's worth changing
the 8250 code this much to accomodate legacy_serial I'm not sure.

cheers


diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 94f3e1c64490..c7d7858fdb3d 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -905,7 +905,7 @@ static struct platform_device *serial8250_isa_devs;
  */
 static DEFINE_MUTEX(serial_mutex);
 
-static struct uart_8250_port *serial8250_find_match_or_unused(struct uart_port *port)
+static struct uart_8250_port *serial8250_find_existing(struct uart_port *port)
 {
 	int i;
 
@@ -921,10 +921,17 @@ static struct uart_8250_port *serial8250_find_match_or_unused(struct uart_port *
 	if (i < nr_uarts && serial8250_ports[i].port.type == PORT_UNKNOWN &&
 			serial8250_ports[i].port.iobase == 0)
 		return &serial8250_ports[i];
+
+	return NULL;
+}
+
+static struct uart_8250_port *serial8250_find_unused(struct uart_port *port)
+{
+	int i;
+
 	/*
-	 * We didn't find a matching entry, so look for the first
-	 * free entry.  We look for one which hasn't been previously
-	 * used (indicated by zero iobase).
+	 * Look for the first free entry. We look for one which hasn't been
+	 * previously used (indicated by zero iobase).
 	 */
 	for (i = 0; i < nr_uarts; i++)
 		if (serial8250_ports[i].port.type == PORT_UNKNOWN &&
@@ -960,12 +967,18 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 	struct uart_8250_port *uart;
 	int ret = -ENOSPC;
 
-	if (up->port.uartclk == 0)
-		return -EINVAL;
-
 	mutex_lock(&serial_mutex);
 
-	uart = serial8250_find_match_or_unused(&up->port);
+	uart = serial8250_find_existing(&up->port);
+	if (!uart) {
+		if (up->port.uartclk == 0) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		uart = serial8250_find_unused(&up->port);
+	}
+
 	if (uart && uart->port.type != PORT_8250_CIR) {
 		if (uart->port.dev)
 			uart_remove_one_port(&serial8250_reg, &uart->port);
@@ -974,7 +987,10 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 		uart->port.membase      = up->port.membase;
 		uart->port.irq          = up->port.irq;
 		uart->port.irqflags     = up->port.irqflags;
-		uart->port.uartclk      = up->port.uartclk;
+
+		if (up->port.uartclk != 0)
+			uart->port.uartclk      = up->port.uartclk;
+
 		uart->port.fifosize     = up->port.fifosize;
 		uart->port.regshift     = up->port.regshift;
 		uart->port.iotype       = up->port.iotype;
@@ -1056,6 +1072,7 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 			ret = 0;
 		}
 	}
+out:
 	mutex_unlock(&serial_mutex);
 
 	return ret;

