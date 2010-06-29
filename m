Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 5D43DB6F15
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Jun 2010 18:04:48 +1000 (EST)
Subject: Re: [PATCH 11/26] KVM: PPC: Make RMO a define
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1550A5F0-3A22-48ED-8251-96328E2FEAE3@kernel.crashing.org>
Date: Tue, 29 Jun 2010 10:04:44 +0200
Message-Id: <7504F7A1-C394-4037-A951-A9AC724C0809@suse.de>
References: <1277508314-915-1-git-send-email-agraf@suse.de>
	<1277508314-915-12-git-send-email-agraf@suse.de>
	<2078D8A9-7D36-4B5D-A779-9BBAB545A53D@kernel.crashing.org>
	<9B84B663-7DC6-4543-96F7-23F77106065C@suse.de>
	<07830DA6-1B53-4E84-A0E2-8449289C71F1@kernel.crashing.org>
	<182AF505-54A6-4F71-AF5D-7CA40D911C35@suse.de>
	<1550A5F0-3A22-48ED-8251-96328E2FEAE3@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>,
	"kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 29.06.2010, at 09:52, Segher Boessenkool wrote:

>>>>> Also, it seems you construct the physical address by masking out =
bits from
>>>>> the effective address.  Most implementations will trap or machine =
check if
>>>>> you address outside of physical address space, instead.
>>>>=20
>>>> Well the only case where I remember to have hit a real RMO case is =
on the PS3 - that issues a data/instruction storage interrupt when =
accessing anything > 8MB in real mode.
>>>>=20
>>>> So I'd argue this is heavily implementation specific.
>>>=20
>>> It is.  So what is the behaviour you want to implement?
>>=20
>> The one below.
>=20
> I'm sorry, I lost it.  "Below"?

Well, the ones a few lines below :).

>=20
>>>> Apart from that what I'm trying to cover is that on ppc64 accessing =
0xc0000000000000 in real mode gets you 0x0. Is there a better name for =
this?
>>>=20
>>> (You missed two zeroes).
>>> In hypervisor real mode, the top few bits are magic.  They are used =
for e.g.
>>> enabling hypervisor offset real mode.
>>> In supervisor real mode, those bits are ignored (and all other bits =
that do
>>> not correspond to physical address lines may also be ignored).
>>=20
>> So which bits exactly are reserved? I couldn't find a reference to =
that part.
>=20
> If by "reserved" you mean "cannot be used for addressing", it's the =
top four
> bits.  Book III-S chapter 5.7.3 in the Power Architecture 2.06 =
document.
> Implementations are allowed to ignore more bits than that.
>=20
> I believe in earlier versions of the architecture it was the top two =
bits,
> not four, but maybe I misremember.

Ah, nice. So that part is implementation specific too. Awesome ;).

>=20
>>> Maybe you want to call it physical_address_mask or similar?
>>=20
>> PAM - doesn't sound bad :).
>=20
> And miraculously nothing in the Power arch uses that acronym yet!  But =
I
> would spell it out if I were you, acronyms are confusing.

Well, the bad thing about not using acronyms here is that I'll run out =
of the 80 character limit pretty soon. And that means line wraps and =
more confusingness when reading the code.

Alex
