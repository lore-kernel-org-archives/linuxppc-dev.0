Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQF6C41rFzDq5j
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 16:00:51 +1000 (AEST)
Received: from pps.filterd (m0048827.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u595xXua012775
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Jun 2016 02:00:49 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23e9me9j5f-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jun 2016 02:00:49 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 9 Jun 2016 00:00:48 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Balbir Singh <bsingharora@gmail.com>, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm: Use jump label to speed up radix_enabled check
In-Reply-To: <1465445571.2948.29.camel@kernel.crashing.org>
References: <1461687855-23017-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1461704701.3135.68.camel@kernel.crashing.org> <571FE8C1.4030903@gmail.com>
 <1461711943.3135.72.camel@kernel.crashing.org> <57200F4A.4070104@gmail.com>
 <1461721589.3586.0.camel@kernel.crashing.org>
 <87mvofedtd.fsf@skywalker.in.ibm.com>
 <1465445571.2948.29.camel@kernel.crashing.org>
Date: Thu, 09 Jun 2016 11:30:41 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <871t46aol2.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Wed, 2016-04-27 at 12:30 +0530, Aneesh Kumar K.V wrote:
>> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
>>=20
>> >=20
>> > On Wed, 2016-04-27 at 11:00 +1000, Balbir Singh wrote:
>> > >=20
>> > > Just basic testing across CPUs with various mm features=C2=A0
>> > > enabled/disabled. Just for sanity
>> > I still don't think it's worth scattering the change. Either the jump
>> > label works or it doesn't ... The only problem is make sure we identify
>> > all the pre-boot ones but that's about it.
>> >=20
>> There are two ways to do this. One is to follow the approach listed
>> below done by Kevin, which is to do the jump_label_init early during boo=
t and
>> switch both cpu and mmu feature check to plain jump label.
>>=20
>> http://mid.gmane.org/1440415228-8006-1-git-send-email-haokexin@gmail.com
>>=20
>> I already found one use case of cpu_has_feature before that
>> jump_label_init. In this approach we need to carefully audit all the
>> cpu/mmu_has_feature calls to make sure they don't get called before
>> jump_label_init. A missed conversion mean we miss a cpu/mmu feature
>> check.
>>=20
>>=20
>> Other option is to follow the patch I posted above, with the simple
>> change of renaming mmu_feature_enabled to mmu_has_feature. So we can
>> use it in early boot without really worrying about when we init jump
>> label.
>>=20
>> What do you suggest we follow ?
>
> So I really don't like your patch, sorry :-(
>
> It adds a whole new section "_in_c", duplicates a lot of infrastructure
> somewhat differently etc... ugh.
>
> I'd rather we follow Kevin's approach and convert all the CPU/MMU/...
> feature things to static keys in C. There aren't that many that
> need to be done really early on, we can audit them.
>
> I would suggest doing:
>
>  1- Add __mmu_has_feature/__cpu_has_feature/... which initially is
> identical to the current one (or just make the current one use the __ var=
iant).
>
>  2- Convert selectively the early boot stuff to use __. There aren't *tha=
t*
> many, I can help you audit them
>
>  3- Add the static key version for all the non  __
>
> Do you have time or should I look into this ?

I can look at this.

-aneesh
