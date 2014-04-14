Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B468514007F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Apr 2014 19:01:34 +1000 (EST)
Message-ID: <534BA3E8.6090504@suse.de>
Date: Mon, 14 Apr 2014 11:01:28 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: liu ping fan <qemulist@gmail.com>
Subject: Re: [PATCH v3] powerpc: kvm: make _PAGE_NUMA take effect
References: <1397216707-12795-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <3DC9A8E1-547C-4660-AB61-BE371DEDA520@suse.de>
 <CAFgQCTsbr9_Y24upMSuOTqdO-gAVySBxW=o6uK2UKHk9=uQihw@mail.gmail.com>
 <534B8384.7050500@suse.de>
 <CAJnKYQ=0dpuO3XBQDpxBi=M_diwVRwA8wa-+JMXnFXYyAPVw-Q@mail.gmail.com>
In-Reply-To: <CAJnKYQ=0dpuO3XBQDpxBi=M_diwVRwA8wa-+JMXnFXYyAPVw-Q@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Liu Ping Fan <pingfank@linux.vnet.ibm.com>,
 "kvm@vger.kernel.org mailing list" <kvm@vger.kernel.org>,
 kvm-ppc <kvm-ppc@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 Liu ping fan <kernelfans@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 14.04.14 10:08, liu ping fan wrote:
> On Mon, Apr 14, 2014 at 2:43 PM, Alexander Graf <agraf@suse.de> wrote:
>> On 13.04.14 04:27, Liu ping fan wrote:
>>> On Fri, Apr 11, 2014 at 10:03 PM, Alexander Graf <agraf@suse.de> wrote:
>>>> On 11.04.2014, at 13:45, Liu Ping Fan <pingfank@linux.vnet.ibm.com>
>>>> wrote:
>>>>
>>>>> When we mark pte with _PAGE_NUMA we already call
>>>>> mmu_notifier_invalidate_range_start
>>>>> and mmu_notifier_invalidate_range_end, which will mark existing guest
>>>>> hpte
>>>>> entry as HPTE_V_ABSENT. Now we need to do that when we are inserting new
>>>>> guest hpte entries.
>>>> What happens when we don't? Why do we need the check? Why isn't it done
>>>> implicitly? What happens when we treat a NUMA marked page as non-present?
>>>> Why does it work out for us?
>>>>
>>>> Assume you have no idea what PAGE_NUMA is, but try to figure out what
>>>> this patch does and whether you need to cherry-pick it into your downstream
>>>> kernel. The description as is still is not very helpful for that. It doesn't
>>>> even explain what really changes with this patch applied.
>>>>
>>> Yeah.  what about appending the following description?  Can it make
>>> the context clear?
>>> "Guest should not setup a hpte for the page whose pte is marked with
>>> _PAGE_NUMA, so on the host, the numa-fault mechanism can take effect
>>> to check whether the page is placed correctly or not."
>>
>> Try to come up with a text that answers the following questions in order:
>>
> I divide them into 3 groups, and answer them by 3 sections. Seems that
> it has the total story :)
> Please take a look.
>
>>    - What does _PAGE_NUMA mean?
> Group 1 -> section 2
>
>>    - How does page migration with _PAGE_NUMA work?
>>    -> Why should we not map pages when _PAGE_NUMA is set?
> Group 2 -> section 1
> (Note: for the 1st question in this group, I am not sure about the
> details, except that we can fix numa balancing by moving task or
> moving page.  So I comment as " migration should be involved to cut
> down the distance between the cpu and pages")
>
>>    - Which part of what needs to be done did the previous _PAGE_NUMA patch
>> address?
>>    - What's the situation without this patch?
>>    - Which scenario does this patch fix?
>>
> Group 3 -> section 3
>
>
> Numa fault is a method which help to achieve auto numa balancing.
> When such a page fault takes place, the page fault handler will check
> whether the page is placed correctly. If not, migration should be
> involved to cut down the distance between the cpu and pages.
>
> A pte with _PAGE_NUMA help to implement numa fault. It means not to
> allow the MMU to access the page directly. So a page fault is triggered
> and numa fault handler gets the opportunity to run checker.
>
> As for the access of MMU, we need special handling for the powernv's guest.
> When we mark a pte with _PAGE_NUMA, we already call mmu_notifier to
> invalidate it in guest's htab, but when we tried to re-insert them,
> we firstly try to fix it in real-mode. Only after this fails, we fallback
> to virt mode, and most of important, we run numa fault handler in virt
> mode.  This patch guards the way of real-mode to ensure that if a pte is
> marked with _PAGE_NUMA, it will NOT be fixed in real mode, instead, it will
> be fixed in virt mode and have the opportunity to be checked with placement.

s/fixed/mapped/g

Otherwise works as patch description for me :).


Alex
