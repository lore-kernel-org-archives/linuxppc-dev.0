Return-Path: <flar@cynthia.pants.nu>
Received: from cynthia.pants.nu (unknown [76.245.85.235])
	by ozlabs.org (Postfix) with ESMTP id 90373DDDB4
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 10:13:16 +1100 (EST)
Date: Wed, 11 Feb 2009 14:35:46 -0800
From: Brad Boyer <flar@allandria.com>
To: Vijay Nikam <vijay.t.nikam@gmail.com>
Subject: Re: request_irq return errno 38
Message-ID: <20090211223546.GA20129@cynthia.pants.nu>
References: <f234e2140902110043i5a4aefb5yb635bc32b9653943@mail.gmail.com>
	<1234343703.9778.13.camel@localhost>
	<f234e2140902110141l52550ceem664f57f697bd48e0@mail.gmail.com>
	<1234346072.9778.20.camel@localhost>
	<f234e2140902110213g3ae48f2es9fe41087bc8c7b39@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f234e2140902110213g3ae48f2es9fe41087bc8c7b39@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 11, 2009 at 03:43:26PM +0530, Vijay Nikam wrote:
> I read in LDD book, they give directly irq no. they have given
> parallel port example, here they have set or said irq no. defaults to
> 7 and they have not done any irq_mapping so what is the difference ? ?
> ? I mean how I should know when to use irq_mapping and when not ? ? ?
> 
> Also is it some difference between writng drivers on embedded Linux
> level and Linux PC (i386) ? ? ?

The basic request_irq() function is generic, but the value of the
arguments (especially the number for the IRQ line) is architecture
specific in many ways. This is one difference between the i386 code
and the powerpc code inside Linux. Most i386 hardware is standard
PC hardware with very clearly defined interrupt sources. Because of
this, the mapping from the numeric IRQ value to a real hardware
interrupt source is defined pretty clearly. The powerpc architecture
code has to support almost arbitrarily complex hardware, and the
embedded world is the source of most of the complexity. Because of
this, the powerpc code has to dynamically allocate those numeric
IRQ sources and tie them to a specific hardware interrupt. There
is functionality to take the information from your device tree and
convert it to a virtual IRQ. That happens automatically for some types
of devices like PCI cards, but your driver may have to do that mapping
itself in other cases. I believe the appropriate API for this is the
function irq_of_parse_and_map(). It takes a device node and index into
the interrupt list for that device and gives a virtual IRQ number.

	Brad Boyer
	flar@allandria.com
