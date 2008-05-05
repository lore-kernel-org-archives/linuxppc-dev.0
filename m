Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6C02EDDDF5
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 09:37:01 +1000 (EST)
Subject: Re: [PATCH] Sam440ep support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Giuseppe Coviello <cjg@cruxppc.org>
In-Reply-To: <a265241c0805051123h595123edrd46bf65a8099c3c2@mail.gmail.com>
References: <a265241c0805051123h595123edrd46bf65a8099c3c2@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 06 May 2008 09:36:48 +1000
Message-Id: <1210030608.21644.114.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I wonder about the way this is split between the platform file and this
"sysdev" file.

The platform file is so small (and similar to other platform files) that
I wonder if we can move toward something aking to the 5200 simple
platform, that is have one platform with a list of matches.

Now, the sysdev file I'm not so happy about. sysdev isn't supposed to
contain board code, it's supposed to contain drivers for low level
system devices such as interrupt controllers, PCI bridges, etc... that
are shared by multiple platforms.

The code in there definitely looks like it should be done differently
too.

The IBM IIC driver should already have an of_platform_device created for
it, so we can have here a generic driver for that chip that instanciates
itself based on it. No need to create a platform device .. Or is the ibm
iic host driver only in the form of a platform device nowadays ?

That can be a problem as we end up with basically 2 devices for the same
device node... Why wouldn't ibm iic be an of platform driver ? If it's
for arch/ppc compatibility, we don't care..

You can then expose all i2c devices underneath it with generic code too
too no ? I haven't followed the discussion about i2c bindings but it
looks like you should be able to have some generic code that instanciate
all i2c devices in the device tree based on nodes under a given
controller...

Ben.
