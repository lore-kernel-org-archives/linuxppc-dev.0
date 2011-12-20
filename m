Return-Path: <paulus@ozlabs.org>
Date: Tue, 20 Dec 2011 21:21:42 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: [RFC PATCH 0/2] KVM: PPC: Book3S HV: Report stolen time to guests
Message-ID: <20111220102142.GB5626@bloggs.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Under pHyp, recent kernels use the dispatch trace log (DTL) to measure
stolen time.  The DTL is a ring buffer containing 48-byte entries,
where the hypervisor creates an entry each time a virtual cpu is
dispatched.  The entries contain a couple of fields that the kernel
interprets as stolen time, measured in timebase ticks.

Although this is not an ideal interface, it is one that our guest
kernels already support.  So this series of patches adds code to
Book3S HV KVM to measure stolen time and report it to the guest via a
dispatch trace log.

Stolen time is measured per virtual core (set of 4 vcpus, on POWER7)
as being all the time when no vcpu thread is executing inside
kvmppc_run_core(), or when a vcpu thread is running the virtual core
but is preempted.

The first patch fixes some potential races with the registration and
unregistration of the DTL and the other per-virtual-processor areas,
since the guest can (un)register a per-virtual-processor area for one
vcpu in a call to the H_REGISTER_VPA hypercall on another vcpu, and
hence potentially while KVM is using a previously-registered area.

The second patch adds the machinery for measuring stolen time and for
creating DTL entries.

Paul.
