Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rnvj55CD1zDqwr
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 16:05:45 +1000 (AEST)
Received: by mail-pa0-x231.google.com with SMTP id ks6so6410565pab.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Jul 2016 23:05:45 -0700 (PDT)
Subject: Re: [PATCH 1/4] kvm/ppc/book3s_hv: Change vcore element
 runnable_threads from linked-list to array
To: Paolo Bonzini <pbonzini@redhat.com>, Paul Mackerras <paulus@ozlabs.org>
References: <1465982468-18833-1-git-send-email-sjitindarsingh@gmail.com>
 <20160624095923.GG26584@fergus.ozlabs.ibm.com> <57735226.6010904@gmail.com>
 <f433feff-b8c6-2b99-4357-5146032e7d6d@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 mpe@ellerman.id.au, benh@kernel.crashing.org, kvm@vger.kernel.org,
 agraf@suse.com, rkrcmar@redhat.com
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-ID: <5783372F.2050804@gmail.com>
Date: Mon, 11 Jul 2016 16:05:35 +1000
MIME-Version: 1.0
In-Reply-To: <f433feff-b8c6-2b99-4357-5146032e7d6d@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 29/06/16 22:51, Paolo Bonzini wrote:
>
> On 29/06/2016 06:44, Suraj Jitindar Singh wrote:
>> Thanks for catching that, yeah I see.
>>
>> I don't think we can trivially move the struct kvmppc_vcore definition into 
>> kvm_book3s.h as other code in kvm_host.h (i.e. struct kvm_vcpu_arch) requires
>> the definition. I was thinking that I could just put runnable_threads inside an #ifdef.
>>
>> #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
>> 	struct kvm_vcpu *runnable_threads[MAX_SMT_THREADS];
>> #endif
> You can rename MAX_SMT_THREADS to BOOK3S_MAX_SMT_THREADS and move it to
> kvm_host.h.  It seems like assembly code does not use it, so it's
> unnecessary to have it in book3s_asm.h.

It looks like MAX_SMT_THREADS is used else where in book3s_asm.h.
I think the easiest option is to put the v_core struct in book3s.h. 

>
> Paolo
