Return-Path: <srs0=upsz=gr=yahoo.com=tath76@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409Vr52c4vzDqqH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 23:36:37 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 409Vr42CFPz8vnZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 23:36:36 +1100 (AEDT)
Received: from sonic306-2.consmr.mail.bf2.yahoo.com
 (sonic306-2.consmr.mail.bf2.yahoo.com [74.6.132.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 409Vr26pKgz9s1R
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Mar 2018 23:36:34 +1100 (AEDT)
Date: Tue, 27 Mar 2018 12:36:28 +0000 (UTC)
From: T T <tath76@yahoo.com>
To: linuxppc-dev@ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Cc: mauricfo@linux.vnet.ibm.com
Message-ID: <1464025410.301444.1522154188153@mail.yahoo.com>
In-Reply-To: <20180327120153.31612-10-mpe@ellerman.id.au>
References: <20180327120153.31612-1-mpe@ellerman.id.au>
 <20180327120153.31612-10-mpe@ellerman.id.au>
Subject: Re: [PATCH v2 10/10] powerpc/64s: Wire up cpu_show_spectre_v2()
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_Part_301443_784540807.1522154188151"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

------=_Part_301443_784540807.1522154188151
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

 unscribed me=C2=A0

    On =E2=80=8ETuesday=E2=80=8E, =E2=80=8EMarch=E2=80=8E =E2=80=8E27=E2=80=
=8E, =E2=80=8E2018=E2=80=8E =E2=80=8E05=E2=80=8E:=E2=80=8E31=E2=80=8E:=E2=
=80=8E31=E2=80=8E =E2=80=8EAM=E2=80=8E =E2=80=8EPDT, Michael Ellerman <mpe@=
ellerman.id.au> wrote: =20
=20
 Add a definition for cpu_show_spectre_v2() to override the generic
version. This has several permuations, though in practice some may not
occur we cater for any combination.

The most verbose is:

=C2=A0 Mitigation: Indirect branch serialisation (kernel only), Indirect
=C2=A0 branch cache disabled, ori31 speculation barrier enabled

We don't treat the ori31 speculation barrier as a mitigation on its
own, because it has to be *used* by code in order to be a mitigation
and we don't know if userspace is doing that. So if that's all we see
we say:

=C2=A0 Vulnerable, ori31 speculation barrier enabled

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/security.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.=
c
index 0eace3cac818..2cee3dcd231b 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -58,3 +58,36 @@ ssize_t cpu_show_spectre_v1(struct device *dev, struct d=
evice_attribute *attr, c
=20
 =C2=A0=C2=A0=C2=A0 return sprintf(buf, "Vulnerable\n");
 }
+
+ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *a=
ttr, char *buf)
+{
+=C2=A0=C2=A0=C2=A0 bool bcs, ccd, ori;
+=C2=A0=C2=A0=C2=A0 struct seq_buf s;
+
+=C2=A0=C2=A0=C2=A0 seq_buf_init(&s, buf, PAGE_SIZE - 1);
+
+=C2=A0=C2=A0=C2=A0 bcs =3D security_ftr_enabled(SEC_FTR_BCCTRL_SERIALISED)=
;
+=C2=A0=C2=A0=C2=A0 ccd =3D security_ftr_enabled(SEC_FTR_COUNT_CACHE_DISABL=
ED);
+=C2=A0=C2=A0=C2=A0 ori =3D security_ftr_enabled(SEC_FTR_SPEC_BAR_ORI31);
+
+=C2=A0=C2=A0=C2=A0 if (bcs || ccd) {
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 seq_buf_printf(&s, "Mitigation: ");
+
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (bcs)
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 seq_buf_printf(&s=
, "Indirect branch serialisation (kernel only)");
+
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (bcs && ccd)
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 seq_buf_printf(&s=
, ", ");
+
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (ccd)
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 seq_buf_printf(&s=
, "Indirect branch cache disabled");
+=C2=A0=C2=A0=C2=A0 } else
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 seq_buf_printf(&s, "Vulnerable");
+
+=C2=A0=C2=A0=C2=A0 if (ori)
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 seq_buf_printf(&s, ", ori31 speculat=
ion barrier enabled");
+
+=C2=A0=C2=A0=C2=A0 seq_buf_printf(&s, "\n");
+
+=C2=A0=C2=A0=C2=A0 return s.len;
+}
--=20
2.14.1

 =20
------=_Part_301443_784540807.1522154188151
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div style=3D"font-family:Helvetica Neue, Helvetic=
a, Arial, sans-serif;font-size:13px;"><div></div>
            <div>unscribed me&nbsp;<br></div><div><br></div>
           =20
            <div class=3D"yahoo_quoted" id=3D"yahoo_quoted_2185832396">
                <div style=3D"font-family:'Helvetica Neue', Helvetica, Aria=
l, sans-serif;font-size:13px;color:#26282a;">
                   =20
                    <div>
                        On =E2=80=8ETuesday=E2=80=8E, =E2=80=8EMarch=E2=80=
=8E =E2=80=8E27=E2=80=8E, =E2=80=8E2018=E2=80=8E =E2=80=8E05=E2=80=8E:=E2=
=80=8E31=E2=80=8E:=E2=80=8E31=E2=80=8E =E2=80=8EAM=E2=80=8E =E2=80=8EPDT, M=
ichael Ellerman &lt;mpe@ellerman.id.au&gt; wrote:
                    </div>
                    <div><br></div>
                    <div><br></div>
                    <div><div dir=3D"ltr">Add a definition for cpu_show_spe=
ctre_v2() to override the generic<br clear=3D"none">version. This has sever=
al permuations, though in practice some may not<br clear=3D"none">occur we =
cater for any combination.<br clear=3D"none"><br clear=3D"none">The most ve=
rbose is:<br clear=3D"none"><br clear=3D"none">&nbsp; Mitigation: Indirect =
branch serialisation (kernel only), Indirect<br clear=3D"none">&nbsp; branc=
h cache disabled, ori31 speculation barrier enabled<br clear=3D"none"><br c=
lear=3D"none">We don't treat the ori31 speculation barrier as a mitigation =
on its<br clear=3D"none">own, because it has to be *used* by code in order =
to be a mitigation<br clear=3D"none">and we don't know if userspace is doin=
g that. So if that's all we see<br clear=3D"none">we say:<br clear=3D"none"=
><br clear=3D"none">&nbsp; Vulnerable, ori31 speculation barrier enabled<br=
 clear=3D"none"><br clear=3D"none">Signed-off-by: Michael Ellerman &lt;<a h=
ref=3D"mailto:mpe@ellerman.id.au" shape=3D"rect" ymailto=3D"mailto:mpe@elle=
rman.id.au">mpe@ellerman.id.au</a>&gt;<br clear=3D"none">---<br clear=3D"no=
ne"> arch/powerpc/kernel/security.c | 33 +++++++++++++++++++++++++++++++++<=
br clear=3D"none"> 1 file changed, 33 insertions(+)<br clear=3D"none"><br c=
lear=3D"none">diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/ke=
rnel/security.c<br clear=3D"none">index 0eace3cac818..2cee3dcd231b 100644<b=
r clear=3D"none">--- a/arch/powerpc/kernel/security.c<br clear=3D"none">+++=
 b/arch/powerpc/kernel/security.c<br clear=3D"none">@@ -58,3 +58,36 @@ ssiz=
e_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr, =
c<br clear=3D"none"> <br clear=3D"none"> &nbsp;&nbsp;&nbsp; return sprintf(=
buf, "Vulnerable\n");<br clear=3D"none"> }<br clear=3D"none">+<br clear=3D"=
none">+ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attrib=
ute *attr, char *buf)<br clear=3D"none">+{<br clear=3D"none">+&nbsp;&nbsp;&=
nbsp; bool bcs, ccd, ori;<br clear=3D"none">+&nbsp;&nbsp;&nbsp; struct seq_=
buf s;<br clear=3D"none">+<br clear=3D"none">+&nbsp;&nbsp;&nbsp; seq_buf_in=
it(&amp;s, buf, PAGE_SIZE - 1);<br clear=3D"none">+<br clear=3D"none">+&nbs=
p;&nbsp;&nbsp; bcs =3D security_ftr_enabled(SEC_FTR_BCCTRL_SERIALISED);<br =
clear=3D"none">+&nbsp;&nbsp;&nbsp; ccd =3D security_ftr_enabled(SEC_FTR_COU=
NT_CACHE_DISABLED);<br clear=3D"none">+&nbsp;&nbsp;&nbsp; ori =3D security_=
ftr_enabled(SEC_FTR_SPEC_BAR_ORI31);<br clear=3D"none">+<br clear=3D"none">=
+&nbsp;&nbsp;&nbsp; if (bcs || ccd) {<br clear=3D"none">+&nbsp;&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp; seq_buf_printf(&amp;s, "Mitigation: ");<br clear=3D"non=
e">+<br clear=3D"none">+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (bcs)<br c=
lear=3D"none">+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; seq=
_buf_printf(&amp;s, "Indirect branch serialisation (kernel only)");<br clea=
r=3D"none">+<br clear=3D"none">+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (b=
cs &amp;&amp; ccd)<br clear=3D"none">+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp; seq_buf_printf(&amp;s, ", ");<br clear=3D"none">+<br cl=
ear=3D"none">+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (ccd)<br clear=3D"no=
ne">+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; seq_buf_print=
f(&amp;s, "Indirect branch cache disabled");<br clear=3D"none">+&nbsp;&nbsp=
;&nbsp; } else<br clear=3D"none">+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; seq=
_buf_printf(&amp;s, "Vulnerable");<br clear=3D"none">+<br clear=3D"none">+&=
nbsp;&nbsp;&nbsp; if (ori)<br clear=3D"none">+&nbsp;&nbsp;&nbsp; &nbsp;&nbs=
p;&nbsp; seq_buf_printf(&amp;s, ", ori31 speculation barrier enabled");<br =
clear=3D"none">+<br clear=3D"none">+&nbsp;&nbsp;&nbsp; seq_buf_printf(&amp;=
s, "\n");<br clear=3D"none">+<br clear=3D"none">+&nbsp;&nbsp;&nbsp; return =
s.len;<div class=3D"yqt8803334646" id=3D"yqtfd04053"><br clear=3D"none">+}<=
br clear=3D"none">-- <br clear=3D"none">2.14.1<br clear=3D"none"><br clear=
=3D"none"></div></div></div>
                </div>
            </div></div></body></html>
------=_Part_301443_784540807.1522154188151--
