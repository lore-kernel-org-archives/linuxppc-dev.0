Return-Path: <scottwood@freescale.com>
Message-ID: <4905F97B.60705@freescale.com>
Date: Mon, 27 Oct 2008 12:25:15 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: GPIO - marking individual pins (not) available in device tree
References: <4900ED81.3040202@genesi-usa.com>
	<4900F90B.80703@firmworks.com>	<4901032F.3090805@genesi-usa.com>
	<49011C42.2020101@firmworks.com>	<49024646.3050300@genesi-usa.com>
	<49025DE0.6070403@firmworks.com>	<4904DD76.7070706@genesi-usa.com>	<20081026235303.GE22339@yookeroo.seuss>
	<4905E857.6040206@genesi-usa.com> <4905EDBE.8020105@freescale.com>
	<4905F4C4.4000309@genesi-usa.com>
In-Reply-To: <4905F4C4.4000309@genesi-usa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Matt Sealey wrote:
> I say ANY firmware environment because at the end
> of the day what methods the OF implements, or even if the firmware
> (like a U-Boot modification) "lies" about it being device_type serial
> or device_type network, Linux completely f**ks over the client
> interface at the first opportunity it gets and does not call ANY
> appreciable method anyway.

That's Linux's choice; what does that have to do with how the firmware
expresses the functionality it provides?

> So, it is not a lie to say it's a certain device_type,

It's not a lie because Linux doesn't care that it's a lie?

> and I really do focus here on the between-the-lines reading of the OF
> spec where devices which ARE useful for booting, console and probing
> (for instance marking detected disks as "block", ethernet as
> "network", serial consoles as "serial" and displays and keyboards are
> present in the tree if they are present on the machine) is more
> relevant here than the Open Firmware client interface methods which
> Linux is steadfastly resolved never to use anyway.

If you're not going to use the method interface, then what *do* you use 
device_type for?

> So let's just take the basic premise of the device_type and not the 
> literal truth of it (hey, the world wasn't created in 7 days after
> all, who'd have thunk?) and use it to the advantage of the Linux
> kernel instead of ditching it as legacy.

What advantage would that be?

>> Define "they", "used", and "firmware environment".  Obviously
>> u-boot may use the serial port for its console, but there's no
>> method interface defined by the device tree, nor is there any
>> firmware resident at all after starting the kernel.
> 
> However it is a serial port, and when it boots it says "input:
> serial" and "output: serial" - or it could be netconsole or so. Or
> even screen and keyboard! These are put into /chosen/stdin and
> /chosen/stdout when the system is booted with the device tree.

And how, exactly, do /chosen/stdin and /chosen/stdout depend on device_type?

> Should a platform be extremely specific and check compatible
> properties for every kind of serial port it could ever support

Of course it should check compatible -- how else would it know how to 
drive the thing?

> (including PCI, ISA/LPC, and otherwise connected GPIO implementations
> or crazy designs) just so that it can carry over the firmware choices
> reported in the device tree to the booting system, or should it
> simply be looking for those generic device classes?

And what do you propose it do with a generic "serial" in the absence of 
a method interface?  Just assume it's ns16550?

> A simple way to check what is in use and what basic sort of
> peripheral it is, without knowing the ultimate specifics of the
> device (since you would not be in a driver, early_init is too early
> of course in the examples, but I could probably think of a bunch of
> othe reasons you'd want to check some of the /chosen nodes or make a
> quick check if the device was purposed by the firmware for some
> reason)

-EPARSE

>> 2. 1275 did not appear to be actively maintained and updated.
> 
> But, it did not suddenly break in the last 14 years, did it?

New hardware came along that is not described.  Details that fall out of 
the use of flat trees are not addressed (no ihandles, phandles as 
properties, etc).

> ePAPR doesn't resolve a single thing we didn't already know,

The primary intent was to codify existing practice.

> Don't
> get me started on how useless and ineffectual Power.org technical
> subcommittees are.. there is no reason why PAPR and ePAPR couldn't
> have been the same specification. When you start thinking about
> U-Boot with RTAS or the IBM Hypervisor this is going to kick you in
> the backside.

Agreed; that's more of a political issue than a technical one.

>> 3. It standardized the flattened device tree interface, which did
>> not exist in 1275.
> 
> This is about all it did but it is not like we've not been using 
> flattened device trees for the past 2 or so years *anyway*.

...in Linux and u-boot.  ePAPR gives us a self-contained document that 
we can point other firmware and OS developers to.

> They did 
> always work. The real sore points here are device bindings and a
> grand total of nothing changed between OF and now with that.
> 
> The assertion in ePAPR that device_type is deprecated and ignored 
> because ePAPR doesn't support FCode is naive at best.

It's deprecated *in the context of flat device trees*.  Anything not 
using flat device trees is out-of-scope with respect to ePAPR.

-Scott
