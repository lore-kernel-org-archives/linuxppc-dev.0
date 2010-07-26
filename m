Return-Path: <glikely@secretlab.ca>
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by ozlabs.org (Postfix) with ESMTP id 09F31B70A8
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 17:59:37 +1000 (EST)
Received: by gwj15 with SMTP id 15so1794631gwj.15
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 00:59:36 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <73839B4A0818E747864426270AC332C30540064C@zmy16exm20.fsl.freescale.net>
References: <1279591705-7574-1-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-2-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-3-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-4-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-5-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-6-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-7-git-send-email-Mingkai.hu@freescale.com>
	<20100726003501.GE25419@angua.secretlab.ca>
	<73839B4A0818E747864426270AC332C30540064C@zmy16exm20.fsl.freescale.net>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 26 Jul 2010 01:59:15 -0600
Message-ID: <AANLkTimcggE4oafhPTMjSZCOoVJm_H7iCSHL1LiwrVOt@mail.gmail.com>
Subject: Re: [PATCH 6/6] DTS: add SPI flash(s25fl128p01) support on p4080ds
	and mpc8536ds board
To: Hu Mingkai-B21284 <B21284@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Zang Roy-R61911 <R61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 26, 2010 at 1:39 AM, Hu Mingkai-B21284 <B21284@freescale.com> w=
rote:
>
>
>> -----Original Message-----
>> From: Grant Likely [mailto:glikely@secretlab.ca] On Behalf Of
>> Grant Likely
>> Sent: Monday, July 26, 2010 8:35 AM
>> To: Hu Mingkai-B21284
>> Cc: linuxppc-dev@ozlabs.org; galak@kernel.crashing.org; Zang
>> Roy-R61911
>> Subject: Re: [PATCH 6/6] DTS: add SPI flash(s25fl128p01)
>> support on p4080ds and mpc8536ds board
>>
>> On Tue, Jul 20, 2010 at 10:08:25AM +0800, Mingkai Hu wrote:
>> > Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
>> > ---
>> > =A0arch/powerpc/boot/dts/mpc8536ds.dts | =A0 52
>> +++++++++++++++++++++++++++++++++++
>> > =A0arch/powerpc/boot/dts/p4080ds.dts =A0 | =A0 =A09 ++----
>> > =A02 files changed, 55 insertions(+), 6 deletions(-)
>> >
>> > diff --git a/arch/powerpc/boot/dts/mpc8536ds.dts
>> > b/arch/powerpc/boot/dts/mpc8536ds.dts
>> > index 815cebb..e5d07ec 100644
>> > --- a/arch/powerpc/boot/dts/mpc8536ds.dts
>> > +++ b/arch/powerpc/boot/dts/mpc8536ds.dts
>> > @@ -108,6 +108,58 @@
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
>> > =A0 =A0 =A0 =A0 =A0 =A0 };
>> >
>> > + =A0 =A0 =A0 =A0 =A0 spi@7000 {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0>;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,espi";
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x7000 0x1000>;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <59 0x2>;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&mpic>;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl,espi-num-chipselects =3D <4>=
;
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flash@0 {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =
=3D <1>;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D =
<1>;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "=
spansion,s25sl12801";
>>
>> whitespace inconsitencies
>>
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0>;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi-max-frequenc=
y =3D <40000000>;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 partition@u-boot=
 {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
label =3D "u-boot";
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
reg =3D <0x00000000 0x00100000>;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
read-only;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 partition@kernel=
 {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
label =3D "kernel";
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
reg =3D <0x00100000 0x00500000>;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
read-only;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 partition@dtb {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
label =3D "dtb";
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
reg =3D <0x00600000 0x00100000>;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
read-only;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 partition@fs {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
label =3D "file system";
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
reg =3D <0x00700000 0x00900000>;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flash@1 {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "=
spansion,s25sl12801";
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <1>;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi-max-frequenc=
y =3D <40000000>;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flash@2 {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "=
spansion,s25sl12801";
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <2>;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi-max-frequenc=
y =3D <40000000>;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flash@3 {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "=
spansion,s25sl12801";
>>
>> whitespace inconsitencies
>>
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <3>;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi-max-frequenc=
y =3D <40000000>;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
>> > + =A0 =A0 =A0 =A0 =A0 };
>> > +
>> > =A0 =A0 =A0 =A0 =A0 =A0 dma@21300 {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
>> > diff --git a/arch/powerpc/boot/dts/p4080ds.dts
>> > b/arch/powerpc/boot/dts/p4080ds.dts
>> > index 6b29eab..ac7dd23 100644
>> > --- a/arch/powerpc/boot/dts/p4080ds.dts
>> > +++ b/arch/powerpc/boot/dts/p4080ds.dts
>> > @@ -236,22 +236,19 @@
>> > =A0 =A0 =A0 =A0 =A0 =A0 };
>> >
>> > =A0 =A0 =A0 =A0 =A0 =A0 spi@110000 {
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <0>;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0>;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,espi";
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x110000 0x1000>;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <53 0x2>;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&mpic>;
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 espi,num-ss-bits =3D <4>;
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode =3D "cpu";
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl,espi-num-chipselects =3D <4>=
;
>> >
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl_m25p80@0 {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flash@0 {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells=
 =3D <1>;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =
=3D <1>;
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "=
fsl,espi-flash";
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "=
spansion,s25sl12801";
>>
>> whitespace inconsistencies
>>
>
> I use checkpatch to check the patch, but don't find any warnings and
> errors.
> so what's the whitespace inconsistencies means?
>
> hmk@rock:~/public/linux-2.6$ ./scripts/checkpatch.pl
> patch/public/v1/0006-DTS-add-SPI-flash-s25fl128p01-support-on-p4080ds-an
> d.patch
> total: 0 errors, 0 warnings, 83 lines checked
>
> patch/public/v1/0006-DTS-add-SPI-flash-s25fl128p01-support-on-p4080ds-an
> d.patch has no obvious style problems and is ready for submission.

Configure your editor to show tab characters differently from spaces.
About a dozen lines have a single space at the beginning of the line
before the tab indentation.

g.
