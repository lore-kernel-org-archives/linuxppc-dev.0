Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 30F7DB7037
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Dec 2011 00:22:53 +1100 (EST)
Message-ID: <4EF87528.8000305@redhat.com>
Date: Mon, 26 Dec 2011 15:22:48 +0200
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] KVM: Move gfn_to_memslot() to kvm_host.h
References: <20111220092102.GA5626@bloggs.ozlabs.ibm.com>
In-Reply-To: <20111220092102.GA5626@bloggs.ozlabs.ibm.com>
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

On 12/20/2011 11:21 AM, Paul Mackerras wrote:
> This moves gfn_to_memslot(), and the functions it calls, that is,
> search_memslots() and __gfn_to_memslot(), from kvm_main.c to kvm_host.h
> so that gfn_to_memslot() can be called from non-modular code even
> when KVM is a module.  On powerpc, the Book3S HV style of KVM has
> code that is called from real mode which needs to call gfn_to_memslot()
> and thus needs this.  (Module code is allocated in the vmalloc region,
> which can't be accessed in real mode.)
>
> With this, we can remove builtin_gfn_to_memslot() from book3s_hv_rm_mmu.c
> and thus eliminate a little bit of duplication.

Those functions are too big to be inlined IMO.  How about moving them to
another C file, and making it builtin for ppc?

The only issue is what to call it. virt/kvm/builtin-for-ppc seems silly.

Or we could move the implementation into a header file, with an extra __
prefix, and have the C stubs call those inlines, so we have exactly on
instantiation.  Your real mode code can then call the inlines.

-- 
error compiling committee.c: too many arguments to function
