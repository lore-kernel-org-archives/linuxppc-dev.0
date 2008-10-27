Return-Path: <neko@genesi-usa.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.25])
	by ozlabs.org (Postfix) with ESMTP id 662C5DDDE7
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 04:05:08 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so1666018qwb.15
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Oct 2008 10:05:04 -0700 (PDT)
Message-ID: <4905F4C4.4000309@genesi-usa.com>
Date: Mon, 27 Oct 2008 12:05:08 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: GPIO - marking individual pins (not) available in device tree
References: <4900ED81.3040202@genesi-usa.com>
	<4900F90B.80703@firmworks.com>	<4901032F.3090805@genesi-usa.com>
	<49011C42.2020101@firmworks.com>	<49024646.3050300@genesi-usa.com>
	<49025DE0.6070403@firmworks.com>	<4904DD76.7070706@genesi-usa.com>	<20081026235303.GE22339@yookeroo.seuss>
	<4905E857.6040206@genesi-usa.com> <4905EDBE.8020105@freescale.com>
In-Reply-To: <4905EDBE.8020105@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: Mitch Bradley <wmb@firmworks.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Scott Wood wrote:
> Matt Sealey wrote:
> 
> Nobody is saying that device_type should not be used in real OF when an 
> appropriate method interface exists.  What we're saying is that flat 
> device trees, which are incapable of providing a method interface, 
> should not lie and claim that they have one.
> 
> As for "ANY firmware environment", I'd suggest that any new method 
> interfaces, where backwards compatibility isn't an issue, use some 
> relevant compatible rather than device_type, so that multiple supported 
> interfaces can be listed.  What do you have against vendor namespaces 
> (don't make the device binding guess which firmware type it's on) and 
> multiple interfaces per node?

I say ANY firmware environment because at the end of the day what methods
the OF implements, or even if the firmware (like a U-Boot modification)
"lies" about it being device_type serial or device_type network, Linux
completely f**ks over the client interface at the first opportunity it
gets and does not call ANY appreciable method anyway.

So, it is not a lie to say it's a certain device_type, and I really
do focus here on the between-the-lines reading of the OF spec where
devices which ARE useful for booting, console and probing (for instance
marking detected disks as "block", ethernet as "network", serial
consoles as "serial" and displays and keyboards are present in the
tree if they are present on the machine) is more relevant here than
the Open Firmware client interface methods which Linux is steadfastly
resolved never to use anyway.

Other operating systems might be a little less pleased about the lack
of methods but we've been pushing them to ignore the CI for a long,
long time as it causes way too many problems with differences in MMU
mapping (even in virtual-mode) when booting the system, to try and
access a disk through the client interface or use a polled ethernet
driver which has to go through an egregious context switch to load
significant amounts of data.

So let's just take the basic premise of the device_type and not the
literal truth of it (hey, the world wasn't created in 7 days
after all, who'd have thunk?) and use it to the advantage of the
Linux kernel instead of ditching it as legacy.

> Define "they", "used", and "firmware environment".  Obviously u-boot may 
> use the serial port for its console, but there's no method interface 
> defined by the device tree, nor is there any firmware resident at all 
> after starting the kernel.

However it is a serial port, and when it boots it says "input: serial"
and "output: serial" - or it could be netconsole or so. Or even screen
and keyboard! These are put into /chosen/stdin and /chosen/stdout when
the system is booted with the device tree.

Should a platform be extremely specific and check compatible properties
for every kind of serial port it could ever support (including PCI, ISA/LPC,
and otherwise connected GPIO implementations or crazy designs) just so
that it can carry over the firmware choices reported in the device tree
to the booting system, or should it simply be looking for those generic
device classes?

A simple way to check what is in use and what basic sort of peripheral it
is, without knowing the ultimate specifics of the device (since you would
not be in a driver, early_init is too early of course in the examples, but
I could probably think of a bunch of othe reasons you'd want to check some
of the /chosen nodes or make a quick check if the device was purposed by
the firmware for some reason)

> It fixes three primary concerns:
> 
> 1. The 1275 documentation is scattered in many places, some of which are 
> not easily accessible to the general public (just look at the i2c mess).

To be honest I didn't know i2c had ever been defined at all, so I see
your point there.

> 2. 1275 did not appear to be actively maintained and updated.

But, it did not suddenly break in the last 14 years, did it?

This simply exposes the endemic problem of Linux developers subscribing
to the Not Invented Here philosophy and making subtle yet intrusive
changes to suit themselves and brighten their name in lights while, in
the end, ignoring their own statements to whit the benefits and reasons
why they wanted to change something.

I am still kind of sore that the policy swung from "the firmware is
responsible" to "we will accept any crazy patch for prom_init.c which
will fix up a device even though there is an easy way to fix it from
the firmware side and not clutter Linux, and even though the patch
doesn't ACTUALLY work" and many other 180's in the history of the
device tree specifications and the support Linux implements.

ePAPR doesn't resolve a single thing we didn't already know, and
considering it was written by the IBM and Freescale engineers who
implemented and maintain the support and the firmware.. I wonder
how much thought went into it besides how to format it as a PDF.
Don't get me started on how useless and ineffectual Power.org
technical subcommittees are.. there is no reason why PAPR and
ePAPR couldn't have been the same specification. When you start
thinking about U-Boot with RTAS or the IBM Hypervisor this is
going to kick you in the backside.

> 3. It standardized the flattened device tree interface, which did not 
> exist in 1275.

This is about all it did but it is not like we've not been using
flattened device trees for the past 2 or so years *anyway*. They did
always work. The real sore points here are device bindings and
a grand total of nothing changed between OF and now with that.

The assertion in ePAPR that device_type is deprecated and ignored
because ePAPR doesn't support FCode is naive at best.

To be honest I've lost the will to actually contribute to the
discussion because it's just reminding me of why we got a refund
from Power.org and why we stopped submitting patches to mainline.

Thanks for your input, Mitch, at least. It was very helpful.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
