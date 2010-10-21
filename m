Return-Path: <lizf@cn.fujitsu.com>
Message-ID: <4CBFFF43.2010100@cn.fujitsu.com>
Date: Thu, 21 Oct 2010 16:52:19 +0800
From: Li Zefan <lizf@cn.fujitsu.com>
MIME-Version: 1.0
To: subrata@linux.vnet.ibm.com
Subject: Re: [2.6.36-rc7, Power6] LTP Ftrace Stress tests causes KERNEL	PANIC
	and brings the system to xmon
References: <1286998463.4893.26.camel@subratamodak.linux.ibm.com>
	<1287649998.22128.1.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1287649998.22128.1.camel@subratamodak.linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: ltp-list <ltp-list@lists.sf.net>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, rostedt <rostedt@goodmis.org>,
	Linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(I guess you didn't notice I've also forwarded the bug report to LKML?
 http://marc.info/?l=3Dlinux-kernel&m=3D128737193919500&w=3D2)

Subrata Modak wrote:
> Stefen,
>=20
> Can you please know your thoughts on this issue ?
>=20

Stefen? Steven? :)

> Regards--
> Subrata
>=20
> On Thu, 2010-10-14 at 01:04 +0530, Subrata Modak wrote:
>> Hi,
>>
>> Executing LTP Ftrace Stress tests on 2.6.36-rc7, Power6 creates kernel
>> Panic and xmon is invoked:
>>

...

>>
>> However Peter Zijlstra=C5=9B proposed patch did not fix this issue. Th=
e patch
>> was
>> posted to LTP:
>> http://marc.info/?l=3Dltp-list&m=3D128696942432669&w=3D2
>>
>> The Kernel paniked even after the patch. However this time th message =
was
>> different. Other xmon output is also shown below:
>>

So they are 2 different bugs, and Peter's patch fixed the first one.
But that patch is too bug for .36..

For the second bug, as I said, it's a dead loop, and it's PowerPC specifi=
c,
so better have someone in PPC fixed it, and Steven has proposed to add
recursive check.

...

>>  pid   =3D 1668, cc0000000002226b0 .rb_reserve_next_event+0x20c/0x804
>> [c0000000d9f8b9b0] c000000000223178 .ring_buffer_lock_reserve+0x24c/0x=
2a4
>> [c0000000d9f8ba40] c00000000022d6f4 .trace_buffer_lock_reserve+0x58/0x=
e4
>> [c0000000d9f8baf0] c00000000022ec9c
>> .trace_current_buffer_lock_reserve+0x44/0x6c
>> [c0000000d9f8bb80] c000000000011c5c .ftrace_raw_event_hcall_entry+0x7c=
/0x144
>> [c0000000d9f8bc40] c000000000096624 .__trace_hcall_entry+0xa0/0xec
>> [c0000000d9f8bcd0] c00000000009786c .plpar_hcall_norets+0x50/0xd0
>> [c0000000d9f8bd40] c0000000000749c8 .__spin_yield+0x130/0x15c
>> [c0000000d9f8bdd0] c000000000213458 .trace_clock_global+0x11c/0x2a0
>> [c0000000d9f8be90] c0000000002226b0 .rb_reserve_next_event+0x20c/0x804
>> [c0000000d9f8bfa0] c000000000223178 .ring_buffer_lock_reserve+0x24c/0x=
2a4
>> [c0000000d9f8c030] c00000000022d6f4 .trace_buffer_lock_reserve+0x58/0x=
e4
>> [c0000000d9f8c0e0] c00000000022ec9c
>> .trace_current_buffer_lock_reserve+0x44/0x6c
>> [c0000000d9f8c170] c000000000011c5c .ftrace_raw_event_hcall_entry+0x7c=
/0x144
>> [c0000000d9f8c230] c000000000096624 .__trace_hcall_entry+0xa0/0xec
>> [c0000000d9f8c2c0] c00000000009786c .plpar_hcall_norets+0x50/0xd0
>> [c0000000d9f8c330] c0000000000749c8 .__spin_yield+0x130/0x15c
>> [c0000000d9f8c3c0] c000000000213458 .trace_clock_global+0x11c/0x2a0
>> [c0000000d9f8c480] c0000000002226b0 .rb_reserve_next_event+0x20c/0x804
>> [c0000000d9f8c590] c000000000223178 .ring_buffer_lock_reserve+0x24c/0x=
2a4
>> [c0000000d9f8c620] c00000000022d6f4 .trace_buffer_lock_reserve+0x58/0x=
e4
