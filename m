Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BE0391A000A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jul 2014 20:29:09 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Mon, 28 Jul 2014 15:59:04 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 653D5E0053
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jul 2014 16:00:46 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6SAT1jJ9699502
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jul 2014 15:59:01 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6SAT05K006089
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jul 2014 15:59:00 +0530
Date: Mon, 28 Jul 2014 15:58:58 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: Kernel crash caused by cpufreq
Message-ID: <20140728102858.GA8549@dirshya.in.ibm.com>
Reply-To: svaidy@linux.vnet.ibm.com
References: <20140725010757.GA19679@shangw>
 <1406530990.23799.8.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1406530990.23799.8.camel@concordia>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Michael Ellerman <mpe@ellerman.id.au> [2014-07-28 17:03:10]:

> On Fri, 2014-07-25 at 11:07 +1000, Gavin Shan wrote:
> > I'm tracing one LSI interrupt issue on P8 box, and eventually into the
> > following kernel crash. Not sure if there is one fix against this? :-)
> 
> Vaidy wrote that I'm pretty sure (on CC).

Yes, I did :)
 
> > Starting Linux PPC64 #401 SMP Fri Jul 25 10:52:28 EST 2014
> > -----------------------------------------------------
> > ppc64_pft_size                = 0x0
> > physicalMemorySize            = 0x800000000
> > htab_address                  = 0xc0000007fe000000
> > htab_hash_mask                = 0x3ffff
> > -----------------------------------------------------
> >  <- setup_system()
> > Initializing cgroup subsys cpuset
> > Initializing cgroup subsys cpuacct
> > Linux version 3.16.0-rc6-00076-g4226dbe-dirty (shangw@shangw) (gcc version 4.5.2 (crosstool-NG 1.19.0) ) #401 SMP Fri Jul 25 10:52:28 EST 2014
> > 	:
> > < Unrelated log stripped >
> 
> Are you sure there's nothing else in the log that might be related? See the
> messages in init_powernv_pstates() for example.

Most likely PMSR register is showing out of bound values because of
potential firmware (OPAL) issue.

> > ------------[ cut here ]------------
> > kernel BUG at drivers/cpufreq/powernv-cpufreq.c:134!
> > cpu 0x1: Vector: 700 (Program Check) at [c0000007f8483370]
> >     pc: c00000000096f32c: .pstate_id_to_freq+0x2c/0x50
> >     lr: c00000000096f37c: .powernv_read_cpu_freq+0x2c/0x50
> >     sp: c0000007f84835f0
> >    msr: 9000000000029032
> >   current = 0xc0000007f8400000
> >   paca    = 0xc00000000ff00400	 softe: 0	 irq_happened: 0x01
> >     pid   = 1, comm = swapper/0
> > kernel BUG at drivers/cpufreq/powernv-cpufreq.c:134!
> > enter ? for help
> > [link register   ] c00000000096f37c .powernv_read_cpu_freq+0x2c/0x50
> > [c0000007f84835f0] c000000001076070 key_type_dns_resolver+0xef20/0x40d20 (unreliable)
> > [c0000007f8483670] c00000000010812c .generic_exec_single+0x8c/0x270
> > [c0000007f8483730] c0000000001083d0 .smp_call_function_single+0x90/0xb0
> > [c0000007f84837b0] c000000000108cec .smp_call_function_any+0x15c/0x200
> > [c0000007f8483860] c00000000096f27c .powernv_cpufreq_get+0x3c/0x60
> > [c0000007f84838f0] c000000000969dc4 .__cpufreq_add_dev.clone.11+0x574/0xa20
> > [c0000007f84839e0] c0000000005f7a4c .subsys_interface_register+0xec/0x130
> > [c0000007f8483a90] c000000000967af8 .cpufreq_register_driver+0x168/0x2d0
> > [c0000007f8483b30] c000000000f774cc .powernv_cpufreq_init+0x210/0x244
> > [c0000007f8483be0] c00000000000bc08 .do_one_initcall+0xc8/0x240
> > [c0000007f8483ce0] c000000000f44054 .kernel_init_freeable+0x268/0x33c
> > [c0000007f8483db0] c00000000000c4dc .kernel_init+0x1c/0x110
> > [c0000007f8483e30] c00000000000a428 .ret_from_kernel_thread+0x58/0xb0
> > 1:mon> e
> > cpu 0x1: Vector: 700 (Program Check) at [c0000007f8483370]
> >     pc: c00000000096f32c: .pstate_id_to_freq+0x2c/0x50
> >     lr: c00000000096f37c: .powernv_read_cpu_freq+0x2c/0x50
> >     sp: c0000007f84835f0
> >    msr: 9000000000029032
> >   current = 0xc0000007f8400000
> >   paca    = 0xc00000000ff00400	 softe: 0	 irq_happened: 0x01
> >     pid   = 1, comm = swapper/0
> > kernel BUG at drivers/cpufreq/powernv-cpufreq.c:134!
> > 1:mon> r
> > R00 = 0000000000000042   R16 = 0000000000000000
> > R01 = c0000007f84835f0   R17 = 0000000000000000
> > R02 = c00000000116c430   R18 = 0000000000000000
> > R03 = ffffffffffffffbe   R19 = 0000000000000001
> > R04 = 0000000000000000   R20 = c00000078bd61e58
> > R05 = c00000000114ca78   R21 = c000000001008910
> > R06 = c0000007f84838d0   R22 = c0000000011c1b74
> > R07 = 0000000000000001   R23 = c000000002200030
> > R08 = c0000000011c1910   R24 = 0000000000000001
> > R09 = c000000001f2970c   R25 = c000000001008730
> > R10 = 0000000000000001   R26 = c000000001f29478
> > R11 = 0000000000000042   R27 = c0000007f84838d0
> > R12 = 0000000044002084   R28 = c00000000114ca78
> > R13 = c00000000ff00400   R29 = 0000000000000000
> > R14 = c00000000000c4c0   R30 = c0000000010a90f0
> > R15 = 0000000000000000   R31 = c0000007f84838d0
> > pc  = c00000000096f32c .pstate_id_to_freq+0x2c/0x50
> > cfar= c00000000096f324 .pstate_id_to_freq+0x24/0x50
> > lr  = c00000000096f37c .powernv_read_cpu_freq+0x2c/0x50
> > msr = 9000000000029032   cr  = 44002082
> > ctr = c00000000096f350   xer = 0000000020000000   trap =  700
> > 1:mon>
> 
> Gavin, in future for a dump like this it's very helpful to see the actual code
> that hit the bug. You can get that with:
> 
> 1:mon> di $.pstate_id_to_freq
> 
> 
> Vaidy, judging by r3 it looks like i became negative. That would obviously
> happen if powernv_pstate_info.max was zero?

yes, negative is ok.  Something has gone wrong with the PState
firmware/hardware.  A BUG_ON() is too severe for this error.  I will
change code to not stop the system for this error and also investigate
what is happening at runtime.

--Vaidy
