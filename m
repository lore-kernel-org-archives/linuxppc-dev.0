Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvrTH3tvzzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 17:00:51 +1000 (AEST)
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 27 Apr 2016 12:30:46 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3R70hf610027064
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 12:30:43 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3R70dBr030832
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 12:30:42 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Balbir Singh <bsingharora@gmail.com>, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm: Use jump label to speed up radix_enabled check
In-Reply-To: <1461721589.3586.0.camel@kernel.crashing.org>
References: <1461687855-23017-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1461704701.3135.68.camel@kernel.crashing.org> <571FE8C1.4030903@gmail.com>
 <1461711943.3135.72.camel@kernel.crashing.org> <57200F4A.4070104@gmail.com>
 <1461721589.3586.0.camel@kernel.crashing.org>
Date: Wed, 27 Apr 2016 12:30:30 +0530
Message-ID: <87mvofedtd.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Wed, 2016-04-27 at 11:00 +1000, Balbir Singh wrote:
>> Just basic testing across CPUs with various mm features=C2=A0
>> enabled/disabled. Just for sanity
>
> I still don't think it's worth scattering the change. Either the jump
> label works or it doesn't ... The only problem is make sure we identify
> all the pre-boot ones but that's about it.
>

There are two ways to do this. One is to follow the approach listed
below done by Kevin, which is to do the jump_label_init early during boot a=
nd
switch both cpu and mmu feature check to plain jump label.

http://mid.gmane.org/1440415228-8006-1-git-send-email-haokexin@gmail.com

I already found one use case of cpu_has_feature before that
jump_label_init. In this approach we need to carefully audit all the
cpu/mmu_has_feature calls to make sure they don't get called before
jump_label_init. A missed conversion mean we miss a cpu/mmu feature
check.


Other option is to follow the patch I posted above, with the simple
change of renaming mmu_feature_enabled to mmu_has_feature. So we can
use it in early boot without really worrying about when we init jump
label.

What do you suggest we follow ?

-aneesh
