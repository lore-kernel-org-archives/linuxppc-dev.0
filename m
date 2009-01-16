Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 40AE8474C7
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 20:03:59 +1100 (EST)
Date: Fri, 16 Jan 2009 12:03:56 +0300
From: Yuri Tikhonov <yur@emcraft.com>
Message-ID: <13156621.20090116120356@emcraft.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re[2]: [PATCH 11/11][v2] ppc440spe-adma: ADMA driver for PPC440SP(e)
	systems
In-Reply-To: <20090113022316.GA3628@yookeroo.seuss>
References: <200901130343.56020.yur@emcraft.com>
	<20090113022316.GA3628@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: wd@denx.de, dzu@denx.de, linux-raid@vger.kernel.org,
	linuxppc-dev@ozlabs.org, yanok@emcraft.com, dan.j.williams@intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=0D=0A Hello David,

 Thanks a lot for review.

 The general note to be made here is that the changes to the DTS file=20
made by this patch are necessary for a ppc440spe ADMA driver, which is=20
a not-completed arch/powerpc port from the arch/ppc branch, and which=20
uses DT (well, incorrectly) just to get interrupts. Otherwise, it's=20
just a platform device driver.

 We provided this ADMA driver just as the reference of driver, which=20
implements the RAID-6 related low-level stuff. ppc440spe ADMA in its=20
current state is far from ready for merging. We'll elaborate on its=20
cleaning up then (surely, taking into account all the comments made=20
from community). But, even now, the driver works, so we publish this=20
so interested people could use and test it.

 Some comments mixed in below.

On Tuesday, January 13, 2009 you wrote:

> On Tue, Jan 13, 2009 at 03:43:55AM +0300, Yuri Tikhonov wrote:
>> Adds the platform device definitions and the architecture specific suppo=
rt
>> routines for the ppc440spe adma driver.
>>=20
>> Any board equipped with PPC440SP(e) controller may utilize this driver.
>>=20
>> diff --git a/arch/powerpc/boot/dts/katmai.dts b/arch/powerpc/boot/dts/ka=
tmai.dts
>> index 077819b..f2f77c8 100644
>> --- a/arch/powerpc/boot/dts/katmai.dts
>> +++ b/arch/powerpc/boot/dts/katmai.dts
>> @@ -16,7 +16,7 @@
>> =20
>>  / {
>>       #address-cells =3D <2>;
>> -     #size-cells =3D <1>;
>> +     #size-cells =3D <2>;

> You've changed the root level size-cells, but haven't updated the
> sub-nodes (such as /memory) accordingly.

 Thanks, we'll fix this in the next version of this patch.

>>       model =3D "amcc,katmai";
>>       compatible =3D "amcc,katmai";
>>       dcr-parent =3D <&{/cpus/cpu@0}>;
>> @@ -392,6 +392,30 @@
>>                               0x0 0x0 0x0 0x3 &UIC3 0xa 0x4 /* swizzled =
int C */
>>                               0x0 0x0 0x0 0x4 &UIC3 0xb 0x4 /* swizzled =
int D */>;
>>               };
>> +             DMA0: dma0 {

> No 'compatible' property, which seems dubious.

 OK, we'll fix.

>> +                     interrupt-parent =3D <&DMA0>;
>> +                     interrupts =3D <0 1>;
>> +                     #interrupt-cells =3D <1>;
>> +                     #address-cells =3D <0>;
>> +                     #size-cells =3D <0>;
>> +                     interrupt-map =3D <
>> +                             0 &UIC0 0x14 4
>> +                             1 &UIC1 0x16 4>;
>> +             };
>> +             DMA1: dma1 {
>> +                     interrupt-parent =3D <&DMA1>;
>> +                     interrupts =3D <0 1>;
>> +                     #interrupt-cells =3D <1>;
>> +                     #address-cells =3D <0>;
>> +                     #size-cells =3D <0>;
>> +                     interrupt-map =3D <
>> +                             0 &UIC0 0x16 4
>> +                             1 &UIC1 0x16 4>;

> Are these interrupt-maps correct?  The second interrupt from both dma
> controllers is routed to the same line on UIC1?

 The map is correct:

- first interrupts are 'DMAx Command Status FIFO Needs Service';
- second interrupt is 'DMA Error', both DMA engines share common error IRQ.


>> +             };
>> +             xor {
>> +                     interrupt-parent =3D <&UIC1>;
>> +                     interrupts =3D <0x1f 4>;

> What the hell is this thing?  No compatible property, nor even a
> meaningful name.

 This is the XOR accelerator, the dedicated DMA engine of ppc440spe=20
equipped with the ability to do XOR operations in h/w. I guess, it=20
could be named like DMA2.

 Regards, Yuri

 --
 Yuri Tikhonov, Senior Software Engineer
 Emcraft Systems, www.emcraft.com
