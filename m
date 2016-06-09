Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQBjs6fnWzDqR5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 14:13:05 +1000 (AEST)
Message-ID: <1465445571.2948.29.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/mm: Use jump label to speed up radix_enabled check
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Balbir Singh
 <bsingharora@gmail.com>, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Date: Thu, 09 Jun 2016 14:12:51 +1000
In-Reply-To: <87mvofedtd.fsf@skywalker.in.ibm.com>
References: <1461687855-23017-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1461704701.3135.68.camel@kernel.crashing.org> <571FE8C1.4030903@gmail.com>
 <1461711943.3135.72.camel@kernel.crashing.org> <57200F4A.4070104@gmail.com>
 <1461721589.3586.0.camel@kernel.crashing.org>
 <87mvofedtd.fsf@skywalker.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-04-27 at 12:30 +0530, Aneesh Kumar K.V wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > 
> > On Wed, 2016-04-27 at 11:00 +1000, Balbir Singh wrote:
> > > 
> > > Just basic testing across CPUs with various mm features 
> > > enabled/disabled. Just for sanity
> > I still don't think it's worth scattering the change. Either the jump
> > label works or it doesn't ... The only problem is make sure we identify
> > all the pre-boot ones but that's about it.
> > 
> There are two ways to do this. One is to follow the approach listed
> below done by Kevin, which is to do the jump_label_init early during boot and
> switch both cpu and mmu feature check to plain jump label.
> 
> http://mid.gmane.org/1440415228-8006-1-git-send-email-haokexin@gmail.com
> 
> I already found one use case of cpu_has_feature before that
> jump_label_init. In this approach we need to carefully audit all the
> cpu/mmu_has_feature calls to make sure they don't get called before
> jump_label_init. A missed conversion mean we miss a cpu/mmu feature
> check.
> 
> 
> Other option is to follow the patch I posted above, with the simple
> change of renaming mmu_feature_enabled to mmu_has_feature. So we can
> use it in early boot without really worrying about when we init jump
> label.
> 
> What do you suggest we follow ?

So I really don't like your patch, sorry :-(

It adds a whole new section "_in_c", duplicates a lot of infrastructure
somewhat differently etc... ugh.

I'd rather we follow Kevin's approach and convert all the CPU/MMU/...
feature things to static keys in C. There aren't that many that
need to be done really early on, we can audit them.

I would suggest doing:

 1- Add __mmu_has_feature/__cpu_has_feature/... which initially is
identical to the current one (or just make the current one use the __ variant).

 2- Convert selectively the early boot stuff to use __. There aren't *that*
many, I can help you audit them

 3- Add the static key version for all the non  __

Do you have time or should I look into this ?

Cheers,
Ben.
