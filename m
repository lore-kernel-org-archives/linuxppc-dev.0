Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 7F9B5B707F
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 28 Jun 2010 18:32:36 +1000 (EST)
Message-ID: <4C285E21.8050907@redhat.com>
Date: Mon, 28 Jun 2010 11:32:33 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 26/26] KVM: PPC: Add Documentation about PV interface
References: <1277508314-915-1-git-send-email-agraf@suse.de>
	<07C9A4B8-881A-438C-AA99-AEC23887C6B8@suse.de>
	<4C270876.2050806%40redhat.com>
	<1277709531_13308@mail4.comsite.net>
	<92F4A3F3-A89F-418D-BD4D-66E2489F2E42@suse.de>
	<4C285991.1050303@redhat.com>
	<4330E5DC-63C5-40EA-9E99-34EE58074D1A@suse.de>
In-Reply-To: <4330E5DC-63C5-40EA-9E99-34EE58074D1A@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

On 06/28/2010 11:21 AM, Alexander Graf wrote:
>
> The other alternative I'd see is to reuse an instruction that is not sc. We could for example pull the mfpvr trick again, but pass a different magic value in the register this time that tells the hypervisor "this is a hypercall".
>
> Or we could reserve a different SPR. But from what I've seen there are already quite a lot of SPRs out there. More than available numbers :).
>
> The hypercall technique I used here is actually inspired by MOL. They use magic constants in r3 and r4 for their "OSI" identification. I'm frankly not sure what the best approach is, but considering that syscalls from the kernel lie in the guest kernel's hand, we could just declare any breakage a guest kernel bug.
>
>    

Magic = liable to break without notice.

Given r0 is the architectural syscall number, and r3 is the Linux 
syscall number, we can use a combination of r0 and r3, reserve r3 in 
Linux, and hope that no one else uses our selection of r0.

Still smelly, but not as bad.

-- 
error compiling committee.c: too many arguments to function
