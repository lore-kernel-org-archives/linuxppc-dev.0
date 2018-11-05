Return-Path: <SRS0=pi+/=NQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D927C0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 20:13:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F14720819
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 20:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F14720819
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=liunx.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42pkQ32lmmzDr3b
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 07:13:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=liunx.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=liunx.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=ldufour@liunx.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=liunx.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42pgz26RgDzF1XR
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2018 05:23:10 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wA5IKItr178584
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Nov 2018 13:23:08 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2njsd8wa2t-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Nov 2018 13:23:07 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@liunx.vnet.ibm.com>;
 Mon, 5 Nov 2018 18:23:05 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 5 Nov 2018 18:22:55 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wA5IMs4x60620884
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 5 Nov 2018 18:22:54 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C11EF4C044;
 Mon,  5 Nov 2018 18:22:54 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 86E934C04E;
 Mon,  5 Nov 2018 18:22:50 +0000 (GMT)
Received: from pomme.local (unknown [9.145.22.14])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  5 Nov 2018 18:22:50 +0000 (GMT)
Subject: Re: [PATCH v11 10/26] mm: protect VMA modifications using VMA
 sequence count
To: vinayak menon <vinayakm.list@gmail.com>
References: <1526555193-7242-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1526555193-7242-11-git-send-email-ldufour@linux.vnet.ibm.com>
 <CAOaiJ-nJ_=+diXz8ji42Rro3Mj16C1=NpenRuY3-mjs_GhR4mA@mail.gmail.com>
From: Laurent Dufour <ldufour@liunx.vnet.ibm.com>
Date: Mon, 5 Nov 2018 19:22:50 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAOaiJ-nJ_=+diXz8ji42Rro3Mj16C1=NpenRuY3-mjs_GhR4mA@mail.gmail.com>
Content-Type: multipart/mixed; boundary="------------DA83A55C36818F3EBAB536C7"
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18110518-0008-0000-0000-0000028BB13D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110518-0009-0000-0000-000021F5E701
Message-Id: <239bab9c-e38c-951d-9114-34227b1dc94c@liunx.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-05_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811050163
X-Mailman-Approved-At: Tue, 06 Nov 2018 07:02:16 +1100
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: jack@suse.cz, sergey.senozhatsky.work@gmail.com,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>,
 Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, paulus@samba.org,
 punitagrawal@gmail.com, hpa@zytor.com,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, khandual@linux.vnet.ibm.com,
 Andrea Arcangeli <aarcange@redhat.com>, ak@linux.intel.com,
 Minchan Kim <minchan@kernel.org>, x86@kernel.org,
 Matthew Wilcox <willy@infradead.org>,
 Daniel Jordan <daniel.m.jordan@oracle.com>, Ingo Molnar <mingo@redhat.com>,
 David Rientjes <rientjes@google.com>,
 Paul McKenney <paulmck@linux.vnet.ibm.com>, npiggin@gmail.com,
 Jerome Glisse <jglisse@redhat.com>, dave@stgolabs.net, kemi.wang@intel.com,
 kirill@shutemov.name, Thomas Gleixner <tglx@linutronix.de>,
 Ganesh Mahendran <opensource.ganesh@gmail.com>, yang.shi@linux.alibaba.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Vinayak Menon <vinmenon@codeaurora.org>, aneesh.kumar@linux.vnet.ibm.com,
 Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>, haren@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This is a multi-part message in MIME format.
--------------DA83A55C36818F3EBAB536C7
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 05/11/2018 à 08:04, vinayak menon a écrit :
> Hi Laurent,
> 
> On Thu, May 17, 2018 at 4:37 PM Laurent Dufour
> <ldufour@linux.vnet.ibm.com> wrote:
>>
>> The VMA sequence count has been introduced to allow fast detection of
>> VMA modification when running a page fault handler without holding
>> the mmap_sem.
>>
>> This patch provides protection against the VMA modification done in :
>>          - madvise()
>>          - mpol_rebind_policy()
>>          - vma_replace_policy()
>>          - change_prot_numa()
>>          - mlock(), munlock()
>>          - mprotect()
>>          - mmap_region()
>>          - collapse_huge_page()
>>          - userfaultd registering services
>>
>> In addition, VMA fields which will be read during the speculative fault
>> path needs to be written using WRITE_ONCE to prevent write to be split
>> and intermediate values to be pushed to other CPUs.
>>
>> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
>> ---
>>   fs/proc/task_mmu.c |  5 ++++-
>>   fs/userfaultfd.c   | 17 +++++++++++++----
>>   mm/khugepaged.c    |  3 +++
>>   mm/madvise.c       |  6 +++++-
>>   mm/mempolicy.c     | 51 ++++++++++++++++++++++++++++++++++-----------------
>>   mm/mlock.c         | 13 ++++++++-----
>>   mm/mmap.c          | 22 +++++++++++++---------
>>   mm/mprotect.c      |  4 +++-
>>   mm/swap_state.c    |  8 ++++++--
>>   9 files changed, 89 insertions(+), 40 deletions(-)
>>
>>   struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
>>                                  struct vm_fault *vmf)
>> @@ -665,9 +669,9 @@ static inline void swap_ra_clamp_pfn(struct vm_area_struct *vma,
>>                                       unsigned long *start,
>>                                       unsigned long *end)
>>   {
>> -       *start = max3(lpfn, PFN_DOWN(vma->vm_start),
>> +       *start = max3(lpfn, PFN_DOWN(READ_ONCE(vma->vm_start)),
>>                        PFN_DOWN(faddr & PMD_MASK));
>> -       *end = min3(rpfn, PFN_DOWN(vma->vm_end),
>> +       *end = min3(rpfn, PFN_DOWN(READ_ONCE(vma->vm_end)),
>>                      PFN_DOWN((faddr & PMD_MASK) + PMD_SIZE));
>>   }
>>
>> --
>> 2.7.4
>>
> 
> I have got a crash on 4.14 kernel with speculative page faults enabled
> and here is my analysis of the problem.
> The issue was reported only once.

Hi Vinayak,

Thanks for reporting this.

> 
> [23409.303395]  el1_da+0x24/0x84
> [23409.303400]  __radix_tree_lookup+0x8/0x90
> [23409.303407]  find_get_entry+0x64/0x14c
> [23409.303410]  pagecache_get_page+0x5c/0x27c
> [23409.303416]  __read_swap_cache_async+0x80/0x260
> [23409.303420]  swap_vma_readahead+0x264/0x37c
> [23409.303423]  swapin_readahead+0x5c/0x6c
> [23409.303428]  do_swap_page+0x128/0x6e4
> [23409.303431]  handle_pte_fault+0x230/0xca4
> [23409.303435]  __handle_speculative_fault+0x57c/0x7c8
> [23409.303438]  do_page_fault+0x228/0x3e8
> [23409.303442]  do_translation_fault+0x50/0x6c
> [23409.303445]  do_mem_abort+0x5c/0xe0
> [23409.303447]  el0_da+0x20/0x24
> 
> Process A accesses address ADDR (part of VMA A) and that results in a
> translation fault.
> Kernel enters __handle_speculative_fault to fix the fault.
> Process A enters do_swap_page->swapin_readahead->swap_vma_readahead
> from speculative path.
> During this time, another process B which shares the same mm, does a
> mprotect from another CPU which follows
> mprotect_fixup->__split_vma, and it splits VMA A into VMAs A and B.
> After the split, ADDR falls into VMA B, but process A is still using
> VMA A.
> Now ADDR is greater than VMA_A->vm_start and VMA_A->vm_end.
> swap_vma_readahead->swap_ra_info uses start and end of vma to
> calculate ptes and nr_pte, which goes wrong due to this and finally
> resulting in wrong "entry" passed to
> swap_vma_readahead->__read_swap_cache_async, and in turn causing
> invalid swapper_space
> being passed to __read_swap_cache_async->find_get_page, causing an abort.
> 
> The fix I have tried is to cache vm_start and vm_end also in vmf and
> use it in swap_ra_clamp_pfn. Let me know your thoughts on this. I can
> send
> the patch I am a using if you feel that is the right thing to do.

I think the best would be to don't do swap readahead during the 
speculatvive page fault. If the page is found in the swap cache, that's 
fine, but otherwise, we should f	allback to the regular page fault.

The attached -untested- patch is doing this, if you want to give it a 
try. I'll review that for the next series.

Thanks,
Laurent.

--------------DA83A55C36818F3EBAB536C7
Content-Type: text/plain; charset=UTF-8; x-mac-type="0"; x-mac-creator="0";
 name="0001-mm-don-t-do-swap-readahead-during-speculative-page-f.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-mm-don-t-do-swap-readahead-during-speculative-page-f.pa";
 filename*1="tch"

RnJvbSAwNTZhZmFmYjBiY2NlYTZhMzU2ZjgwZjQyNTNmZmNkM2VmNGExZjhkIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBMYXVyZW50IER1Zm91ciA8bGR1Zm91ckBsaW51eC52
bmV0LmlibS5jb20+CkRhdGU6IE1vbiwgNSBOb3YgMjAxOCAxODo0MzowMSArMDEwMApTdWJq
ZWN0OiBbUEFUQ0hdIG1tOiBkb24ndCBkbyBzd2FwIHJlYWRhaGVhZCBkdXJpbmcgc3BlY3Vs
YXRpdmUgcGFnZSBmYXVsdAoKVmluYXlhayBNZW5vbiBmYWNlZCBhIHBhbmljIGJlY2F1c2Ug
b25lIHRocmVhZCB3YXMgcGFnZSBmYXVsdGluZyBhIHBhZ2UgaW4Kc3dhcCwgd2hpbGUgYW5v
dGhlciBvbmUgd2FzIG1wcm90ZWN0aW5nIGEgcGFydCBvZiB0aGUgVk1BIGxlYWRpbmcgdG8g
YSBWTUEKc3BsaXQuClRoaXMgcmFpc2UgYSBwYW5pYyBpbiBzd2FwX3ZtYV9yZWFkYWhlYWQo
KSBiZWNhdXNlIHRoZSBWTUEncyBib3VuZGFyaWVzCndlcmUgbm90IG1vcmUgbWF0Y2hpbmcg
dGhlIGZhdWx0aW5nIGFkZHJlc3MuCgpUbyBhdm9pZCB0aGlzLCBpZiB0aGUgcGFnZSBpcyBu
b3QgZm91bmQgaW4gdGhlIHN3YXAsIHRoZSBzcGVjdWxhdGl2ZSBwYWdlCmZhdWx0IGlzIGFi
b3J0ZWQgdG8gcmV0cnkgYSByZWd1bGFyIHBhZ2UgZmF1bHQuCgpTaWduZWQtb2ZmLWJ5OiBM
YXVyZW50IER1Zm91ciA8bGR1Zm91ckBsaW51eC52bmV0LmlibS5jb20+Ci0tLQogbW0vbWVt
b3J5LmMgfCAxMCArKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygr
KQoKZGlmZiAtLWdpdCBhL21tL21lbW9yeS5jIGIvbW0vbWVtb3J5LmMKaW5kZXggOWRkNWZm
ZWIxZjdlLi43MjBkYzlhMWI5OWYgMTAwNjQ0Ci0tLSBhL21tL21lbW9yeS5jCisrKyBiL21t
L21lbW9yeS5jCkBAIC0zMTM5LDYgKzMxMzksMTYgQEAgdm1fZmF1bHRfdCBkb19zd2FwX3Bh
Z2Uoc3RydWN0IHZtX2ZhdWx0ICp2bWYpCiAJCQkJbHJ1X2NhY2hlX2FkZF9hbm9uKHBhZ2Up
OwogCQkJCXN3YXBfcmVhZHBhZ2UocGFnZSwgdHJ1ZSk7CiAJCQl9CisJCX0gZWxzZSBpZiAo
dm1mLT5mbGFncyAmIEZBVUxUX0ZMQUdfU1BFQ1VMQVRJVkUpIHsKKwkJCS8qCisJCQkgKiBE
b24ndCB0cnkgcmVhZGFoZWFkIGR1cmluZyBhIHNwZWN1bGF0aXZlIHBhZ2UgZmF1bHQgYXMK
KwkJCSAqIHRoZSBWTUEncyBib3VuZGFyaWVzIG1heSBjaGFuZ2UgaW4gb3VyIGJhY2suCisJ
CQkgKiBJZiB0aGUgcGFnZSBpcyBub3QgaW4gdGhlIHN3YXAgY2FjaGUgYW5kIHN5bmNocm9u
b3VzIHJlYWQKKwkJCSAqIGlzIGRpc2FibGVkLCBmYWxsIGJhY2sgdG8gdGhlIHJlZ3VsYXIg
cGFnZSBmYXVsdCBtZWNoYW5pc20uCisJCQkgKi8KKwkJCWRlbGF5YWNjdF9jbGVhcl9mbGFn
KERFTEFZQUNDVF9QRl9TV0FQSU4pOworCQkJcmV0ID0gVk1fRkFVTFRfUkVUUlk7CisJCQln
b3RvIG91dDsKIAkJfSBlbHNlIHsKIAkJCXBhZ2UgPSBzd2FwaW5fcmVhZGFoZWFkKGVudHJ5
LCBHRlBfSElHSFVTRVJfTU9WQUJMRSwKIAkJCQkJCXZtZik7Ci0tIAoyLjE5LjEKCg==
--------------DA83A55C36818F3EBAB536C7--

