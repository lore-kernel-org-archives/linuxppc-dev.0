Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 24CAEB6F5A
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Jul 2011 01:22:12 +1000 (EST)
Message-ID: <4E0C94A0.3090301@suse.de>
Date: Thu, 30 Jun 2011 17:22:08 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Avi Kivity <avi@redhat.com>
Subject: Re: [RFC PATCH 17/17] KVM: PPC: Add an ioctl for userspace to select
	which platform to emulate
References: <20110629101552.GA25406@bloggs.ozlabs.ibm.com>
	<20110629104103.GR25406@bloggs.ozlabs.ibm.com>
	<4E0C9077.2060608@suse.de> <4E0C9339.2080601@redhat.com>
In-Reply-To: <4E0C9339.2080601@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
	kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/30/2011 05:16 PM, Avi Kivity wrote:
> On 06/30/2011 06:04 PM, Alexander Graf wrote:
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
>>> +    __u16 platform;        /* defines the OS/hypervisor ABI */
>>> +    __u16 guest_arch;    /* e.g. decimal 206 for v2.06 */
>>> +    __u32 flags;
>>
>>
>> Please add some padding so we can extend it later if necessary.
>
> Regarding that.  There's another option - the ioctl code embeds the 
> structure size.  So if we extend the ioctl parsing to pad up (or 
> truncate down) from the user's size to our size, and similarly in the 
> other direction, we can get away from this ugliness.
>
> Some years ago I posted a generic helper that did this (and also 
> kmalloc'ed and kfree'd the data itself), but it wasn't received 
> favourably.  Maybe I should try again (and we can possibly use it in 
> kvm even if it is rejected for general use, though that's against our 
> principles of pushing all generic infrastructure to the wider kernel).

That does sound interesting, but requires a lot more thought to be put 
into the actual code, as we basically need to read out the feature 
bitmap, then provide a minimum size for the chosen features and then 
decide if they fit in.

But yes, that'd still be a lot better than shoving around useless data 
all the time :)


Alex
