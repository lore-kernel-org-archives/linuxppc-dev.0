Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tTF400QmbzDvnY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 20:09:52 +1100 (AEDT)
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tTF3z27kLz9vF7
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Nov 2016 20:09:51 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id x23so782169pgx.3
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Nov 2016 01:09:51 -0800 (PST)
Subject: Re: [PATCH v2] KVM/PPC Patch for KVM issue in real mode
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
References: <20a3e138-8a6e-6ad8-b9ba-ec8332f011a5@gmail.com>
 <8760n5icw5.fsf@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Radim <rkrcmar@redhat.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <2df982da-32f6-2634-52cc-071addae3b23@gmail.com>
Date: Wed, 30 Nov 2016 20:09:33 +1100
MIME-Version: 1.0
In-Reply-To: <8760n5icw5.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 30/11/16 19:35, Aneesh Kumar K.V wrote:
> Balbir Singh <bsingharora@gmail.com> writes:
> 
>> Some KVM functions for book3s_hv are called in real mode.
>> In real mode the top 4 bits of the address space are ignored,
>> hence an address beginning with 0xc0000000+offset is the
>> same as 0xd0000000+offset. The issue was observed when
>> a kvm memslot resolution lead to random values when
>> access from kvmppc_h_enter(). The issue is hit if the
>> KVM host is running with a page size of 4K, since
>> kvzalloc() looks at size < PAGE_SIZE. On systems with
>> 64K the issue is not observed easily, it largely depends
>> on the size of the structure being allocated.
>>
>> The proposed fix moves all KVM allocations for book3s_hv
>> to kzalloc() until all structures used in real mode are
>> audited. For safety allocations are moved to kmalloc
>> space. The impact is a large allocation on systems with
>> 4K page size.
> 
> We did such access using *real_vmalloc_addr(void *x). So you are
> suggesting here is we don't do that for all code path ?
> 

Yep.. that is true

> Do you have a stack dump for which you identified the issue ?
> 

I found it with kvm_memslots, don't have a stack dump, but
IIRC, I saw it with search_memslots <-- __gfn_to_memslot()

>>
>> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
>> ---
>>  Changelog v2:
>>    Fix build failures reported by the kbuild test robot
>>    http://www.spinics.net/lists/kvm/msg141727.html
>>
>>  arch/powerpc/include/asm/kvm_host.h | 19 +++++++++++++++++++
>>  include/linux/kvm_host.h            | 11 +++++++++++
>>  virt/kvm/kvm_main.c                 |  2 +-
>>  3 files changed, 31 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
>> index f15713a..53f5172 100644
>> --- a/arch/powerpc/include/asm/kvm_host.h
>> +++ b/arch/powerpc/include/asm/kvm_host.h
>> @@ -734,6 +734,25 @@ struct kvm_vcpu_arch {
>>  #define __KVM_HAVE_ARCH_WQP
>>  #define __KVM_HAVE_CREATE_DEVICE
>>  
>> +#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
>> +#define __KVM_HAVE_ARCH_VZALLOC_OVERRIDE
> 
> do we need that OVERRIDE ? We usually have HAVE_ARCH_KVM_VZALLOC
> or just say #ifndef kvm_arch_vzalloc ?
> 

I can move __KVM_HAVE_ARCH_VZALLOC_OVERRIDE to
HAVE_ARCH_KVM_VZALLOC_OVERRIDE if it helps with clarity
and convention

Thanks for the review,
Balbir
