Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 8E2B5B6F35
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 28 Jun 2010 18:13:08 +1000 (EST)
Message-ID: <4C285991.1050303@redhat.com>
Date: Mon, 28 Jun 2010 11:13:05 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 26/26] KVM: PPC: Add Documentation about PV interface
References: <1277508314-915-1-git-send-email-agraf@suse.de>
	<07C9A4B8-881A-438C-AA99-AEC23887C6B8@suse.de>
	<4C270876.2050806%40redhat.com>
	<1277709531_13308@mail4.comsite.net>
	<92F4A3F3-A89F-418D-BD4D-66E2489F2E42@suse.de>
In-Reply-To: <92F4A3F3-A89F-418D-BD4D-66E2489F2E42@suse.de>
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

On 06/28/2010 10:49 AM, Alexander Graf wrote:
>
>> I don't believe we support the kernel actually doing a syscall to itself
>> anymore, at least on powerpc.  The callers call the underlying system
>> call function, or kernel_thread.
>>
>> That said, I would suggest we allocate a syscall number for this, as it
>> would document the usage.  (In additon to 0..nr_syscalls - 1 we have
>> 0x1ebe in use).
>>      
> That's actually a pretty good idea.
>    

Since the syscall register is not architectual (or rather it is 
architectural but Linux ignores it) I don't see the point.  It would 
work for Linux but may alias some random parameter for a different 
guest.  We need a reliable method of distinguishing between syscalls and 
hypercalls.  Matching pc would work (but is defeated by inlining) so 
long as we find some other way of identifying the hc pc to the hypervisor.



-- 
error compiling committee.c: too many arguments to function
