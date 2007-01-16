Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D05B9DDDFD
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 08:20:10 +1100 (EST)
In-Reply-To: <8746466a0701161246wbe4268esab51bc07a7efb2a3@mail.gmail.com>
References: <8746466a0701161246wbe4268esab51bc07a7efb2a3@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F5C9484B-93D7-4B08-813A-8B14D3F0F878@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: EDAC platform devices for fsl_soc
Date: Tue, 16 Jan 2007 15:17:20 -0600
To: Dave <dave.jiang@gmail.com>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 16, 2007, at 2:46 PM, Dave wrote:

> I'm trying to write an EDAC driver for the mpc8560 board. I will need
> to access the DDR error management registers, the L2 error management
> registers, the PCI management registers, and also the related IRQs
> (internal 0, 2, and 8). So I would like to insert some entries into
> the 8560 fdt in order to parse them and map the hw irq to virq in
> order to setup the platform device resources.
>
> Below is what I was thinking the fdt should look like. Is that  
> reasonable?

I dont see the reason to introduce nodes that are specific to EDAC.   
You should add nodes for the full device (which includes the error  
mgmt).  In the case of PCI the node should be there and fixing the  
dts to report the proper irq is all that is needed.

>
>     soc8560@e0000000 {
>        #address-cells = <1>;
>        #size-cells = <1>;
>        #interrupt-cells = <2>;
>        device_type = "soc";
>        ranges = <0 e0000000 00100000>;
>        reg = <e0000000 00000200>;
>        bus-frequency = <13ab6680>;
>
>        dram_control@2000 {
>            device_type = "edac";
>            compatible = "85xx";
>            reg = <2000 e5c>;

expand to cover the full 4k allocated to ddr controller

>            linux,phandle = <2000>;
>            interrupt-parent = <40000>;
>            interrupts = <2 1>;

should be <2 2>

>        };

maybe something more generic like

memory-controller@2000 {

...

}

>        l2_error@20e00 {
>            device_type = "edac";
>            compatible = "85xx";
>            reg = <20e00 5c>;
>            linux,phandle = <20e00>;
>            interrupt-parent = <40000>;
>            interrupts = <0 1>;

should be <0 2>

>        };

Let's mimic the CPU cache node for this:

l2-cache@20000 {
	device_type = "cache";
	...  (various cache properties, size, line size, etc.)

         compatible = "85xx";
(Not sure if 85xx is the best for compatible)

         reg = <20000 100>;
         interrupt-parent = <40000>;
         interrupts = <0 1>;
};

>
>        pci_error@8e00 {
>            device_type = "edac";
>            compatible = "85xx";
>            reg = <8e00 20>;
>            linux,phandle = <8e00>;
>            interrupt-parent = <40000>;
>            interrupts = <8 0>;
>        };

Use the existing pci node as I mentioned above.

- k

> .....
>
> -- 
> -= Dave =-
