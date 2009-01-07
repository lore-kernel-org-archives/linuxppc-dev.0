Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 5CFEC474C2
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 05:48:30 +1100 (EST)
Date: Wed, 7 Jan 2009 12:48:23 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH/RFC] sysfs cache code rewrite
Message-ID: <20090107184823.GE7376@localdomain>
References: <20081224045554.GA6958@localdomain>
	<20090106212533.GB7376@localdomain> <1231311102.14860.80.camel@pasglop>
	<1231311324.14860.81.camel@pasglop> <20090107094611.GD7376@localdomain>
	<1231323344.14860.87.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1231323344.14860.87.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Wed, 2009-01-07 at 03:46 -0600, Nathan Lynch wrote:
> > Benjamin Herrenschmidt wrote:
> > > 
> > > > I don't know quite the detail of the new cpumask stuff ... It could be
> > > > as simple as passing a pointer instead of the value in the
> > > > cpumask_scnprintf call though...
> > > 
> > > Actually, I'll do more tests and if that ends up being the only needed
> > > change, I'll push your patch with that small change out to powerpc next
> > > tonight.
> > 
> > Sorry about that, here's an incremental... let me know if you want the
> > whole thing re-posted.
> 
> Nah, that's fine. I did that exact change in the patch before putting
> in my tree. I haven't had a chance to test boot tho, did you ?

I have now, on Power6, with latest Linus -git snapshot; comes up fine
and the shared_cpu_map attrs display as expected.  This one is in
shared processor mode so we only have L1 information:

# uname -r
2.6.28-git9-autokern1
# grep -r . /sys/devices/system/cpu/cpu*/cache
/sys/devices/system/cpu/cpu0/cache/index0/type:Data
/sys/devices/system/cpu/cpu0/cache/index0/level:1
/sys/devices/system/cpu/cpu0/cache/index0/shared_cpu_map:00000000,00000000,00000000,00000003
/sys/devices/system/cpu/cpu0/cache/index0/size:64K
/sys/devices/system/cpu/cpu0/cache/index0/coherency_line_size:128
/sys/devices/system/cpu/cpu0/cache/index0/number_of_sets:128
/sys/devices/system/cpu/cpu0/cache/index0/ways_of_associativity:4
/sys/devices/system/cpu/cpu0/cache/index1/type:Instruction
/sys/devices/system/cpu/cpu0/cache/index1/level:1
/sys/devices/system/cpu/cpu0/cache/index1/shared_cpu_map:00000000,00000000,00000000,00000003
/sys/devices/system/cpu/cpu0/cache/index1/size:64K
/sys/devices/system/cpu/cpu0/cache/index1/coherency_line_size:128
/sys/devices/system/cpu/cpu0/cache/index1/number_of_sets:128
/sys/devices/system/cpu/cpu0/cache/index1/ways_of_associativity:4
/sys/devices/system/cpu/cpu1/cache/index0/type:Data
/sys/devices/system/cpu/cpu1/cache/index0/level:1
/sys/devices/system/cpu/cpu1/cache/index0/shared_cpu_map:00000000,00000000,00000000,00000003
/sys/devices/system/cpu/cpu1/cache/index0/size:64K
/sys/devices/system/cpu/cpu1/cache/index0/coherency_line_size:128
/sys/devices/system/cpu/cpu1/cache/index0/number_of_sets:128
/sys/devices/system/cpu/cpu1/cache/index0/ways_of_associativity:4
/sys/devices/system/cpu/cpu1/cache/index1/type:Instruction
/sys/devices/system/cpu/cpu1/cache/index1/level:1
/sys/devices/system/cpu/cpu1/cache/index1/shared_cpu_map:00000000,00000000,00000000,00000003
/sys/devices/system/cpu/cpu1/cache/index1/size:64K
/sys/devices/system/cpu/cpu1/cache/index1/coherency_line_size:128
/sys/devices/system/cpu/cpu1/cache/index1/number_of_sets:128
/sys/devices/system/cpu/cpu1/cache/index1/ways_of_associativity:4
/sys/devices/system/cpu/cpu2/cache/index0/type:Data
/sys/devices/system/cpu/cpu2/cache/index0/level:1
/sys/devices/system/cpu/cpu2/cache/index0/shared_cpu_map:00000000,00000000,00000000,0000000c
/sys/devices/system/cpu/cpu2/cache/index0/size:64K
/sys/devices/system/cpu/cpu2/cache/index0/coherency_line_size:128
/sys/devices/system/cpu/cpu2/cache/index0/number_of_sets:128
/sys/devices/system/cpu/cpu2/cache/index0/ways_of_associativity:4
/sys/devices/system/cpu/cpu2/cache/index1/type:Instruction
/sys/devices/system/cpu/cpu2/cache/index1/level:1
/sys/devices/system/cpu/cpu2/cache/index1/shared_cpu_map:00000000,00000000,00000000,0000000c
/sys/devices/system/cpu/cpu2/cache/index1/size:64K
/sys/devices/system/cpu/cpu2/cache/index1/coherency_line_size:128
/sys/devices/system/cpu/cpu2/cache/index1/number_of_sets:128
/sys/devices/system/cpu/cpu2/cache/index1/ways_of_associativity:4
/sys/devices/system/cpu/cpu3/cache/index0/type:Data
/sys/devices/system/cpu/cpu3/cache/index0/level:1
/sys/devices/system/cpu/cpu3/cache/index0/shared_cpu_map:00000000,00000000,00000000,0000000c
/sys/devices/system/cpu/cpu3/cache/index0/size:64K
/sys/devices/system/cpu/cpu3/cache/index0/coherency_line_size:128
/sys/devices/system/cpu/cpu3/cache/index0/number_of_sets:128
/sys/devices/system/cpu/cpu3/cache/index0/ways_of_associativity:4
/sys/devices/system/cpu/cpu3/cache/index1/type:Instruction
/sys/devices/system/cpu/cpu3/cache/index1/level:1
/sys/devices/system/cpu/cpu3/cache/index1/shared_cpu_map:00000000,00000000,00000000,0000000c
/sys/devices/system/cpu/cpu3/cache/index1/size:64K
/sys/devices/system/cpu/cpu3/cache/index1/coherency_line_size:128
/sys/devices/system/cpu/cpu3/cache/index1/number_of_sets:128
/sys/devices/system/cpu/cpu3/cache/index1/ways_of_associativity:4
/sys/devices/system/cpu/cpu4/cache/index0/type:Data
/sys/devices/system/cpu/cpu4/cache/index0/level:1
/sys/devices/system/cpu/cpu4/cache/index0/shared_cpu_map:00000000,00000000,00000000,00000030
/sys/devices/system/cpu/cpu4/cache/index0/size:64K
/sys/devices/system/cpu/cpu4/cache/index0/coherency_line_size:128
/sys/devices/system/cpu/cpu4/cache/index0/number_of_sets:128
/sys/devices/system/cpu/cpu4/cache/index0/ways_of_associativity:4
/sys/devices/system/cpu/cpu4/cache/index1/type:Instruction
/sys/devices/system/cpu/cpu4/cache/index1/level:1
/sys/devices/system/cpu/cpu4/cache/index1/shared_cpu_map:00000000,00000000,00000000,00000030
/sys/devices/system/cpu/cpu4/cache/index1/size:64K
/sys/devices/system/cpu/cpu4/cache/index1/coherency_line_size:128
/sys/devices/system/cpu/cpu4/cache/index1/number_of_sets:128
/sys/devices/system/cpu/cpu4/cache/index1/ways_of_associativity:4
/sys/devices/system/cpu/cpu5/cache/index0/type:Data
/sys/devices/system/cpu/cpu5/cache/index0/level:1
/sys/devices/system/cpu/cpu5/cache/index0/shared_cpu_map:00000000,00000000,00000000,00000030
/sys/devices/system/cpu/cpu5/cache/index0/size:64K
/sys/devices/system/cpu/cpu5/cache/index0/coherency_line_size:128
/sys/devices/system/cpu/cpu5/cache/index0/number_of_sets:128
/sys/devices/system/cpu/cpu5/cache/index0/ways_of_associativity:4
/sys/devices/system/cpu/cpu5/cache/index1/type:Instruction
/sys/devices/system/cpu/cpu5/cache/index1/level:1
/sys/devices/system/cpu/cpu5/cache/index1/shared_cpu_map:00000000,00000000,00000000,00000030
/sys/devices/system/cpu/cpu5/cache/index1/size:64K
/sys/devices/system/cpu/cpu5/cache/index1/coherency_line_size:128
/sys/devices/system/cpu/cpu5/cache/index1/number_of_sets:128
/sys/devices/system/cpu/cpu5/cache/index1/ways_of_associativity:4
/sys/devices/system/cpu/cpu6/cache/index0/type:Data
/sys/devices/system/cpu/cpu6/cache/index0/level:1
/sys/devices/system/cpu/cpu6/cache/index0/shared_cpu_map:00000000,00000000,00000000,000000c0
/sys/devices/system/cpu/cpu6/cache/index0/size:64K
/sys/devices/system/cpu/cpu6/cache/index0/coherency_line_size:128
/sys/devices/system/cpu/cpu6/cache/index0/number_of_sets:128
/sys/devices/system/cpu/cpu6/cache/index0/ways_of_associativity:4
/sys/devices/system/cpu/cpu6/cache/index1/type:Instruction
/sys/devices/system/cpu/cpu6/cache/index1/level:1
/sys/devices/system/cpu/cpu6/cache/index1/shared_cpu_map:00000000,00000000,00000000,000000c0
/sys/devices/system/cpu/cpu6/cache/index1/size:64K
/sys/devices/system/cpu/cpu6/cache/index1/coherency_line_size:128
/sys/devices/system/cpu/cpu6/cache/index1/number_of_sets:128
/sys/devices/system/cpu/cpu6/cache/index1/ways_of_associativity:4
/sys/devices/system/cpu/cpu7/cache/index0/type:Data
/sys/devices/system/cpu/cpu7/cache/index0/level:1
/sys/devices/system/cpu/cpu7/cache/index0/shared_cpu_map:00000000,00000000,00000000,000000c0
/sys/devices/system/cpu/cpu7/cache/index0/size:64K
/sys/devices/system/cpu/cpu7/cache/index0/coherency_line_size:128
/sys/devices/system/cpu/cpu7/cache/index0/number_of_sets:128
/sys/devices/system/cpu/cpu7/cache/index0/ways_of_associativity:4
/sys/devices/system/cpu/cpu7/cache/index1/type:Instruction
/sys/devices/system/cpu/cpu7/cache/index1/level:1
/sys/devices/system/cpu/cpu7/cache/index1/shared_cpu_map:00000000,00000000,00000000,000000c0
/sys/devices/system/cpu/cpu7/cache/index1/size:64K
/sys/devices/system/cpu/cpu7/cache/index1/coherency_line_size:128
/sys/devices/system/cpu/cpu7/cache/index1/number_of_sets:128
/sys/devices/system/cpu/cpu7/cache/index1/ways_of_associativity:4
