Return-Path: <bwarren@qstreams.com>
Received: from smtp102.biz.mail.re2.yahoo.com (smtp102.biz.mail.re2.yahoo.com
	[68.142.229.216]) by ozlabs.org (Postfix) with SMTP id 3D7FDDDE39
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Oct 2007 04:44:14 +1000 (EST)
Message-ID: <471657FB.3040806@qstreams.com>
Date: Wed, 17 Oct 2007 14:44:11 -0400
From: Ben Warren <bwarren@qstreams.com>
MIME-Version: 1.0
To: Michael Brian Willis <willis@arlut.utexas.edu>
Subject: Re: MPC85xx and linux IDE driver
References: <1192213784.4862.48.camel@louie> <470FCF8A.1000504@qstreams.com>
	<1192643237.4929.41.camel@louie>
In-Reply-To: <1192643237.4929.41.camel@louie>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Michael Brian Willis wrote:
> On Fri, 2007-10-12 at 15:48 -0400, Ben Warren wrote:
>   
>   
>> Here's what I use:
>>
>> http://marc.info/?l=linux-kernel&m=113877891224982&w=2
>>     
>
> Thanks for the response Ben. 
>
> I have put the driver you mentioned in my linux source and added the
> necessary information in the Kconfig file and the Makefile. So, I am now
> able to build the driver when I make my kernel image. However, I can't
> figure out what else needs to be done in order to actually use the
> driver for my compact flash device. Do I need to specify anything at the
> kernel command line, or do I need to modify any other config files?
> (Below is the ide portion of my linux .config file)
>
>   
This device driver is a platform driver, so you need to register a 
platform device somewhere in your board-specific init code that contains 
the hardware details (memory mapping and IRQ #).  You can either pass 
this in via device tree or hard code it.  I chose the latter in order to 
get up and runninq quickly.  Here's the init function I use.  CS0 is @ 
0xe4000000, CS1 is @ 0xe4100000 and I'm using IRQ20, which is one of the 
external IRQs on my CPU:

/* Compact Flash Initialization */

static int __init prism_setup_cf(void)
{
    struct resource r[3];
    struct platform_device *cf_dev;
    unsigned int virq;

    memset(&r, 0, sizeof(r));
    r[0].start = 0xe4000000;
    r[0].end = 0xe400000f;
    r[0].flags = IORESOURCE_MEM;

    r[1].start = 0xe4100000;
    r[1].end = 0xe410000f;
    r[1].flags = IORESOURCE_MEM;

   
    virq = irq_find_mapping(NULL, 20);
    set_irq_type(virq, IRQ_TYPE_EDGE_FALLING);
    r[2].start = virq;
    r[2].end = 0;
    r[2].flags = IORESOURCE_IRQ;

    cf_dev = platform_device_register_simple("mmio-cfide", 0, r, 3);

    return (cf_dev ? 0 : PTR_ERR(cf_dev));
}

> Thank you for your help so far, anymore help/direction is greatly
> appreciated. 
>
>   
Glad to help.

regards,
Ben
