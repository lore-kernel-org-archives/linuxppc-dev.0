Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.230])
	by ozlabs.org (Postfix) with ESMTP id C36CCDDEE3
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 07:35:39 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f9so1852692rvb.9
	for <linuxppc-dev@ozlabs.org>; Fri, 01 May 2009 14:35:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1241211774-32719-1-git-send-email-fkan@amcc.com>
References: <1241211774-32719-1-git-send-email-fkan@amcc.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 1 May 2009 15:35:23 -0600
Message-ID: <fa686aa40905011435v1071f871nbc47871fdb4046e1@mail.gmail.com>
Subject: Re: [PATCH 2/2] Added AMCC 460EX Canyonlands SATA support.
To: Feng Kan <fkan@amcc.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 1, 2009 at 3:02 PM, Feng Kan <fkan@amcc.com> wrote:
> This adds the OF platform support for the AMCC 460EX Canyonlands SATA por=
t.
>
> Signed-off-by: Feng Kan <fkan@amcc.com>
> ---
> =A0arch/powerpc/boot/dts/canyonlands.dts =A0| =A0 =A08 ++
> =A0arch/powerpc/platforms/44x/Makefile =A0 =A0| =A0 =A04 +
> =A0arch/powerpc/platforms/44x/amcc-sata.c | =A0125 ++++++++++++++++++++++=
++++++++++
> =A03 files changed, 137 insertions(+), 0 deletions(-)
> =A0create mode 100644 arch/powerpc/platforms/44x/amcc-sata.c
>
> diff --git a/arch/powerpc/boot/dts/canyonlands.dts b/arch/powerpc/boot/dt=
s/canyonlands.dts
> index 5fd1ad0..b536223 100644
> --- a/arch/powerpc/boot/dts/canyonlands.dts
> +++ b/arch/powerpc/boot/dts/canyonlands.dts
> @@ -163,6 +163,14 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <0x1e 4>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SATA0: sata@bffd1000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "amcc,sat=
a-460ex";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <4 0xbffd1000 0x800=
 4 0xbffd0800 0x400>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D <&U=
IC3>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <0 4 =A0 =
=A0 =A0 /* SATA */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A05 4>; =A0 =A0 /* AHBDMA */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
> +

You should also add documentation for the "amcc,sata-460ex" binding to
Documentation/powerpc/dts-bindings.  Doesn't have to be huge, just a
blurb describing the device and what each tuple in the reg &
interrupts properties mean.

g.


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
