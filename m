Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F38042C0377
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 21:59:40 +1100 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Mon, 18 Feb 2013 20:55:06 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8E85D3578054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 21:59:36 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1IAlJ6P6881536
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 21:47:19 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1IAxYqe010067
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 21:59:36 +1100
Message-ID: <5122091C.2080308@linux.vnet.ibm.com>
Date: Mon, 18 Feb 2013 16:27:32 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 00/45] CPU hotplug: stop_machine()-free CPU hotplug
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <510FBC01.2030405@linux.vnet.ibm.com> <87haloiwv0.fsf@rustcorp.com.au>
 <51134596.4080106@linux.vnet.ibm.com>
 <20130208154113.GV17833@n2100.arm.linux.org.uk>
 <51152B81.2050501@linux.vnet.ibm.com> <51153F72.1060005@linux.vnet.ibm.com>
 <CAKfTPtCe+cD7LLkb+D6pqG1SwG2V08ws=4XO3ttHEHV2qgmqPg@mail.gmail.com>
 <5118E2CD.90401@linux.vnet.ibm.com>
 <20130211190852.GA5695@linux.vnet.ibm.com>
 <5119BDFD.1000909@linux.vnet.ibm.com>
 <CAKfTPtAo2hQTfBKTVUuLKgsGJ2ZLD0UTR3fH9UFuJwyFt4n__w@mail.gmail.com>
 <511E8F3C.2010406@linux.vnet.ibm.com>
 <CAKfTPtD=2jn1AVjuhVP1ot7_8x9-W4==hNGZET5N9tRE7gtyMw@mail.gmail.com>
 <512203B3.7090002@linux.vnet.ibm.com>
 <alpine.LFD.2.02.1302181151040.22263@ionos>
In-Reply-To: <alpine.LFD.2.02.1302181151040.22263@ionos>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-doc@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, walken@google.com, mingo@kernel.org,
 linux-arch@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>,
 xiaoguangrong@linux.vnet.ibm.com, wangyun@linux.vnet.ibm.com,
 paulmck@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 linux-pm@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
 rostedt@goodmis.org, rjw@sisk.pl, namhyung@kernel.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, oleg@redhat.com,
 Vincent Guittot <vincent.guittot@linaro.org>, sbw@mit.edu, tj@kernel.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/18/2013 04:24 PM, Thomas Gleixner wrote:
> On Mon, 18 Feb 2013, Srivatsa S. Bhat wrote:
>> Lockup observed while running this patchset, with CPU_IDLE and INTEL_IDLE turned
>> on in the .config:
>>
>>  smpboot: CPU 1 is now offline
>> Kernel panic - not syncing: Watchdog detected hard LOCKUP on cpu 11
>> Pid: 0, comm: swapper/11 Not tainted 3.8.0-rc7+stpmch13-1 #8
>> Call Trace:
>>  [<ffffffff812aba1e>] do_raw_spin_lock+0x7e/0x150
>>  [<ffffffff815a64c1>] _raw_spin_lock_irqsave+0x61/0x70
>>  [<ffffffff810c0758>] ? clockevents_notify+0x28/0x150
>>  [<ffffffff815a6d37>] ? _raw_spin_unlock_irqrestore+0x77/0x80
>>  [<ffffffff810c0758>] clockevents_notify+0x28/0x150
>>  [<ffffffff8130459f>] intel_idle+0xaf/0xe0
>>  [<ffffffff81472ee0>] ? disable_cpuidle+0x20/0x20
>>  [<ffffffff81472ef9>] cpuidle_enter+0x19/0x20
>>  [<ffffffff814734c1>] cpuidle_wrap_enter+0x41/0xa0
>>  [<ffffffff81473530>] cpuidle_enter_tk+0x10/0x20
>>  [<ffffffff81472f17>] cpuidle_enter_state+0x17/0x50
>>  [<ffffffff81473899>] cpuidle_idle_call+0xd9/0x290
>>  [<ffffffff810203d5>] cpu_idle+0xe5/0x140
>>  [<ffffffff8159c603>] start_secondary+0xdd/0xdf
> 
>> BUG: spinlock lockup suspected on CPU#2, migration/2/19
>>  lock: clockevents_lock+0x0/0x40, .magic: dead4ead, .owner: swapper/8/0, .owner_cpu: 8
> 
> Unfortunately there is no back trace for cpu8.

Yes :-(

I had run this several times hoping to get a backtrace on the lock-holder,
expecting trigger_all_cpu_backtrace() to get it right at least once. But I
hadn't succeeded even once.

> That's probably caused
> by the watchdog -> panic setting.
> 

Oh, ok..

> So we have no idea why cpu2 and 11 get stuck on the clockevents_lock
> and without that information it's impossible to decode.
> 

But thankfully, the issue seems to have been resolved by the diff I posted
in my previous mail, along with the fixes related to memory barriers.

Regards,
Srivatsa S. Bhat
