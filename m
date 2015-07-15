Return-Path: <masami.hiramatsu.pt@hitachi.com>
Received: from mailxx.hitachi.co.jp (fallback.hitachi.co.jp [133.145.228.50])
 by lists.ozlabs.org (Postfix) with ESMTP id 8E62C1A001E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 13:48:50 +1000 (AEST)
Received: from mail7.hitachi.co.jp (mail7.hitachi.co.jp [133.145.228.42])
 by mailxx.hitachi.co.jp (Postfix) with ESMTP id 8686B177037E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 12:09:16 +0900 (JST)
Message-ID: <55A5CED4.7050400@hitachi.com>
Date: Wed, 15 Jul 2015 12:09:08 +0900
From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
MIME-Version: 1.0
To: Vivek Goyal <vgoyal@redhat.com>,
 Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
CC: Andrew Morton <akpm@linux-foundation.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>, linux-mips@linux-mips.org,
 Baoquan He <bhe@redhat.com>, linux-sh@vger.kernel.org,
 linux-s390@vger.kernel.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
 Daniel Walker <dwalker@fifo99.com>, linuxppc-dev@lists.ozlabs.org,
 linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: Re: [PATCH 3/3] kexec: Change the timing of callbacks related
 to "crash_kexec_post_notifiers" boot option
References: <20150710113331.4368.10495.stgit@softrs>
 <20150710113331.4368.77050.stgit@softrs> <20150714144248.GC10792@redhat.com>
In-Reply-To: <20150714144248.GC10792@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2015/07/14 23:42, Vivek Goyal wrote:
> On Fri, Jul 10, 2015 at 08:33:31PM +0900, Hidehiro Kawai wrote:
>> This patch fixes problems reported by Daniel Walker
>> (https://lkml.org/lkml/2015/6/24/44), and also replaces the bug fix
>> commits 5375b70 and f45d85f.
>>
>> If "crash_kexec_post_notifiers" boot option is specified,
>> other cpus are stopped by smp_send_stop() before entering
>> crash_kexec(), while usually machine_crash_shutdown() called by
>> crash_kexec() does that.  This behavior change leads two problems.
>>
>>  Problem 1:
>>  Some function in the crash_kexec() path depend on other cpus being
>>  still online.  If other cpus have been offlined already, they
>>  doesn't work properly.
>>
>>   Example:
>>    panic()
>>     crash_kexec()
>>      machine_crash_shutdown()
>>       octeon_generic_shutdown() // shutdown watchdog for ONLINE cpus
>>      machine_kexec()
>>
>>  Problem 2:
>>  Most of architectures stop other cpus in the machine_crash_shutdown()
>>  path and save register information at the same time.  However, if
>>  smp_send_stop() is called before that, we can't save the register
>>  information.
>>
>> To solve these problems, this patch changes the timing of calling
>> the callbacks instead of changing the timing of crash_kexec() if
>> crash_kexec_post_notifiers boot option is specified.
>>
>>  Before:
>>   if (!crash_kexec_post_notifiers)
>>       crash_kexec()
>>
>>   smp_send_stop()
>>   atomic_notifier_call_chain()
>>   kmsg_dump()
>>
>>   if (crash_kexec_post_notifiers)
>>       crash_kexec()
>>
>>  After:
>>   crash_kexec()
>>       machine_crash_shutdown()
>>       if (crash_kexec_post_notifiers) {
>>           atomic_notifier_call_chain()
>>           kmsg_dump()
>>       }
>>       machine_kexec()
>>
>>   smp_send_stop()
>>   if (!crash_kexec_post_notifiers) {
>>       atomic_notifier_call_chain()
>>       kmsg_dump()
>>   }
>>
> 
> I think this new code flow looks bad. Now we are calling kmsg_dump()
> and atomic_notifier_call_chain() from inside the crash_kexec() as well
> as from inside panic(). This is bad.
> 
> So basic problem seems to be that cpus need to be stopped once (with
> or without panic notifiers. So why don't we look into desiginig a 
> function which stops cpus, saves register states first and then does
> rest of the processing.
> 
> Something like.
> 
> stop_cpus_save_register_state;
> 
> if (!crash_kexec_post_notifiers)
> 	crash_kexec()
> 
> atomic_notifier_call_chain()
> kmsg_dump()
> 
> Here crash_kexec() will have to be modified and it will assume that cpus
> have already been stopped and register states have already been saved.

Ah, nice! I like this idea :)

> 
> IOW, is there a reason that we can't get rid of smp_send_stop() and
> use the mechanism crash_kexec() is using to stop cpus after panic()?

I think there is no reason why we don't do so. smp_send_stop() just
stops other cpus, but crash's one does more (collect registers and
stop watchdogs if needed, etc.). why don't we just replace(improve) it?

Thank you!


-- 
Masami HIRAMATSU
Linux Technology Research Center, System Productivity Research Dept.
Center for Technology Innovation - Systems Engineering
Hitachi, Ltd., Research & Development Group
E-mail: masami.hiramatsu.pt@hitachi.com
