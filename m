Return-Path: <brad@bradleyehughes.com>
Received: from mail-bw0-f42.google.com (mail-bw0-f42.google.com
	[209.85.214.42]) by ozlabs.org (Postfix) with ESMTP id A5058B70AE
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 02:53:15 +1000 (EST)
Received: by bwz11 with SMTP id 11so362493bwz.15
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jul 2010 09:53:13 -0700 (PDT)
MIME-Version: 1.0
Sender: brad@bradleyehughes.com
In-Reply-To: <7AD5FB58-D6EA-4AA6-870B-32E901F72589@kernel.crashing.org>
References: <AANLkTinQkpBTtmVZYGM71wzREHGDzG6R3k7LbR66yX5c@mail.gmail.com>
	<7AD5FB58-D6EA-4AA6-870B-32E901F72589@kernel.crashing.org>
From: Bradley Hughes <bhughes@silicontkx.com>
Date: Wed, 21 Jul 2010 12:52:52 -0400
Message-ID: <AANLkTinoCJrYTdc56uK0ELQGMfG-em_5iiTtGGGWCgPT@mail.gmail.com>
Subject: Re: [PATCH] DTS: Adding device tree source for the STx GP3 SSA
	MPC8555-based board.
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 21, 2010 at 10:24 AM, Kumar Gala <galak@kernel.crashing.org> wr=
ote:
>>
>> + =A0 =A0 soc8555@e0000000 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "soc";
>> + =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "simple-bus";
>> + =A0 =A0 =A0 =A0 =A0 =A0 ranges =3D <0x0 0xe0000000 0x100000>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 bus-frequency =3D <0>;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 ecm-law@0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,ecm-law";
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x0 0x1000>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl,num-laws =3D <8>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 };
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 ecm@1000 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc8555-ec=
m", "fsl,ecm";
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x1000 0x1000>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <17 2>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&mpic>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 };
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 memory-controller@2000 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,8555-memor=
y-controller";
>
> fsl,mpc8555?

Ah, yes -- it seems the dts I used for an example also has this
problem.  In drivers/edac/mpc85xx_edac.c, bindings still work for
fsl,85.. style notation, but a comment claims that this notation would
be deprecated at some point (2.6.29 or 2.6.30).  I have updated my
local copy and it works fine, should I send a new patch?  I could also
extend this change to the other DTS files affected (A quick search
found 14 instances of fsl,85.. style notation.)  Please let me know
what I should do.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x2000 0x1000>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&mpic>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <18 2>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 };
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 L2: l2-cache-controller@20000 {
>
> fsl,mpc8555?
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,8555-l2-ca=
che-controller";
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x20000 0x1000>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cache-line-size =3D <32>; // 3=
2 bytes
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cache-size =3D <0x40000>; // L=
2, 256K
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&mpic>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <16 2>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 };
>> +
>
> - k
>
>
>
>

Best Regards,
Bradley
