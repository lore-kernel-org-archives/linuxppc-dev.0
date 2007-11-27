Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 32449DDD0C
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 08:19:05 +1100 (EST)
Message-Id: <5D634124-D3BA-41B7-9765-4A1A09C8DCB8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
In-Reply-To: <474C3C79.5060908@ru.mvista.com>
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 3/3] [POWERPC] MPC8349E-mITX: introduce localbus and pata
	nodes
Date: Tue, 27 Nov 2007 15:18:55 -0600
References: <20071127153708.GA12490@localhost.localdomain>
	<20071127153940.GC14183@localhost.localdomain>
	<474C3C79.5060908@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 27, 2007, at 9:49 AM, Sergei Shtylyov wrote:

> Hello.
>
> Anton Vorontsov wrote:
>
>> This patch adds localbus and pata nodes to use CF IDE interface
>> on MPC8349E-mITX boards.
>
>> Patch also adds code to probe localbus.
>
>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>> ---
>> arch/powerpc/boot/dts/mpc8349emitx.dts    |   17 ++++++++++++++++-
>> arch/powerpc/platforms/83xx/mpc834x_itx.c |   17 +++++++++++++++++
>> 2 files changed, 33 insertions(+), 1 deletions(-)
>
>> diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/=20=

>> boot/dts/mpc8349emitx.dts
>> index 5072f6d..7a97068 100644
>> --- a/arch/powerpc/boot/dts/mpc8349emitx.dts
>> +++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
>> @@ -249,6 +249,21 @@
>> 		device_type =3D "pci";
>> 	};
>>
>> +	localbus@e0005000 {
>> +		#address-cells =3D <2>;
>> +		#size-cells =3D <1>;
>> +		compatible =3D "fsl,mpc8349emitx-localbus",
>
>    Board compatible bus?
>
>> +			     "fsl,mpc8349e-localbus",
>> +			     "fsl,pq2pro-localbus";
>> +		reg =3D <e0005000 d8>;
>> +		ranges =3D <3 0 f0000000 210>;
>>
>> -
>> +		pata@3,0 {
>> +			compatible =3D "fsl,mpc8349emitx-pata", =
"pata-platform";
>> +			reg =3D <3 0 10 3 20c 4>;
>> +			ioport-shift =3D <1>;
>
>    Bleh... that shift again. And this is surely not a good name for a
> property (where's I/O ports in your case?) -- why not call it "reg-=20
> shift"
> (well, I'd call it "reg-size" or "reg-stride" myself :-)?

I'm coming into this late, but if ioport-shift applies to reg (which I =20=

think it does) it should really be called "reg-shift".  The ePAPR is =20
using that property name:

Specifies in bytes how far the discrete device registers are separated =20=

from each other. The
individual register location is calculated by using following formula: =20=

=93registers address=94 <<
reg-shift. If unspecified the default value is 0.

- k
