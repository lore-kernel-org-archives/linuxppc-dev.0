Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6BB99DDEF7
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jul 2008 09:12:54 +1000 (EST)
In-Reply-To: <486E26C0.9060604@genesi-usa.com>
References: <40B88BFD-1FEB-4E36-9917-54C7380FF801@kernel.crashing.org>
	<20080703185312.GA6043@polina.dev.rtsoft.ru>
	<486E26C0.9060604@genesi-usa.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Message-Id: <e88aa775e8f6dcc85f1e4b9c3ca28fdd@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: New fsl device bindings file
Date: Sat, 5 Jul 2008 01:12:31 +0200
To: Matt Sealey <matt@genesi-usa.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> 	/* deprecated; */
>> 	device_type =3D "i2c";
>
> How about "deprecated but kept for compatibility with true Open=20
> Firmware
> implementations"?

Well, except a flat tree isn't compatible with OF at all here.
A "device_type" promises a certain interface; a flat tree doesn't
even have the "open" method.  =46rom the OF base spec:

	=93device_type=94 S

	Standard property name to specify the implemented interface.

	prop-encoded-array: Text string encoded with encode-string.

	Specifies the =93device type=94 of this package, thus implying a
	specific set of package class methods implemented by this
	package.

> Seriously, you can't have a binding for "OF" and then cut out that=20
> part of the
> standard at a whim.

Nothing is cut out.  There never was a device binding for device_type
i2c; creating one would be a considerable effort, and since flat tree
users wouldn't use it anyway, you can't be seriously suggesting they
should do this.

> It should be there (at least for those parts which are
> governed by a client interface API, like display, serial etc.

Huh?  Nothing in the client interface mentions display or serial
as far as I know.

> but cutting it off takes away all it's meaning,

So what?  There _is_ no "real" device interface, when a flat tree is
used.

> plus Linux implementations STILL keep searching
> that property along with "compatible",

That's a bug.


Segher
