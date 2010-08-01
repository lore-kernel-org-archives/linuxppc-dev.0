Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 695CCB70D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  2 Aug 2010 06:21:40 +1000 (EST)
Subject: Re: [PATCH 00/27] KVM PPC PV framework v3
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <4C557E7A.3010606@redhat.com>
Date: Sun, 1 Aug 2010 22:21:37 +0200
Message-Id: <C27A7E71-2F93-45D2-989D-0AB80D9C2C0B@suse.de>
References: <1280407688-9815-1-git-send-email-agraf@suse.de>
	<4C557E7A.3010606@redhat.com>
To: Avi Kivity <avi@redhat.com>
Cc: KVM list <kvm@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 01.08.2010, at 16:02, Avi Kivity wrote:

> On 07/29/2010 03:47 PM, Alexander Graf wrote:
>> On PPC we run PR=3D0 (kernel mode) code in PR=3D1 (user mode) and =
don't use the
>> hypervisor extensions.
>>=20
>> While that is all great to show that virtualization is possible, =
there are
>> quite some cases where the emulation overhead of privileged =
instructions is
>> killing performance.
>>=20
>> This patchset tackles exactly that issue. It introduces a paravirtual =
framework
>> using which KVM and Linux share a page to exchange register state =
with. That
>> way we don't have to switch to the hypervisor just to change a value =
of a
>> privileged register.
>>=20
>> To prove my point, I ran the same test I did for the MMU =
optimizations against
>> the PV framework. Here are the results:
>>=20
>> [without]
>>=20
>> debian-powerpc:~# time for i in {1..1000}; do /bin/echo hello>  =
/dev/null; done
>>=20
>> real    0m14.659s
>> user    0m8.967s
>> sys     0m5.688s
>>=20
>> [with]
>>=20
>> debian-powerpc:~# time for i in {1..1000}; do /bin/echo hello>  =
/dev/null; done
>>=20
>> real    0m7.557s
>> user    0m4.121s
>> sys     0m3.426s
>>=20
>>=20
>> So this is a significant performance improvement! I'm quite happy how =
fast this
>> whole thing becomes :)
>>=20
>> I tried to take all comments I've heard from people so far about such =
a PV
>> framework into account. In case you told me something before that is =
a no-go
>> and I still did it, please just tell me again.
>>=20
>> To make use of this whole thing you also need patches to qemu and =
openbios. I
>> have them in my queue, but want to see this set upstream first before =
I start
>> sending patches to the other projects.
>>=20
>> Now go and have fun with fast VMs on PPC! Get yourself a G5 on ebay =
and start
>> experiencing the power yourself. - heh
>>=20
>> v1 ->  v2:
>>=20
>>   - change hypervisor calls to use r0 and r3
>>   - make crit detection only trigger in supervisor mode
>>   - RMO ->  PAM
>>   - introduce kvm_patch_ins
>>   - only flush icache when patching
>>   - introduce kvm_patch_ins_b
>>   - update documentation
>>=20
>> v2 ->  v3:
>>=20
>>   - use pPAPR conventions for hypercall interface
>>   - only use r0 as magic sc number
>>   - remove PVR detection
>>   - remove BookE shared page mapping support
>>   - combine book3s-64 and -32 magic page ra override
>>   - add self-test check if the mapping works to guest code
>>   - add safety check for relocatable kernels
>>=20
>=20
> Looks reasonable.  Since it's fair to say I understand nothing about =
powerpc, I'd like someone who does to review it and ack, please, with an =
emphasis on the interfaces.

Sounds good. Preferably someone with access to the ePAPR spec :).


Alex
