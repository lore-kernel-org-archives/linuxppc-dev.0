Return-Path: <kevcorry@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 55926DDE39
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Apr 2007 06:32:19 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l35KWGEb009176
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Apr 2007 16:32:16 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l35KWGPY200244
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Apr 2007 14:32:16 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l35KWFgh019124
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Apr 2007 14:32:15 -0600
From: Kevin Corry <kevcorry@us.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org
Subject: Re: Questions about porting perfmon2 to powerpc
Date: Thu, 5 Apr 2007 15:32:07 -0500
References: <200704051455.34600.kevcorry@us.ibm.com>
	<200704052208.01753.arnd@arndb.de>
In-Reply-To: <200704052208.01753.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704051532.08775.kevcorry@us.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Carl Love <carll@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu April 5 2007 3:08 pm, Arnd Bergmann wrote:
> On Thursday 05 April 2007, Kevin Corry wrote:
> > First, the stock 2.6.20 kernel has a prototype in include/linux/smp.h for
> > a function called smp_call_function_single(). However, this routine is
> > only implemented on i386, x86_64, ia64, and mips. Perfmon2 apparently
> > needs to call this to run a function on a specific CPU. Powerpc provides
> > an smp_call_function() routine to run a function on all active CPUs, so I
> > used that as a basis to add an smp_call_function_single() routine. I've
> > included the patch below and was wondering if it looked like a sane
> > approach.
>
> The function itself looks good, but since it's very similar to the existing
> smp_call_function(), you should probably try to share some of the code,
> e.g. by making a helper function that gets an argument to decide whether
> to run on a specific CPU or on all CPUs.

Ok. I'll see what I can come up with and post another patch today or tomorrow.


> > Next, we ran into a problem related to Perfmon2 initialization and sysfs.
> > The problem turned out to be that the powerpc version of topology_init()
> > is defined as an __initcall() routine, but Perfmon2's initialization is
> > done as a subsys_initcall() routine. Thus, Perfmon2 tries to initialize
> > its sysfs information before some of the powerpc cpu information has been
> > initialized. However, on all other architectures, topology_init() is
> > defined as a subsys_initcall() routine, so this problem was not seen on
> > any other platforms. Changing the powerpc version of topology_init() to a
> > subsys_initcall() seems to have fixed the bug. However, I'm not sure if
> > that is going to cause problems elsewhere in the powerpc code. I've
> > included the patch below (after the smp-call-function-single patch). Does
> > anyone know if this change is safe, or if there was a specific reason
> > that topology_init() was left as an __initcall() on powerpc?
>
> In general, it's better to do initcalls as late as possible, so
> __initcall() is preferred over subsys_initcall() if both work. Have you
> tried doing it the other way and starting perfmon2 from a regular
> __initcall()?

For the moment, I made the change to topology_init() since it was the simplest 
fix to get things working. I have considered switching the perfmon2 
initialization to __initcall(), but there are apparently some timing issues 
with ensuring that the perfmon2 core code is initialized before any of its 
sub-modules. Since they could all be compiled statically in the kernel, I'm 
not sure if there's a way to ensure the ordering of calls within a single 
initcall level. I'll need to ask Stephane if there were any other reasons why 
subsys_initcall() was used for perfmon2.

Thanks, Arnd.
-- 
Kevin Corry
kevcorry@us.ibm.com
http://www.ibm.com/linux/
