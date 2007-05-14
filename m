Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2E3B4DDDE9
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 11:20:08 +1000 (EST)
Message-ID: <4647B95D.1040404@genesi-usa.com>
Date: Mon, 14 May 2007 02:20:29 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH 1/4 v4] powerpc: document phy-connection-type property
References: <20070423144052.261f68ad.kim.phillips@freescale.com>	<5c96dd623e3a6737db48ab17c3550610@kernel.crashing.org>
	<20070423160621.329d1a08.kim.phillips@freescale.com>
In-Reply-To: <20070423160621.329d1a08.kim.phillips@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi guys,

Since I'm poking around on 52xx I had a query - firstly it doesn't
look like the 52xx fec driver uses phylib at all since it also tries
to support the 7-wire ethernet interface, which isn't ?? supported
by phylib.

Stumbling across this property I wondered, if the driver can check
the device tree for the phy type to set it up properly in this
manner, would it also be relevant to list the 7-wire style of
connection, so that drivers can provide the alternative code?

Side note, is phylib flexible enough to support the 7-wire
non-MII connection? It looks sorta so, but...

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Kim Phillips wrote:
> On Mon, 23 Apr 2007 22:59:43 +0200
> Segher Boessenkool <segher@kernel.crashing.org> wrote:
> 
>>> phy-connection-type is now maintained one-to-one with definitions
>>> in include/linux/phy.h, albeit in the form of a string.
>> That's sort-of accidental though :-)
>>
> sure..
> 
>>> --- a/Documentation/powerpc/booting-without-of.txt
>>> +++ b/Documentation/powerpc/booting-without-of.txt
>>> @@ -1562,6 +1562,9 @@ platforms are moved over to use the 
>>> flattened-device-tree model.
>>>       network device.  This is used by the bootwrapper to interpret
>>>       MAC addresses passed by the firmware when no information other
>>>       than indices is available to associate an address with a device.
>>> +   - phy-connection-type : a string naming the controller/PHY 
>>> interface type,
>>> +     i.e., "mii" (default), "rmii", "gmii", "rgmii", "rgmii-id", 
>>> "tbi",
>>> +     or "rtbi".
>> Could you put this right after the "phy-handle" definition
>> please?
> 
> phy-handle is a required property, whereas phy-connection-type is not
> (it's recommended). Are you suggesting phy-connection-type be a required
> property?
> 
>>> @@ -1573,6 +1576,7 @@ platforms are moved over to use the 
>>> flattened-device-tree model.
>>>  		interrupts = <a0 0>;
>>>  		interrupt-parent = <700>;
>>>  		mac-address = [ 00 04 9f 00 23 23 ];
>>> +		phy-connection-type = "gmii";
>>>  		rx-clock = "none";
>>>  		tx-clock = "clk9";
>>>  		phy-handle = <212000>;
>> Same here.  It's nice to keep things grouped, it
>> improves understanding ;-)
> 
> That's understandable.  Lemme know about the above though.
> 
> Kim
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
