Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id A0065B70F9
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 30 Aug 2010 21:16:11 +1000 (EST)
Message-ID: <4C7B5F96.4010607@windriver.com>
Date: Mon, 30 Aug 2010 15:36:54 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: deebul nair <deebuls@gmail.com>
Subject: Re: MPC85xx - accessing external interrupt
References: <AANLkTim5FXeRvx2TiPMGSkwqdbOeei6bL5PebK7+toLZ@mail.gmail.com>
In-Reply-To: <AANLkTim5FXeRvx2TiPMGSkwqdbOeei6bL5PebK7+toLZ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

deebul nair wrote:
> Hi all
> 
> I am trying to use the external interrupts on the Powerpc architecture
> MPC8542 .
> 
> My  problem is that my driver is trying to request the external
> interrupt IRQ1, and I dont know what number use in INTR_NUM:
> 
> request_irq(INTR_NUM, , , , )
> 
> As per the MPC85xx documentation
> Documentation/powerpc/dts-bindings/fsl/mpic.txt
> about the implementation of interrupts virtual numbers
> the external interrupt virtual irq number for IRQ1 should be 1
> 
> but when i try to give INTR_NUM ins request_irq as 1 it gives error .
> 
> When i use irq_create_mapping() it gives me output as 16.. and it registers
> .. but the problem is it is not fixed
> neither it gives interrupts .
> when i remove and add it registers to some other addresses
> 
> i even tried irq_of_parse_map()
> 
> for_each_node_by_type(np,"interrupt-controller"){
>     if(of_device_is_compatible(np,"chrp,open-pic")){
>            found=np;
>            break;
> }
> }
> 
> virq = irq_of_parse_and_map(found, irq);
> 
> this always returns 0
> whatever may be the irq value..
> as a result the driver gives error for irq 0

Anyway the following path should be the correct path:

request_irq(virq)
	      |
	      + virq = irq_of_parse_and_map(hw_irq)
					      |
					      + We get this from the dts file.

So you should define the appropriate node for your device. Then convert your
hw_irq to vir_irq via irq_of_parse_and_map() to pass that to reuest_irq() on
your device driver. Sometime this process is wrapped by some functions so I
recommend you refer to the files on the directory, arch/powerpc/sysdev/.

But I think the root cause to your problem is that you cannot pass the proper
arguments to irq_of_parse_and_map().
------
unsigned int irq_of_parse_and_map(struct device_node *dev, int index)

You should do this like the following:
------
	struct device_node *np;
	unsigned int virq;

	np = of_find_compatible_node(NULL, NULL, "<the compatible property of your
device node on dts>");
	if (np) {
		irq_of_parse_and_map(np, 0);
	}

	request_irq(virq,......);

Here I assume you have only one irq property so set 'index' as '0' on the
function, irq_of_parse_and_map().

Cheers
Tiejun
		
> 
> 
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
