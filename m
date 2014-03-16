Return-Path: <paulus@ozlabs.org>
Date: Sun, 16 Mar 2014 22:00:40 +1100
From: Paul Mackerras <paulus@samba.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: kvmppc_wait_for_nap warnings and KVM host+guest hang on 3.14-rc6*
Message-ID: <20140316110040.GA20179@iris.ozlabs.ibm.com>
References: <20140316154400.406537e1@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140316154400.406537e1@kryten>
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org, agraf@suse.de,
 aneesh.kumar@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Mar 16, 2014 at 03:44:00PM +1100, Anton Blanchard wrote:
> 
> I was testing KVM on an upstream kernel (3.14.0-rc6-00145-ga4ecdf8)
> with Gregory's emulated MMIO fixes.
> 
> I ran with 16 cores and 4 threads (matches the host):
> 
> qemu-system-ppc64 -enable-kvm -smp cores=16,threads=4 -m 32G -M pseries -cpu POWER7 -nographic -nodefaults -monitor stdio -serial pty -drive file=XXX -netdev bridge,br=br0,id=net0,helper=/usr/libexec/qemu-bridge-helper -device virtio-net-pci,netdev=net0
> 
> Note that in kernel XICS acceleration wasn't enabled (perhaps it should
> be the default, it isn't right now):
> 
> qemu-system-ppc64: KVM and IRQ_XICS capability must be present for in-kernel XICS
> 
> During boot I see processors stuck in the guest:
> 
> [   16.145166] Processor 1 is stuck.
> 
> And thousands of:
> 
> kvmppc_wait_for_nap timeout 0 1
> kvmppc_wait_for_nap timeout 0 1
> kvmppc_wait_for_nap timeout 0 1
> kvmppc_wait_for_nap timeout 0 1

You need the couple of patches I posted recently, which Paolo Bonzini
is hopefully going to get to Linus before 3.14 is released, and which
are in the "next" branch of the kvm tree:

KVM: PPC: Book3S HV: Remove bogus duplicate code
KVM: PPC: Book3S HV: Fix register usage when loading/saving VRSAVE

as well as the series that you have in your "le" branch and Alex has
in his "kvm-ppc-queue" branch:

PPC: KVM: introduce helper to check RESUME_GUEST and related
PPC: KVM: fix VCPU run for HV KVM (v2)
PPC: KVM: fix RESUME_GUEST check before ending CEDE in kvmppc_run_core()
PPC: KVM: fix RESUME_GUEST check before returning from kvmppc_run_core()

Paul.
