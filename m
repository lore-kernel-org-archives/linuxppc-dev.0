Return-Path: <pbonzini@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfjGl07nRzDqw3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 22:51:27 +1000 (AEST)
Subject: Re: [PATCH 1/4] kvm/ppc/book3s_hv: Change vcore element
 runnable_threads from linked-list to array
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 Paul Mackerras <paulus@ozlabs.org>
References: <1465982468-18833-1-git-send-email-sjitindarsingh@gmail.com>
 <20160624095923.GG26584@fergus.ozlabs.ibm.com> <57735226.6010904@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, mpe@ellerman.id.au,
 benh@kernel.crashing.org, kvm@vger.kernel.org, agraf@suse.com,
 rkrcmar@redhat.com
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f433feff-b8c6-2b99-4357-5146032e7d6d@redhat.com>
Date: Wed, 29 Jun 2016 14:51:19 +0200
MIME-Version: 1.0
In-Reply-To: <57735226.6010904@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 29/06/2016 06:44, Suraj Jitindar Singh wrote:
> Thanks for catching that, yeah I see.
> 
> I don't think we can trivially move the struct kvmppc_vcore definition into 
> kvm_book3s.h as other code in kvm_host.h (i.e. struct kvm_vcpu_arch) requires
> the definition. I was thinking that I could just put runnable_threads inside an #ifdef.
> 
> #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> 	struct kvm_vcpu *runnable_threads[MAX_SMT_THREADS];
> #endif

You can rename MAX_SMT_THREADS to BOOK3S_MAX_SMT_THREADS and move it to
kvm_host.h.  It seems like assembly code does not use it, so it's
unnecessary to have it in book3s_asm.h.

Paolo
