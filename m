Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 39DE8B6EEE
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 20 Jul 2010 17:37:38 +1000 (EST)
Subject: Re: [PPC64/Power7 - 2.6.35-rc5] Bad relocation warnings whileBuilding
	a CONFIG_RELOCATABLE kernel with CONFIG_ISERIES enabled
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <reloc-2010-07-19-3@mdm.bga.com>
Date: Tue, 20 Jul 2010 09:37:27 +0200
Message-Id: <0D8EEF0C-CC43-4E37-B184-0D3B9BC400D1@suse.de>
References: <4C443E78.6020902@suse.de> <reloc-2010-07-19@mdm.bga.com>
	<8C4BCF61-7F5D-4C80-A311-93CF8521FBF5@suse.de>
	<1273060251.13463.8.camel@subratamodak.linux.ibm.com>
	<20100507054034.GB25173@drongo>
	<1279193743.10707.5.camel@subratamodak.linux.ibm.com>
	<1279501889.10390.1834.camel@pasglop>
	<reloc-2010-07-19-2@mdm.bga.com> <reloc-2010-07-19-3@mdm.bga.com>
To: Milton Miller <miltonm@bga.com>
Cc: KVM list <kvm@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kvm-ppc@vger.kernel.org,
	linux-kernel List <linux-kernel@vger.kernel.org>,
	Subrata Modak <subrata@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 20.07.2010, at 09:27, Milton Miller wrote:

> On Mon, 19 Jul 2010 about 14:00:56 +0200, Alexander Graf wrote:
>> Milton Miller wrote:
>>> I wrote:
>>>=20
>>> Oh yea, and for book-3s, the code copies from 0x100 to =
__end_interrupts
>>> in arch/powerpc/kernel/exceptions-64s.h down to the real 0, but the =
rest
>>> of the kernel is at some disjointed address.  The interrupt will go =
to
>>> the copy at the real zero.  Any references to code outside that =
region
>>> must be done via a full indrect branch (not a relative one), simiar =
to
>>> the secondary startup (via following the function pointer in a =
descriptor
>>> set in very low memory), or syscall entry and exception vectors via =
paca.
>>>=20
>>=20
>> That would still break on normal PPC boxes, as any address accessed =
in
>> real mode has to be inside the RMA. And the #include for
>> kvm/book3s_rmhandlers.S happens after __end_interrupts. So I'd end up
>> with code that gets executed outside of the RMA after a relocation, =
right?
>>=20
>> Alex
>>=20
>=20
> Weither its outside of the RMA or not, DO_KVM is creating a branch =
outside
> of code copied to lowmem.
>=20
> This is BROKEN.
>=20
> We have a hard limit that we can't extend _end_interrupts past 0x7000, =
and
> a soft limit that we can't exceed 0x6000.  If there is space, we could
> move the real mode handler extensions inside end_interrupts in
> exceptions-64s.S, and store the full address in a .quad so it gets
> relocated properly.  Don't subtract the start, we have designed the =
kernel
> to run with start at a VA that can be used as a EA in real mode.

Moving everything to exceptions-64s.S sounds like the best thing to do. =
All the code in real mode really is there so it stays inside the RMA. I =
don't think we can guarantee that for any code that is not copied, =
right?

> Otherwise we need to mark KVM_BOOK3S_64 depends on (!RELOCATABLE ||
> BROKEN) for 2.6.35 until we get fixes.

Well - it's only broken when really getting relocated. But I agree, the =
current state doesn't cope with Linux's relocation logic.

> I took a read though the book3s code as of 2.6.34.   A few things I =
noticed:
>=20
> (1) The code is using slb large to control the segment size.   It =
should
> be using SLB B field (or just impliment 256M segments only).

I'm not sure I understand this part? We only use 256MB segments for now.

> (2) It appears that the mtspr and mfspr code is using the same storage =
for
> bats 4-7 as 0-3 ... I would have expected a 4 + a few places.

Yes, that one is fixed in more recent versions already.

> (3) Its not clear to me that you clear RI when transitioning to the =
guest
> but its obviously required because you place state in srr0 & srr1.

Uh - do I have to clear RI? I'm not prepared to take an interrupt =
anyways and RI is just a soft flag for Linux's handlers, right?

> (4) I don't understand why __kvmppc_vcpu_run turns on interrupts so =
that
> __kvmppc_vcpu_entry can turn them back off.   Something to do with
> irq trace annotations?

__kvmppc_vcpu_run turns on soft interrupts while __kvmppc_vcpu_entry =
turns them off in MSR. This is so that when enabling interrupts again on =
guest exit, we have the soft enable bit set.


Alex
