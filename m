Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 12EF7B6F68
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2011 21:58:56 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p5TBeWSH006321
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2011 05:40:32 -0600
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	p5TBwoSJ036360
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2011 05:58:50 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p5TBwobb010881
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2011 05:58:50 -0600
Date: Wed, 29 Jun 2011 07:58:57 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC PATCH 17/17] KVM: PPC: Add an ioctl for userspace to select
	which platform to emulate
Message-ID: <20110629115857.GB17551@zod.rchland.ibm.com>
References: <20110629101552.GA25406@bloggs.ozlabs.ibm.com>
	<20110629104103.GR25406@bloggs.ozlabs.ibm.com>
	<20110629115346.GA17551@zod.rchland.ibm.com>
	<B21FDD77-90CF-4A23-84E3-8C73CFF70B92@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <B21FDD77-90CF-4A23-84E3-8C73CFF70B92@suse.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 29, 2011 at 01:56:16PM +0200, Alexander Graf wrote:
>
>On 29.06.2011, at 13:53, Josh Boyer wrote:
>
>> On Wed, Jun 29, 2011 at 08:41:03PM +1000, Paul Mackerras wrote:
>>> Documentation/virtual/kvm/api.txt   |   35 +++++++++++++++++++++++++++++++++++
>>> arch/powerpc/include/asm/kvm.h      |   15 +++++++++++++++
>>> arch/powerpc/include/asm/kvm_host.h |    1 +
>>> arch/powerpc/kvm/powerpc.c          |   28 ++++++++++++++++++++++++++++
>>> include/linux/kvm.h                 |    1 +
>>> 5 files changed, 80 insertions(+), 0 deletions(-)
>>> 
>>> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
>>> index b0e4b9c..3ab012c 100644
>>> --- a/Documentation/virtual/kvm/api.txt
>>> +++ b/Documentation/virtual/kvm/api.txt
>>> @@ -1430,6 +1430,41 @@ is supported; 2 if the processor requires all virtual machines to have
>>> an RMA, or 1 if the processor can use an RMA but doesn't require it,
>>> because it supports the Virtual RMA (VRMA) facility.
>>> 
>>> +4.64 KVM_PPC_SET_PLATFORM
>>> +
>>> +Capability: none
>>> +Architectures: powerpc
>>> +Type: vm ioctl
>>> +Parameters: struct kvm_ppc_set_platform (in)
>>> +Returns: 0, or -1 on error
>>> +
>>> +This is used by userspace to tell KVM what sort of platform it should
>>> +emulate.  The return value of the ioctl tells userspace whether the
>>> +emulation it is requesting is supported by KVM.
>>> +
>>> +struct kvm_ppc_set_platform {
>>> +	__u16 platform;		/* defines the OS/hypervisor ABI */
>>> +	__u16 guest_arch;	/* e.g. decimal 206 for v2.06 */
>>> +	__u32 flags;
>>> +};
>>> +
>>> +/* Values for platform */
>>> +#define KVM_PPC_PV_NONE		0	/* bare-metal, non-paravirtualized */
>>> +#define KVM_PPC_PV_KVM		1	/* as defined in kvm_para.h */
>>> +#define KVM_PPC_PV_SPAPR	2	/* IBM Server PAPR (a la PowerVM) */
>>> +
>>> +/* Values for flags */
>>> +#define KVM_PPC_CROSS_ARCH	1	/* guest architecture != host */
>>> +
>>> +The KVM_PPC_CROSS_ARCH bit being 1 indicates that the guest is of a
>>> +sufficiently different architecture to the host that the guest cannot
>>> +be permitted to use supervisor mode.  For example, if the host is a
>>> +64-bit machine and the guest is a 32-bit machine, then this bit should
>>> +be set.
>> 
>> This makes me wonder if a similar thing might eventually be usable for
>> running an i686 or x32 guest on an x86_64 KVM host.  I have no idea if
>> that is even theoretically possible, but if it is it might be better to
>> rename the ioctl to be architecture agnostic.
>
>On x86 this is not required unless we want to "virtualize" pre-CPUID CPUs. Everything as of Pentium has a full bitmap of feature capabilities that KVM gets from user space, including information such as "Can we do 64-bit mode?".

Ah.  Thank you for the explanation.

josh
