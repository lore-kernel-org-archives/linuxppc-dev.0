Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6826F2C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 00:40:21 +1000 (EST)
Subject: Re: [PATCH 1/2] Powerpc: Add voltage ranges support for T4
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <192298D25D96A042975E372855100DB70A1A93DC@039-SN2MPN1-012.039d.mgd.msft.net>
Date: Mon, 22 Jul 2013 09:39:41 -0500
Message-Id: <18210A71-9F5A-40B7-AC3A-03CEF6C28982@kernel.crashing.org>
References: <1374479636-9254-1-git-send-email-Haijun.Zhang@freescale.com>
 <192298D25D96A042975E372855100DB70A1A93DC@039-SN2MPN1-012.039d.mgd.msft.net>
To: Wrobel Heinz-R39252 <r39252@freescale.com>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Zhang Haijun-B42677 <B42677@freescale.com>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 "cbouatmailru@gmail.com" <cbouatmailru@gmail.com>,
 "cjb@laptop.org" <cjb@laptop.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 22, 2013, at 4:47 AM, Wrobel Heinz-R39252 wrote:

>> Subject: [PATCH 1/2] Powerpc: Add voltage ranges support for T4
>>=20
>> Special voltages that can be support by eSDHC of T4 in esdhc node.
>>=20
>> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
>> Signed-off-by: Anton Vorontsov <cbouatmailru@gmail.com>
>=20
>> --- a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
>> +++ b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
>> @@ -19,6 +19,8 @@ Optional properties:
>>     "bus-width =3D <1>" property.
>>   - sdhci,auto-cmd12: specifies that a controller can only handle =
auto
>>     CMD12.
>> +  - 3300 3300: specifies that eSDHC controller can support voltages
>> ranges
>> +    from 3300 to 3300. This is an optional.
>=20
> "This is an optional." is an unclear statement.
>=20
>> +++ b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
>> @@ -399,6 +399,7 @@
>> 	sdhc@114000 {
>> 		compatible =3D "fsl,t4240-esdhc", "fsl,esdhc";
>> 		sdhci,auto-cmd12;
>> +		voltage-ranges =3D <1800 1800 3300 3300>;
>=20
> This is IMHO incorrect and potentially dangerous.
> The T4 silicon will only support 1.8V on SDHC pins per hardware =
specification.
> The Freescale T4240QDS reference board has extra voltage shifters =
added to allow 3.3V operation, but that is _not_ a silicon feature. It =
is a specific board feature that may or may not translate to other =
boards, depending on how SD spec conformant a board builder wants to be.
>=20
> If the intent is to state that a physical SDHC interface on a board =
has to be built to support 3.3V operation to be SD spec conformant for =
off-the-shelf cards because a reset would change the signal voltage to =
3.3V, then I am not sure that putting this down as silicon "feature" =
without further explanation about the background anywhere is the right =
way to go.
> IMHO silicon features are really just silicon features and not =
technically optional external circuitry additions implied by common use.
>=20
> Best regards,
>=20
> Heinz

I'd say that the t4240si-post.dtsi should be:

	voltage-ranges =3D <1800 1800>;

Than have the t4240qds.dts do:

	voltage-ranges =3D <1800 1800 3300 3300>;

As the 3.3V sounds like a board specific feature.

[ send this as 2 patches, on for the t4240si-post.dtsi and another for =
the t4240qds.dts ]

- k
=09=
