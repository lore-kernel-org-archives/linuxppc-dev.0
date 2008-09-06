Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 69A25DDE11
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Sep 2008 01:32:53 +1000 (EST)
Message-Id: <A2164774-E93D-4782-8E49-DD6124EF496F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: benh@kernel.crashing.org
In-Reply-To: <1220654280.4879.202.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH v3 2/4] powerpc: Fixes for CONFIG_PTE_64BIT for SMP support
Date: Sat, 6 Sep 2008 10:32:46 -0500
References: <1220465344-16753-1-git-send-email-galak@kernel.crashing.org>
	<1220465344-16753-2-git-send-email-galak@kernel.crashing.org>
	<1220497970.4879.36.camel@pasglop>
	<828A65C6-A5DD-41C6-BA38-25BE04D76AA2@kernel.crashing.org>
	<1220654280.4879.202.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 5, 2008, at 5:38 PM, Benjamin Herrenschmidt wrote:

> On Fri, 2008-09-05 at 14:44 -0500, Kumar Gala wrote:
>>> I also wonder if you should first ensure that the PTE is invalid and
>>> if not, clear it and flush the TLB page ... Or at least add a
>>> WARN_ON(pte_valid()) in case we get that wrong ...
>>
>> I believe that's an issue since kmap_atomic() will call set_pte_at  
>> and
>> have the valid bit set.
>
> Hrm... on the other hand, it's safe because kmap_atomic() is per-CPU  
> and
> thus won't race with anything...
>
> On the other hand, if others (mprotect, mremap, whoever...) does it,
> it's not safe.
>
> I'm keen on letting set_pte_at() to the job and maybe if we can remove
> the explicit flush kmap_atomic does... Though it's not totally trivial
> to "know" it's a flush that doesn't need global invalidations...
>
> May be worth moving your current stuff into a __set_pte_at() that you
> use from kmap atomic, and have set_pte_at() wrap that along with a
> present warn. That would do for the time being.

That works for me.

- k
