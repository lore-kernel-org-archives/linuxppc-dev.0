Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqZ0V19RczDq68
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 17:54:34 +1000 (AEST)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 20 Apr 2016 17:54:32 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id D52012BB0066
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 17:54:24 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3K7sAVR4981162
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 17:54:24 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3K7rhhV004585
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 17:53:43 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, benh@kernel.crashing.org,
 paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: Re: [PATCH V2 01/68] powerpc/cxl: Use REGION_ID instead of opencoding
In-Reply-To: <1461121434.13404.1.camel@ellerman.id.au>
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1460182444-2468-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <87mvoy9ql8.fsf@skywalker.in.ibm.com>
 <1461121434.13404.1.camel@ellerman.id.au>
Date: Wed, 20 Apr 2016 03:53:21 -0400
Message-ID: <87shyg3edq.fsf@skywalker.in.ibm.com>
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

> On Wed, 2016-04-13 at 08:12 +0530, Aneesh Kumar K.V wrote:
>> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
>> > Also note that the `~` operation is wrong.
>> > 
>> > Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
>> > Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>> > Acked-by: Ian Munsie <imunsie@au1.ibm.com>
>> > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> > ---
>> >  drivers/misc/cxl/fault.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > 
>> > diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
>> > index 9a8650bcb042..9a236543da23 100644
>> > --- a/drivers/misc/cxl/fault.c
>> > +++ b/drivers/misc/cxl/fault.c
>> > @@ -152,7 +152,7 @@ static void cxl_handle_page_fault(struct cxl_context *ctx,
>> >  	access = _PAGE_PRESENT;
>> >  	if (dsisr & CXL_PSL_DSISR_An_S)
>> >  		access |= _PAGE_RW;
>> > -	if ((!ctx->kernel) || ~(dar & (1ULL << 63)))
>> > +	if ((!ctx->kernel) || (REGION_ID(dar) == USER_REGION_ID))
>> >  		access |= _PAGE_USER;
>> > 
>> >  	if (dsisr & DSISR_NOHPTE)
>> 
>> Posted an updated version of this patch alone with improved commit
>> message here
>> 
>> http://mid.gmane.org/1460482475-20782-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com
>
> I never saw it. And that link is empty?
>

Interesting . I will send this again.

-aneesh
