Return-Path: <blackluck@ktk.bme.hu>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 539CCB7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 28 Jun 2009 03:53:03 +1000 (EST)
Received: from mail.ktk.bme.hu (mail.ktk.bme.hu [152.66.220.33])
	by ozlabs.org (Postfix) with ESMTP id 5A50CDDD01
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Jun 2009 03:53:02 +1000 (EST)
Message-ID: <4A465AF5.9000606@ktk.bme.hu>
Date: Sat, 27 Jun 2009 19:46:29 +0200
From: Laszlo Fekete <blackluck@ktk.bme.hu>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: sym scsi driver problem with 2.6.26 or newer debian kernel on
	p610 (fwd)
References: <Pine.LNX.4.64.0906141105050.4412@axis700.grange>	
	<4A38B883.80507@ktk.bme.hu> <4A3F4A77.6070704@ktk.bme.hu>	
	<1245719890.4017.26.camel@pasglop>
	<1245724218.4017.35.camel@pasglop>	
	<1245794228.10356.31.camel@pasglop>
	<1245799792.10356.42.camel@pasglop>	
	<1245822826.9237.62.camel@concordia>
	<1245823019.10356.69.camel@pasglop>
	<1245824392.9237.85.camel@concordia>
In-Reply-To: <1245824392.9237.85.camel@concordia>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2646875F3C4CB4ADF569A3CA"
Cc: Olof Johansson <olof@lixom.net>, debian-powerpc@lists.debian.org,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linuxppc-dev@ozlabs.org
Reply-To: blackluck@ktk.bme.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2646875F3C4CB4ADF569A3CA
Content-Type: multipart/alternative;
 boundary="------------080407030406080700010004"

This is a multi-part message in MIME format.
--------------080407030406080700010004
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable

Hello!

Thank you very much, this patch works me too.

Maybe this patch will be in the debian kernel someday?

Thank you: blackluck

Michael Ellerman wrote:
> On Wed, 2009-06-24 at 15:56 +1000, Benjamin Herrenschmidt wrote:
>  =20
>> On Wed, 2009-06-24 at 15:53 +1000, Michael Ellerman wrote:
>>    =20
>>> Doesn't fix my machine :/
>>>
>>>      =20
>> That doesn't make sense ... What if you remove the bit inside the ifde=
f
>> CONFIG_MPIC_BROKEN_REGREAD in _mpic_read() ?
>>
>> If that makes a difference, then it would be interesting to add a prin=
tk
>> in there that prints what the original value "val" is and what we have=

>> in the shadow...
>>    =20
>
> With this patch it boots:
>
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index 2353adc..fc17289 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -231,13 +231,16 @@ static inline u32 _mpic_irq_read(struct mpic *mpi=
c, unsign
>         unsigned int    isu =3D src_no >> mpic->isu_shift;
>         unsigned int    idx =3D src_no & mpic->isu_mask;
>         unsigned int    val;
> +       unsigned int    shadow;
> =20
>         val =3D _mpic_read(mpic->reg_type, &mpic->isus[isu],
>                          reg + (idx * MPIC_INFO(IRQ_STRIDE))); =20
>  #ifdef CONFIG_MPIC_BROKEN_REGREAD
> -       if (reg =3D=3D 0)
> -               val =3D (val & (MPIC_VECPRI_MASK | MPIC_VECPRI_ACTIVITY=
)) |
> +       if (reg =3D=3D 0) {
> +               shadow =3D (val & (MPIC_VECPRI_MASK | MPIC_VECPRI_ACTIV=
ITY)) |
>                         mpic->isu_reg0_shadow[idx];
> +               printk("%s: val 0x%x shadow 0x%x\n", __func__, val, sha=
dow);
> +       }
>  #endif
>         return val;
>  }
>
>
> And I see:
>
> sym53c8xx 0000:00:0c.0: enabling device (0140 -> 0143)
> sym0: <896> rev 0x7 at pci 0000:00:0c.0 irq 17
> sym0: No NVRAM, ID 7, Fast-40, SE, parity checking
> _mpic_irq_read: val 0x80480004 shadow 0x80080014
> _mpic_irq_read: val 0x480004 shadow 0x480004
>
>
>
> cheers
>  =20

--------------080407030406080700010004
Content-Type: text/html; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content=3D"text/html;charset=3DISO-8859-2" http-equiv=3D"Content-=
Type">
  <title></title>
</head>
<body bgcolor=3D"#ffffff" text=3D"#000000">
Hello!<br>
<br>
Thank you very much, this patch works me too.<br>
<br>
Maybe this patch will be in the debian kernel someday?<br>
<br>
Thank you: blackluck<br>
<br>
Michael Ellerman wrote:
<blockquote cite=3D"mid:1245824392.9237.85.camel@concordia" type=3D"cite"=
>
  <pre wrap=3D"">On Wed, 2009-06-24 at 15:56 +1000, Benjamin Herrenschmid=
t wrote:
  </pre>
  <blockquote type=3D"cite">
    <pre wrap=3D"">On Wed, 2009-06-24 at 15:53 +1000, Michael Ellerman wr=
ote:
    </pre>
    <blockquote type=3D"cite">
      <pre wrap=3D"">Doesn't fix my machine :/

      </pre>
    </blockquote>
    <pre wrap=3D"">That doesn't make sense ... What if you remove the bit=
 inside the ifdef
CONFIG_MPIC_BROKEN_REGREAD in _mpic_read() ?

If that makes a difference, then it would be interesting to add a printk
in there that prints what the original value "val" is and what we have
in the shadow...
    </pre>
  </blockquote>
  <pre wrap=3D""><!---->
With this patch it boots:

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 2353adc..fc17289 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -231,13 +231,16 @@ static inline u32 _mpic_irq_read(struct mpic *mpic,=
 unsign
        unsigned int    isu =3D src_no &gt;&gt; mpic-&gt;isu_shift;
        unsigned int    idx =3D src_no &amp; mpic-&gt;isu_mask;
        unsigned int    val;
+       unsigned int    shadow;
=20
        val =3D _mpic_read(mpic-&gt;reg_type, &amp;mpic-&gt;isus[isu],
                         reg + (idx * MPIC_INFO(IRQ_STRIDE))); =20
 #ifdef CONFIG_MPIC_BROKEN_REGREAD
-       if (reg =3D=3D 0)
-               val =3D (val &amp; (MPIC_VECPRI_MASK | MPIC_VECPRI_ACTIVI=
TY)) |
+       if (reg =3D=3D 0) {
+               shadow =3D (val &amp; (MPIC_VECPRI_MASK | MPIC_VECPRI_ACT=
IVITY)) |
                        mpic-&gt;isu_reg0_shadow[idx];
+               printk("%s: val 0x%x shadow 0x%x\n", __func__, val, shado=
w);
+       }
 #endif
        return val;
 }


And I see:

sym53c8xx 0000:00:0c.0: enabling device (0140 -&gt; 0143)
sym0: &lt;896&gt; rev 0x7 at pci 0000:00:0c.0 irq 17
sym0: No NVRAM, ID 7, Fast-40, SE, parity checking
_mpic_irq_read: val 0x80480004 shadow 0x80080014
_mpic_irq_read: val 0x480004 shadow 0x480004



cheers
  </pre>
</blockquote>
</body>
</html>

--------------080407030406080700010004--

--------------enig2646875F3C4CB4ADF569A3CA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkpGWvoACgkQl8goZcXbQ28ESwCfcJgHm2M975N3cHmuwcqt5dEA
CykAoJE+6LPdjyf8vclLhMCAOcDf9fCD
=eBfq
-----END PGP SIGNATURE-----

--------------enig2646875F3C4CB4ADF569A3CA--
