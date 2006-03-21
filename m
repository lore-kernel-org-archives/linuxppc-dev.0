Return-Path: <nathanl@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 98A8B67A2E
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Mar 2006 06:20:21 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e31.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2LJKIpv010571
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Mar 2006 14:20:18 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2LJHIPM263386
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Mar 2006 12:17:18 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k2LJKIp5008377
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Mar 2006 12:20:18 -0700
Subject: Re: [PATCH 7/7] powerpc numa: Consolidate assignment of cpus to nodes
From: Nathan Lynch <nathanl@austin.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <1142966317.10906.172.camel@localhost.localdomain>
References: <11429014352189-git-send-email-nathanl@austin.ibm.com>
	<1142966317.10906.172.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 13:16:11 -0600
Message-Id: <1142968571.27114.28.camel@pants.austin.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-03-21 at 10:38 -0800, Dave Hansen wrote:
> On Mon, 2006-03-20 at 18:37 -0600, Nathan Lynch wrote:
> > +       cpu_numa_callback(&ppc64_numa_nb, CPU_UP_PREPARE,
> > +                         (void *)(unsigned long)boot_cpuid); 
> 
> That double-cast really caught my eye.  cpu_numa_callback() looks a
> little bit confused about what type cpuids should be.
> 
> Its lcpu is an "unsigned long", but it has integers passed into it
> (boot_cpuid), and calls map_cpu_to_node(lcpu, 0), where the first
> argument is an integer, but an "unsigned long" is passed in.  This may
> be harmless, but I still have to think about it, which is bad.
> 
> Seems like just making cpu_numa_callback()'s lcpu an int would get rid
> of at least one net cast.  Why not just pass &boot_cpuid in there, and
> do this:
> 
> 	int lcpu = *(int *)hcpu;

That's not the convention for cpu hotplug notifiers.  The id of the cpu
subject to online/offline is passed in the void * argument.  I'd have to
change the cpu hotplug core and every notifier in the kernel to
implement your suggestion.

> 
> That makes it _really_ obvious what is going on.  While it isn't
> horribly uncommon to pass integers around inside of void*s, it can be a
> bit confusing.  You also get readability issues with long<->int
> conversions as you saw.
> 
> By the way, what do the "l" and "h" in front of "cpu" mean anyway?

"logical" and "hot"?  I dunno, just seemed to be the convention in other
cpu notifiers at the time the code was written.
