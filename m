Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vCKNJ2fFVzDq8b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 19:36:00 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Matt Fleming <matt@codeblueprint.co.uk>
Cc: fweisbec@gmail.com, tglx@linutronix.de, pmladek@suse.com, hpa@zytor.com,
 efault@gmx.de, sergey.senozhatsky.work@gmail.com, peterz@infradead.org,
 mgorman@techsingularity.net, wanpeng.li@hotmail.com, umgwanakikbuti@gmail.com,
 byungchul.park@lge.com, jack@suse.cz, mingo@kernel.org, riel@redhat.com,
 luca.abeni@unitn.it, yuyang.du@intel.com, torvalds@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-next\@vger.kernel.org" <linux-next@vger.kernel.org>
Subject: Re: [tip:sched/core] sched/core: Add debugging code to catch missing
 update_rq_clock() calls
In-Reply-To: <20170130213435.GM31613@codeblueprint.co.uk>
References: <20160921133813.31976-8-matt@codeblueprint.co.uk>
 <tip-cb42c9a3ebbbb23448c3f9a25417fae6309b1a92@git.kernel.org>
 <87tw8gutp6.fsf@concordia.ellerman.id.au>
 <20170130213435.GM31613@codeblueprint.co.uk>
Date: Tue, 31 Jan 2017 19:35:59 +1100
Message-ID: <87d1f3vd74.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Matt Fleming <matt@codeblueprint.co.uk> writes:

> On Tue, 31 Jan, at 08:24:53AM, Michael Ellerman wrote:
>> 
>> I'm hitting this on multiple powerpc systems:
>> 
>> [   38.339126] rq->clock_update_flags < RQCF_ACT_SKIP
>> [   38.339134] ------------[ cut here ]------------
>> [   38.339142] WARNING: CPU: 2 PID: 1 at kernel/sched/sched.h:804 detach_task_cfs_rq+0xa0c/0xd10
>
> [...]
>  
>> I assume I should be worried?
>
> Thanks for the report. No need to worry, the bug has existed for a
> while, this patch just turns on the warning ;-)
>
> The following commit queued up in tip/sched/core should fix your
> issues (assuming you see the same callstack on all your powerpc
> machines):
>
>   https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/commit/?h=sched/core&id=1b1d62254df0fe42a711eb71948f915918987790

Great thanks.

Looks like that commit is in today's linux-next, so hopefully I won't
see any oopses in my boot tests overnight. If I do I'll let you know.

cheers
