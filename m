Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 0FE91B708A
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 28 Jun 2010 18:21:47 +1000 (EST)
Subject: Re: [PATCH 26/26] KVM: PPC: Add Documentation about PV interface
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <4C285991.1050303@redhat.com>
Date: Mon, 28 Jun 2010 10:21:43 +0200
Message-Id: <4330E5DC-63C5-40EA-9E99-34EE58074D1A@suse.de>
References: <1277508314-915-1-git-send-email-agraf@suse.de>
	<07C9A4B8-881A-438C-AA99-AEC23887C6B8@suse.de>
	<4C270876.2050806%40redhat.com>
	<1277709531_13308@mail4.comsite.net>
	<92F4A3F3-A89F-418D-BD4D-66E2489F2E42@suse.de>
	<4C285991.1050303@redhat.com>
To: Avi Kivity <avi@redhat.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kvm-ppc@vger.kernel.org,
	Milton Miller <miltonm@bga.com>, KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 28.06.2010, at 10:13, Avi Kivity wrote:

> On 06/28/2010 10:49 AM, Alexander Graf wrote:
>>=20
>>> I don't believe we support the kernel actually doing a syscall to =
itself
>>> anymore, at least on powerpc.  The callers call the underlying =
system
>>> call function, or kernel_thread.
>>>=20
>>> That said, I would suggest we allocate a syscall number for this, as =
it
>>> would document the usage.  (In additon to 0..nr_syscalls - 1 we have
>>> 0x1ebe in use).
>>>    =20
>> That's actually a pretty good idea.
>>  =20
>=20
> Since the syscall register is not architectual (or rather it is =
architectural but Linux ignores it) I don't see the point.  It would =
work for Linux but may alias some random parameter for a different =
guest.  We need a reliable method of distinguishing between syscalls and =
hypercalls.  Matching pc would work (but is defeated by inlining) so =
long as we find some other way of identifying the hc pc to the =
hypervisor.

The other alternative I'd see is to reuse an instruction that is not sc. =
We could for example pull the mfpvr trick again, but pass a different =
magic value in the register this time that tells the hypervisor "this is =
a hypercall".

Or we could reserve a different SPR. But from what I've seen there are =
already quite a lot of SPRs out there. More than available numbers :).

The hypercall technique I used here is actually inspired by MOL. They =
use magic constants in r3 and r4 for their "OSI" identification. I'm =
frankly not sure what the best approach is, but considering that =
syscalls from the kernel lie in the guest kernel's hand, we could just =
declare any breakage a guest kernel bug.


Alex
