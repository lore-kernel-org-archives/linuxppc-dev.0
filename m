Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yDTZ456BDzDqv8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Oct 2017 13:49:16 +1100 (AEDT)
Date: Sat, 14 Oct 2017 13:49:08 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Greg Kurz <groug@kaod.org>
Cc: kvm-ppc@vger.kernel.org, qemu-ppc@nongnu.org,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2] KVM: PPC: Book3S PR: only install valid SLBs during
 KVM_SET_SREGS
Message-ID: <20171014024908.GG26120@fergus.ozlabs.ibm.com>
References: <150693362232.15210.2878817650741484831.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <150693362232.15210.2878817650741484831.stgit@bahia>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 02, 2017 at 10:40:22AM +0200, Greg Kurz wrote:
> Userland passes an array of 64 SLB descriptors to KVM_SET_SREGS,
> some of which are valid (ie, SLB_ESID_V is set) and the rest are
> likely all-zeroes (with QEMU at least).
> 
> Each of them is then passed to kvmppc_mmu_book3s_64_slbmte(), which
> assumes to find the SLB index in the 3 lower bits of its rb argument.
> When passed zeroed arguments, it happily overwrites the 0th SLB entry
> with zeroes. This is exactly what happens while doing live migration
> with QEMU when the destination pushes the incoming SLB descriptors to
> KVM PR. When reloading the SLBs at the next synchronization, QEMU first
> clears its SLB array and only restore valid ones, but the 0th one is
> now gone and we cannot access the corresponding memory anymore:
> 
> (qemu) x/x $pc
> c0000000000b742c: Cannot access memory
> 
> To avoid this, let's filter out non-valid SLB entries. While here, we
> also force a full SLB flush before installing new entries.

With this, a 32-bit powermac config with PR KVM enabled fails to build:

  CC [M]  arch/powerpc/kvm/book3s_pr.o
/home/paulus/kernel/kvm/arch/powerpc/kvm/book3s_pr.c: In function ‘kvm_arch_vcpu_ioctl_set_sregs_pr’:
/home/paulus/kernel/kvm/arch/powerpc/kvm/book3s_pr.c:1337:13: error: ‘SLB_ESID_V’ undeclared (first use in this function)
    if (rb & SLB_ESID_V)
             ^
/home/paulus/kernel/kvm/arch/powerpc/kvm/book3s_pr.c:1337:13: note: each undeclared identifier is reported only once for each function it appears in
/home/paulus/kernel/kvm/scripts/Makefile.build:313: recipe for target 'arch/powerpc/kvm/book3s_pr.o' failed
make[3]: *** [arch/powerpc/kvm/book3s_pr.o] Error 1

Paul.
