Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 72C68B6F69
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Jul 2011 20:23:26 +1000 (EST)
Subject: Re: [RFC PATCH 17/17] KVM: PPC: Add an ioctl for userspace to select
	which platform to emulate
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20110701100948.GA14080@bloggs.ozlabs.ibm.com>
Date: Fri, 1 Jul 2011 12:23:21 +0200
Message-Id: <0E599E8E-0A32-46B5-B39F-BD8016DE65FF@suse.de>
References: <20110629101552.GA25406@bloggs.ozlabs.ibm.com>
	<20110629104103.GR25406@bloggs.ozlabs.ibm.com>
	<4E0C9077.2060608@suse.de>
	<20110701100948.GA14080@bloggs.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
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


On 01.07.2011, at 12:09, Paul Mackerras wrote:

> On Thu, Jun 30, 2011 at 05:04:23PM +0200, Alexander Graf wrote:
>> On 06/29/2011 12:41 PM, Paul Mackerras wrote:
>>> +struct kvm_ppc_set_platform {
>>> +	__u16 platform;		/* defines the OS/hypervisor ABI */
>>> +	__u16 guest_arch;	/* e.g. decimal 206 for v2.06 */
>>> +	__u32 flags;
>>=20
>> Please add some padding so we can extend it later if necessary.
>>=20
>>> +};
>>> +
>>> +/* Values for platform */
>>> +#define KVM_PPC_PV_NONE		0	/* bare-metal, =
non-paravirtualized */
>>> +#define KVM_PPC_PV_KVM		1	/* as defined in =
kvm_para.h */
>>> +#define KVM_PPC_PV_SPAPR	2	/* IBM Server PAPR (a la =
PowerVM) */
>>=20
>> We also support BookE which would be useful to also include in the =
list.
>> Furthermore, KVM is more of a feature flag than a platform. We can
>> easily support KVM extensions on an SPAPR platform, no?
>=20
> Yes, I guess so.  The hypercall sequence will have to be different,
> since ordinary system call interrupts go straight to the guest.  But I
> guess you've allowed for that with the hypercall sequence property in
> the device tree.
>=20
>> This whole interface also could deprecate the PVR setting one, so we
>> can simply include PVR as well and not require kernel space to jump
>> through hoops to figure out its capabilities.
>=20
> I debated about whether to include a PVR value in this structure.
>=20
> The thing is that POWER7 has the "Processor Compatibility Register"
> (PCR), which has a bit which makes the processor behave in user mode
> as if it were a POWER6.  So, we could run a book3s_hv guest in POWER6
> mode by setting this bit (which we might want to do to run older
> distros).  However, this bit doesn't affect the PVR value that the
> guest sees.  That's why I went for an architecture level rather than a
> specific PVR value.
>=20
> We could go with a PVR value and use the "logical" PVR values defined
> in PAPR to represent architecture levels, e.g. 0x0f000002 for
> architecture v2.05 (POWER6).

IIUC the PVR values are somewhat standardized to contain major and minor =
revision numbers. Can't we just mask out the minor ones and match for =
known good systems?

>=20
>> And we need to identify 32-bit BookS processors, so we can go into
>> 32-bit mode when necessary. That should also be a different
>> guest_arch, right?
>=20
> Right.  If we go with a PVR value then we just use the PVR value for a
> suitable 32-bit processor.

Well, we need to have some way of mapping PVR to arch then. KVM easily =
supports -cpu G3 and G4. We might also want to have some information on =
feature flags, such as Altivec or SPE mode available. Or paired singles =
:). I'm not sure I want to have all that mapping information inside the =
kernel.

So what we could do is we just provide as much information as we can =
from user space, including PVR, architecture (2.01 for example), =
features (32/64-bit, booke/books, fpu, altivec, spe, ...).

>=20
>>> +
>>> +/* Values for flags */
>>> +#define KVM_PPC_CROSS_ARCH	1	/* guest architecture !=3D host =
*/
>>=20
>> User space shouldn't have to worry about this one. It's up to the
>> kernel to decide that it's cross.
>=20
> I put that in because we might want to force the use of book3s_pr, for
> example if we know we're going to want to do emulated MMIO or
> something else that isn't implemented in book3s_hv just yet.

Ah, I see. Well, we could just add a flag to the feature list saying =
MMIO. If that's impossible to satisfy (HV only), fail the call. =
Otherwise switch to _pr mode. Later when _hv might be able to support =
MMIO, we can use it without changing user space.

> Ultimately, yes, the kernel should be able to decide whether it's
> cross or not.  However, I don't think we should make it completely
> opaque to userspace as to whether the kernel is using _pr or _hv.
> If nothing else, userspace should be able to find out and tell the
> user so that performance expectations can be set correctly.

Hrm. Sure, but the decision should be done in kernel land based on all =
information required to actually make it. And the kernel has more =
information regarding the system it's running on, so that's the place to =
actually do the decision. Bubbling it up to user space again is =
certainly fine by me :).


Alex
