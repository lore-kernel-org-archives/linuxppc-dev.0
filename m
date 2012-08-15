Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CC77B2C0086
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Aug 2012 07:02:10 +1000 (EST)
Subject: Re: [PATCH V7 2/3] powerpc/ge_imp3a: Add ISA node to PCI primary bus
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <502BDCEE.70007@freescale.com>
Date: Wed, 15 Aug 2012 16:01:57 -0500
Message-Id: <62B0A8DA-3EB8-494C-946B-4D2C4510F702@kernel.crashing.org>
References: <1345021026-10886-1-git-send-email-B38951@freescale.com>
 <1345021026-10886-3-git-send-email-B38951@freescale.com>
 <502BDCEE.70007@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Cc: B07421@freescale.com, linuxppc-dev@lists.ozlabs.org,
 Jia Hongtao <B38951@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 15, 2012, at 12:31 PM, Scott Wood wrote:

> On 08/15/2012 03:57 AM, Jia Hongtao wrote:
>> PCI primary bus will be determined by looking for ISA node in device =
tree.
>> Also for board ge_imp3a primary bus is the second PCI controller =
detected.
>> So we add ISA node to ge_imp3a's device tree to fit the new =
determination.
>>=20
>> Adding ISA node to other boards' device tree is not necessary. The =
situation
>> that the first bus is primary have already been handled. Please refer =
to the
>> following patch:
>> powerpc/pci: Make sure ISA IO base is not zero
>>=20
>> Signed-off-by: Jia Hongtao <B38951@freescale.com>
>> Signed-off-by: Li Yang <leoli@freescale.com>
>> ---
>> arch/powerpc/boot/dts/ge_imp3a.dts |    4 ++++
>> 1 files changed, 4 insertions(+), 0 deletions(-)
>>=20
>> diff --git a/arch/powerpc/boot/dts/ge_imp3a.dts =
b/arch/powerpc/boot/dts/ge_imp3a.dts
>> index fefae41..aa2c4b5 100644
>> --- a/arch/powerpc/boot/dts/ge_imp3a.dts
>> +++ b/arch/powerpc/boot/dts/ge_imp3a.dts
>> @@ -248,6 +248,10 @@
>> 				  0x1000000 0x0 0x0
>> 				  0x1000000 0x0 0x0
>> 				  0x0 0x10000>;
>> +
>> +			isa@1e {
>> +				device_type =3D "isa";
>> +			};
>> 		};
>> 	};
>> };
>=20
> I believe I already said it's not acceptable to break old device =
trees.
>=20
> -Scott
>=20

I agree w/Scott this is NOT an acceptable solution, both because of old =
device tree and its just wrong to list ISA if it doesn't exist in the =
device.

- k=
