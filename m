Return-Path: <tath76@yahoo.com>
Received: from sonic311-13.consmr.mail.bf2.yahoo.com
 (sonic311-13.consmr.mail.bf2.yahoo.com [74.6.131.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409Vqc3zPlzF22J
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 23:36:08 +1100 (AEDT)
Date: Tue, 27 Mar 2018 12:35:58 +0000 (UTC)
From: T T <tath76@yahoo.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>
Message-ID: <674188442.347898.1522154158190@mail.yahoo.com>
In-Reply-To: <877epxk983.fsf@concordia.ellerman.id.au>
References: <20180326150233.23089-1-npiggin@gmail.com>
 <877epxk983.fsf@concordia.ellerman.id.au>
Subject: Re: [PATCH] powerpc/powernv/nvram: opal_nvram_write handle unknown
 OPAL errors
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_Part_347897_10136288.1522154158189"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

------=_Part_347897_10136288.1522154158189
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

 unscribed me=C2=A0

    On =E2=80=8ETuesday=E2=80=8E, =E2=80=8EMarch=E2=80=8E =E2=80=8E27=E2=80=
=8E, =E2=80=8E2018=E2=80=8E =E2=80=8E05=E2=80=8E:=E2=80=8E34=E2=80=8E:=E2=
=80=8E30=E2=80=8E =E2=80=8EAM=E2=80=8E =E2=80=8EPDT, Michael Ellerman <mpe@=
ellerman.id.au> wrote: =20
=20
 Nicholas Piggin <npiggin@gmail.com> writes:

> opal_nvram_write currently just assumes success if it encounters an
> error other than OPAL_BUSY or OPAL_BUSY_EVENT. Have it return -EIO
> on other errors instead.

Does that ever happen with current skiboot?

Even if it doesn't I think I'm inclined to tag this for stable.

cheers

> diff --git a/arch/powerpc/platforms/powernv/opal-nvram.c b/arch/powerpc/p=
latforms/powernv/opal-nvram.c
> index 9db4398ded5d..13bf625dc3e8 100644
> --- a/arch/powerpc/platforms/powernv/opal-nvram.c
> +++ b/arch/powerpc/platforms/powernv/opal-nvram.c
> @@ -59,6 +59,8 @@ static ssize_t opal_nvram_write(char *buf, size_t count=
, loff_t *index)
>=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (rc =3D=3D OPAL_BUSY_EVENT=
)
>=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 opal_poll_=
events(NULL);
>=C2=A0 =C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 if (rc)
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return -EIO;
>=C2=A0 =C2=A0=C2=A0=C2=A0 *index +=3D count;
>=C2=A0 =C2=A0=C2=A0=C2=A0 return count;
>=C2=A0 }
> --=20
> 2.16.1
 =20
------=_Part_347897_10136288.1522154158189
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div style=3D"font-family:Helvetica Neue, Helvetic=
a, Arial, sans-serif;font-size:13px;"><div></div>
            <div>unscribed me&nbsp;<br></div><div><br></div>
           =20
            <div class=3D"yahoo_quoted" id=3D"yahoo_quoted_2267153160">
                <div style=3D"font-family:'Helvetica Neue', Helvetica, Aria=
l, sans-serif;font-size:13px;color:#26282a;">
                   =20
                    <div>
                        On =E2=80=8ETuesday=E2=80=8E, =E2=80=8EMarch=E2=80=
=8E =E2=80=8E27=E2=80=8E, =E2=80=8E2018=E2=80=8E =E2=80=8E05=E2=80=8E:=E2=
=80=8E34=E2=80=8E:=E2=80=8E30=E2=80=8E =E2=80=8EAM=E2=80=8E =E2=80=8EPDT, M=
ichael Ellerman &lt;mpe@ellerman.id.au&gt; wrote:
                    </div>
                    <div><br></div>
                    <div><br></div>
                    <div><div dir=3D"ltr">Nicholas Piggin &lt;<a href=3D"ma=
ilto:npiggin@gmail.com" ymailto=3D"mailto:npiggin@gmail.com">npiggin@gmail.=
com</a>&gt; writes:<br></div><div dir=3D"ltr"><br></div><div dir=3D"ltr">&g=
t; opal_nvram_write currently just assumes success if it encounters an<br><=
/div><div dir=3D"ltr">&gt; error other than OPAL_BUSY or OPAL_BUSY_EVENT. H=
ave it return -EIO<br></div><div dir=3D"ltr">&gt; on other errors instead.<=
br></div><div dir=3D"ltr"><br></div><div dir=3D"ltr">Does that ever happen =
with current skiboot?<br></div><div dir=3D"ltr"><br></div><div dir=3D"ltr">=
Even if it doesn't I think I'm inclined to tag this for stable.<br></div><d=
iv dir=3D"ltr"><br></div><div dir=3D"ltr">cheers<br></div><div dir=3D"ltr">=
<br></div><div dir=3D"ltr">&gt; diff --git a/arch/powerpc/platforms/powernv=
/opal-nvram.c b/arch/powerpc/platforms/powernv/opal-nvram.c<br></div><div d=
ir=3D"ltr">&gt; index 9db4398ded5d..13bf625dc3e8 100644<br></div><div dir=
=3D"ltr">&gt; --- a/arch/powerpc/platforms/powernv/opal-nvram.c<br></div><d=
iv dir=3D"ltr">&gt; +++ b/arch/powerpc/platforms/powernv/opal-nvram.c<br></=
div><div dir=3D"ltr">&gt; @@ -59,6 +59,8 @@ static ssize_t opal_nvram_write=
(char *buf, size_t count, loff_t *index)<br></div><div dir=3D"ltr">&gt;&nbs=
p; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (rc =3D=3D OPAL_BUSY_EVENT)<br>=
</div><div dir=3D"ltr">&gt;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nb=
sp;&nbsp;&nbsp; opal_poll_events(NULL);<br></div><div dir=3D"ltr">&gt;&nbsp=
; &nbsp;&nbsp;&nbsp; }<br></div><div dir=3D"ltr">&gt; +&nbsp;&nbsp;&nbsp; i=
f (rc)<br></div><div dir=3D"ltr">&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; return -EIO;<br></div><div dir=3D"ltr">&gt;&nbsp; &nbsp;&nbsp;&nbsp; *ind=
ex +=3D count;<br></div><div dir=3D"ltr">&gt;&nbsp; &nbsp;&nbsp;&nbsp; retu=
rn count;<br></div><div dir=3D"ltr">&gt;&nbsp; }<br></div><div dir=3D"ltr">=
&gt; -- <br></div><div dir=3D"ltr">&gt; 2.16.1<br></div></div>
                </div>
            </div></div></body></html>
------=_Part_347897_10136288.1522154158189--
