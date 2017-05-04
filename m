Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJhjw0qsjzDqBJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 May 2017 03:25:07 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v44HNwSp108355
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 13:24:58 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a86ge6r5a-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 May 2017 13:24:57 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Thu, 4 May 2017 18:24:55 +0100
Subject: Re: [RFC 1/2] powerpc/mm: Add marker for contexts requiring global
 TLB invalidations
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 alistair@popple.id.au, bsingharora@gmail.com,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
References: <20170503142906.29220-1-fbarrat@linux.vnet.ibm.com>
 <20170503142906.29220-2-fbarrat@linux.vnet.ibm.com>
 <87inlhp1iq.fsf@skywalker.in.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Thu, 4 May 2017 19:24:51 +0200
MIME-Version: 1.0
In-Reply-To: <87inlhp1iq.fsf@skywalker.in.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <848dceb7-1814-6123-df67-008db71ace0d@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 04/05/2017 à 08:41, Aneesh Kumar K.V a écrit :
> Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:
>
>> Introduce a new 'flags' attribute per context and define its first bit
>> to be a marker requiring all TLBIs for that context to be broadcasted
>> globally. Once that marker is set on a context, it cannot be removed.
>>
>> Such a marker is useful for memory contexts used by devices behind the
>> NPU and CAPP/PSL. The NPU and the PSL keep their own
>> translation cache so they need to see all the TLBIs for those
>> contexts.
>
> Can we also switch existing cxl_ctx_in_use() to this ?


That was my initial intent. But in the hash code, when calling the 
tlbie, it seems that we no longer have the related context handy. Or did 
I miss it? so it would require quite a bit of changes.

So I've just focused on fixing the pb for radix for the time being. That 
being said, we'll have to update what we do for hash if we ever want to 
support opencapi with hash/powervm (which seems like a strong 
possibility for next year), as we could have more than one opencapi drivers.

   Fred
