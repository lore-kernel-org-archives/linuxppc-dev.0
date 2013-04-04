Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B28752C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2013 19:38:28 +1100 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 4 Apr 2013 14:05:32 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id BBDC61258023
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2013 14:09:39 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r348cCig42139878
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Apr 2013 14:08:13 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r348cGL5021084
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Apr 2013 19:38:17 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Simon Jeons <simon.jeons@gmail.com>
Subject: Re: [PATCH -V5 00/25] THP support for PPC64
In-Reply-To: <515D1A2C.1000606@gmail.com>
References: <1365055083-31956-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <515D1A2C.1000606@gmail.com>
Date: Thu, 04 Apr 2013 14:08:15 +0530
Message-ID: <878v4y4rns.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Simon Jeons <simon.jeons@gmail.com> writes:

> Hi Aneesh,
> On 04/04/2013 01:57 PM, Aneesh Kumar K.V wrote:
>> Hi,
>>
>> This patchset adds transparent hugepage support for PPC64.
>>
>> TODO:
>> * hash preload support in update_mmu_cache_pmd (we don't do that for hugetlb)
>>
>> Some numbers:
>>
>> The latency measurements code from Anton  found at
>> http://ozlabs.org/~anton/junkcode/latency2001.c
>>
>> THP disabled 64K page size
>> ------------------------
>> [root@llmp24l02 ~]# ./latency2001 8G
>>   8589934592    731.73 cycles    205.77 ns
>> [root@llmp24l02 ~]# ./latency2001 8G
>>   8589934592    743.39 cycles    209.05 ns
>
> Could you explain what's the meaning of result?
>

That is the total memory range, cycles taken to access an address and
time taken to access. That numbers shows the overhead of tlb miss.

you can find the source at http://ozlabs.org/~anton/junkcode/latency2001.c


-aneesh
