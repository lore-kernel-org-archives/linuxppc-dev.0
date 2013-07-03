Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id E0F052C009E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 02:59:50 +1000 (EST)
Subject: Re: [PATCH 3/6] KVM: PPC: Book3E: Increase FPU laziness
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <300B73AA675FCE4A93EB4FC1D42459FF0A2A3BDA@039-SN2MPN1-013.039d.mgd.msft.net>
Date: Wed, 3 Jul 2013 18:59:45 +0200
Message-Id: <23C56B31-5145-481E-9877-F1878F66959D@suse.de>
References: <1372855359-13452-1-git-send-email-mihai.caraman@freescale.com>
 <1372855359-13452-4-git-send-email-mihai.caraman@freescale.com>
 <4A7356DD-BD24-49B3-AB17-B3237F71CF88@suse.de>
 <300B73AA675FCE4A93EB4FC1D42459FF0A2A38B0@039-SN2MPN1-013.039d.mgd.msft.net>
 <C4820C32-33E6-4E34-A24C-C49BD7CC8307@suse.de>
 <300B73AA675FCE4A93EB4FC1D42459FF0A2A3BDA@039-SN2MPN1-013.039d.mgd.msft.net>
To: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 03.07.2013, at 17:41, Caraman Mihai Claudiu-B02008 wrote:

>>>>> Increase FPU laziness by calling kvmppc_load_guest_fp() just =
before
>>>>> returning to guest instead of each sched in. Without this =
improvement
>>>>> an interrupt may also claim floting point corrupting guest state.
>>>>=20
>>>> Not sure I follow. Could you please describe exactly what's =
happening?
>>>=20
>>> This was already discussed on the list, I will forward you the =
thread.
>>=20
>> The only thing I've seen in that thread was some pathetic theoretical
>> case where an interrupt handler would enable fp and clobber state
>> carelessly. That's not something I'm worried about.
>=20
> Neither me though I don't find it pathetic. Please refer it to Scott.

If from Linux's point of view we look like a user space program with =
active floating point registers, we don't have to worry about this case. =
Kernel code that would clobber that fp state would clobber random user =
space's fp state too.

>=20
>>=20
>> I really don't see where this patch improves anything tbh. It =
certainly
>> makes the code flow more awkward.
>=20
> I was pointing you to this: The idea of FPU/AltiVec laziness that the =
kernel
> is struggling to achieve is to reduce the number of store/restore =
operations.
> Without this improvement we restore the unit each time we are sched =
it. If an
> other process take the ownership of the unit (on SMP it's even worse =
but don't
> bother with this) the kernel store the unit state to qemu task. This =
can happen
> multiple times during handle_exit().
>=20
> Do you see it now?=20

Yup. Looks good. The code flow is very hard to follow though - there are =
a lot of implicit assumptions that don't get documented anywhere. For =
example the fact that we rely on giveup_fpu() to remove MSR_FP from our =
thread.


Alex
