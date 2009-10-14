Return-Path: <roberto.j.guerra@gmail.com>
Received: from mail-qy0-f187.google.com (mail-qy0-f187.google.com
	[209.85.221.187]) by ozlabs.org (Postfix) with ESMTP id 624D4B7B78
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Oct 2009 08:34:09 +1100 (EST)
Received: by qyk17 with SMTP id 17so294111qyk.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 14 Oct 2009 14:34:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20091009181617.GA14304@loki.buserror.net>
References: <7c4144600910090714g524bad07ubf6cad3aaf8085ff@mail.gmail.com>
	<20091009170433.GA17372@b07421-ec1.am.freescale.net>
	<7c4144600910091059o492c870cn3ea1c1a96d2f0823@mail.gmail.com>
	<20091009181617.GA14304@loki.buserror.net>
Date: Wed, 14 Oct 2009 17:34:06 -0400
Message-ID: <7c4144600910141434y26972dbbnb776c4ef89d15a17@mail.gmail.com>
Subject: Re: Support for S29JL064 in MPC8272ADS?
From: Roberto Guerra <roberto.j.guerra@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 9, 2009 at 2:16 PM, Scott Wood <scottwood@freescale.com> wrote:
> On Fri, Oct 09, 2009 at 01:59:58PM -0400, Roberto Guerra wrote:
>> No. I did not. My FDT was simplified from the stock MPC8272ADS:
>> =3D> fdt list
>> / {
>> =A0 =A0 =A0 =A0 model =3D "pq2fads";
>> =A0 =A0 =A0 =A0 compatible =3D "fsl,pq2fads";
>> =A0 =A0 =A0 =A0 #address-cells =3D <0x00000001>;
>> =A0 =A0 =A0 =A0 #size-cells =3D <0x00000001>;
>> =A0 =A0 =A0 =A0 cpus {
>> =A0 =A0 =A0 =A0 };
>> =A0 =A0 =A0 =A0 memory {
>> =A0 =A0 =A0 =A0 };
>> =A0 =A0 =A0 =A0 soc@f0000000 {
>> =A0 =A0 =A0 =A0 };
>> =A0 =A0 =A0 =A0 chosen {
>> =A0 =A0 =A0 =A0 };
>> };
>
> You need more than that. =A0What happened to all the content of those nod=
es?
>
>> I am searching how I could add the mtd branch between the "soc" and
>> the "chosen".
>
> Look at the localbus node on the mpc8272ads dts.
>
> Look at (and use) a recent upstream kernel, if you're not already.
>
> -Scott
>

I've been learning how to modify the dts from
http://www.mjmwired.net/kernel/Documentation/powerpc/dts-bindings/mtd-physm=
ap.txt#49
The original mpc8272ads.dts represents four 8-bit JEDEC Sharp flash
chips in 1 SIMM module:
[snip]        localbus@f0010100 {
                compatible =3D "fsl,mpc8280-localbus",
                             "fsl,pq2-localbus";
                #address-cells =3D <2>;
                #size-cells =3D <1>;
                reg =3D <f0010100 60>;

                ranges =3D <0 0 fe000000 00800000
                          1 0 f4500000 00008000
                          8 0 f8200000 00008000>;

                flash@0,0 {
                        compatible =3D "jedec-flash";
                        reg =3D <0 0 800000>;
                        bank-width =3D <4>;
                        device-width =3D <1>;
                };
[snip]
My board (based on the PQ2FADS, using the MPC8272ADS BSP) uses one
16-bit Spansion (AMD) CFI chip at addresses FF800000 through FFFFFFFF.
It probably needs to be represented this way (I've only made changes
to the "flash" section.
[snip]
                flash@0,0 {
                        compatible =3D "amd, s29jl064h", "cfi-flash";
                        reg =3D <0 0 800000>;
                        bank-width =3D <2>;
                        device-width =3D <2>;
                };
[snip]
However, I don't know what would be the correct addresses to type
after "localbus", "flash" and "reg". Is this enough information to
define my dts?
Thanks,
Roberto
