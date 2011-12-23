Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id BF129B71F1
 for <linuxppc-dev@ozlabs.org>; Sat, 24 Dec 2011 00:33:23 +1100 (EST)
Subject: Re: [PATCH] KVM: Move gfn_to_memslot() to kvm_host.h
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20111220092102.GA5626@bloggs.ozlabs.ibm.com>
Date: Fri, 23 Dec 2011 14:33:18 +0100
Message-Id: <24902063-CA9C-4751-89F7-4EB1F96DECFB@suse.de>
References: <20111220092102.GA5626@bloggs.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, KVM list <kvm@vger.kernel.org>,
 kvm-ppc@vger.kernel.org, Avi Kivity <avi@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 20.12.2011, at 10:21, Paul Mackerras wrote:

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
> 
> Signed-off-by: Paul Mackerras <paulus@samba.org>

Avi, please ack.


Alex
