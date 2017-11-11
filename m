Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yYyqv0Z26zDrJy
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Nov 2017 00:46:50 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vABDiIrH097899
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Nov 2017 08:46:48 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e5wyeyrtu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Nov 2017 08:46:47 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 11 Nov 2017 13:46:46 -0000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, benh@kernel.crashing.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/64s/slice: Use addr limit when computing slice
 mask
In-Reply-To: <20171111200951.648f37c6@roar.ozlabs.ibm.com>
References: <20171110045507.30147-1-aneesh.kumar@linux.vnet.ibm.com>
 <87zi7uo4c9.fsf@concordia.ellerman.id.au> <87mv3urqi2.fsf@linux.vnet.ibm.com>
 <20171111200951.648f37c6@roar.ozlabs.ibm.com>
Date: Sat, 11 Nov 2017 19:16:39 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87k1yxrkqo.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> On Fri, 10 Nov 2017 22:59:57 +0530
> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:
>
>> Michael Ellerman <mpe@ellerman.id.au> writes:
>> 
>> > "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
>> >  
>> >> While computing slice mask for the free area we need make sure we only search
>> >> in the addr limit applicable for this mmap. We update the slb_addr_limit
>> >> after we request for a mmap above 128TB. But the following mmap request
>> >> with hint addr below 128TB should still limit its search to below 128TB. ie.
>> >> we should not use slb_addr_limit to compute slice mask in this case. Instead,
>> >> we should derive high addr limit based on the mmap hint addr value.
>> >>
>> >> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> >> ---
>> >>  arch/powerpc/mm/slice.c | 34 ++++++++++++++++++++++------------
>> >>  1 file changed, 22 insertions(+), 12 deletions(-)  
>> >
>> > How does this relate to the fixes Nick has sent?  
>> 
>> This patch is on top of the patch series sent by Nick. Without this
>> patch we will allocate memory across the 128TB range if hint_addr <
>> 128TB but hint_addr + len is more. Inorder to recreate this issue we
>> will have to map stack below. Hence one won't hit the error in general
>> case.
>
> I couldn't get it to trigger this case after that series -- hash
> get_unmapped_area should be excluding that case up front before
> getting into the slice allocator. Do you have an strace to reproduce
> it?

That is correct. This change in slice_get_unmapped_area prevents the
issue I mentioned above. I did have that hunk reverted to check the error
mask creation. 

-		if (addr > mm->task_size - len ||
+		if (addr > high_limit - len ||
 		    !slice_area_is_free(mm, addr, len))
 			addr = 0;
 	}


>
> Either way I do think it would be good to tighten up all the slice
> bitmap limits, including all the other places that hardcodes the
> max bitmap size.
>


-aneesh
