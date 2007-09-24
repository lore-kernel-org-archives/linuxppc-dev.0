Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3D938DDEDE
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 07:41:35 +1000 (EST)
In-Reply-To: <20070920005201.GE14404@localhost.localdomain>
References: <20070917130005.GA29654@ru.mvista.com>
	<19e5f15308dfb8e60e2e49379666d00a@kernel.crashing.org>
	<46F1299A.1000508@ru.mvista.com>
	<d0e5786123822b4d178932d9048f6a22@kernel.crashing.org>
	<20070920005201.GE14404@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9e4addbf405b35bbe59b82276755e4b8@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/3] usb: ehci-ppc-of dts bindings.
Date: Mon, 24 Sep 2007 23:40:49 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Nothing in a flat device tree should ever define a device_type, except
>> perhaps for compatibility with legacy kernel code.
>
> This is not necessarily true.  As Segher says, device_type originally
> indicated the OF programming model for a device.  However, we've
> extended the notion for the flat device tree to allow device_type to
> cover "device classes" which could have certain common properties and
> semantics.

Such device classes are already handled by the "generic names"
recommended practice.

Reusing device_type for a different purpose is dangerous: before you
know it, you'll end up with a conflict, as was nicely demonstrated
today with device_type "rtc".

> However, in this case, a meaningful class binding must
> already be defined: it might make sense for usb to have a defined
> device_type, but it's not been defined so far, so for now you must
> omit device_type (if a device_type is defined in future, it's easier
> to add legacy hooks that will include devices which are missing the
> relevant device_type marker than to work around devices which *do*
> have the marker, but pre-date and don't follow the defined class
> binding).

Nothing in the kernel should assume it can find all devices of a
certain "class" any other way than by exhaustively matching on
possible "compatible" values.  I'm not sure why you would want to,
anyway: you need "compatible" to select which driver to use, already.


Segher
