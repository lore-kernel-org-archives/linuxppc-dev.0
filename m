Return-Path: <geoff@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tMV2m1nS5zDvNk
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 11:33:52 +1100 (AEDT)
Subject: Re: [V2,10/68] powerpc/mm: Update _PAGE_KERNEL_RO
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
References: <1460182444-2468-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <rep.1421449714.geoff@infradead.org> <8760ni2flp.fsf@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Geoff Levand <geoff@infradead.org>
Message-ID: <adbd0bd1-f483-5da7-17ec-0ce0847b9143@infradead.org>
Date: Sun, 20 Nov 2016 16:33:48 -0800
MIME-Version: 1.0
In-Reply-To: <8760ni2flp.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Aneesh,

On 11/20/2016 10:03 AM, Aneesh Kumar K.V wrote: 
> So I am trying to understand what the PPP bit value should be. I haven't
> studied PS3 enough to figure this out myself. So we use the SLB class
> value of 0 for the kernel and 1 for user. What is the expected PPP bit
> value for the above ioremap range ? Once we clarify that may be we can figure out
> a way to express that in linux page table and later map that correctly
> in hash fault.
> 
> Right now we map PPP bits as below:
> 
> kernel RW = 0b000 -> class 1 /user no access
> kernel RO = 0b110 -> class 1 /user no access
> USER RW   = 0b010 -> class 0/kernel RW
> USER RO   = 0b011 -> class 1/kernel RO

I don't quite understand what is meant by these PPP bits and how
those relate to the documented PTE bits.

As for the PS3's spu shadow registers, they are read-only, and
only used within the kernel, actually, only within
platforms/ps3/spu.c.

Here is a test I did that looped varying rflags.

ps3_hpte_insert: rflags=0 result=LV1_ACCESS_VIOLATION (-5)
ps3_hpte_insert: rflags=1 result=LV1_ACCESS_VIOLATION (-5)
ps3_hpte_insert: rflags=2 result=LV1_ACCESS_VIOLATION (-5)
ps3_hpte_insert: rflags=3 result=LV1_SUCCESS (0)
ps3_hpte_insert: rflags=4 result=LV1_ACCESS_VIOLATION (-5)
ps3_hpte_insert: rflags=5 result=LV1_ACCESS_VIOLATION (-5)
ps3_hpte_insert: rflags=6 result=LV1_ACCESS_VIOLATION (-5)
ps3_hpte_insert: rflags=7 result=LV1_SUCCESS (0)
ps3_hpte_insert: rflags=8 result=LV1_ACCESS_VIOLATION (-5)
ps3_hpte_insert: rflags=9 result=LV1_ACCESS_VIOLATION (-5)
ps3_hpte_insert: rflags=a result=LV1_ACCESS_VIOLATION (-5)
ps3_hpte_insert: rflags=b result=LV1_SUCCESS (0)
ps3_hpte_insert: rflags=c result=LV1_ACCESS_VIOLATION (-5)
ps3_hpte_insert: rflags=d result=LV1_ACCESS_VIOLATION (-5)
ps3_hpte_insert: rflags=e result=LV1_ACCESS_VIOLATION (-5)
ps3_hpte_insert: rflags=f result=LV1_SUCCESS (0)

Please let me know what other info you need.

-Geoff
