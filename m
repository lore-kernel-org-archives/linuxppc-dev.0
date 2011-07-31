Return-Path: <felix@embedded-sol.com>
Received: from sh78.surpasshosting.com (sh78.surpasshosting.com [72.29.64.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 986BBB6F6F
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Aug 2011 05:28:33 +1000 (EST)
Message-ID: <4E35ACE0.3020908@embedded-sol.com>
Date: Sun, 31 Jul 2011 22:28:32 +0300
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: GPIO IRQ on P1022
References: <4E35309E.4000202@embedded-sol.com>
	<4E357285.8080708@grandegger.com>
	<4E357A1A.1080606@embedded-sol.com>
	<4E3595B6.4010406@grandegger.com>
In-Reply-To: <4E3595B6.4010406@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Tabi Timur-B04825 <B04825@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Wolfgang,

On 07/31/2011 08:49 PM, Wolfgang Grandegger wrote:
> Hi Felix,
>
> On 07/31/2011 05:51 PM, Felix Radensky wrote:
>> Hi Wolfgang,
>>
>> On 07/31/2011 06:19 PM, Wolfgang Grandegger wrote:
>>> On 07/31/2011 12:38 PM, Felix Radensky wrote:
>>>> Hi,
>>>>
>>>> I'm running kernel 3.0 on a custom board based on Freescale P1022.
>>>> The interrupt line of on-board FPGA is connected to GPIO2_9. FPGA
>>>> IRQ is level, active low. The GPIOs are mapped like this:
> Here you say that it's a level sensitive interrupt but ...
>
>>>> GPIOs 160-191, /soc@ffe00000/gpio-controller@f200:
>>>>
>>>> GPIOs 192-223, /soc@ffe00000/gpio-controller@f100:
>>>>
>>>> GPIOs 224-255, /soc@ffe00000/gpio-controller@f000:
>>>>
>>>> I've verified that pin mixing is done correctly, and the
>>>> FPGA IRQ line is indeed configured as GPIO.
>>>>
>>>> I have the following code in my driver:
>>>>
>>>>       #define FPGA_IRQ_GPIO 169
>>>>
>>>>       err = gpio_request(FPGA_IRQ_GPIO, "FPGA IRQ");
>>>>       if (err) {
>>>>           printk(KERN_ERR "Failed to request FPGA IRQ GPIO, err=%d\n",
>>>> err);
>>>>           goto out;
>>>>       }
>>>>
>>>>       gpio_direction_input(FPGA_IRQ_GPIO);
>>>>
>>>>       irq = gpio_to_irq(FPGA_IRQ_GPIO);
>>>>       if (irq<   0) {
>>>>           printk(KERN_ERR "Failed to map FPGA GPIO to IRQ\n");
>>>>           goto out;
>>>>       }
>>>>
>>>>       err = request_irq(irq, gsat_interrupt,
>>>>                 IRQF_TRIGGER_FALLING, DRVNAME, priv);
> .. you request here an edge triggered interrupt.

Yes, that is is correct. mpc8xxx_gpio.c driver does not allow
level sensitive interrupts, so I had no choice but to specify
IRQF_TRIGGER_FALLING.

Felix.
