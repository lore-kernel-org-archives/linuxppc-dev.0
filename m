Return-Path: <vincent.guittot@linaro.org>
Received: from mail-bk0-f54.google.com (mail-bk0-f54.google.com
 [209.85.214.54])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6FC0A2C0099
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2013 03:50:33 +1100 (EST)
Received: by mail-bk0-f54.google.com with SMTP id w5so2669065bku.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 08:50:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1361201422.23152.154.camel@gandalf.local.home>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <510FBC01.2030405@linux.vnet.ibm.com>
 <87haloiwv0.fsf@rustcorp.com.au>
 <51134596.4080106@linux.vnet.ibm.com>
 <20130208154113.GV17833@n2100.arm.linux.org.uk>
 <51152B81.2050501@linux.vnet.ibm.com>
 <51153F72.1060005@linux.vnet.ibm.com>
 <CAKfTPtCe+cD7LLkb+D6pqG1SwG2V08ws=4XO3ttHEHV2qgmqPg@mail.gmail.com>
 <5118E2CD.90401@linux.vnet.ibm.com>
 <20130211190852.GA5695@linux.vnet.ibm.com>
 <5119BDFD.1000909@linux.vnet.ibm.com>
 <CAKfTPtAo2hQTfBKTVUuLKgsGJ2ZLD0UTR3fH9UFuJwyFt4n__w@mail.gmail.com>
 <511E8F3C.2010406@linux.vnet.ibm.com>
 <CAKfTPtD=2jn1AVjuhVP1ot7_8x9-W4==hNGZET5N9tRE7gtyMw@mail.gmail.com>
 <512203B3.7090002@linux.vnet.ibm.com>
 <512207A6.4000402@linux.vnet.ibm.com>
 <CAKfTPtA1aTseD6Gntkf_zbCEbfZzt3P2-P1un6iF5_1TdVLjRQ@mail.gmail.com>
 <1361201422.23152.154.camel@gandalf.local.home>
Date: Mon, 18 Feb 2013 17:50:28 +0100
Message-ID: <CAKfTPtC4hbXXWO=_zsGYryM9hpWaGFLbiY+jiLf=koLa4xGJOQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/45] CPU hotplug: stop_machine()-free CPU hotplug
From: Vincent Guittot <vincent.guittot@linaro.org>
To: Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-doc@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, walken@google.com, mingo@kernel.org,
 linux-arch@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>,
 xiaoguangrong@linux.vnet.ibm.com, wangyun@linux.vnet.ibm.com,
 paulmck@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 linux-pm@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>, rjw@sisk.pl,
 namhyung@kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, oleg@redhat.com, sbw@mit.edu,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, tj@kernel.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 18 February 2013 16:30, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Mon, 2013-02-18 at 11:58 +0100, Vincent Guittot wrote:
>
>> My tests have been done without cpuidle because i have some issues
>> with function tracer and cpuidle
>>
>> But the cpu hotplug and cpuidle work well when I run the tests without
>> enabling the function tracer
>>
>
> I know suspend and resume has issues with function tracing (because it
> makes things like calling smp_processor_id() crash the system), but I'm
> unaware of issues with hotplug itself. Could be some of the same issues.
>
> Can you give me more details, I'll try to investigate it.

yes for sure.
The problem is more linked to cpuidle and function tracer.

cpu hotplug and function tracer work when cpuidle is disable.
cpu hotplug and cpuidle works if i don't enable function tracer.
my platform is dead as soon as I enable function tracer if cpuidle is
enabled. It looks like some notrace are missing in my platform driver
but we haven't completely fix the issue yet

Vincent

>
> Thanks,
>
> -- Steve
>
>
