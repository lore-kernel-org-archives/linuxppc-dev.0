Return-Path: <scottwood@freescale.com>
Message-ID: <472634C9.108@freescale.com>
Date: Mon, 29 Oct 2007 14:30:17 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: RFC:  replace device_type with new "class" property?
References: <9696D7A991D0824DBA8DFAC74A9C5FA30359F9BB@az33exm25.fsl.freescale.net>	<4725FA58.4030505@genesi-usa.com>
	<20071029172724.11354.qmail@farnsworth.org>
	<47262E36.4030503@genesi-usa.com>
In-Reply-To: <47262E36.4030503@genesi-usa.com>
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

Matt Sealey wrote:
> I don't see how this makes anything any better.
> 
> Under Open Firmware, if device_type is "display", then it had better
> act as a display through the client interface, interpose it's framebuffer
> methods properly and suchlike.
> 
> In FDT, what is the purpose of the binding but to report devices? It
> does not really define any interface whatsoever. Having it "conform
> to a standards-compliant binding" by reporting standard,display goes
> in the direction of ignoring the simple fact that most displays act
> and are programmed very differently

In that case, it probably make sense to simply not have a binding for 
displays.

> I would say the same for USB, where standard,usb would be really
> glossing over the simple fact that *all usb controllers should by
> default be created equal*. OHCI does not act any different, and
> UHCI doesn't act any different, in the specification. If the chip
> does weird things, you do not go around revoking it's status as an
> OHCI controller, do you?

If its weird things are sufficiently non-OHCI, yes. :-)
Good luck fitting a CPM USB controller into some *HCI designation.

> As an addendum to Scott's other mail I came up with a good reason to
> give users readable names but standard device_types. Consider 802.11g,
> which may have a name of "wifi"

This is reasonable.

> but since it is a network adapter, have device_type "ethernet".

This is acceptable as existing practice, but "standard,ethernet" would 
be just fine.  And there may be additional properties defined for 
wireless devices, and an additional "standard,wifi" binding could be 
added.  You can't have multiple device_types.

> It is ethernet after all, but users would like to know which it is
> compared with the onboard ethernet, given a list of devices on the OF
> console, without knowing the base addresses of registers.

My preferred solution to this particular problem is a label property, 
that can go beyond ethernet/wifi and say things like "front panel 
ethernet", "back panel ethernet A", "back panel ethernet B", "wireless", 
etc., without taking away name's existing use, and without limiting the 
label to the characters allowed in a node name.

-Scott
