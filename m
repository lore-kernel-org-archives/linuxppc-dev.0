Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A9F38B6F5A
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Jul 2011 01:04:30 +1000 (EST)
Message-ID: <4E0C9077.2060608@suse.de>
Date: Thu, 30 Jun 2011 17:04:23 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC PATCH 17/17] KVM: PPC: Add an ioctl for userspace to select
	which platform to emulate
References: <20110629101552.GA25406@bloggs.ozlabs.ibm.com>
	<20110629104103.GR25406@bloggs.ozlabs.ibm.com>
In-Reply-To: <20110629104103.GR25406@bloggs.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

On 06/29/2011 12:41 PM, Paul Mackerras wrote:
> This new ioctl allows userspace to specify what paravirtualization
> interface (if any) KVM should implement, what architecture version
> the guest virtual processors should conform to, and whether the guest
> can be permitted to use a real supervisor mode.
>
> At present the only effect of the ioctl is to indicate whether the
> requested emulation is available, but in future it may be used to
> select between different emulation techniques (book3s_pr vs. book3s_hv)
> or set the CPU compatibility mode for the guest.
>
> If book3s_pr KVM is enabled in the kernel config, then this new
> ioctl accepts platform values of KVM_PPC_PV_NONE and KVM_PPC_PV_KVM,
> but not KVM_PPC_PV_SPAPR.  If book3s_hv KVM is enabled, then this
> ioctl requires that the platform is KVM_PPC_PV_SPAPR and the
> guest_arch field contains one of 201 or 206 (for architecture versions
> 2.01 and 2.06) -- when running on a PPC970, it must contain 201, and
> when running on a POWER7, it must contain 206.
>
> Signed-off-by: Paul Mackerras<paulus@samba.org>
> ---
>   Documentation/virtual/kvm/api.txt   |   35 +++++++++++++++++++++++++++++++++++
>   arch/powerpc/include/asm/kvm.h      |   15 +++++++++++++++
>   arch/powerpc/include/asm/kvm_host.h |    1 +
>   arch/powerpc/kvm/powerpc.c          |   28 ++++++++++++++++++++++++++++
>   include/linux/kvm.h                 |    1 +
>   5 files changed, 80 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index b0e4b9c..3ab012c 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -1430,6 +1430,41 @@ is supported; 2 if the processor requires all virtual machines to have
>   an RMA, or 1 if the processor can use an RMA but doesn't require it,
>   because it supports the Virtual RMA (VRMA) facility.
>
> +4.64 KVM_PPC_SET_PLATFORM
> +
> +Capability: none
> +Architectures: powerpc
> +Type: vm ioctl
> +Parameters: struct kvm_ppc_set_platform (in)
> +Returns: 0, or -1 on error
> +
> +This is used by userspace to tell KVM what sort of platform it should
> +emulate.  The return value of the ioctl tells userspace whether the
> +emulation it is requesting is supported by KVM.
> +
> +struct kvm_ppc_set_platform {
> +	__u16 platform;		/* defines the OS/hypervisor ABI */
> +	__u16 guest_arch;	/* e.g. decimal 206 for v2.06 */
> +	__u32 flags;

Please add some padding so we can extend it later if necessary.

> +};
> +
> +/* Values for platform */
> +#define KVM_PPC_PV_NONE		0	/* bare-metal, non-paravirtualized */
> +#define KVM_PPC_PV_KVM		1	/* as defined in kvm_para.h */
> +#define KVM_PPC_PV_SPAPR	2	/* IBM Server PAPR (a la PowerVM) */

We also support BookE which would be useful to also include in the list.
Furthermore, KVM is more of a feature flag than a platform. We can 
easily support KVM extensions on an SPAPR platform, no?

This whole interface also could deprecate the PVR setting one, so we can 
simply include PVR as well and not require kernel space to jump through 
hoops to figure out its capabilities.

And we need to identify 32-bit BookS processors, so we can go into 
32-bit mode when necessary. That should also be a different guest_arch, 
right?

> +
> +/* Values for flags */
> +#define KVM_PPC_CROSS_ARCH	1	/* guest architecture != host */

User space shouldn't have to worry about this one. It's up to the kernel 
to decide that it's cross.


Alex
