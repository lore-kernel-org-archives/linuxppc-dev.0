Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 75DAE2C023D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2012 21:10:49 +1100 (EST)
Subject: Re: [Qemu-ppc] [RFC PATCH 05/17] KVM: PPC: booke: Extend MAS2 EPN
 mask for 64-bit
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <300B73AA675FCE4A93EB4FC1D42459FF15B15F@039-SN2MPN1-013.039d.mgd.msft.net>
Date: Mon, 8 Oct 2012 12:10:40 +0200
Message-Id: <0A87124F-B5D0-475C-A33C-A1F36C1B56D9@suse.de>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
 <1340627195-11544-6-git-send-email-mihai.caraman@freescale.com>
 <D3F90478-D3C9-4699-ADFD-CE752D9A569F@suse.de>
 <300B73AA675FCE4A93EB4FC1D42459FF15B15F@039-SN2MPN1-013.039d.mgd.msft.net>
To: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
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


On 05.07.2012, at 13:14, Caraman Mihai Claudiu-B02008 wrote:

>=20
>=20
>> -----Original Message-----
>> From: Alexander Graf [mailto:agraf@suse.de]
>> Sent: Wednesday, July 04, 2012 4:50 PM
>> To: Caraman Mihai Claudiu-B02008
>> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
>> dev@lists.ozlabs.org; qemu-ppc@nongnu.org
>> Subject: Re: [Qemu-ppc] [RFC PATCH 05/17] KVM: PPC: booke: Extend =
MAS2
>> EPN mask for 64-bit
>>=20
>>=20
>> On 25.06.2012, at 14:26, Mihai Caraman wrote:
>>=20
>>> Extend MAS2 EPN mask for 64-bit hosts, to retain most significant =
bits.
>>> Change get tlb eaddr to use this mask.
>>=20
>> Please see section 6.11.4.8 in the PowerISA 2.06b:
>>=20
>> MMU behavior is largely unaffected by whether the thread is in 32-bit
>> computation mode (MSRCM=3D0) or 64- bit computation mode (MSRCM=3D1). =
The
>> only differ- ences occur in the EPN field of the TLB entry and the =
EPN
>> field of MAS2. The differences are summarized here.
>>=20
>> 	*  Executing a tlbwe instruction in 32-bit mode will set bits =
0:31
>> of the TLB EPN field to zero unless MAS0ATSEL is set, in which case =
those
>> bits are not written to zero.
>> 	*  In 32-bit implementations, MAS2U can be used to read or write
>> EPN0:31 of MAS2.
>>=20
>> So if MSR.CM is not set tlbwe should mask the upper 32 bits out - =
which
>> can happen regardless of CONFIG_64BIT.
>=20
> MAS2_EPN reflects EPN field of MAS2 aka bits 0:51 (for MAV =3D 1.0) =
according
> to section 6.10.3.10 in the PowerISA 2.06b.
>=20
> MAS2_EPN is not used in tlbwe execution emulation, we have MAS2_VAL =
define
> for this case.

So tlbe->mas2 is guaranteed to have the upper bits be 0 when MSR.CM=3D0?

>=20
>> Also, we need to implement MAS2U, to potentially make the upper =
32bits of
>> MAS2 available, right? But that one isn't as important as the first =
bit.
>=20
> MAS2U is guest privileged why does it need special care?

Maybe it's mapped to the upper bits of GMAS2 automatically?

> Freescale core Manuals and EREF does not mention MAS2U so I think I =
our case
> it is not implemented.

Please check with a simple mfspr() test on real hw to see if it really =
isn't implemented.


Alex
