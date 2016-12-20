Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tjfXZ24dVzDwTf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 00:59:10 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id c4so9083892pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 05:59:10 -0800 (PST)
Subject: Re: [PATCH v4 02/12] powerpc: move set_soft_enabled() and rename
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, mpe@ellerman.id.au
References: <1482134828-18811-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1482134828-18811-3-git-send-email-maddy@linux.vnet.ibm.com>
 <f09a9213-9e85-eee0-e212-bd3ee2a3569e@gmail.com>
 <1482226347.15937.44.camel@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, anton@samba.org,
 npiggin@gmail.com
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <b9aa1f9a-4df0-0816-8cf9-ec38dec7d13e@gmail.com>
Date: Wed, 21 Dec 2016 00:58:47 +1100
MIME-Version: 1.0
In-Reply-To: <1482226347.15937.44.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 20/12/16 20:32, Benjamin Herrenschmidt wrote:
> On Tue, 2016-12-20 at 20:03 +1100, Balbir Singh wrote:
>>
>> On 19/12/16 19:06, Madhavan Srinivasan wrote:
>>> Move set_soft_enabled() from powerpc/kernel/irq.c to
>>> asm/hw_irq.c, to force updates to paca-soft_enabled
>>> done via these access function. Add "memory" clobber
>>> to hint compiler since paca->soft_enabled memory is the target
>>> here
>>> +static inline notrace void soft_enabled_set(unsigned long enable)
>>> +{
>>> +	__asm__ __volatile__("stb %0,%1(13)"
>>> +	: : "r" (enable), "i" (offsetof(struct paca_struct,
>>> soft_enabled))
>>> +	: "memory");
>>> +}
>>> +
>>
>> Can't we just rewrite this in "C"?
>>
>> local_paca->soft_enabled = enable
> 
> Well, this is digging out another bloody can of baby eating worms...
> 
> So the reason we wrote it like that is because we had gcc playing
> tricks to us.
> 
> It has been proved to move around references to local_paca, even
> accross preempt_disable boundaries.
> 
> The above prevents it.
> 
> I'm about 100% sure we have a bunch of other issues related to PACA
> access and gcc playing games though. I remember grepping the kernel
> disassembly once for gcc doing funny things with r13 such as copying it
> into another register or even saving and restoring it and my grep
> didn't come up empty ...
> 


I checked for arch_local_irq_restore before suggesting it, not all
functions. I tried a quick audit of disassembly not using load/stores
on r13 and most of it was in hand written disassembly in the exception
handling paths, secondary processor initialization, wake up from idle.
Having said that I audited with one version of gcc on a little endian
vmlinux.


> Something we need to seriously look into one day. I have some ideas on
> how to clean that up in the code to make hardening it easier, let's
> talk next time Nick is in town.
> 

Sure lets leave it as is for now

Balbir
