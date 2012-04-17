Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D69CCB7033
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2012 02:25:20 +1000 (EST)
Message-ID: <4F8D995C.9030300@freescale.com>
Date: Tue, 17 Apr 2012 11:25:00 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Li Yang-R58472 <r58472@freescale.com>
Subject: Re: [PATCH v4 1/4] powerpc/85xx: add HOTPLUG_CPU support
References: <1331889732-25240-1-git-send-email-chenhui.zhao@freescale.com>
 <4F8C78B3.1070002@freescale.com>
 <94F013E7935FF44C83EBE7784D62AD3F092D1098@039-SN2MPN1-022.039d.mgd.msft.net>
In-Reply-To: <94F013E7935FF44C83EBE7784D62AD3F092D1098@039-SN2MPN1-022.039d.mgd.msft.net>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Zhao Chenhui-B35336 <B35336@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/17/2012 04:51 AM, Li Yang-R58472 wrote:
>>>  struct smp_ops_t smp_85xx_ops = {
>>>  	.kick_cpu = smp_85xx_kick_cpu,
>>> -#ifdef CONFIG_KEXEC
>>> +#ifdef CONFIG_HOTPLUG_CPU
>>> +	.cpu_disable	= generic_cpu_disable,
>>> +	.cpu_die	= generic_cpu_die,
>>> +#endif
>>>  	.give_timebase	= smp_generic_give_timebase,
>>>  	.take_timebase	= smp_generic_take_timebase,
>>> -#endif
>>>  };
>>
>> We need to stop using smp_generic_give/take_timebase, not expand its use.
>> This stuff breaks under hypervisors where timebase can't be written.  It
>> wasn't too bad before since we generally didn't enable CONFIG_KEXEC, but
>> we're more likely to want CONFIG_HOTPLUG_CPU.
> 
> I understand that the guest OS shouldn't change the real timebase.  

Cannot change it, and we've seen the tbsync code loop forever when it
tries (since the changes aren't taking effect).

> But no matter what timebase syncing method we are using, the timebase need to be changed anyway for certain features.

That's why I said to do it the way U-Boot does it.

> I think the better way should be trapping timebase modification in the hypervisor.

It does trap.  Currently we treat it as a no-op.  The only reasonable
alternative is to give the guest an exception.  It is simply not allowed
for a guest to modify the timebase -- we are not going to break the
host's timebase sync.  See the virtualized implementation note in
section 9.2.1 of book III-E of Power ISA 2.06B: "In virtualized
implementations, TBU and TBL are read-only."

>> Do the timebase sync the way U-Boot does -- if you find the appropriate
>> guts node in the device tree.
> 
> That involves stopping timebase for a short time on all cores including the cores that are still online.  Won't this be a potential issue?

I don't think it's a big deal in the contexts where you'd be doing
this -- at least not worse than the current situation.  Just make sure
that you don't reset the timebase to zero or otherwise make a core see
the timebase go backward.

-Scott
