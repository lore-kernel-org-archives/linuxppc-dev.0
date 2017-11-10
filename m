Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yY6dD2KKszDrKG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Nov 2017 15:34:40 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc64/exceptions: Refactor code to eliminate a few
 memory loads
In-Reply-To: <20170619184545.28848-1-naveen.n.rao@linux.vnet.ibm.com>
References: <8760fsb902.fsf@skywalker.in.ibm.com>
 <20170619184545.28848-1-naveen.n.rao@linux.vnet.ibm.com>
Date: Fri, 10 Nov 2017 15:34:39 +1100
Message-ID: <874lq2px9c.fsf@concordia.ellerman.id.au>
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

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:

> On 2017/06/19 03:21PM, Aneesh Kumar K.V wrote:
>> > @@ -1445,8 +1446,8 @@ do_hash_page:
>> >  handle_page_fault:
>> >  	andis.  r0,r4,DSISR_DABRMATCH@h
>> >  	bne-    handle_dabr_fault
>> > -	ld	r4,_DAR(r1)
>> > -	ld	r5,_DSISR(r1)
>> > +	mr	r5,r4
>> > +	mr	r4,r3
>> >  	addi	r3,r1,STACK_FRAME_OVERHEAD
>> >  	bl	do_page_fault
>> >  	cmpdi	r3,0
>> 
>> 
>> Can we avoid that if we rearrange args of other functions calls, so that
>> we can use r3 and r4 as it is ?
>
> Here's a version that does that. Again, boot tested with radix and 
> disable_radix.
>
> Thanks,
> Naveen
>
> -
> Change data_access_common() and instruction_access_common() to load the
> trap number in r3, DAR in r4 and DSISR in r5 (rather than in r5, r3 and
> r4 respectively). This change allows us to eliminate a few un-necessary
> memory loads and register move operations in handle_page_fault(),
> handle_dabr_fault() and label '77'.
>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/exceptions-64s.S | 38 +++++++++++++++++-------------------
>  1 file changed, 18 insertions(+), 20 deletions(-)

Sorry I missed this and now it doesn't apply. Do you mind rebasing.

cheers
