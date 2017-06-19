Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wrmTp0K9fzDqB1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 19:51:57 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5J9nfCc088089
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 05:51:55 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b5vugxncg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 05:51:55 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 19 Jun 2017 19:51:52 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5J9pnRR3998066
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 19:51:49 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5J9pfHm006126
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 19:51:41 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, "Shriya R . Kulkarni" <shriykul@in.ibm.com>,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc64/hw_breakpoints: Handle data breakpoints in
 radix mode
In-Reply-To: <20170618094100.29795-1-naveen.n.rao@linux.vnet.ibm.com>
References: <87d1a4wlzz.fsf@concordia.ellerman.id.au>
 <20170618094100.29795-1-naveen.n.rao@linux.vnet.ibm.com>
Date: Mon, 19 Jun 2017 15:21:41 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <8760fsb902.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:

> On 2017/06/16 03:16PM, Michael Ellerman wrote:
>> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
>> 
>> > diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
>> > index ae418b85c17c..17ee701b8336 100644
>> > --- a/arch/powerpc/kernel/exceptions-64s.S
>> > +++ b/arch/powerpc/kernel/exceptions-64s.S
>> > @@ -1442,7 +1440,9 @@ do_hash_page:
>> >  
>> >  /* Here we have a page fault that hash_page can't handle. */
>> >  handle_page_fault:
>> > -11:	ld	r4,_DAR(r1)
>> > +	andis.  r0,r4,DSISR_DABRMATCH@h
>> > +	bne-    handle_dabr_fault
>> 
>> This broke hash. Please test hash! :)
>
> Gah! :double-face-palm:
> I don't know how I missed this... (yes, I do)
>
>> 
>> I added:
>> 
>> @@ -1438,11 +1436,16 @@ do_hash_page:
>> 
>>         /* Error */
>>         blt-    13f
>> +
>> +       /* Reload DSISR into r4 for the DABR check below */
>> +       ld      r4,_DSISR(r1)
>>  #endif /* CONFIG_PPC_STD_MMU_64 */
>> 
>>  /* Here we have a page fault that hash_page can't handle. */
>>  handle_page_fault:
>
> As always, thanks Michael!
>
> I think we can optimize this a bit more to eliminate the loads in
> handle_page_fault. Here's an incremental patch above your changes for
> -next, this time boot-tested with radix and disable_radix.
>
> - Naveen
>
> -----
> [PATCH] powerpc64/exceptions64s: Eliminate a few un-necessary memory loads
>
> In do_hash_page(), we re-load DSISR from stack though it is still present
> in register r4. Eliminate the memory load by preserving this register.
>
> Furthermore, handler_page_fault() reloads DAR and DSISR from memory and
> this is only required if we fall through from do_hash_page().
> Otherwise, r3 and r4 already have DAR and DSISR loaded. Re-use those
> and have do_hash_page() reload those registers when falling-through.
>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/exceptions-64s.S | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index dd619faab862..b5182a1ef3d6 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -1426,8 +1426,8 @@ do_hash_page:
>  	 *
>  	 * at return r3 = 0 for success, 1 for page fault, negative for error
>  	 */
> +	mr	r6,r4
>          mr 	r4,r12
> -	ld      r6,_DSISR(r1)
>  	bl	__hash_page		/* build HPTE if possible */
>          cmpdi	r3,0			/* see if __hash_page succeeded */
>
> @@ -1437,7 +1437,8 @@ do_hash_page:
>  	/* Error */
>  	blt-	13f
>
> -	/* Reload DSISR into r4 for the DABR check below */
> +	/* Reload DAR/DSISR for handle_page_fault */
> +	ld	r3,_DAR(r1)
>  	ld      r4,_DSISR(r1)
>  #endif /* CONFIG_PPC_STD_MMU_64 */
>
> @@ -1445,8 +1446,8 @@ do_hash_page:
>  handle_page_fault:
>  	andis.  r0,r4,DSISR_DABRMATCH@h
>  	bne-    handle_dabr_fault
> -	ld	r4,_DAR(r1)
> -	ld	r5,_DSISR(r1)
> +	mr	r5,r4
> +	mr	r4,r3
>  	addi	r3,r1,STACK_FRAME_OVERHEAD
>  	bl	do_page_fault
>  	cmpdi	r3,0


Can we avoid that if we rearrange args of other functions calls, so that
we can use r3 and r4 as it is ?

-anees
