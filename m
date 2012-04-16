Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C6216B7016
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Apr 2012 19:45:49 +1000 (EST)
Subject: Re: [PATCH 13/17] KVM: PPC: Allow book3s_hv guests to use SMT
 processor modes
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20110629102307.GN25406@bloggs.ozlabs.ibm.com>
Date: Mon, 16 Apr 2012 11:45:44 +0200
Message-Id: <056AF183-5218-457B-9501-B0FF5ED455E9@suse.de>
References: <20110629101552.GA25406@bloggs.ozlabs.ibm.com>
 <20110629102307.GN25406@bloggs.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 29.06.2011, at 12:23, Paul Mackerras wrote:

> This lifts the restriction that book3s_hv guests can only run one
> hardware thread per core, and allows them to use up to 4 threads
> per core on POWER7.  The host still has to run single-threaded.
>=20
> This capability is advertised to qemu through a new KVM_CAP_PPC_SMT
> capability.  The return value of the ioctl querying this capability
> is the number of vcpus per virtual CPU core (vcore), currently 4.
>=20
> To use this, the host kernel should be booted with all threads
> active, and then all the secondary threads should be offlined.
> This will put the secondary threads into nap mode.  KVM will then
> wake them from nap mode and use them for running guest code (while
> they are still offline).  To wake the secondary threads, we send
> them an IPI using a new xics_wake_cpu() function, implemented in
> arch/powerpc/sysdev/xics/icp-native.c.  In other words, at this stage
> we assume that the platform has a XICS interrupt controller and
> we are using icp-native.c to drive it.  Since the woken thread will
> need to acknowledge and clear the IPI, we also export the base
> physical address of the XICS registers using kvmppc_set_xics_phys()
> for use in the low-level KVM book3s code.
>=20
> When a vcpu is created, it is assigned to a virtual CPU core.
> The vcore number is obtained by dividing the vcpu number by the
> number of threads per core in the host.  This number is exported
> to userspace via the KVM_CAP_PPC_SMT capability.  If qemu wishes
> to run the guest in single-threaded mode, it should make all vcpu
> numbers be multiples of the number of threads per core.
>=20
> We distinguish three states of a vcpu: runnable (i.e., ready to =
execute
> the guest), blocked (that is, idle), and busy in host.  We currently
> implement a policy that the vcore can run only when all its threads
> are runnable or blocked.  This way, if a vcpu needs to execute =
elsewhere
> in the kernel or in qemu, it can do so without being starved of CPU
> by the other vcpus.
>=20
> When a vcore starts to run, it executes in the context of one of the
> vcpu threads.  The other vcpu threads all go to sleep and stay asleep
> until something happens requiring the vcpu thread to return to qemu,
> or to wake up to run the vcore (this can happen when another vcpu
> thread goes from busy in host state to blocked).
>=20
> It can happen that a vcpu goes from blocked to runnable state (e.g.
> because of an interrupt), and the vcore it belongs to is already
> running.  In that case it can start to run immediately as long as
> the none of the vcpus in the vcore have started to exit the guest.
> We send the next free thread in the vcore an IPI to get it to start
> to execute the guest.  It synchronizes with the other threads via
> the vcore->entry_exit_count field to make sure that it doesn't go
> into the guest if the other vcpus are exiting by the time that it
> is ready to actually enter the guest.
>=20
> Note that there is no fixed relationship between the hardware thread
> number and the vcpu number.  Hardware threads are assigned to vcpus
> as they become runnable, so we will always use the lower-numbered
> hardware threads in preference to higher-numbered threads if not all
> the vcpus in the vcore are runnable, regardless of which vcpus are
> runnable.
>=20
> Signed-off-by: Paul Mackerras <paulus@samba.org>

[...]

> diff --git a/arch/powerpc/include/asm/kvm_host.h =
b/arch/powerpc/include/asm/kvm_host.h
> index 5616e39..0d6d569 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -25,10 +25,14 @@
> #include <linux/interrupt.h>
> #include <linux/types.h>
> #include <linux/kvm_types.h>
> +#include <linux/threads.h>
> +#include <linux/spinlock.h>
> #include <linux/kvm_para.h>
> #include <asm/kvm_asm.h>
> +#include <asm/processor.h>
>=20
> -#define KVM_MAX_VCPUS 1
> +#define KVM_MAX_VCPUS		NR_CPUS
> +#define KVM_MAX_VCORES		NR_CPUS

Hey Paul,

While trying to trace down why some BookE systems were only able to do =
as many guest vcpus as there were host cpus available, we stumbled over =
this one. Is there any limitation on book3s_hv that would limit the =
available vcpus to configured host vcpus? Or could we just make this a =
static define like on x86?


Alex
