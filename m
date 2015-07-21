Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E82261A0ACF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 21:25:07 +1000 (AEST)
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BA2AD140E01
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 21:25:06 +1000 (AEST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 21 Jul 2015 16:55:04 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id DEF6CE005C
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 16:59:00 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6LBOvup31391900
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 16:54:58 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6LBOt01007365
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 16:54:57 +0530
Message-ID: <55AE2C06.9080905@linux.vnet.ibm.com>
Date: Tue, 21 Jul 2015 16:54:54 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
CC: mikey@neuling.org
Subject: Re: [RFC, 6/8] powerpc/prom: Simplify the logic while fetching SLB
 size
References: <20150721102130.37D3B140DF7@ozlabs.org>
In-Reply-To: <20150721102130.37D3B140DF7@ozlabs.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/21/2015 03:51 PM, Michael Ellerman wrote:
> On Tue, 2015-21-07 at 06:58:44 UTC, Anshuman Khandual wrote:
>> > From: "khandual@linux.vnet.ibm.com" <khandual@linux.vnet.ibm.com>
>> > 
>> > This patch just simplifies the existing code logic while fetching
>> > the SLB size property from the device tree.
>> > 
>> > Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> > ---
>> >  arch/powerpc/kernel/prom.c | 12 +++++-------
>> >  1 file changed, 5 insertions(+), 7 deletions(-)
>> > 
>> > diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
>> > index 8b888b1..f6168e2 100644
>> > --- a/arch/powerpc/kernel/prom.c
>> > +++ b/arch/powerpc/kernel/prom.c
>> > @@ -223,14 +223,12 @@ static void __init check_cpu_slb_size(unsigned long node)
>> >  	const __be32 *slb_size_ptr;
>> >  
>> >  	slb_size_ptr = of_get_flat_dt_prop(node, "slb-size", NULL);
>> > -	if (slb_size_ptr != NULL) {
>> > -		mmu_slb_size = be32_to_cpup(slb_size_ptr);
>> > -		return;
>> > -	}
>> > -	slb_size_ptr = of_get_flat_dt_prop(node, "ibm,slb-size", NULL);
>> > -	if (slb_size_ptr != NULL) {
>> > -		mmu_slb_size = be32_to_cpup(slb_size_ptr);
>> > +	if (!slb_size_ptr) {
>> > +		slb_size_ptr = of_get_flat_dt_prop(node, "ibm,slb-size", NULL);
>> > +		if (!slb_size_ptr)
>> > +			return;
>> >  	}
>> > +	mmu_slb_size = be32_to_cpup(slb_size_ptr);
>> >  }
> It's still ugly. Why not go the whole way:
> 
> 
> 	p = of_get_flat_dt_prop(node, "slb-size", NULL) ? :
> 	    of_get_flat_dt_prop(node, "ibm,slb-size", NULL);
> 
> 	if (p)
> 		mmu_slb_size = be32_to_cpup(p);

Yeah this is better.

> 
> 
> And while you're at it, rename the function, it doesn't check anything. It
> initialises mmu_slb_size, so call it init_mmu_slb_size()?

Sure, will do.
