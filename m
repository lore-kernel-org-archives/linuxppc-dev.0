Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id BA914DDF06
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Mar 2007 03:43:13 +1000 (EST)
In-Reply-To: <4605B861.9060006@am.sony.com>
References: <4605B861.9060006@am.sony.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e1f83c095fc09e65524d4a8800c36120@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 8/9] ps3: cleanup ps3fb before clearing HPTE
Date: Sun, 25 Mar 2007 12:43:26 -0500
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Paul, after reading this note I send a big fat

NACK

to this patch.

On Mar 24, 2007, at 6:46 PM, Geoff Levand wrote:

> Christoph Hellwig wrote:
>>>>  static void ps3_hpte_clear(void)
>>>  {
>>> +
>>> +#ifdef CONFIG_FB_PS3
>>> +    ps3fb_cleanup();
>>> +#endif
>>
>> And well, adding framebuffer calls into the mmu code is rather fucked.
>> This at least needs a big comment explaning the hypervisor braindamage
>> that is responsible for this in colourfull language.
>
> Sorry for such a late reply, but I'm now doing the kexec code and see
> why it was put here (by the original author).  It is so you will have
> debugging output until the very last possible moment during a kexec
> shutdown.

But that is REALLY to late for that.

> The real problem is really that this routine (and the corresponding 
> ppc_md
> variable) are inappropriately named.

Ok, this should be
ppc_md.kexec_cleanup_nothing_but_static_data_bss_real_mode_cleanup()


> In the general case all that is left
> to do is to call ppc_md.hpte_clear_all, but for ps3 we also want to do 
> the
> framebuffer shutdown here, so something like this should be better:
>
> -static void ps3_hpte_clear(void)
> +static void ps3_kexec_final(void)
>
> -       ppc_md.hpte_clear_all = ps3_hpte_clear;
> +       ppc_md.hpte_clear_all = ps3_kexec_final;
>

NACK.

Because at this point, we have already done the copy of the new kernel
to its kexec-specified location, and we are in real mode.   There is
no way ps3fb_cleanup should be running that late.

The only thing ppc_md.htpe_clear_all is allowed to touch is data built
into vmlinux (that is, static data and bss, not even per-cpu data).

Actually, it can touch tce tables, the hash table, and rtas, but only if
they are below the real mode limit.   That's because those regions are 
also
protected from overwrite by default_machine_kexec_prepare().   You 
could use
that hook to protect your fb allocation, but then you need to (1) export
the range to the device tree for kexec user space and (2) change 
kexec-tools
to look for this region.


You could use machine_kexec and machine_crash_kexec, but I would just 
use
the kexec_cpu_down (its called with primary=1 last).

There shouldn't be any debugging after cpu_down anways.  The only things
left are switch stacks, copy kernel, and call htpe_clear.

Oh, I just looked at your ps3 kexec hooks.  Your ps3_kexec_cpu_down 
looks
totally broken.  kexec_cpu_down(crash, secondary) is called on each
cpu, so there should be no for_each_cpu loops there.  Also, the primary
cpu is likely not cpu 0, although it will be called last, after the
other cpus are offline spinning.

If your platform requires you to be on a given cpu you should
set_tasks_allowed() in your machine_kexec_*shutdown, but that will have
an negative effect on crash reliability.
