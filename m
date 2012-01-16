Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ED706B6F71
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Jan 2012 00:18:54 +1100 (EST)
Subject: Re: [PATCH v3] KVM: Move gfn_to_memslot() to kvm_host.h
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20120113060951.GB15875@drongo>
Date: Mon, 16 Jan 2012 14:18:48 +0100
Message-Id: <2F423C68-0AAD-4FC4-999B-DEEECC4C631F@suse.de>
References: <20111220092102.GA5626@bloggs.ozlabs.ibm.com>
 <20120112104115.GA32021@bloggs.ozlabs.ibm.com>
 <20120113060951.GB15875@drongo>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, Avi Kivity <avi@redhat.com>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 13.01.2012, at 07:09, Paul Mackerras wrote:

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
> With this, we can remove builtin_gfn_to_memslot() from book3s_hv_rm_mmu.c.
> 
> Signed-off-by: Paul Mackerras <paulus@samba.org>

Avi?


Alex
