Return-Path: <srs0=upuz=la=linux.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41sLQV5SKSzDqm6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 21:22:26 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41sLQV4n7Mz8tCx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 21:22:26 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41sLQT6zv7z9s5b
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2018 21:22:25 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7HBIoVK051467
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2018 07:22:23 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kwuwfkdty-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2018 07:22:23 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.ibm.com>;
 Fri, 17 Aug 2018 12:22:21 +0100
Subject: Re: [PATCH v7 4/9] powerpc/pseries: Define MCE error event section.
To: Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michal Suchanek <msuchanek@suse.com>, Ananth Narayan <ananth@in.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>
References: <153365127532.14256.1965469477086140841.stgit@jupiter.in.ibm.com>
 <153365141396.14256.7147876868875454254.stgit@jupiter.in.ibm.com>
 <87r2j8apj1.fsf@concordia.ellerman.id.au>
 <13f8280f-02c1-7b00-0a40-a045bf6ee1f6@linux.vnet.ibm.com>
 <87lg97aqxc.fsf@concordia.ellerman.id.au>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.ibm.com>
Date: Fri, 17 Aug 2018 16:52:16 +0530
MIME-Version: 1.0
In-Reply-To: <87lg97aqxc.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <6e1a8b53-c040-f594-fb5b-5c82dff1ce25@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/16/2018 09:44 AM, Michael Ellerman wrote:
> Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> writes:
>> On 08/08/2018 08:12 PM, Michael Ellerman wrote:
> ...
>>>
>>>> +	union {
>>>> +		struct {
>>>> +			uint8_t	ue_err_type;
>>>> +			/* XXXXXXXX
>>>> +			 * X		1: Permanent or Transient UE.
>>>> +			 *  X		1: Effective address provided.
>>>> +			 *   X		1: Logical address provided.
>>>> +			 *    XX	2: Reserved.
>>>> +			 *      XXX	3: Type of UE error.
>>>> +			 */
>>>
>>> But which bit is bit 0? And is that the LSB or MSB?
>>
>> RTAS errorlog data in BE format, the leftmost bit is MSB 0 (1: Permanent
>> or Transient UE.). I Will update the comment above that properly points
>> out which one is MSB 0.
>>
>>>
>>>
>>>> +			uint8_t	reserved_1[6];
>>>> +			__be64	effective_address;
>>>> +			__be64	logical_address;
>>>> +		} ue_error;
>>>> +		struct {
>>>> +			uint8_t	soft_err_type;
>>>> +			/* XXXXXXXX
>>>> +			 * X		1: Effective address provided.
>>>> +			 *  XXXXX	5: Reserved.
>>>> +			 *       XX	2: Type of SLB/ERAT/TLB error.
>>>> +			 */
>>>> +			uint8_t	reserved_1[6];
>>>> +			__be64	effective_address;
>>>> +			uint8_t	reserved_2[8];
>>>> +		} soft_error;
>>>> +	} u;
>>>> +};
>>>> +#pragma pack(pop)
>>>
>>> Why not __packed ?
>>
>> Because when used __packed it added 1 byte extra padding between
>> reserved_1[6] and effective_address. That caused wrong effective address
>> to be printed on the console. Hence I switched to #pragma pack to force
>> 1 byte alignment for this structure alone.
> 
> OK, that's weird.
> 
> Do we really need to bother with all the union stuff? The only
> difference is the field names, and whether logical address has a value

Also the bit fields for UE and other sub errors differ. Yeah but we can
do away with union stuff.

> or not. What about:
> 
> struct pseries_mc_errorlog {
> 	__be32	fru_id;
> 	__be32	proc_id;
> 	u8	error_type;
> 	u8	sub_error_type;
> 	u8	reserved_1[6];
> 	__be64	effective_address;
> 	__be64	logical_address;
> } __packed;

Sure will do.

Thanks
-Mahesh.

> 
> cheers
> 
