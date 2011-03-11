Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 89343B6FA8
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Mar 2011 00:27:19 +1100 (EST)
Date: Fri, 11 Mar 2011 14:27:50 +0100
From: Anatolij Gustschin <agust@denx.de>
To: "Matthew L. Creech" <mlcreech@gmail.com>
Subject: Re: fsl_udc_core not initializing properly?
Message-ID: <20110311142750.0edc8027@wker>
In-Reply-To: <AANLkTi=B4O7u3S3qsa_zfDKWp33hXw3Yp5j6szRXDgfJ@mail.gmail.com>
References: <AANLkTikaH6=8JgX6wfqLu0fCFBO0A1hHDTpw7Xb64uKS@mail.gmail.com>
	<20110219095253.39540a57@wker>
	<AANLkTikvPOak6mamoeBrDBS5j_M3KuPmQi6DR5Ng6vki@mail.gmail.com>
	<AANLkTi=B4O7u3S3qsa_zfDKWp33hXw3Yp5j6szRXDgfJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 10 Mar 2011 13:46:29 -0500
"Matthew L. Creech" <mlcreech@gmail.com> wrote:

> On Sat, Feb 19, 2011 at 1:01 PM, Matthew L. Creech <mlcreech@gmail.com> w=
rote:
> >
> > Yes, it's there. =C2=A0Here's the DTS entry in case anything else stick=
s out:
> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0usb@23000 {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0compatible =3D "fsl-usb2-dr";
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0reg =3D <0x23000 0x1000>;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0#address-cells =3D <1>;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0#size-cells =3D <0>;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0interrupt-parent =3D <&ipic>;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0interrupts =3D <38 0x8>;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0phy_type =3D "utmi_wide";
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0dr_mode =3D "peripheral";
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0sleep =3D <&pmc 0x00300000>;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};
> >
>=20
> Hi Anatolij,

Hi Matthew,


> I tracked the problem down to a change made in September, which
> happens to be yours:
>=20
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dco=
mmitdiff;h=3D126512e3f274802ca65ebeca8660237f0361ad48
>=20
> When I roll this back, everything works fine again.
>=20
> First of all, I noticed that fsl-mph-dr-of.c isn't even compiling for
> me (even though I have the option enabled in my .config), because it's
> been placed in "usb/host/", and I'm only using device/gadget-mode USB.
>=20
> I edited the top-level Makefile to just force it into "usb/host/", and
> that makes sure that your driver gets built (and it's probed just fine
> at runtime).  But that still didn't solve the problem - as before,
> fsl_udc_probe() is never being called.

Thanks for reporting this bug.

> Did you test this change in device mode?  I'm wondering if there's
> something different about my configuration that prevents it from
> working.  My config is uploaded here if it helps:
>=20
> http://mcreech.com/work/linux.config

I did test in device mode with additional Patches for USB Device/OTG
support for MPC5121e, these patches still need rework to be acceptable in
mainline. Thanks for your config, I'll look at the issue this weekend
and will report the result.

Anatolij
