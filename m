Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqZcg5v4pzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 18:22:27 +1000 (AEST)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 20 Apr 2016 18:22:25 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id AE39A2CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 18:22:11 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3K8M3lV11338038
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 18:22:11 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3K8LcHq029765
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 18:21:38 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, benh@kernel.crashing.org,
 paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [V2,
 68/68] powerpc/mm/radix: Use firmware feature to disable radix
In-Reply-To: <3qqRSV5jq0z9sRB@ozlabs.org>
References: <3qqRSV5jq0z9sRB@ozlabs.org>
Date: Wed, 20 Apr 2016 04:21:18 -0400
Message-ID: <87potk3d35.fsf@skywalker.in.ibm.com>
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

Michael Ellerman <mpe@ellerman.id.au> writes:

> On Sat, 2016-09-04 at 06:14:04 UTC, "Aneesh Kumar K.V" wrote:
>> We can depend on ibm,pa-features to enable/disable radix. This gives us
>> a nice way to test p9 hash config, by changing device tree property.
>
> I think we might want to be more careful here.
>
> You set MMU_FTR_RADIX in the cputable entry. So it's on by default on P9 cpus.
>
> Then if there is an ibm,pa-features property *and* it is >= 41 bytes long, the
> below feature entry will hit. In that case the firmware controls whether it's on
> or off.
>
> I think it would be clearer if we removed RADIX from the cputable, and the below
> became the only way to turn it on. Would that break anything?

I was thinking we want to use RADIX by default on Power9. Hence the idea
of clearing feature bit. Now we will be using this to switch
between Radix and hash segment table. We are not really going to use
this to switch between the long tested SLB hash to the newly
added Power9 Radix. So it is not really there to make sure we run safely
with old code by default.

>
>> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
>> index 7030b035905d..a4d1f44364b8 100644
>> --- a/arch/powerpc/kernel/prom.c
>> +++ b/arch/powerpc/kernel/prom.c
>> @@ -165,6 +165,7 @@ static struct ibm_pa_feature {
>>  	 * which is 0 if the kernel doesn't support TM.
>>  	 */
>>  	{CPU_FTR_TM_COMP, 0, 0,		22, 0, 0},
>> +	{0, MMU_FTR_RADIX, 0,		40, 0, 0},
>
> So that says bit 0 of byte 40 enables MMU_FTR_RADIX. Where is that documented?
>

In PAPR document.

-aneehs
