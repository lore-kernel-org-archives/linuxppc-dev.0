Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 74D5067B1F
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jun 2006 09:12:12 +1000 (EST)
Subject: Re: [RFC] Interrupt mapping documentation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Becky Bruce <Becky.Bruce@freescale.com>
In-Reply-To: <EC61A880-9242-4BCE-B72D-8AFC038CD592@freescale.com>
References: <1150598731.23600.146.camel@localhost.localdomain>
	<EC61A880-9242-4BCE-B72D-8AFC038CD592@freescale.com>
Content-Type: text/plain
Date: Tue, 20 Jun 2006 09:12:00 +1000
Message-Id: <1150758720.23600.291.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> One concern is this stated requirement that a tree have an interrupt- 
> controller node.  It's not uncommon (in fact, I'm doing it right  
> now...) for FSL and some of our customers to build and run the kernel  
> on a simulator that has only a processor core, memory, and a memory- 
> mapped pseudo-terminal.  The terminal does not generate interrupts,  
> but is polled from the Decrementer interrupt.  So I do not have an  
> interrupt controller in the "system" at all.

You don't need an interrupt controller if you don't take interrupts ;)

> How are you planning to enforce this requirement?  I believe the dtc  
> I have right now warns me about no interrupt-controller node, but it  
> builds the tree anyway, and I can boot my kernel just fine.  If all  
> I'll need to do to get this working in the new world order is to add  
> an "interrupt-controller" property to my soc node, I can deal with  
> that.  I just don't want the kernel to konk out and refuse to boot if  
> it doesn't find any interrupts.

If you don't have interrupts, there is no problem. If you do, well, in
fact, I wrote my remapping core in such a way that it _can_ work without
interrupt controller nodes. There are ways to hack around... But you
won't be able to use the OF-parsing facilities to obtain interrupt
mapping of course.

I suppose I should update the above to say "If your platform can handle
external interrupts..."

> >  3) Representing devices without a current OF specification
> > @@ -1263,11 +1305,12 @@
> >
> >     Example :
> >
> > -	pic@40000 {
> > +	interrupt-controller@40000 {
> >  		linux,phandle = <40000>;
> >  		clock-frequency = <0>;
> >  		interrupt-controller;
> >  		#address-cells = <0>;
> > +		#interrupt-cells = <2>;
> >  		reg = <40000 40000>;
> >  		built-in;
> >  		compatible = "chrp,open-pic";
> > @@ -1445,6 +1488,314 @@

> I'm curious about why you chose to rename the pic node here - now we  
> have interrupt-controller as a device name, as well as an interrupt- 
> controller property inside the device.  Reading the rest of this doc,  
> the latter should be sufficient.  Is this just a stylistic decision?

It's a common practice to name it that way, like it's a common practice
to name ethernet controllers "ethernet"... doesn't _have_ to be that
way. There is an OF RFC or something, I cna't remember the details, that
defines that kind of standard naming.

> >
> > +1) Interrupt controllers
> > +------------------------
> > +
> > +An interrupt controller is identified by the presence of an empty
> > +"interrupt-controller" property in the node. It must also have those
> > +two required properties:
> > +
> > +    - linux,phandle : The normally optional phandle is required  
> > for an
> > +      interrupt controller node as that node will have to be
> > +      referrenced by phandle by other nodes (childs and nexus).
> > +    - #interrupt-cells : This property contains one cell indicating
> > +      the size of the child interrupt specifiers (number of
> > +      cells). For example, both ISA and OpenPIC standard specifiers
> > +      are 2 cells long (interrupt source number and trigger type)  
> > thus
> > +      the interrupt-controller node for these shall contain a
> > +      #interrupt-cells property with the value <2>.
> > +
> > +In addition, it needs that optional property if there is ever a nexus
> > +pointing to that controller:
> > +
> > +    - #address-cells : This is generally the value 0 for an interrupt
> > +      controller, the reason why this property is needed is described
> > +      in the documentation of an interrupt nexus.
> > +
> 
> I think there is some potential for confusion to the reader about the  
> required use of #address-cells. In the original document, we talk  
> about how devices without an #address-cells property derive the value  
> from the parent:

Which is incorrect according to the spec. It's a "feature" we had in the
kernel to work around a  ouple of broken device-trees in early Apple OFs
iirc, and when drafting that initial spec, I incorrectly assumed it was
standard OF.
 
> "In general, the format of an address for a device is defined by the
> parent bus type, based on the #address-cells and #size-cells
> property. In the absence of such a property, the parent's parent
> values are used, etc..."

Yes, and that's wrong. In the case of an interrupt nexus, I would like
to enforce it anyway for various reasons, like the fact that it
simplifies the parsing when hop'ing through more than one interrupt
parent to require explicit #address-cells on interrupt controllers and
interrupt nexus.

> The additions in the patch specify new requirements that don't seem  
> to match up with the statement above.  In the new patch, #address- 
> cells is listed as a required node for interrupt-controller nodes,  
> there's no mention of inheritance from a parent, and in one place in  
> the Nexus section, it's stated that if there's no #address-cells node  
> the kernel assumes it's 0.
>
> I think the doc needs a bit of clarification in this area.

Yup. #address-cells is mandatory to be able to parse the "parent" unit
interrupt specifier part of an interrupt-map. Thus the interrupt
controller must provide one. Since in most case, the parent unit
interrupt specifiers don't contain a unit address, but just an interrupt
line and sense, thus interrupt-controllers shall expose that by having a
#address-cells with a value of 0.

Now regarding default values, it's unclear. The OF interrupt mapping
document seems to imply that when parsing the interrupt tree, the
absence of a #address-cells in the interrupt parent means no unit
address while the OF spec defines a default value of 2 for a missing
#address-cells when parsing device addresse...

> I think it would be useful to continue the example here, and show an  
> "interrupt-map" property definition with all the fields filled in.

That's the goal :) I didn't have time to write examples yet.

> Perhaps you were planning to do this as part of your PCI examples; if  
> so just ignore this.

Yes. PCI is the typical case of using interrupt-map's

Ben.
