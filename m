Return-Path: <Chris.Packham@alliedtelesis.co.nz>
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [202.36.163.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vDKj35xs8zDqC4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 10:53:59 +1100 (AEDT)
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Borislav Petkov <bp@alien8.de>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "morbidrsa@gmail.com" <morbidrsa@gmail.com>, Rob Herring
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Benjamin
 Herrenschmidt" <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] EDAC: mpc85xx: Add T2080 l2-cache support
Date: Wed, 1 Feb 2017 23:46:23 +0000
Message-ID: <01fe1af463c640a8bd48e45c2752b52c@svr-chch-ex1.atlnz.lc>
References: <20170201231624.28843-1-chris.packham@alliedtelesis.co.nz>
 <20170201232735.byk7bnpeoqtcc7mh@pd.tnic>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/02/17 12:28, Borislav Petkov wrote:=0A=
> On Thu, Feb 02, 2017 at 12:16:24PM +1300, Chris Packham wrote:=0A=
>> The l2-cache controller on the T2080 SoC has similar capabilities to the=
=0A=
>> others already supported by the mpc85xx_edac driver. Add it to the list=
=0A=
>> of compatible devices.=0A=
>>=0A=
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>=0A=
>> Acked-by: Johannes Thumshirn <jth@kernel.org>=0A=
>> ---=0A=
>> This is a resend of a patch that got an ack[1] but didn't seem to get=0A=
>> picked up.=0A=
>>=0A=
>> [1] http://marc.info/?l=3Dlinux-edac&m=3D148042072225488&w=3D2=0A=
>>=0A=
>> Changes since v1:=0A=
>> - Collect ack from Johannes.=0A=
>=0A=
> Whoops, my bad. Sorry about that.=0A=
>=0A=
>>  arch/powerpc/boot/dts/fsl/t2081si-post.dtsi | 1 +=0A=
>>  drivers/edac/mpc85xx_edac.c                 | 1 +=0A=
>>  2 files changed, 2 insertions(+)=0A=
>>=0A=
>> diff --git a/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi b/arch/powerpc/=
boot/dts/fsl/t2081si-post.dtsi=0A=
>> index c744569a20e1..a97296c64eb2 100644=0A=
>> --- a/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi=0A=
>> +++ b/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi=0A=
>> @@ -678,5 +678,6 @@=0A=
>>  		compatible =3D "fsl,t2080-l2-cache-controller";=0A=
>>  		reg =3D <0xc20000 0x40000>;=0A=
>>  		next-level-cache =3D <&cpc>;=0A=
>> +		interrupts =3D <16 2 1 9>;=0A=
>>  	};=0A=
>>  };=0A=
>> diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c=
=0A=
>> index 8f66cbed70b7..67f7bc3fe5b3 100644=0A=
>> --- a/drivers/edac/mpc85xx_edac.c=0A=
>> +++ b/drivers/edac/mpc85xx_edac.c=0A=
>> @@ -629,6 +629,7 @@ static const struct of_device_id mpc85xx_l2_err_of_m=
atch[] =3D {=0A=
>>  	{ .compatible =3D "fsl,p1020-l2-cache-controller", },=0A=
>>  	{ .compatible =3D "fsl,p1021-l2-cache-controller", },=0A=
>>  	{ .compatible =3D "fsl,p2020-l2-cache-controller", },=0A=
>> +	{ .compatible =3D "fsl,t2080-l2-cache-controller", },=0A=
>=0A=
> WARNING: DT compatible string "fsl,t2080-l2-cache-controller" appears un-=
documented -- check ./Documentation/devicetree/bindings/=0A=
> #58: FILE: drivers/edac/mpc85xx_edac.c:632:=0A=
> +       { .compatible =3D "fsl,t2080-l2-cache-controller", },=0A=
>=0A=
> What is checkpatch.pl trying to tell me here?=0A=
>=0A=
=0A=
checpkatch.pl is confused by =0A=
Documentation/devicetree/bindings/powerpc/fsl/l2cache.txt which says=0A=
=0A=
- compatible    : Should include "fsl,chip-l2-cache-controller" and "cache"=
=0A=
                   where chip is the processor (bsc9132, npc8572 etc.)=0A=
=0A=
So none of the fsl cache controllers pass the checkpatch.pl test.=0A=
