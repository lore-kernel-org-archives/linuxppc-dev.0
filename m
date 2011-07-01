Return-Path: <paulus@ozlabs.org>
Date: Fri, 1 Jul 2011 20:09:48 +1000
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC PATCH 17/17] KVM: PPC: Add an ioctl for userspace to select
	which platform to emulate
Message-ID: <20110701100948.GA14080@bloggs.ozlabs.ibm.com>
References: <20110629101552.GA25406@bloggs.ozlabs.ibm.com>
	<20110629104103.GR25406@bloggs.ozlabs.ibm.com>
	<4E0C9077.2060608@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E0C9077.2060608@suse.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 30, 2011 at 05:04:23PM +0200, Alexander Graf wrote:
> On 06/29/2011 12:41 PM, Paul Mackerras wrote:
> >+struct kvm_ppc_set_platform {
> >+	__u16 platform;		/* defines the OS/hypervisor ABI */
> >+	__u16 guest_arch;	/* e.g. decimal 206 for v2.06 */
> >+	__u32 flags;
> 
> Please add some padding so we can extend it later if necessary.
> 
> >+};
> >+
> >+/* Values for platform */
> >+#define KVM_PPC_PV_NONE		0	/* bare-metal, non-paravirtualized */
> >+#define KVM_PPC_PV_KVM		1	/* as defined in kvm_para.h */
> >+#define KVM_PPC_PV_SPAPR	2	/* IBM Server PAPR (a la PowerVM) */
> 
> We also support BookE which would be useful to also include in the list.
> Furthermore, KVM is more of a feature flag than a platform. We can
> easily support KVM extensions on an SPAPR platform, no?

Yes, I guess so.  The hypercall sequence will have to be different,
since ordinary system call interrupts go straight to the guest.  But I
guess you've allowed for that with the hypercall sequence property in
the device tree.

> This whole interface also could deprecate the PVR setting one, so we
> can simply include PVR as well and not require kernel space to jump
> through hoops to figure out its capabilities.

I debated about whether to include a PVR value in this structure.

The thing is that POWER7 has the "Processor Compatibility Register"
(PCR), which has a bit which makes the processor behave in user mode
as if it were a POWER6.  So, we could run a book3s_hv guest in POWER6
mode by setting this bit (which we might want to do to run older
distros).  However, this bit doesn't affect the PVR value that the
guest sees.  That's why I went for an architecture level rather than a
specific PVR value.

We could go with a PVR value and use the "logical" PVR values defined
in PAPR to represent architecture levels, e.g. 0x0f000002 for
architecture v2.05 (POWER6).

> And we need to identify 32-bit BookS processors, so we can go into
> 32-bit mode when necessary. That should also be a different
> guest_arch, right?

Right.  If we go with a PVR value then we just use the PVR value for a
suitable 32-bit processor.

> >+
> >+/* Values for flags */
> >+#define KVM_PPC_CROSS_ARCH	1	/* guest architecture != host */
> 
> User space shouldn't have to worry about this one. It's up to the
> kernel to decide that it's cross.

I put that in because we might want to force the use of book3s_pr, for
example if we know we're going to want to do emulated MMIO or
something else that isn't implemented in book3s_hv just yet.

Ultimately, yes, the kernel should be able to decide whether it's
cross or not.  However, I don't think we should make it completely
opaque to userspace as to whether the kernel is using _pr or _hv.
If nothing else, userspace should be able to find out and tell the
user so that performance expectations can be set correctly.

Paul.
