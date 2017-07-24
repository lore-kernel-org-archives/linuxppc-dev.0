Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGG866xwLzDqtL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 19:21:10 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6O9KBCP030424
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 05:21:08 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bw4r699qn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 05:21:08 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 24 Jul 2017 19:21:05 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6O9Jl8922806772
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 19:19:47 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6O9JlnU020426
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 19:19:47 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, benh@kernel.crashing.org,
 paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Build fix for non SPARSEMEM_VMEMAP config
In-Reply-To: <878tkbbav2.fsf@concordia.ellerman.id.au>
References: <1498630168-26376-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <bb344453-f49d-aff1-8f9c-732b8a40cbfa@ozlabs.ru>
 <bb3cb2f5-12dd-0b0d-0b2a-ca5de2d1f6bf@linux.vnet.ibm.com>
 <878tkbbav2.fsf@concordia.ellerman.id.au>
Date: Mon, 24 Jul 2017 14:49:45 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87fudmqjim.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
>
>> On Wednesday 28 June 2017 12:48 PM, Alexey Kardashevskiy wrote:
>>> On 28/06/17 16:09, Aneesh Kumar K.V wrote:
>>>> We can use pfn_to_page in realmode for other configs. Hence remove the
>>>> CONFIG_FLATMEM ifdef
>>> 
>>> For CONFIG_SPARSEMEM and CONFIG_DISCONTIGMEM and others (I am struggling to
>>> find the full list :) )? Are you sure about that? If I recall correctly, at
>>> the time realmode_pfn_to_page() could not work for all of them, what changed?
>>
>> That is one thing I wanted to check. Everything other than 
>> SPARSEMEM_VMEMMAP should use linear mapping which can work with real 
>> mode also right ? Or am i missing something ?
>
> I think that's right. But I'm going to make you test it anyway :)

Tested this by printing page->flags with FLATMEM, SPARSEMEM and
SPARSEMEM_VMEMMAP in kvm real mode handler.

-aneesh
