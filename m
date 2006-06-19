Return-Path: <Becky.Bruce@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 42988679FF
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jun 2006 05:55:36 +1000 (EST)
In-Reply-To: <1150598731.23600.146.camel@localhost.localdomain>
References: <1150598731.23600.146.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <EC61A880-9242-4BCE-B72D-8AFC038CD592@freescale.com>
From: Becky Bruce <Becky.Bruce@freescale.com>
Subject: Re: [RFC] Interrupt mapping documentation
Date: Mon, 19 Jun 2006 14:57:46 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben,

Wow, you've been busy!  This mostly looks good to me - just a few  
*minor* comments below. I've snipped out parts I'm not commenting on,  
to shrink this email down.....

>
> +  g) interrupt controller
> +
> +  At least one interrupt controller shall be present somewhere in the
> +  device-tree. It can be anywhere, it doesn't have to be a dedicated
> +  node (could be the /soc node) though it's generally separate. See
> +  chapter VII for a description of interrupt mapping and associated
> +  properties.
> +

One concern is this stated requirement that a tree have an interrupt- 
controller node.  It's not uncommon (in fact, I'm doing it right  
now...) for FSL and some of our customers to build and run the kernel  
on a simulator that has only a processor core, memory, and a memory- 
mapped pseudo-terminal.  The terminal does not generate interrupts,  
but is polled from the Decrementer interrupt.  So I do not have an  
interrupt controller in the "system" at all.

How are you planning to enforce this requirement?  I believe the dtc  
I have right now warns me about no interrupt-controller node, but it  
builds the tree anyway, and I can boot my kernel just fine.  If all  
I'll need to do to get this working in the new world order is to add  
an "interrupt-controller" property to my soc node, I can deal with  
that.  I just don't want the kernel to konk out and refuse to boot if  
it doesn't find any interrupts.

>
>  3) Representing devices without a current OF specification
> @@ -1263,11 +1305,12 @@
>
>     Example :
>
> -	pic@40000 {
> +	interrupt-controller@40000 {
>  		linux,phandle = <40000>;
>  		clock-frequency = <0>;
>  		interrupt-controller;
>  		#address-cells = <0>;
> +		#interrupt-cells = <2>;
>  		reg = <40000 40000>;
>  		built-in;
>  		compatible = "chrp,open-pic";
> @@ -1445,6 +1488,314 @@


I'm curious about why you chose to rename the pic node here - now we  
have interrupt-controller as a device name, as well as an interrupt- 
controller property inside the device.  Reading the rest of this doc,  
the latter should be sufficient.  Is this just a stylistic decision?

>
> +1) Interrupt controllers
> +------------------------
> +
> +An interrupt controller is identified by the presence of an empty
> +"interrupt-controller" property in the node. It must also have those
> +two required properties:
> +
> +    - linux,phandle : The normally optional phandle is required  
> for an
> +      interrupt controller node as that node will have to be
> +      referrenced by phandle by other nodes (childs and nexus).
> +    - #interrupt-cells : This property contains one cell indicating
> +      the size of the child interrupt specifiers (number of
> +      cells). For example, both ISA and OpenPIC standard specifiers
> +      are 2 cells long (interrupt source number and trigger type)  
> thus
> +      the interrupt-controller node for these shall contain a
> +      #interrupt-cells property with the value <2>.
> +
> +In addition, it needs that optional property if there is ever a nexus
> +pointing to that controller:
> +
> +    - #address-cells : This is generally the value 0 for an interrupt
> +      controller, the reason why this property is needed is described
> +      in the documentation of an interrupt nexus.
> +

I think there is some potential for confusion to the reader about the  
required use of #address-cells. In the original document, we talk  
about how devices without an #address-cells property derive the value  
from the parent:

"In general, the format of an address for a device is defined by the
parent bus type, based on the #address-cells and #size-cells
property. In the absence of such a property, the parent's parent
values are used, etc..."

The additions in the patch specify new requirements that don't seem  
to match up with the statement above.  In the new patch, #address- 
cells is listed as a required node for interrupt-controller nodes,  
there's no mention of inheritance from a parent, and in one place in  
the Nexus section, it's stated that if there's no #address-cells node  
the kernel assumes it's 0.

I think the doc needs a bit of clarification in this area.

>
> +For example, if a bus has a #address-cells of 1 and a #interrupt- 
> cells
> +of 2, a device with those properties:
> +
> +   reg = <0xabcd1234>;
> +   interrupts = <0x00000001 0x00000000 0x00000002 0x00000001>
> +
> +(That is a device with 2 interrupt specifiers in its "interrupts"
> +property) would thus have the following interrupt unit
> +specifiers for its two interrupts:
> +
> +	   0xabcd1234 0x00000001 0x00000000
> +and
> +	   0xabcd1234 0x00000002 0x00000001
> +
> +Now the "interrupt-map" property is defined as containing a list of:
> +
> + [ child interrupt unit specifier ] [ parent ] [ parent interrupt  
> unit
> + specifier ]
> +
> +That is, a concatenated list of entries containing:
> +
> +     - an interrupt unit specifier for a child device
> +     - a phandle pointing to the interrupt-parent for that interrupt
> +     - an interrupt unit specifier in the parent space for that
> +       interrupt
> +

I think it would be useful to continue the example here, and show an  
"interrupt-map" property definition with all the fields filled in.   
Perhaps you were planning to do this as part of your PCI examples; if  
so just ignore this.

Thanks!
-B
