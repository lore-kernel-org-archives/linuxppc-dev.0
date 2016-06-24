Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rbYhb4X4tzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 19:59:27 +1000 (AEST)
Date: Fri, 24 Jun 2016 19:59:23 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 mpe@ellerman.id.au, benh@kernel.crashing.org, kvm@vger.kernel.org,
 pbonzini@redhat.com, agraf@suse.com, rkrcmar@redhat.com
Subject: Re: [PATCH 1/4] kvm/ppc/book3s_hv: Change vcore element
 runnable_threads from linked-list to array
Message-ID: <20160624095923.GG26584@fergus.ozlabs.ibm.com>
References: <1465982468-18833-1-git-send-email-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1465982468-18833-1-git-send-email-sjitindarsingh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 15, 2016 at 07:21:05PM +1000, Suraj Jitindar Singh wrote:
> The struct kvmppc_vcore is a structure used to store various information
> about a virtual core for a kvm guest. The runnable_threads element of the
> struct provides a list of all of the currently runnable vcpus on the core
> (those in the KVMPPC_VCPU_RUNNABLE state). The previous implementation of
> this list was a linked_list. The next patch requires that the list be able
> to be iterated over without holding the vcore lock.
> 
> Reimplement the runnable_threads list in the kvmppc_vcore struct as an
> array. Implement function to iterate over valid entries in the array and
> update access sites accordingly.
> 
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Unfortunately I get a compile error when compiling for either a 32-bit
powerpc config (e.g. pmac32_defconfig with KVM turned on) or a Book E
config.  The error is:

In file included from /home/paulus/kernel/kvm/include/linux/kvm_host.h:36:0,
                 from /home/paulus/kernel/kvm/arch/powerpc/kernel/asm-offsets.c:54:
/home/paulus/kernel/kvm/arch/powerpc/include/asm/kvm_host.h:299:36: error: ‘MAX_SMT_THREADS’ undeclared here (not in a function)
  struct kvm_vcpu *runnable_threads[MAX_SMT_THREADS];
                                    ^
/home/paulus/kernel/kvm/./Kbuild:81: recipe for target 'arch/powerpc/kernel/asm-offsets.s' failed

You are using MAX_SMT_THREADS in kvm_host.h, but it is defined in
kvm_book3s_asm.h, which gets included by asm-offsets.c after it
include kvm_host.h.  I don't think we can just make kvm_host.h include
book3s.h.  The best solution might be to move the definition of struct
kvmppc_vcore to kvm_book3s.h.

Paul.
