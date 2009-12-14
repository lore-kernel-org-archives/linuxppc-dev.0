Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 740C0B6F10
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Dec 2009 21:22:12 +1100 (EST)
Subject: Re: [Next] CPU Hotplug test failures on powerpc
From: Peter Zijlstra <peterz@infradead.org>
To: Sachin Sant <sachinp@in.ibm.com>
In-Reply-To: <4B2224C7.1020908@in.ibm.com>
References: <4B2224C7.1020908@in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 14 Dec 2009 11:22:02 +0100
Message-ID: <1260786122.4165.142.camel@twins>
Mime-Version: 1.0
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Ingo Molnar <mingo@elte.hu>, linux-next@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-12-11 at 16:23 +0530, Sachin Sant wrote:
> While executing cpu_hotplug(from autotest) tests against latest
> next on a power6 box, the machine locks up. A soft reset shows
> the following trace
>=20
> cpu 0x0: Vector: 100 (System Reset) at [c00000000c9333d0]
>     pc: c0000000003433d8: .find_next_bit+0x54/0xc4
>     lr: c000000000342f10: .cpumask_next_and+0x4c/0x94
>     sp: c00000000c933650
>    msr: 8000000000089032
>   current =3D 0xc00000000c173840
>   paca    =3D 0xc000000000bc2600
>     pid   =3D 2602, comm =3D hotplug06.top.s
> enter ? for help
> [link register   ] c000000000342f10 .cpumask_next_and+0x4c/0x94
> [c00000000c933650] c0000000000e9f34 .cpuset_cpus_allowed_locked+0x38/0x74=
 (unreliable)
> [c00000000c9336e0] c000000000090074 .move_task_off_dead_cpu+0xc4/0x1ac
> [c00000000c9337a0] c0000000005e4e5c .migration_call+0x304/0x830
> [c00000000c933880] c0000000005e0880 .notifier_call_chain+0x68/0xe0
> [c00000000c933920] c00000000012a92c ._cpu_down+0x210/0x34c
> [c00000000c933a90] c00000000012aad8 .cpu_down+0x70/0xa8
> [c00000000c933b20] c000000000525940 .store_online+0x54/0x894
> [c00000000c933bb0] c000000000463430 .sysdev_store+0x3c/0x50
> [c00000000c933c20] c0000000001f8320 .sysfs_write_file+0x124/0x18c
> [c00000000c933ce0] c00000000017edac .vfs_write+0xd4/0x1fc
> [c00000000c933d80] c00000000017efdc .SyS_write+0x58/0xa0
> [c00000000c933e30] c0000000000085b4 syscall_exit+0x0/0x40
> --- Exception: c01 (System Call) at 00000fff9fa8a8f8
> SP (fffe7aef200) is in userspace
> 0:mon> e
> cpu 0x0: Vector: 100 (System Reset) at [c00000000c9333d0]
>     pc: c0000000003433d8: .find_next_bit+0x54/0xc4
>     lr: c000000000342f10: .cpumask_next_and+0x4c/0x94
>     sp: c00000000c933650
>    msr: 8000000000089032
>   current =3D 0xc00000000c173840
>   paca    =3D 0xc000000000bc2600
>     pid   =3D 2602, comm =3D hotplug06.top.s
>=20
> Last few messages from the dmesg log shows


> After some debugging a possible suspect seems to be commit
> 6ad4c18.. : sched: Fix balance vs hotplug race


Oh, wonderful :-/

So what is that thing whining about? Not being able to read a cpumask or
something?

Does your .config have cpusets enabled (there's a different
cpuset_cpus_allowed_locked implementation depending on that)?

I know of at least one remaining race and am working on closing that,
but I'm not sure I can explain this crash with that.
