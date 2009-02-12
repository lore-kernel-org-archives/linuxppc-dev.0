Return-Path: <vijay.t.nikam@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.233])
	by ozlabs.org (Postfix) with ESMTP id E9C2EDDDAE
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 21:51:59 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id l9so240052rvb.9
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 02:51:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20090211223546.GA20129@cynthia.pants.nu>
References: <f234e2140902110043i5a4aefb5yb635bc32b9653943@mail.gmail.com>
	<1234343703.9778.13.camel@localhost>
	<f234e2140902110141l52550ceem664f57f697bd48e0@mail.gmail.com>
	<1234346072.9778.20.camel@localhost>
	<f234e2140902110213g3ae48f2es9fe41087bc8c7b39@mail.gmail.com>
	<20090211223546.GA20129@cynthia.pants.nu>
Date: Thu, 12 Feb 2009 16:21:58 +0530
Message-ID: <f234e2140902120251t2bd3aa5dsc950cacdd6b4422a@mail.gmail.com>
Subject: Re: request_irq return errno 38
From: Vijay Nikam <vijay.t.nikam@gmail.com>
To: Brad Boyer <flar@allandria.com>, scottwood@freescale.com,
	linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks for your replies ...

I checked the irq.c and irq.h and found the prototype of
irq_of_parse_and_map() and found from the comment that it is a wrapper
function contains a chain of irq_map_one() and irq_create_mapping()
...

It means that I can use irq_create_mapping() to know the virq also the
same suggessted by michael ... what is the difference between these
two i.e. irq_create_mapping() and irq_of_parse_and_map() ... I mean in
usage what could be the difference ? ? ?

If used the irq_of_parse_and_map() then the paraments I need to pass
are device_node *dev and index irq_of_parse_and_map(struct device_node
*dev, int index) ... then how I can pass the required information i.e.
dev and index ? ? ?

Also how I can read the device tree binary file ? ? ?

Kindly please acknowledge ... thank you ...

Kind Regards,
Vijay Nikam

On 2/12/09, Brad Boyer <flar@allandria.com> wrote:
> On Wed, Feb 11, 2009 at 03:43:26PM +0530, Vijay Nikam wrote:
> > I read in LDD book, they give directly irq no. they have given
> > parallel port example, here they have set or said irq no. defaults to
> > 7 and they have not done any irq_mapping so what is the difference ? ?
> > ? I mean how I should know when to use irq_mapping and when not ? ? ?
> >
> > Also is it some difference between writng drivers on embedded Linux
> > level and Linux PC (i386) ? ? ?
>
> The basic request_irq() function is generic, but the value of the
> arguments (especially the number for the IRQ line) is architecture
> specific in many ways. This is one difference between the i386 code
> and the powerpc code inside Linux. Most i386 hardware is standard
> PC hardware with very clearly defined interrupt sources. Because of
> this, the mapping from the numeric IRQ value to a real hardware
> interrupt source is defined pretty clearly. The powerpc architecture
> code has to support almost arbitrarily complex hardware, and the
> embedded world is the source of most of the complexity. Because of
> this, the powerpc code has to dynamically allocate those numeric
> IRQ sources and tie them to a specific hardware interrupt. There
> is functionality to take the information from your device tree and
> convert it to a virtual IRQ. That happens automatically for some types
> of devices like PCI cards, but your driver may have to do that mapping
> itself in other cases. I believe the appropriate API for this is the
> function irq_of_parse_and_map(). It takes a device node and index into
> the interrupt list for that device and gives a virtual IRQ number.
>
>        Brad Boyer
>        flar@allandria.com
>
>
