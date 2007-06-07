Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id AE334DDF06
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 03:52:16 +1000 (EST)
Subject: Re: [PATCH] When checking I8042 io port, use
	of_find_compatible_node() instead of of_find_node_by_type()
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <cd1e655423140dbb20af2821d5c3955f@kernel.crashing.org>
References: <1181148145.5674.121.camel@rhino>
	<2a56a9d008269d393c68959f1804c21d@kernel.crashing.org>
	<1181233610.5674.167.camel@rhino>
	<cd1e655423140dbb20af2821d5c3955f@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 07 Jun 2007 10:52:14 -0700
Message-Id: <1181238734.5674.228.camel@rhino>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-06-07 at 18:59 +0200, Segher Boessenkool wrote:
> >>> In check_legacy_ioport(), instead of using of_find_node_by_type() to
> >>> find the 8042 node, use of_find_compatible_node() to find either the
> >>> keyboard or mouse node.
> >>
> >> Why?
> 
> ^^^^^^^^
> 
> Why do you need/want this at all?

check_legacy_ioport() takes an io port as a parameter, and then matches
it with a device node based on the device type.  My patch would instead
match it with the compatible property of one of the 8042 devices, since
AIUI, the device type shouldn't be used.

> 
> >>>  	switch(base_port) {
> >>>  	case I8042_DATA_REG:
> >>> -		np = of_find_node_by_type(NULL, "8042");
> >>> +		np = of_find_compatible_node(NULL, NULL, "pnpPNP,303");
> >>> +		if (!np)
> >>> +			np = of_find_compatible_node(NULL, NULL, "pnpPNP,f03");
> >>> +		if (np) {
> >>> +			parent = of_get_parent(np);
> >>> +			of_node_put(np);
> >>> +			np = parent;
> >>> +		}
> >>
> >> This breaks other boards using 8042, if those exist --
> >> if this code is board-specific, it is in the wrong file.
> >
> > Perhaps I was a little too bold here.
> >
> > I guess if this breaks other boards
> 
> I don't know, but neither do you ;-)

True.

> 
> > then I should leave the check for
> > the device type, or perhaps just drop this patch altogether.
> 
> Maybe you want to test for _either_ of the three devices?

Ok, I'll add the test for the 8042 device type back in to preserve
compatibility with any existing boards.

> 
> > In the latter case, the 8042 node would need to have device_type =
> > "8042".  This contradicts what you posted in an earlier conversation we
> > had regarding the 8641 device tree:
> >
> > On Thu, 2007-05-17 at 01:40 +0200, Segher Boessenkool wrote:
> >>>>>> +                                8042@60 {
> >>>>>> +                                        device_type = "8042";
> >>>>
> >>>> Drop the device_type.  A number as a name isn't
> >>>> all that great, either.
> >>>
> >>> Currently in order for the i8042 devices to be initialized,
> >>> check_legacy_ioport() must find a node with device_type "8042".
> >>
> >> So fix that :-)
> >
> > This is my attempt to fix it :)
> 
> A bit too harsh though...  Deprecate first, remove
> later.

Fair enough.

> 
> > Now if you prefer that the 8042 node on the 8641 has the device_type
> > "8042", I will gladly add it back and drop this patch.
> 
> Never ever device_type.  "compatible" perhaps.  And
> not a bare number, either.

That was my understanding, hence the patch.

> 
> I'm not sure what the Linux code here does exactly --
> it seems to me you're allowing a legacy I/O port mapping
> when legacy drivers probe for it, right?  Instead you
> should change those drivers to not probe (perhaps by
> refusing the I/O range access here), and be explicitly
> instantiated from your device tree parsing code.
> 

The drivers could probably be modified in such a way, but that is not my
goal with these patches.  My goal is to enable the 8042 devices on the
8641.  Any driver modification should be done separately.

--Wade
