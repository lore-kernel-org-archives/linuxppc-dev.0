Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9BB72B6F01
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Jun 2010 17:40:01 +1000 (EST)
Subject: Re: [PATCH 11/26] KVM: PPC: Make RMO a define
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <07830DA6-1B53-4E84-A0E2-8449289C71F1@kernel.crashing.org>
Date: Tue, 29 Jun 2010 09:39:55 +0200
Message-Id: <182AF505-54A6-4F71-AF5D-7CA40D911C35@suse.de>
References: <1277508314-915-1-git-send-email-agraf@suse.de>
	<1277508314-915-12-git-send-email-agraf@suse.de>
	<2078D8A9-7D36-4B5D-A779-9BBAB545A53D@kernel.crashing.org>
	<9B84B663-7DC6-4543-96F7-23F77106065C@suse.de>
	<07830DA6-1B53-4E84-A0E2-8449289C71F1@kernel.crashing.org>
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


On 29.06.2010, at 09:32, Segher Boessenkool wrote:

>>>> On PowerPC it's very normal to not support all of the physical RAM =
in real mode.
>>>=20
>>> Oh?  Are you referring to "real mode limit", or 32-bit =
implementations with
>>> more than 32 address lines, or something else?
>>=20
>> The former.
>=20
> Okay.  In that case, the hypervisor can usually access all of physical
> ram directly, unless it limits itself; and a supervisor gets either
> no real mode access, or all ram, or some part -- whatever the =
hypervisor
> likes.
>=20
> If you access outside of ram, you will most likely get a machine =
check.
> Depends on the implementation (like most things here).
>=20
>>> Either way, RMO is a really bad name for this, since that name is =
already
>>> used for a similar but different concept.
>>=20
>> It's the same concept, no? Not all physical memory is accessible from =
real mode.
>=20
> I think you're looking for "real mode limit":
>=20
> The concept is called "offset real mode".
>=20
> RMO ("real mode offset") is the value that is ORed to an effective =
address
> to make the physical address (not added, "offset" is a pretty bad =
name).
> RML ("real mode limit") is the value that has to be bigger than the =
effective
> address or you will get an exception.
> RMA ("real mode area") is the name for the range of addresses usable =
in offset
> real mode.
>=20
>>> Also, it seems you construct the physical address by masking out =
bits from
>>> the effective address.  Most implementations will trap or machine =
check if
>>> you address outside of physical address space, instead.
>>=20
>> Well the only case where I remember to have hit a real RMO case is on =
the PS3 - that issues a data/instruction storage interrupt when =
accessing anything > 8MB in real mode.
>>=20
>> So I'd argue this is heavily implementation specific.
>=20
> It is.  So what is the behaviour you want to implement?

The one below.

>=20
>> Apart from that what I'm trying to cover is that on ppc64 accessing =
0xc0000000000000 in real mode gets you 0x0. Is there a better name for =
this?
>=20
> (You missed two zeroes).
> In hypervisor real mode, the top few bits are magic.  They are used =
for e.g.
> enabling hypervisor offset real mode.
> In supervisor real mode, those bits are ignored (and all other bits =
that do
> not correspond to physical address lines may also be ignored).

So which bits exactly are reserved? I couldn't find a reference to that =
part.

> Maybe you want to call it physical_address_mask or similar?

PAM - doesn't sound bad :).


Alex
