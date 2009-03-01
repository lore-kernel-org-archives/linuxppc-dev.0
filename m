Return-Path: <jonsmirl@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by ozlabs.org (Postfix) with ESMTP id 2942CDDE0E
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Mar 2009 02:54:56 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so1121862ywb.39
	for <linuxppc-dev@ozlabs.org>; Sun, 01 Mar 2009 07:54:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <fa686aa40903010648q238380acy34b58e04226d8014@mail.gmail.com>
References: <1235575933-29691-1-git-send-email-w.sang@pengutronix.de>
	<fa686aa40902262131i6c75687foaf42daeb4fc7a3b7@mail.gmail.com>
	<20090301101815.GC23093@pengutronix.de>
	<fa686aa40903010648q238380acy34b58e04226d8014@mail.gmail.com>
Date: Sun, 1 Mar 2009 10:54:54 -0500
Message-ID: <9e4733910903010754q1b4d9fafy87668049653d5e21@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mpc52xx: add Phytec phyCORE-MPC5200B-IO board
	(pcm032)
From: Jon Smirl <jonsmirl@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Mar 1, 2009 at 9:48 AM, Grant Likely <grant.likely@secretlab.ca> wr=
ote:
> On Sun, Mar 1, 2009 at 3:18 AM, Wolfram Sang <w.sang@pengutronix.de> wrot=
e:
>> Hi Grant,
>>
>> thanks for the review!
>>
>> On Thu, Feb 26, 2009 at 10:31:24PM -0700, Grant Likely wrote:
>>> Thanks for the patch Wolfram. =A0Comments below.
>>>
>>> On Wed, Feb 25, 2009 at 8:32 AM, Wolfram Sang <w.sang@pengutronix.de> w=
rote:
>>> > Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
>>> > ---
>>> > =A0arch/powerpc/boot/dts/pcm032.dts =A0 =A0 =A0 =A0 =A0 =A0 | =A0391 =
+++++++
>>> > =A0arch/powerpc/configs/52xx/pcm032_defconfig =A0 | 1394 ++++++++++++=
++++++++++++++
>>>
>>> Do you really need a separate defconfig for this board? =A0Can it be
>>> merged with an existing defconfig?
>>
>> Will have a look if I can make a pcm03x_defconfig out of pcm030_defconfi=
g.
>
> Cool, thanks.
>
>>> motionpro.dts is a good example of what it should look like.
>>
>> Ah, thanks for the pointer. Will have a look there. Guess I'll need to u=
pdate
>> pcm030.dts later, too (from which I copied this one). Will rewrite the
>> localbus-node addressing the comments you gave.
>
> pcm030.dts in mainline doesn't have a localbus node.

I've been using this on my pcm030 locally.

pcm030 doesn't have a PCI socket but it can be added via the expansion bus.
With just the basic pcm030 hardware, if I uncomment the pci node I
sometimes hang on boot.

	lpb@ff000000 {
		compatible =3D "fsl,lpb", "simple-bus";
		#address-cells =3D <2>;
		#size-cells =3D <1>;
		ranges =3D <0 0 0xff000000 0x01000000>;

		flash@0 {
			compatible =3D "cfi-flash";
			reg =3D <0 0 0x01000000>;
			bank-width =3D <2>;
			device-width =3D <2>;
			#size-cells =3D <1>;
			#address-cells =3D <1>;
			partition@0 {
				label =3D "ubootl";
				reg =3D <0x00000000 0x00040000>;
			};
			partition@40000 {
				label =3D "kernel";
				reg =3D <0x00040000 0x001c0000>;
			};
			partition@200000 {
				label =3D "jffs2";
				reg =3D <0x00200000 0x00D00000>;
			};
			partition@f00000 {
				label =3D "uboot";
				reg =3D <0x00f00000 0x00040000>;
			};
			partition@f40000 {
				label =3D "oftree";
				reg =3D <0x00f40000 0x00040000>;
			};
			partition@f80000 {
				label =3D "space";
				reg =3D <0x00f80000 0x00080000>;
			};
		};
	};
	/*
	pci@f0000d00 {
		#interrupt-cells =3D <1>;
		#size-cells =3D <2>;
		#address-cells =3D <3>;
		device_type =3D "pci";
		compatible =3D "fsl,mpc5200b-pci","fsl,mpc5200-pci";
		reg =3D <0xf0000d00 0x100>;
		interrupt-map-mask =3D <0xf800 0x0 0x0 0x7>;
		interrupt-map =3D <0xc000 0x0 0x0 0x1 &mpc5200_pic 0x0 0x0 0x3 / 1st slot=
 /
				 0xc000 0x0 0x0 0x2 &mpc5200_pic 0x1 0x1 0x3
				 0xc000 0x0 0x0 0x3 &mpc5200_pic 0x1 0x2 0x3
				 0xc000 0x0 0x0 0x4 &mpc5200_pic 0x1 0x3 0x3

				 0xc800 0x0 0x0 0x1 &mpc5200_pic 0x1 0x1 0x3 / 2nd slot /
				 0xc800 0x0 0x0 0x2 &mpc5200_pic 0x1 0x2 0x3
				 0xc800 0x0 0x0 0x3 &mpc5200_pic 0x1 0x3 0x3
				 0xc800 0x0 0x0 0x4 &mpc5200_pic 0x0 0x0 0x3>;
		clock-frequency =3D <0>; // From boot loader
		interrupts =3D <0x2 0x8 0x0 0x2 0x9 0x0 0x2 0xa 0x0>;
		interrupt-parent =3D <&mpc5200_pic>;
		bus-range =3D <0 0>;
		ranges =3D <0x42000000 0x0 0x80000000 0x80000000 0x0 0x20000000
			  0x02000000 0x0 0xa0000000 0xa0000000 0x0 0x10000000
			  0x01000000 0x0 0x00000000 0xb0000000 0x0 0x01000000>;
	};
*/


>
> g.
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



--=20
Jon Smirl
jonsmirl@gmail.com
