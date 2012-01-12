Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 2A869B6EE8
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Jan 2012 02:47:23 +1100 (EST)
Message-ID: <4F0F0087.7030300@redhat.com>
Date: Thu, 12 Jan 2012 17:47:19 +0200
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] KVM: Move gfn_to_memslot() to kvm_host.h
References: <20111220092102.GA5626@bloggs.ozlabs.ibm.com>
 <20120112104115.GA32021@bloggs.ozlabs.ibm.com>
In-Reply-To: <20120112104115.GA32021@bloggs.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/12/2012 12:41 PM, Paul Mackerras wrote:
> This moves __gfn_to_memslot() and search_memslots() from kvm_main.c to
> kvm_host.h to reduce the code duplication caused by the need for
> non-modular code in arch/powerpc/kvm/book3s_hv_rm_mmu.c to call
> gfn_to_memslot() in real mode.
>
> Rather than putting gfn_to_memslot() itself in a header, which would
> lead to increased code size, this puts __gfn_to_memslot() in a header.
> Then, the non-modular uses of gfn_to_memslot() are changed to call
> __gfn_to_memslot() instead.  This way there is only one place in the
> source code that needs to be changed should the gfn_to_memslot()
> implementation need to be modified.
>
> On powerpc, the Book3S HV style of KVM has code that is called from
> real mode which needs to call gfn_to_memslot() and thus needs this.
> (Module code is allocated in the vmalloc region, which can't be
> accessed in real mode.)
>
>  
> +static inline struct kvm_memory_slot *
> +search_memslots(struct kvm_memslots *slots, gfn_t gfn)
> +{
> +	struct kvm_memory_slot *memslot;
> +
> +	kvm_for_each_memslot(memslot, slots)
> +		if (gfn >= memslot->base_gfn &&
> +		      gfn < memslot->base_gfn + memslot->npages)
> +			return memslot;
> +
> +	return NULL;
> +}
> +
> +static inline struct kvm_memory_slot *
> +__gfn_to_memslot(struct kvm_memslots *slots, gfn_t gfn)
> +{
> +	return search_memslots(slots, gfn);
> +}

Please add a comment here explaining why these functions are inlined. 
There's also the call to kvm_gfn_to_hva_cache_init(), which should be
changed to gfn_to_memslot(), to avoid code bloat.



-- 
error compiling committee.c: too many arguments to function
