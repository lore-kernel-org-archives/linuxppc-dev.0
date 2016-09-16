Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sb4Tq0X5VzDsZM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 16:03:43 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id pp5so3036566pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 23:03:42 -0700 (PDT)
Subject: Re: [V2] powerpc/Kconfig: Update config option based on page size.
To: santhosh <santhog4@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Rashmica Gupta <rashmicy@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
References: <3qk8fY48r6z9t45@ozlabs.org> <87y4893ar2.fsf@skywalker.in.ibm.com>
 <0d167ff1-cc0e-35bc-479c-aec77d2c8556@linux.vnet.ibm.com>
Cc: manvanth@linux.vnet.ibm.com
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <1e406f4d-25bc-c92b-8a5e-5d59ae28a274@gmail.com>
Date: Fri, 16 Sep 2016 16:03:28 +1000
MIME-Version: 1.0
In-Reply-To: <0d167ff1-cc0e-35bc-479c-aec77d2c8556@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 14/09/16 20:40, santhosh wrote:
> 
>> Michael Ellerman <mpe@ellerman.id.au> writes:
>>
>>> On Fri, 2016-19-02 at 05:38:47 UTC, Rashmica Gupta wrote:
>>>> Currently on PPC64 changing kernel pagesize from 4K to 64K leaves
>>>> FORCE_MAX_ZONEORDER set to 13 - which produces a compile error.
>>>>
>>> ...
>>>> So, update the range of FORCE_MAX_ZONEORDER from 9-64 to 8-9 for 64K pages
>>>> and from 13-64 to 9-13 for 4K pages.
>>>>
>>>> Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
>>>> Reviewed-by: Balbir Singh <bsingharora@gmail.com>
>>> Applied to powerpc next, thanks.
>>>
>>> https://git.kernel.org/powerpc/c/a7ee539584acf4a565b7439cea
>>>
>> HPAGE_PMD_ORDER is not something we should check w.r.t 4k linux page
>> size. We do have the below constraint w.r.t hugetlb pages
>>
>> static inline bool hstate_is_gigantic(struct hstate *h)
>> {
>>     return huge_page_order(h) >= MAX_ORDER;
>> }
>>
>> That require MAX_ORDER to be greater than 12.
>>

9 to 13 was done based on calculations you can find the commit



>> Did we test hugetlbfs 4k config with this patch ? Will it work if we
>> start marking hugepage as gigantic page ?
>>
>> -aneesh
>>
> Hello Rashmica,
> 
> With upstream linux kernel 4.8.0-rc1-00006-gbae9cc6 compiled with linux 4k page size we are not able set hugepages, Aneesh had a look at the problem and he mentioned this commit is causing the issue.
> 
> *Details:*
> We are using pkvm ubuntu 16.04 guest with upstream kernel [4.8.0-rc1-00006-gbae9cc6] compiled with  4k page size
> 
> o/p from guest:
> HugePages_Total:       0
> HugePages_Free:        0
> HugePages_Rsvd:        0
> HugePages_Surp:        0
> Hugepagesize:      16384 kB
> 
> Page sizes from device-tree: [dmesg]
> [    0.000000] base_shift=12: shift=12, sllp=0x0000, avpnm=0x00000000, tlbiel=1, penc=0
> [    0.000000] base_shift=12: shift=24, sllp=0x0000, avpnm=0x00000000, tlbiel=1, penc=56
> [    0.000000] base_shift=24: shift=24, sllp=0x0100, avpnm=0x00000001, tlbiel=0, penc=0
> 
> while trying to configure the hugepages inside the guest it throws the below error:
> 
> echo 100 > /proc/sys/vm/nr_hugepages
> -bash: echo: write error: Invalid argument
> 
> *Note*: we do not see the problem when the linux page is 64k


Just to reiterate you are seeing this problem using 4k page size and 16M as the hugepage size.
With FORCE_MAX_ZONEORDER set to 9 to 13 for 4k pages, you can do upto 32M if FORCE_MAX_ZONEORDER
is 13 and same for 64K with FORCE_MAX_ZONEORDER set to 9.

Basically the constraint is


FORCE_MAX_ZONEBITS <= 25 - PAGESHIFT

What is your value of FORCE_MAX_ZONEORDER in the .config?

Balbir Singh.
