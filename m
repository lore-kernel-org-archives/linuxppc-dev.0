Return-Path: <dgibson@ozlabs.org>
Date: Thu, 20 Sep 2007 10:52:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/3] usb: ehci-ppc-of dts bindings.
Message-ID: <20070920005201.GE14404@localhost.localdomain>
References: <20070917130005.GA29654@ru.mvista.com>
	<19e5f15308dfb8e60e2e49379666d00a@kernel.crashing.org>
	<46F1299A.1000508@ru.mvista.com>
	<d0e5786123822b4d178932d9048f6a22@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d0e5786123822b4d178932d9048f6a22@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 19, 2007 at 06:50:02PM +0200, Segher Boessenkool wrote:
> >>> +  Required properties:
> >>> +  - device_type : should be "usb".
> >> No device_type please.  The published USB binding doesn't define
> >> one on purpose.
> >
> > Could you please, explain why?
> > Sorry, I don't think I get the concept of device description here.
> 
> "device_type" is meant to be used only by OF for determining the OF
> programming model for a device.  No such thing has been defined for
> USB busses, so the USB binding does not define a "device_type" either.
> 
> Nothing in a flat device tree should ever define a device_type, except
> perhaps for compatibility with legacy kernel code.

This is not necessarily true.  As Segher says, device_type originally
indicated the OF programming model for a device.  However, we've
extended the notion for the flat device tree to allow device_type to
cover "device classes" which could have certain common properties and
semantics.  However, in this case, a meaningful class binding must
already be defined: it might make sense for usb to have a defined
device_type, but it's not been defined so far, so for now you must
omit device_type (if a device_type is defined in future, it's easier
to add legacy hooks that will include devices which are missing the
relevant device_type marker than to work around devices which *do*
have the marker, but pre-date and don't follow the defined class
binding).

> >>> +  - compatible : should be "ehci".
> >> Just "ehci" isn't enough -- compare to OHCI, which is the name for
> >> a kind of USB host controller as well as for a kind of Firewire
> >> host controller.
> >
> > Actually, I though device type="usb" + compatible="ehci" would be 
> > enough.
> 
> "compatible" values are their own namespace, you should in principle
> be able to find a driver for a device with them without having to look
> at other properties.

Yes.  Regardless of the state of any class / device_type binding, the
compatible property *alone* should be sufficient to select a driver.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
