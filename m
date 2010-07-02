Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7BC22B70A7
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  3 Jul 2010 04:41:46 +1000 (EST)
Subject: Re: [PATCH 27/27] KVM: PPC: Add Documentation about PV interface
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <EB2E1C5B-118B-481B-83D6-44CFAA2E55D3@kernel.crashing.org>
Date: Fri, 2 Jul 2010 20:41:40 +0200
Message-Id: <A98DA9FC-DC42-452E-BD44-5F86D1707BF0@suse.de>
References: <1277980982-12433-1-git-send-email-agraf@suse.de>
	<1277980982-12433-28-git-send-email-agraf@suse.de>
	<EB2E1C5B-118B-481B-83D6-44CFAA2E55D3@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 02.07.2010, at 18:27, Segher Boessenkool wrote:

>> +To find out if we're running on KVM or not, we overlay the PVR =
register. Usually
>> +the PVR register contains an id that identifies your CPU type. If, =
however, you
>> +pass KVM_PVR_PARA in the register that you want the PVR result in, =
the register
>> +still contains KVM_PVR_PARA after the mfpvr call.
>> +
>> +	LOAD_REG_IMM(r5, KVM_PVR_PARA)
>> +	mfpvr	r5
>> +	[r5 still contains KVM_PVR_PARA]
>=20
> I love this part :-)

:)

>=20
>> +	__u64 scratch3;
>> +	__u64 critical;		/* Guest may not get interrupts if =3D=3D =
r1 */
>> +	__u64 sprg0;
>> +	__u64 sprg1;
>> +	__u64 sprg2;
>> +	__u64 sprg3;
>> +	__u64 srr0;
>> +	__u64 srr1;
>> +	__u64 dar;
>> +	__u64 msr;
>> +	__u32 dsisr;
>> +	__u32 int_pending;	/* Tells the guest if we have an =
interrupt */
>> +};
>> +
>> +Additions to the page must only occur at the end. Struct fields are =
always 32
>> +bit aligned.
>=20
> The u64s are 64-bit aligned, should they always be?

That's obvious, isn't it? And the ABI only specifies u64s to be 32 bit =
aligned, no? At least that's what ld and std specify.

>=20
>> +The "ld" and "std" instructions are transormed to "lwz" and "stw" =
instructions
>> +respectively on 32 bit systems with an added offset of 4 to =
accomodate for big
>> +endianness.
>=20
> Will this add never overflow?  Is there anything that checks for it?

It basically means that to access dar, we either do

ld  rX, DAR(0)

or

lwz rX, DAR+4(0)


>=20
>> +mtmsrd	rX, 0		b	<special mtmsr section>
>> +mtmsr			b	<special mtmsr section>
>=20
> mtmsr rX

Nod.


Alex
