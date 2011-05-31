Return-Path: <xenidis@gmail.com>
Received: from mail-gx0-f170.google.com (mail-gx0-f170.google.com
	[209.85.161.170]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0E105B6F7A
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Jun 2011 06:26:24 +1000 (EST)
Received: by gxk27 with SMTP id 27so2665358gxk.15
	for <linuxppc-dev@ozlabs.org>; Tue, 31 May 2011 13:26:21 -0700 (PDT)
Sender: "xenidis@gmail.com" <xenidis@gmail.com>
Subject: Re: [PATCH 10/13] kvm/powerpc: Add support for Book3S processors in
	hypervisor mode
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Jimi Xenidis <jimix@pobox.com>
In-Reply-To: <10cc079a31947ec4b6d39f30f2ac50f2@kernel.crashing.org>
Date: Tue, 31 May 2011 16:26:09 -0400
Message-Id: <A052DEF7-7DA0-4573-89EC-0A685ED4B498@pobox.com>
References: <20110511103443.GA2837@brick.ozlabs.ibm.com>
	<20110511104456.GK2837@brick.ozlabs.ibm.com>
	<BDD550B2-02CA-4B1A-A05B-6CB3EF89B7B3@suse.de>
	<20110516055809.GA3590@drongo>
	<D8CAE971-9A97-4C02-8908-2B199C81947A@suse.de>
	<20110527103334.GA4236@brick.ozlabs.ibm.com>
	<b833d9df4fc8e1e6a8b6a56311c6f344@kernel.crashing.org>
	<6A1CA2C8-8032-4D67-9C14-4ABD81ABCDD7@suse.de>
	<10cc079a31947ec4b6d39f30f2ac50f2@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: kvm-ppc@vger.kernel.org, Linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Alexander Graf <agraf@suse.de>, KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 27, 2011, at 9:07 PM, Segher Boessenkool wrote:

>>>> If HDEC expires when interrupts are off, the HDEC interrupt stays
>>>> pending until interrupts get re-enabled.  I'm not sure exactly what
>>>> the conditions are that cause an HDEC interrupt to get lost, but =
they
>>>> seem to involve at least a partition switch.
>>>=20
>>> On some CPUs, if the top bit of the decrementer is 0 again when you =
re-enable
>>> the interrupt, the interrupt is lost (so it is actually =
level-triggered).
>>> The arch books talk a bit about this AFAIR.
>>=20
>> Sure, but that shouldn't happen with HDEC during the odd 50 =
instructions that it takes to enter the guest :)
>=20
> It's more like 500 insns, including some ptesync, so lots of cycles =
too.

I don't think its actually that bad.

IIRC the problem is mostly due to another interrupt of a higher priority =
that sets MSR[HV] is pending.
This could also be a synchronous instruction on or near the HSRR0 (like =
a hypercall).
Since almost everything _is_ of a higher priority, externals, VRMA-ish, =
emulation, that will occur first (or at the same time).
This extends the window where the HDEC could go +ve.

Another way around this is to check, on HV switch, if the HDEC is ever =
bigger then it should _ever_ be, but what paulus has in his code is =
actually best, although the value (10?) may be too small.

> Can another hardware thread be running at the same time?

I'll leave this question to someone else.
-JX

>=20
>=20
> Segher
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
