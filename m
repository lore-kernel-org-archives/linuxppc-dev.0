Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6740DB6F1A
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 28 Jun 2010 17:49:42 +1000 (EST)
Subject: Re: [PATCH 26/26] KVM: PPC: Add Documentation about PV interface
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1277709531_13308@mail4.comsite.net>
Date: Mon, 28 Jun 2010 09:49:33 +0200
Message-Id: <92F4A3F3-A89F-418D-BD4D-66E2489F2E42@suse.de>
References: <1277508314-915-1-git-send-email-agraf@suse.de>
	<07C9A4B8-881A-438C-AA99-AEC23887C6B8@suse.de>
	<4C270876.2050806%40redhat.com>
	<1277709531_13308@mail4.comsite.net>
To: Milton Miller <miltonm@bga.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Avi Kivity <avi@redhat.com>,
	kvm-ppc@vger.kernel.org, KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 28.06.2010, at 09:18, Milton Miller wrote:

> On Sun Jun 27 around 19:33:52 EST 2010 Alexander Graf wrote:
>> Am 27.06.2010 um 10:14 schrieb Avi Kivity <avi at redhat.com>:
>>> On 06/26/2010 02:25 AM, Alexander Graf wrote:
>=20
>>>> +
>>>> +PPC hypercalls
>>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>> +
>>>> +The only viable ways to reliably get from guest context to host =20=

>>>> context are:
>>>> +
>>>> +    1) Call an invalid instruction
>>>> +    2) Call the "sc" instruction with a parameter to "sc"
>>>> +    3) Call the "sc" instruction with parameters in GPRs
>>>> +
>>>> +Method 1 is always a bad idea. Invalid instructions can be =20
>>>> replaced later on
>>>> +by valid instructions, rendering the interface broken.
>>>> +
>>>> +Method 2 also has downfalls. If the parameter to "sc" is !=3D 0 =
the =20
>>>> spec is
>>>> +rather unclear if the sc is targeted directly for the hypervisor =20=

>>>> or the
>>>> +supervisor. It would also require that we read the syscall issuing =
=20
>>>> instruction
>>>> +every time a syscall is issued, slowing down guest syscalls.
>>>> +
>=20
> It goes to the hypervisor, and it would require the hypervisor to
> return to the supervisor, but I believe it just returns to the user =
with
> permission denied.

That's what I assumed, yeah :(.

>=20
>>>> +Method 3 is what KVM uses. We pass magic constants =20
>>>> (KVM_SC_MAGIC_R3 and
>>>> +KVM_SC_MAGIC_R4) in r3 and r4 respectively. If a syscall =20
>>>> instruction with these
>>>> +magic values arrives from the guest's kernel mode, we take the =20
>>>> syscall as a
>>>> +hypercall.
>>>>=20
>>>=20
>>> Is there any chance a normal syscall will have those values in r3 =20=

>>> and r4?
>>=20
>> r3 is the syscall number. So as long as the guest doesn't reuse that =20=

>> value, we're safe. Since in general syscall numbers are not randomly =20=

>> scattered throughout the number range, we should be ok here.
>>=20
>=20
> No, r0 has the system call number.  Registers 3 and 4 are the first
> 2 args in c abi (or first 64 bit arg in 32 bit c abi), but the linux
> syscall abi special.  (In addition, it returns success or failure in
> cr0).

Oh. Ahem :)

>=20
>>>=20
>>> If so, maybe it's better to use pc as they key for hypercalls.  Let =20=

>>> the guest designate one instruction address as the hypercall call =20=

>>> point; kvm can easily check it and reflect it back to the guest if =20=

>>> it doesn't match.
>>>=20
>>=20
>> You mean the guest would tell the hv where the hypercall lies? That =20=

>> would require a hypercall, no? Defining it statically is tricky. I =20=

>> want to PV'nize osx using a kernel module later, so I don't have =20
>> control over the physical layout.
>>=20
>>> Is it valid and useful to issue sc from privileged mode anyway, =20
>>> except for calling the hypervisor?
>>=20
>> Same as a syscall on x86 really. The kernel can and does issue =20
>> syscalls within itself.
>>=20
>>=20
>=20
> I don't believe we support the kernel actually doing a syscall to =
itself
> anymore, at least on powerpc.  The callers call the underlying system
> call function, or kernel_thread.
>=20
> That said, I would suggest we allocate a syscall number for this, as =
it
> would document the usage.  (In additon to 0..nr_syscalls - 1 we have
> 0x1ebe in use).

That's actually a pretty good idea.

>=20
> Also, is there any desire to nest such emulation?

Nesting should just work, right? Since we only accept hypercalls from =
PR=3D0 and guests run in PR=3D1, we get the sc interrupt in the l1 guest =
by then.

The only issue I'm aware of that completely breaks when using nested KVM =
on PPC is the MSR_IR !=3D MSR_DR logic. We fetch the instruction we got =
an interrupt on for certain interrupts in the world switch handler by =
keeping MSR_IR=3D0, but setting MSR_DR=3D1. And KVM speeds up MSR_DR !=3D =
MSR_IR by mapping both of them lazily in a special address space. So if =
you access the same page as instruction and as data, you get an invalid =
result.

Alex
