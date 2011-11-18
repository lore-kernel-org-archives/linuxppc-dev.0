Return-Path: <paulus@ozlabs.org>
Date: Sat, 19 Nov 2011 08:54:24 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC PATCH 0/11] KVM: PPC: Update Book3S HV memory handling
Message-ID: <20111118215424.GA24455@bloggs.ozlabs.ibm.com>
References: <20111116225055.GA26985@bloggs.ozlabs.ibm.com>
 <AA9CC080-B96B-41C7-A054-8286CF8BC3FE@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AA9CC080-B96B-41C7-A054-8286CF8BC3FE@suse.de>
Cc: linuxppc-dev@ozlabs.org, Marcelo Tosatti <mtosatti@redhat.com>,
 Avi Kivity <avi@redhat.com>, kvm-ppc@vger.kernel.org,
 kvm list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 18, 2011 at 02:57:11PM +0100, Alexander Graf wrote:
> 
> This touches areas that I'm sure non-PPC people would want to see as
> well. Could you please CC kvm@vger too next time?
> 
> Avi, Marcelo, mind to review some of the bits in this patch set? :)

I did cc the last patch (the one that adds barriers in the MMU
notifier sequence/count logic) to kvm@vger.  Do you mean I should cc
the whole series?  The only other thing touching generic code is the
addition of the KVM_MEMSLOT_IO flag in the first patch.

I'm hoping the extra barriers will be OK since they are no-ops on
x86.  In fact I now think that the smp_wmbs I added to
kvm_mmu_notifier_invalidate_page and kvm_mmu_notifier_change_pte
aren't in fact necessary, since it's only necessary to ensure that the
sequence number increase is visible before the point where
kvm_unmap_hva or kvm_set_spte_hva unlock the bitlock on the first rmap
chain they look at, which will be ensured anyway by the barrier before
the unlock.

Paul.
