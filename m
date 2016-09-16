Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sbJmM06MrzDsZW
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Sep 2016 01:17:06 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8GF7pMi039813
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 11:17:04 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25fv64101d-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 11:17:03 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 16 Sep 2016 11:17:02 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>,
 santhosh <santhog4@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Rashmica Gupta <rashmicy@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: manvanth@linux.vnet.ibm.com
Subject: Re: [V2] powerpc/Kconfig: Update config option based on page size.
In-Reply-To: <1e406f4d-25bc-c92b-8a5e-5d59ae28a274@gmail.com>
References: <3qk8fY48r6z9t45@ozlabs.org> <87y4893ar2.fsf@skywalker.in.ibm.com>
 <0d167ff1-cc0e-35bc-479c-aec77d2c8556@linux.vnet.ibm.com>
 <1e406f4d-25bc-c92b-8a5e-5d59ae28a274@gmail.com>
Date: Fri, 16 Sep 2016 20:46:54 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87oa3nyivt.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> writes:

> On 14/09/16 20:40, santhosh wrote:
>> 
>>> Michael Ellerman <mpe@ellerman.id.au> writes:
>>>
>>>> On Fri, 2016-19-02 at 05:38:47 UTC, Rashmica Gupta wrote:
>>>>> Currently on PPC64 changing kernel pagesize from 4K to 64K leaves
>>>>> FORCE_MAX_ZONEORDER set to 13 - which produces a compile error.
>>>>>
>>>> ...
>>>>> So, update the range of FORCE_MAX_ZONEORDER from 9-64 to 8-9 for 64K pages
>>>>> and from 13-64 to 9-13 for 4K pages.
>>>>>
>>>>> Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
>>>>> Reviewed-by: Balbir Singh <bsingharora@gmail.com>
>>>> Applied to powerpc next, thanks.
>>>>
>>>> https://git.kernel.org/powerpc/c/a7ee539584acf4a565b7439cea
>>>>
>>> HPAGE_PMD_ORDER is not something we should check w.r.t 4k linux page
>>> size. We do have the below constraint w.r.t hugetlb pages
>>>
>>> static inline bool hstate_is_gigantic(struct hstate *h)
>>> {
>>>     return huge_page_order(h) >= MAX_ORDER;
>>> }
>>>
>>> That require MAX_ORDER to be greater than 12.
>>>
>
> 9 to 13 was done based on calculations you can find the commit
>
>
>
>>> Did we test hugetlbfs 4k config with this patch ? Will it work if we
>>> start marking hugepage as gigantic page ?
>>>
>>> -aneesh
>>>
>> Hello Rashmica,
>> 
>> With upstream linux kernel 4.8.0-rc1-00006-gbae9cc6 compiled with linux 4k page size we are not able set hugepages, Aneesh had a look at the problem and he mentioned this commit is causing the issue.
>> 
>> *Details:*
>> We are using pkvm ubuntu 16.04 guest with upstream kernel [4.8.0-rc1-00006-gbae9cc6] compiled with  4k page size
>> 
>> o/p from guest:
>> HugePages_Total:       0
>> HugePages_Free:        0
>> HugePages_Rsvd:        0
>> HugePages_Surp:        0
>> Hugepagesize:      16384 kB
>> 
>> Page sizes from device-tree: [dmesg]
>> [    0.000000] base_shift=12: shift=12, sllp=0x0000, avpnm=0x00000000, tlbiel=1, penc=0
>> [    0.000000] base_shift=12: shift=24, sllp=0x0000, avpnm=0x00000000, tlbiel=1, penc=56
>> [    0.000000] base_shift=24: shift=24, sllp=0x0100, avpnm=0x00000001, tlbiel=0, penc=0
>> 
>> while trying to configure the hugepages inside the guest it throws the below error:
>> 
>> echo 100 > /proc/sys/vm/nr_hugepages
>> -bash: echo: write error: Invalid argument
>> 
>> *Note*: we do not see the problem when the linux page is 64k
>
>
> Just to reiterate you are seeing this problem using 4k page size and 16M as the hugepage size.
> With FORCE_MAX_ZONEORDER set to 9 to 13 for 4k pages, you can do upto 32M if FORCE_MAX_ZONEORDER
> is 13 and same for 64K with FORCE_MAX_ZONEORDER set to 9.
>
> Basically the constraint is
>
>
> FORCE_MAX_ZONEBITS <= 25 - PAGESHIFT
>
> What is your value of FORCE_MAX_ZONEORDER in the .config?

The problem is the reverse of why the orginal fix was done. ie, When you
change the pae size from 64K to 4K using nconfig, we don't update the
FORCE_MAX_ZONEORDER and hence we end up a value of 9. That results in
the above error with hugetlb. So from a failed build when switching from
4k to 64K we now have a broken hugetlb when switching from 64K to 4K.

As suggested in the review of the original patch, we should make the 
FORCE_MAX_ZONEORDER range such that it picks the right value that will
get 16MB hugetlb to work.

Something like the below. That range is strange, but without that it picks a value
of 11.

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 927d2ab2ce08..792cb1768c8f 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -637,7 +637,7 @@ config FORCE_MAX_ZONEORDER
 	int "Maximum zone order"
 	range 8 9 if PPC64 && PPC_64K_PAGES
 	default "9" if PPC64 && PPC_64K_PAGES
-	range 9 13 if PPC64 && !PPC_64K_PAGES
+	range 13 13 if PPC64 && !PPC_64K_PAGES
 	default "13" if PPC64 && !PPC_64K_PAGES
 	range 9 64 if PPC32 && PPC_16K_PAGES
 	default "9" if PPC32 && PPC_16K_PAGES


-aneesh
