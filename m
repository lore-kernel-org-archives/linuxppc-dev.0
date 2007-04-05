Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 5876EDDEDA
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Apr 2007 06:08:09 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Questions about porting perfmon2 to powerpc
Date: Thu, 5 Apr 2007 22:08:00 +0200
References: <200704051455.34600.kevcorry@us.ibm.com>
In-Reply-To: <200704051455.34600.kevcorry@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704052208.01753.arnd@arndb.de>
Cc: Carl Love <carll@us.ibm.com>, Kevin Corry <kevcorry@us.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 05 April 2007, Kevin Corry wrote:

> First, the stock 2.6.20 kernel has a prototype in include/linux/smp.h for a 
> function called smp_call_function_single(). However, this routine is only 
> implemented on i386, x86_64, ia64, and mips. Perfmon2 apparently needs to 
> call this to run a function on a specific CPU. Powerpc provides an 
> smp_call_function() routine to run a function on all active CPUs, so I used 
> that as a basis to add an smp_call_function_single() routine. I've included 
> the patch below and was wondering if it looked like a sane approach.

The function itself looks good, but since it's very similar to the existing
smp_call_function(), you should probably try to share some of the code,
e.g. by making a helper function that gets an argument to decide whether
to run on a specific CPU or on all CPUs.

> Next, we ran into a problem related to Perfmon2 initialization and sysfs. The 
> problem turned out to be that the powerpc version of topology_init() is 
> defined as an __initcall() routine, but Perfmon2's initialization is done as 
> a subsys_initcall() routine. Thus, Perfmon2 tries to initialize its sysfs 
> information before some of the powerpc cpu information has been initialized. 
> However, on all other architectures, topology_init() is defined as a 
> subsys_initcall() routine, so this problem was not seen on any other 
> platforms. Changing the powerpc version of topology_init() to a 
> subsys_initcall() seems to have fixed the bug. However, I'm not sure if that 
> is going to cause problems elsewhere in the powerpc code. I've included the 
> patch below (after the smp-call-function-single patch). Does anyone know if 
> this change is safe, or if there was a specific reason that topology_init() 
> was left as an __initcall() on powerpc?

In general, it's better to do initcalls as late as possible, so __initcall()
is preferred over subsys_initcall() if both work. Have you tried doing it
the other way and starting perfmon2 from a regular __initcall()?

	Arnd <><
