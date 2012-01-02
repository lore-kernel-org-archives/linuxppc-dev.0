Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 408CC1007D9
 for <linuxppc-dev@ozlabs.org>; Tue,  3 Jan 2012 02:23:19 +1100 (EST)
Subject: Re: [PATCH] KVM: Move gfn_to_memslot() to kvm_host.h
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <4EF87528.8000305@redhat.com>
Date: Mon, 2 Jan 2012 16:23:11 +0100
Message-Id: <6918CBBE-19AF-4323-BFE7-0F8739E32008@suse.de>
References: <20111220092102.GA5626@bloggs.ozlabs.ibm.com>
 <4EF87528.8000305@redhat.com>
To: Avi Kivity <avi@redhat.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 26.12.2011, at 14:22, Avi Kivity wrote:

> On 12/20/2011 11:21 AM, Paul Mackerras wrote:
>> This moves gfn_to_memslot(), and the functions it calls, that is,
>> search_memslots() and __gfn_to_memslot(), from kvm_main.c to kvm_host.h
>> so that gfn_to_memslot() can be called from non-modular code even
>> when KVM is a module.  On powerpc, the Book3S HV style of KVM has
>> code that is called from real mode which needs to call gfn_to_memslot()
>> and thus needs this.  (Module code is allocated in the vmalloc region,
>> which can't be accessed in real mode.)
>> 
>> With this, we can remove builtin_gfn_to_memslot() from book3s_hv_rm_mmu.c
>> and thus eliminate a little bit of duplication.
> 
> Those functions are too big to be inlined IMO.  How about moving them to
> another C file, and making it builtin for ppc?
> 
> The only issue is what to call it. virt/kvm/builtin-for-ppc seems silly.

Yeah - and it makes it pretty confusing to find the functions then.

> Or we could move the implementation into a header file, with an extra __
> prefix, and have the C stubs call those inlines, so we have exactly on
> instantiation.  Your real mode code can then call the inlines.

I like this version. That way everyone should be happy :)


Alex
