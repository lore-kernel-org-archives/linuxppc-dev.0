Return-Path: <kevcorry@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 36327DDE3C
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Apr 2007 12:44:20 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l362iGdL001718
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Apr 2007 22:44:16 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l362iGD1157882
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Apr 2007 20:44:16 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l362iGg6023977
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Apr 2007 20:44:16 -0600
From: Kevin Corry <kevcorry@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: Re: Questions about porting perfmon2 to powerpc
Date: Thu, 5 Apr 2007 21:44:10 -0500
References: <200704051455.34600.kevcorry@us.ibm.com>
	<1175814243.30879.146.camel@localhost.localdomain>
In-Reply-To: <1175814243.30879.146.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704052144.10257.kevcorry@us.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Carl Love <carll@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu April 5 2007 6:04 pm, Benjamin Herrenschmidt wrote:
> On Thu, 2007-04-05 at 14:55 -0500, Kevin Corry wrote:
> > First, the stock 2.6.20 kernel has a prototype in include/linux/smp.h for
> > a function called smp_call_function_single(). However, this routine is
> > only implemented on i386, x86_64, ia64, and mips. Perfmon2 apparently
> > needs to call this to run a function on a specific CPU. Powerpc provides
> > an smp_call_function() routine to run a function on all active CPUs, so I
> > used that as a basis to add an smp_call_function_single() routine. I've
> > included the patch below and was wondering if it looked like a sane
> > approach.
>
> We should do better... it will require some backend work for the various
> supported PICs though. I've always wanted to look into doing a 
> smp_call_function_cpumask in fact :-)

I was actually wondering about that myself today. It would seem like an 
smp_call_function() that takes a CPU mask would be much more flexible than 
either the current version or the new one that I proposed. However, that was 
a little more hacking that I was willing to do today on powerpc architecture 
code. :)

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
> It would make sense to follow what other archs do. Note that if both
> perfmon and topology_init are subsys_initcall, that is on the same
> level, it's still a bit hairy to expect one to be called before the
> other...

I wondered that as well, but based on what Arnd posted earlier (presumably 
about the kernel linking order), the topology_init() call, which is in the 
arch/ top-level directory, should occur before pfm_init(), which is in 
perfmon/, even if both are in the same initcall level.

Thanks,
-- 
Kevin Corry
kevcorry@us.ibm.com
http://www.ibm.com/linux/
