Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-quonix.sasl.smtp.pobox.com
	[208.72.237.25]) by ozlabs.org (Postfix) with ESMTP id 4A347DDEED
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 14:56:00 +1000 (EST)
Date: Mon, 14 Jul 2008 23:55:51 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [PATCH] kill useless SMT code in prom_hold_cpus
Message-ID: <20080715045551.GV9594@localdomain>
References: <20080708223631.GP9594@localdomain>
	<20080715022202.GD20457@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080715022202.GD20457@bakeyournoodle.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tony Breeds wrote:
> On Tue, Jul 08, 2008 at 05:36:31PM -0500, Nathan Lynch wrote:
> 
> > -			prom_printf("%x : starting cpu hw idx %x... ", cpuid, reg);
> > +			prom_printf("starting cpu hw idx %x... ", reg);
> 
> If we remove this, where else can we see the mapping of hardware IDs
> to logical cpu IDs?  This is useful on POWER4 (at least where they can be
> different).

sysfs.  (e.g. /sys/devices/system/cpu/cpu0/physical_id)

> > -	if (cpuid > NR_CPUS)
> > -		prom_printf("WARNING: maximum CPUs (" __stringify(NR_CPUS)
> > -			    ") exceeded: ignoring extras\n");
> > -
> 
> I think this printf() is valuable, if your boot a 128 thread machine on
> a kernel with NR_CPUS=64, this is the only messaage you get to indicate
> that you're wasting 64 threads, and how to resolve it.

The proper place for such a message is in the kernel's smp bringup
code later on, and/or the code that initializes the various cpu maps.
The prom_init code should not really be concerned with the kernel's
NR_CPUS configuration or mapping of logical to physical ids.
