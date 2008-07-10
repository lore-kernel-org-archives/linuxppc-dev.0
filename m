Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 507B8DDF3A
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 08:10:00 +1000 (EST)
In-Reply-To: <48768018.2070704@hhs.nl>
References: <for-27-patch1-0@bga.com> <48768018.2070704@hhs.nl>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <acca8e14e769b2feadee19f1f7448438@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [lm-sensors] [RFC] (almost) booting allyesconfig -- please don't
	poke super-io without request_region
Date: Thu, 10 Jul 2008 16:51:33 -0500
To: Hans de Goede <j.w.r.degoede@hhs.nl>
Cc: linuxppc-dev@ozlabs.org, Samuel Ortiz <samuel@sortiz.org>,
	linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 10, 2008, at 4:33 PM, Hans de Goede wrote:

> Milton Miller wrote:
>> After the following patch to mark the isa region busy and applying a 
>> few
>> patches[1], I was able to kexec boot into an all-yes-config kernel 
>> from linux-next, with the following KCONFIG_ALLCONFIG file:
...
>> While the first two might not be required, and the third is just
>> selecting the right platform, it would be nice to get the drivers
>> to play as well as the rest of the kernel.
>> The drivers all are for super-io chips, either irda/FIR drivers or 
>> hwmon,
>> and poke at isa ports without checking request_region.
>
> Erm,
>
> The superio sensor drivers only poke the superio chip registers 
> without request region during the probe phase, iow they try to detect 
> the chip, using a widely document and standardized (part of isa pnp 
> AFAIK) procedure on standardized ports.
>
> Let me try to explain a bit about superio chips, they have 2 superio 
> control registers (an index and data register) with which things like 
> a manufacturer and device id can be read, besides these id registers 
> they also have a set of registers with config for different logical 
> devices. Once the id is matched, the driver knows which logical device 
> config to read, reads a (different) isa base address + range from the 
> logical device config, and then does a request_region on the region 
> actually used by the logical device.
>
> The superio control registers are thus a sort of pci configuration 
> space if you want, doing a request_region on these is not such a good 
> idea, as multiple drivers (for different logical devices within the 
> superio device) may use these, so trying to gain exclusive access will 
> lead to troubles.
>
> I hope with this info about the problem space, that you maybe have a 
> suggestion on howto fix this?
>

My point is that they are probing without even knowing that a such a IO 
range exists.

These are the only drivers left in the tree that still do this.  (At 
least that are not
blocked on a powerpc allyesconfig for 64-bit, !CONFIG_VIRT_TO_BUS).

One could make a superio driver, and create sub-devices for the IR, 
I2C, floppy, parallel, etc
nodes.

I would even accept a check_region (horrors!), it would impove the 
situation.

But most other drivers do this by request_region, probe, then release 
the region afterwards.

Besides, one could argue the superio region should be requested while 
probing, to prevent other cpus from poking at the super io chip at the 
same time.   Think of it as missing locking.

milton
