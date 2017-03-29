Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vtGLt61zCzDqGp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 16:20:54 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2T5Davr022023
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 01:20:52 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29ft6g7byu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 01:20:52 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 29 Mar 2017 01:20:51 -0400
Subject: Re: [PATCH V5 01/17] powerpc/mm/slice: Convert slice_mask high slice
 to a bitmap
To: Paul Mackerras <paulus@ozlabs.org>
References: <1490153823-29241-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1490153823-29241-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20170329031153.GA13844@fergus.ozlabs.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 29 Mar 2017 10:50:40 +0530
MIME-Version: 1.0
In-Reply-To: <20170329031153.GA13844@fergus.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <a94cb96c-f808-1fa4-8116-fa4d48bfcf8c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 29 March 2017 08:41 AM, Paul Mackerras wrote:
> On Wed, Mar 22, 2017 at 09:06:47AM +0530, Aneesh Kumar K.V wrote:
>> In followup patch we want to increase the va range which will result
>> in us requiring high_slices to have more than 64 bits. To enable this
>> convert high_slices to bitmap. We keep the number bits same in this patch
>> and later change that to higher value
>
> See comment below...
>
>> @@ -531,8 +569,8 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>>  	slice_print_mask(" mask", mask);
>>
>>   convert:
>> -	andnot_mask(mask, good_mask);
>> -	andnot_mask(mask, compat_mask);
>> +	slice_andnot_mask(&mask, &good_mask);
>> +	slice_andnot_mask(&mask, &compat_mask);
>>  	if (mask.low_slices || mask.high_slices) {
>
> The test on mask.high_slices here wants to test whether high_slices
> has any bits set, but with the conversion to a bitmap, the test will
> be always true since what will be tested is the address of the array
> in the bitmap.
>

Thanks for the review. How about the below change ?


diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index f808f99372e4..252d90b7c3c5 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -588,7 +588,7 @@ unsigned long slice_get_unmapped_area(unsigned long 
addr, unsigned long len,
   convert:
         slice_andnot_mask(&mask, &good_mask);
         slice_andnot_mask(&mask, &compat_mask);
-       if (mask.low_slices || mask.high_slices) {
+       if (mask.low_slices || !bitmap_empty(mask.high_slices, 
SLICE_NUM_HIGH)) {
                 slice_convert(mm, mask, psize);
                 if (psize > MMU_PAGE_BASE)
                         on_each_cpu(slice_flush_segments, mm, 1);
