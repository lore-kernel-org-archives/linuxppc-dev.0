Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C06B3B6FE5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2012 10:06:45 +1100 (EST)
Subject: Re: [RFC PATCH 14/16] KVM: PPC: booke: category E.HV (GS-mode) support
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <4F0CB5B1.6010601@freescale.com>
Date: Wed, 11 Jan 2012 00:06:39 +0100
Message-Id: <033F89A4-66C4-415F-9888-12B6B1B49B5D@suse.de>
References: <20111221013443.GN8378@schlenkerla.am.freescale.net>
 <1A656B06-E290-4B75-8F98-F8FAB8B817F1@suse.de> <4F0B8B7D.4@freescale.com>
 <A1483A2E-FF86-4E25-93CC-9EA1BA4925D4@suse.de>
 <4F0CB5B1.6010601@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 10.01.2012, at 23:03, Scott Wood wrote:

> On 01/09/2012 09:11 PM, Alexander Graf wrote:
>> On 10.01.2012, at 01:51, Scott Wood wrote:
>>> On 01/09/2012 11:46 AM, Alexander Graf wrote:
>>>> On 21.12.2011, at 02:34, Scott Wood wrote:
>>>>> +		/* For debugging, encode the failing instruction and
>>>>> +		 * report it to userspace. */
>>>>> +		run->hw.hardware_exit_reason =3D ~0ULL << 32;
>>>>> +		run->hw.hardware_exit_reason |=3D vcpu->arch.last_inst;
>>>>=20
>>>>=20
>>>> I'm fairly sure you want to fix this :)
>>>=20
>>> Likewise, that's what booke.c already does.  What should it do =
instead?
>>=20
>> This is what book3s does:
>>=20
>>                case EMULATE_FAIL:
>>                        printk(KERN_CRIT "%s: emulation at %lx failed =
(%08x)\n",
>>                               __func__, kvmppc_get_pc(vcpu), =
kvmppc_get_last_inst(vcpu));
>>                        kvmppc_core_queue_program(vcpu, flags);
>>                        r =3D RESUME_GUEST;
>>=20
>> which also doesn't throttle the printk, but I think injecting a
>> program fault into the guest is the most sensible thing to do if we
>> don't know what the instruction is supposed to do. Best case we get
>> an oops inside the guest telling us what broke :).
>=20
> Ah, yes, it should send a program check.
>=20
>>>> Ah, so that's what you want to use regs for. So is having a pt_regs
>>>> struct that only contains useful register values in half its fields
>>>> any useful here? Or could we keep control of the registers =
ourselves,
>>>> enabling us to maybe one day optimize things more.
>>>=20
>>> I think it contains enough to be useful for debugging code such as =
sysrq
>>> and tracers, and as noted in the comment we could copy the rest if =
we
>>> care enough.  MSR might be worth copying.
>>>=20
>>> It will eventually be used for machine checks as well, which I'd =
like to
>>> hand reasonable register state to, at least for GPRs, LR, and PC.
>>>=20
>>> If there's a good enough performance reason, we could just copy
>>> everything over for machine checks and pass NULL to do_IRQ (I think =
it
>>> can take this -- a dummy regs struct if not), but it seems premature =
at
>>> the moment unless the switch already causes measured performance =
loss
>>> (cache utilization?).
>>=20
>> I'm definitely not concerned about performance, but complexity and =
uniqueness.
>>=20
>> With the pt_regs struct, we have a bunch of fields in the vcpu that =
are there, but unused. I find that situation pretty confusing.
>=20
> I removed the registers from the vcpu, that are to be used in regs =
instead.
>=20
> There are a few fields in regs that are not valid, though it is
> explicitly pointed out via a comment.

Yes, and if there was real technical reason to do it this way I'd agree. =
But there isn't.

>=20
>> So yes, I would definitely prefer to copy registers during MC and =
keep the registers where they are today - unless there are SPRs for them =
of course.
>>=20
>> Imagine we'd one day want to share GPRs with user space through the
>> kvm_run structure (see the s390 patches on the ML for this). I really
>> wouldn't want to make pt_regs part of our userspace ABI.
>=20
> Neither would I.  If that's something that's reasonably likely to
> happen, I guess that's a good enough reason to avoid this.  We could
> always add later a debug option to copy regs even on normal =
interrupts,
> if needed.

Yup. I don't want to walk in the wrong direction basically. The overhead =
of copying
a couple fields to the stack on machine checks doesn't sound too bad =
compared
to the flexibility we maintain by keeping fields under our control.

Another imaginary case. I experimented with putting the GPRs into the =
PACA
back in the day. I don't remember why anymore, but it was for some =
speedup
of something.

That wouldn't be possible if we mandate everyone to use pt_regs.

>=20
>>> We probably should defer the check until after we've disabled
>>> interrupts, similar to signals -- even if we didn't exit for an
>>> interrupt, we could have received one after enabling them.
>>=20
>> Yup. I just don't think you can call resched() with interrupts =
disabled, so a bit cleverness is probably required here.
>=20
> I think it is actually allowed, but interrupts will be enabled on
> return.  We'll need to repeat prepare_to_enter if we do schedule.  =
Since
> we already need special handling for that, we might as well add a
> local_irq_enable() once we know we are going to schedule, just in =
case.

Yup :). And then check again.

>=20
>>>>> diff --git a/arch/powerpc/kvm/booke.h b/arch/powerpc/kvm/booke.h
>>>>> index 05d1d99..d53bcf2 100644
>>>>> --- a/arch/powerpc/kvm/booke.h
>>>>> +++ b/arch/powerpc/kvm/booke.h
>>>>> @@ -48,7 +48,20 @@
>>>>> #define BOOKE_IRQPRIO_PERFORMANCE_MONITOR 19
>>>>> /* Internal pseudo-irqprio for level triggered externals */
>>>>> #define BOOKE_IRQPRIO_EXTERNAL_LEVEL 20
>>>>> -#define BOOKE_IRQPRIO_MAX 20
>>>>> +#define BOOKE_IRQPRIO_DBELL 21
>>>>> +#define BOOKE_IRQPRIO_DBELL_CRIT 22
>>>>> +#define BOOKE_IRQPRIO_MAX 23
>>>>=20
>>>> So was MAX wrong before or is it too big now?
>>>=20
>>> MAX is just a marker for how many IRQPRIOs we have, not any sort of
>>> external limit.  This patch adds new IRQPRIOs, so MAX goes up.
>>>=20
>>> The actual limit is the number of bits in a long.
>>=20
>=20
>> Yes, and before the highest value was 20 with MAX being 20, now the
>> highest value is 22 with MAX being 23. Either MAX =3D=3D highest =
number
>> or MAX =3D=3D highest number + 1, but you're changing the semantics =
of
>> MAX here. Maybe it was wrong before, I don't know, hence I'm asking
>> :).
>=20
> Oh, didn't notice that.
>=20
> Actually, it looks like the two places that reference =
BOOKE_IRQPRIO_MAX
> don't agree on what they're expecting.  book3s uses "one greater than
> the highest irqprio", so I guess we should resolve it that way (even
> though I'd normally expect that to be phrased "num" rather than "max")
> -- as a separate patch, of course.

Yup. As long as it's consistent it's fine. I just really stumbled over =
this since the semantics of the define changed.


Alex=
