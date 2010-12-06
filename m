Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A6C4BB70AF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  7 Dec 2010 01:44:47 +1100 (EST)
Received: from lpsc0174x.localnet (lpsc0174x.in2p3.fr [134.158.40.174])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with ESMTP id
	oB6EielX007722
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Dec 2010 15:44:40 +0100
From: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Getting the IRQ number (Was: Basic driver devel questions ?)
Date: Mon, 6 Dec 2010 15:44:39 +0100
References: <201012011115.00960.dargaud@lpsc.in2p3.fr>
	<201012061058.37612.dargaud@lpsc.in2p3.fr>
	<1291637228.21242.14.camel@concordia>
In-Reply-To: <1291637228.21242.14.camel@concordia>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201012061544.40124.dargaud@lpsc.in2p3.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello all,

> OK, that should be all pretty straight forward, and covered by the
> material in LDD and similar references. You just need to get your device
> probed.

I'm not sure what you mean with that term: simply identifying that the device 
works using device specific code ?
I've looked at several *_probe functions from other drivers and they are all 
completely different with no common code...

Or do you mean calling of_platform_bus_probe() ? What does that function do ?

> No it's just that platform_drivers are now able to do all the things an
> of_platform_driver can do, so new code should just use platform_driver.
> 
> I'm not sure if of_platform_bus_probe() will go away eventually, but for
> now it is the only way to achieve what you need.

I assume the kernel needs to be compiled with CONFIG_OF.
...hmm I had to "git pull" in order for this to compile your snippet. That's 
really recent! Unfortunately i need to reflash my device with the new kernel 
before i can begin testing my module.

When I try to compile your (adapted) snippet, I got this minor problems:

  .probe = foo_driver_probe,
^ warning: initialization from incompatible pointer type
Shouldn't foo_driver_probe be:
static int foo_driver_probe(struct platform_device *pdev)
instead of:
static int foo_driver_probe(struct platform_device *device,
                            const struct of_device_id *device_id)


Also:
       struct foo_device *foo;
That's where I put my own content, right ?
And needs to be kfreed in a foo_driver_remove() function, right ?

> > I still need a platform_device_register() after your sample init, right ?
> 
> I had one in there already, in foo_driver_init(), didn't I?

You had platform_driver_register(), not that I'm all clear yet on the 
distinction...


Another question: I just spent 10 minutes trying to find where "struct device" 
was defined. (ack-)grep was absolutely no use. Isn't there a way to cross-
reference my own kernel, the way I've compiled it ?
-- 
Guillaume Dargaud
http://www.gdargaud.net/Climbing/
