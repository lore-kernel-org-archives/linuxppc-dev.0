Return-Path: <mlcreech@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E38D2B6F83
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Mar 2011 05:46:33 +1100 (EST)
Received: by wyj26 with SMTP id 26so1696972wyj.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Mar 2011 10:46:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <AANLkTikvPOak6mamoeBrDBS5j_M3KuPmQi6DR5Ng6vki@mail.gmail.com>
References: <AANLkTikaH6=8JgX6wfqLu0fCFBO0A1hHDTpw7Xb64uKS@mail.gmail.com>
	<20110219095253.39540a57@wker>
	<AANLkTikvPOak6mamoeBrDBS5j_M3KuPmQi6DR5Ng6vki@mail.gmail.com>
Date: Thu, 10 Mar 2011 13:46:29 -0500
Message-ID: <AANLkTi=B4O7u3S3qsa_zfDKWp33hXw3Yp5j6szRXDgfJ@mail.gmail.com>
Subject: Re: fsl_udc_core not initializing properly?
From: "Matthew L. Creech" <mlcreech@gmail.com>
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Feb 19, 2011 at 1:01 PM, Matthew L. Creech <mlcreech@gmail.com> wro=
te:
>
> Yes, it's there. =A0Here's the DTS entry in case anything else sticks out=
:
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usb@23000 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl-usb2-d=
r";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x23000 0x1000>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#address-cells =3D <1>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#size-cells =3D <0>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D <&ipi=
c>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <38 0x8>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0phy_type =3D "utmi_wide";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dr_mode =3D "peripheral";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sleep =3D <&pmc 0x00300000=
>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
>

Hi Anatolij,

I tracked the problem down to a change made in September, which
happens to be yours:

http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
itdiff;h=3D126512e3f274802ca65ebeca8660237f0361ad48

When I roll this back, everything works fine again.

First of all, I noticed that fsl-mph-dr-of.c isn't even compiling for
me (even though I have the option enabled in my .config), because it's
been placed in "usb/host/", and I'm only using device/gadget-mode USB.

I edited the top-level Makefile to just force it into "usb/host/", and
that makes sure that your driver gets built (and it's probed just fine
at runtime).  But that still didn't solve the problem - as before,
fsl_udc_probe() is never being called.

Did you test this change in device mode?  I'm wondering if there's
something different about my configuration that prevents it from
working.  My config is uploaded here if it helps:

http://mcreech.com/work/linux.config

Thanks!

--=20
Matthew L. Creech
