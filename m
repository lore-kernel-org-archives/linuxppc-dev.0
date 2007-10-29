Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8E704DE0A6
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 03:11:47 +1100 (EST)
Date: Mon, 29 Oct 2007 11:11:40 -0500
From: Scott Wood <scottwood@freescale.com>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: RFC:  replace device_type with new "class" property?
Message-ID: <20071029161140.GA4358@loki.buserror.net>
References: <9696D7A991D0824DBA8DFAC74A9C5FA30359F9BB@az33exm25.fsl.freescale.net>
	<4725FA58.4030505@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4725FA58.4030505@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 29, 2007 at 03:20:56PM +0000, Matt Sealey wrote:
> I think device_type, compatible and model properties fulfil
> this already, they simply aren't being used correctly.

device_type has a few drawbacks, though:

1. You can only specify one type, whereas with a new property we could
define it as a list (similar to compatible).  It's possible for one node to
comply with multiple class bindings, such as when there's a binding for
clients of the type of bus it's on as well as the type of device it is, or
when there are multiple levels of detail (such as complying with both
simple-bus and some specific bus binding).

2. We want to avoid any confusion with OF bindings and abused device_type
entries that have been allowed to become existing practice.

3. It's the only standard property (AFAIK) with an underscore in it. :-)

> Remember that, while you may want to make FDTs easier to
> design, OpenFirmware and the requirement on device interfaces
> through the client interface still exist and are still
> implemented (from time to time).

Sure -- and we don't want to risk the code thinking it can call into OF
based on what we put in a flat device tree, right?

> For readability, the name of the device needn't match device_type;
> for instance on the 5121E it may be that the 'diu' unit be
> called diu, but be of device_type 'display'

I don't think that's more readable than setting the name to display.
Something containing "diu" will be in the compatible list.

> Further differentiation should be done through the 'model'
> property in my opinion. This is optional in the OpenFirmware
> spec, but that does not mean it should be important. It is
> currently defined as something to determine the exact model
> of a chip in order to enable quirks, bugfixes and suchlike,
> but most implementations switch on something else entirely
> (like SVR or a heuristic behaviour).
> 
> Selecting the "model" would be no different to, for example,
> having a list of PCI IDs that will work with a driver.

It's what we currently do with compatible.  Why break it into two
properties?

The PCI ID thing can be quite a headache, BTW, when you get a new PCI device
that won't work with the existing driver, for no reason other than that it
hasn't been updated with the new ID.

> There was a little discussion at bplan once that it would be
> easier to implement a kind of vendor/device id system much
> like PCI, USB etc. implements in hardware in order to match
> hardware. I suppose you could use a "class" property to
> implement this -

No, you should use compatible for that.

> but for instance in the case of USB or PCI, this is already encoded in the
> device_type for anything the firmware cannot work out (pci1106,6062 or
> so).

No, that goes in name/compatible according to the OF PCI binding.

> Perhaps it is a solution though; mark each device with a
> class property, for instance on the 5200B give it a unique
> chip ID (fsl5200 or soc5200?)

No.  That's precisely the sort of device_type abuse we want to get away from
with class.

Personally, I'm fine with just using name and compatible, but others such as
Stuart have expressed a desire for something to formally indicate compliance
with a standard binding.  I don't think we should expand the use of
device_type in any case.

-Scott
