Return-Path: <kernelfans@gmail.com>
Received: from mail-yh0-x22b.google.com (mail-yh0-x22b.google.com
 [IPv6:2607:f8b0:4002:c01::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8A0AA140125
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Apr 2014 13:37:01 +1100 (EST)
Received: by mail-yh0-f43.google.com with SMTP id b6so1101688yha.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Apr 2014 19:36:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <C4D7ADEA-9CEB-4717-9AFD-CC8EFB18184A@suse.de>
References: <1390292129-15871-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <8761pdk6x5.fsf@linux.vnet.ibm.com>
 <C4D7ADEA-9CEB-4717-9AFD-CC8EFB18184A@suse.de>
Date: Thu, 3 Apr 2014 10:36:55 +0800
Message-ID: <CAFgQCTs8LSXUi+AwxR9j+2-QRGw4EFZWx-JxktAnJ3VvwLJb9A@mail.gmail.com>
Subject: Re: [PATCH v2] powernv: kvm: make _PAGE_NUMA take effect
From: Liu ping fan <kernelfans@gmail.com>
To: Alexander Graf <agraf@suse.de>
Content-Type: text/plain; charset=UTF-8
Cc: kvm-devel <kvm@vger.kernel.org>, kvm-ppc <kvm-ppc@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Alex, could you help to pick up this patch? since  v3.14 kernel can
enable numa fault for powerpc.

Thx,
Fan

On Mon, Jan 27, 2014 at 5:11 PM, Alexander Graf <agraf@suse.de> wrote:
>
> On 21.01.2014, at 10:42, Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> wrote:
>
>> Liu Ping Fan <kernelfans@gmail.com> writes:
>>
>>> To make sure that on host, the pages marked with _PAGE_NUMA result in a fault
>>> when guest access them, we should force the checking when guest uses hypercall
>>> to setup hpte.
>>>
>>> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
>>
>> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>>
>> When we mark pte with _PAGE_NUMA we already call mmu_notifier_invalidate_range_start and
>> mmu_notifier_invalidate_range_end, which will mark existing guest hpte
>> entry as HPTE_V_ABSENT. Now we need to do that when we are inserting new
>> guest hpte entries. This patch does that.
>
> So what happens next? We insert a page into the HTAB without HPTE_V_VALID set, so the guest will fail to use it. If the guest does an H_READ on it it will suddenly turn to V_VALID though?
>
> I might need a crash course in the use of HPTE_V_ABSENT.
>
>
> Alex
>
