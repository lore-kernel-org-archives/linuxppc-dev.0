Return-Path: <matt@genesi-usa.com>
Message-ID: <47262E36.4030503@genesi-usa.com>
Date: Mon, 29 Oct 2007 19:02:14 +0000
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Dale Farnsworth <dale@farnsworth.org>
Subject: Re: RFC:  replace device_type with new "class" property?
References: <9696D7A991D0824DBA8DFAC74A9C5FA30359F9BB@az33exm25.fsl.freescale.net>	<4725FA58.4030505@genesi-usa.com>
	<20071029172724.11354.qmail@farnsworth.org>
In-Reply-To: <20071029172724.11354.qmail@farnsworth.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dale Farnsworth wrote:
> Scott wrote:
>> Personally, I'm fine with just using name and compatible, but others such as
>> Stuart have expressed a desire for something to formally indicate compliance
>> with a standard binding.  I don't think we should expand the use of
>> device_type in any case.
> 
> I agree that the existing compatible property is sufficient to do
> what Stuart wants.  All that is required is to define some standard
> bindings and give them well-known names for the compatible property.
> If needed, we could define a prefix that indicates that a compatible
> entry refers to a standards-compliant binding.  For example,
> "standard,network", or "standard,display".  I don't see the benefit
> of creating a new property similar to device_type.

I don't see how this makes anything any better.

Under Open Firmware, if device_type is "display", then it had better
act as a display through the client interface, interpose it's framebuffer
methods properly and suchlike.

In FDT, what is the purpose of the binding but to report devices? It
does not really define any interface whatsoever. Having it "conform
to a standards-compliant binding" by reporting standard,display goes
in the direction of ignoring the simple fact that most displays act
and are programmed very differently (with the glorious exception of
potentially giving it a "compatible" of "vga" - on PCI this is
handled very easily by the PCI class code! Which was exactly my
point..).

I would say the same for USB, where standard,usb would be really
glossing over the simple fact that *all usb controllers should by
default be created equal*. OHCI does not act any different, and
UHCI doesn't act any different, in the specification. If the chip
does weird things, you do not go around revoking it's status as an
OHCI controller, do you?

As an addendum to Scott's other mail I came up with a good reason to
give users readable names but standard device_types. Consider 802.11g,
which may have a name of "wifi" but since it is a network adapter,
have device_type "ethernet". It is ethernet after all, but users
would like to know which it is compared with the onboard ethernet,
given a list of devices on the OF console, without knowing the base
addresses of registers.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
