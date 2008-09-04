Return-Path: <oscar@silvustechnologies.com>
Received: from smtpout07.prod.mesa1.secureserver.net
	(smtpout07-04.prod.mesa1.secureserver.net [64.202.165.233])
	by ozlabs.org (Postfix) with SMTP id 57CAEDE061
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 04:45:20 +1000 (EST)
Message-ID: <48C02CA8.1030604@silvustechnologies.com>
Date: Thu, 04 Sep 2008 11:44:56 -0700
From: Oscar Takeshita <oscar@silvustechnologies.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Hooking an IRQ on a modified mpc8349emitx board
References: <48BF15ED.4050707@silvustechnologies.com>
	<20080904144457.GA2522@ld0162-tx32.am.freescale.net>
In-Reply-To: <20080904144457.GA2522@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks Scott,

It is hooked and alive! Your couple of lines guided me through. Here's 
the outline of what I did after looking
at other powerpc drivers and the ePAPR document from Power.org:

1. Assumed that MPC83xx_IRQ_EXT1 (0x11 without offset) corresponds to IRQ1.
2. Created a node in my dts that looks like:

mydevice@40000 {
     device_type = "network";
     interrupts = <11 8>;
     interrupt-parent = < &ipic >;
}

3. On my kernel device driver I have the following outline:

struct device_node *np;
int irq;
if ((np = of_find_node_by_name(NULL, "mydevice")) == NULL) {
        printk(KERN_ERR "Can't find my device node\n");
        irq = -1;
}
else
        irq = irq_of_parse_and_map(np,0);


4. Ready to use request_irq() on irq!

Thanks,

Oscar

Scott Wood wrote:
> On Wed, Sep 03, 2008 at 03:55:41PM -0700, Oscar Takeshita wrote:
>   
>> I've been trying to hook an IRQ on a modified mpc8349emitx board without 
>> success.
>>
>> The IRQ is hooked physically to IRQ1/GPIO2[13] on the mpc8349e. No other 
>> devices are
>> tied to this pin.
>>
>> I'm using uboot 1.2.0 and kernel 2.6.22.19.
>>
>> Do I need to have a dts entry for this interrupt in order to make
>> request_irq() succeed?
>>
>> How can I find the IRQ number? I tried probe_irq_on/off unfortunately it 
>> did not work.
>> Would it be MPC83xx_IRQ_EXT1 in arch/powerpc/include/asm/mpc83xx.h ?
>>
>> I'm new doing kernel work. Any hints appreciated.
>>     
>
> You need to describe the IRQ in a device tree node and use
> irq_of_parse_and_map().  request_irq() takes virtual IRQ numbers.
>
> Maybe we should put together an arch/powerpc FAQ...
>
> -Scott
>
>
>   
