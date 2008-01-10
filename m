Return-Path: <strosake@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D8D34DE027
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 08:46:48 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0ALkjkS025701
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 16:46:45 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0ALkilF078182
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 14:46:44 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0ALkiMZ027081
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 14:46:44 -0700
Message-ID: <4786923E.9090902@austin.ibm.com>
Date: Thu, 10 Jan 2008 15:46:38 -0600
From: Mike Strosaker <strosake@austin.ibm.com>
MIME-Version: 1.0
To: linasvepstas@gmail.com
Subject: Re: [PATCH 1/8] pseries: phyp dump: Docmentation
References: <4782B985.2090508@austin.ibm.com>
	<4782C026.8080302@austin.ibm.com>	<20080109042911.GT14201@localdomain>	<3ae3aa420801090731r2e25e42awcae385b448e20b16@mail.gmail.com>	<20080109184437.GU14201@localdomain>	<3ae3aa420801091833i6cf32616o2a060579be1f3191@mail.gmail.com>	<20080110031723.GA22168@lixom.net>	<3ae3aa420801092012m5e47cbd7lc7a5f91842074af7@mail.gmail.com>	<20080110162120.GA4831@lixom.net>
	<3ae3aa420801100834r6bd2750eqa7c8d29877350463@mail.gmail.com>
In-Reply-To: <3ae3aa420801100834r6bd2750eqa7c8d29877350463@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, lkessler@us.ibm.com, mahuja@us.ibm.com,
	Nathan Lynch <ntl@pobox.com>, Olof Johansson <olof@lixom.net>,
	strosake@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linas Vepstas wrote:
> On 10/01/2008, Olof Johansson <olof@lixom.net> wrote:
> 
>>On Wed, Jan 09, 2008 at 10:12:13PM -0600, Linas Vepstas wrote:
>>
>>>On 09/01/2008, Olof Johansson <olof@lixom.net> wrote:
>>>
>>>>On Wed, Jan 09, 2008 at 08:33:53PM -0600, Linas Vepstas wrote:
>>>>
>>>>
>>>>>Heh. That's the elbow-grease of this thing.  The easy part is to get
>>>>>the core function working. The hard part is to test these various configs,
>>>>>and when they don't work, figure out what went wrong. That will take
>>>>>perseverence and brains.
>>>>
>>>>This just sounds like a whole lot of extra work to get a feature that
>>>>already exists.
>>>
>>>Well, no. kexec is horribly ill-behaved with respect to PCI. The
>>>kexec kernel starts running with PCI devices in some random
>>>state; maybe they're DMA'ing or who knows what. kexec tries
>>>real hard to whack a few needed pci devices into submission
>>>but it has been hit-n-miss, and the source of 90% of the kexec
>>>headaches and debugging effort. Its not pretty.
>>
>>It surprises me that this hasn't been possible to resolve with less than
>>architecting a completely new interface, given that the platform has
>>all this fancy support for isolating and resetting adapters. After all,
>>the exact same thing has to be done by the hypervisor before rebooting
>>the partition.
> 
> 
> OK, point taken.
> 
> -- The phyp interfaces are there for AIX, which I guess must
>    not have kexec-like ability. So this is a case of Linux leveraging
>   a feature architected for AIX.

Certainly AIX was in a more difficult position at the time, because they don't 
have a kexec equivalent, and thus were collecting dump data with a potentially 
faulty kernel.  It makes sense to have something outside the partition collect or 
maintain the data; ideally, some kind of service partition would extract dump 
data from a failed partition, but giving one partition total access to the memory 
of another is clearly risky.  Both the PHYP-assistance method and the kexec 
method are ways to simulate that without the risk.

At the risk of repeating what others have already said, the PHYP-assistance 
method provides some advantages that the kexec method cannot:
  - Availability of the system for production use before the dump data is 
collected.  As was mentioned before, some production systems may choose not to 
operate with the limited memory initially available after the reboot, but it sure 
is nice to provide the option.
  - Ensuring that the devices are in a good state.  PHYP doesn't expose a method 
to force adapters into a frozen state, (which I agree would be useful), and I 
don't know of any plans to do so.  What we are starting to see is that some 
drivers need modifications in order to work correctly with kdump [1].  Supporting 
PHYP-assisted dump would eliminate those issues.
  - The small possibility that the kexec area could have been munged by the 
failing kernel, preventing it from being able to collect a dump.

The NUMA issues are daunting, but not insurmountable.  Release early, release 
often, n'est-ce pas?

Mike

[1] http://ozlabs.org/pipermail/linuxppc-dev/2007-November/045663.html
