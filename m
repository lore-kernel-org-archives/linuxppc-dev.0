Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 50D08B6F04
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  4 Jul 2010 19:41:18 +1000 (EST)
Message-ID: <4C30573A.3000407@redhat.com>
Date: Sun, 04 Jul 2010 12:41:14 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 27/27] KVM: PPC: Add Documentation about PV interface
References: <1277980982-12433-1-git-send-email-agraf@suse.de>
	<1277980982-12433-28-git-send-email-agraf@suse.de>
	<EB2E1C5B-118B-481B-83D6-44CFAA2E55D3@kernel.crashing.org>
	<1278196909.4200.389.camel@pasglop>
	<79514591-DCC1-4D9E-AFB7-AA985ADF3C0F@suse.de>
	<4C305001.7060301@redhat.com>
	<40488555-C73E-4C04-BFAD-31ED99CDBBDA@suse.de>
	<486564E7-7942-4021-8EB2-67DC4E56580D@suse.de>
In-Reply-To: <486564E7-7942-4021-8EB2-67DC4E56580D@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/04/2010 12:30 PM, Alexander Graf wrote:
>
>> Considering how the parts of the draft that I read about sound like, that's not the inventor's idea. PPC people love to see the BIOS be part of the virtualization solution. I don't. That's the biggest difference here and reason for us going different directions.
>>
>> I think what they thought of is something like
>>
>> if (in_kvm()) {
>>   device_tree_put("/hypervisor/exit", EXIT_TYPE_MAGIC);
>>   device_tree_put("/hypervisor/exit_magic", EXIT_MAGIC);
>> }
>>
>> which then the OS reads out. But that's useless, as the hypercalls are hypervisor specific. So why make the detection on the Linux side generic?
>>      
> In fact, it's even worse. Right now with KVM for PPC we have 3 different ways of generating the device tree:
>
> 1) OpenBIOS (Mac emulation)
> 2) Qemu libfdt (BookE)
> 3) MOL OF implementation
>    

I sympathize.  But, if the arch says that's how you do things, then 
that's how you do things.

> So I'd have to touch even more projects. Just for the sake of splitting out something that belongs together anyway. And probably even create new interfaces just for that sake (qemu asking the kernel which type of hypercalls the vm should use) even though the guest could just query all that itself.
>    

qemu needs to be involved, in case one day you support more than one 
type of hypercalls (like x86 does with hyper-v) or if you want to live 
migrate from a host that has hypercall support to another host that has 
this feature removed (as has already happened on x86 with the pvmmu).

Planning for the future means a lot of boring interfaces.

-- 
error compiling committee.c: too many arguments to function
