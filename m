Return-Path: <himangi774@gmail.com>
Received: from mail-wg0-x22e.google.com (mail-wg0-x22e.google.com
 [IPv6:2a00:1450:400c:c00::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7E9F2140079
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 May 2014 04:04:19 +1000 (EST)
Received: by mail-wg0-f46.google.com with SMTP id n12so5364737wgh.29
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 May 2014 11:04:14 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 16 May 2014 23:34:13 +0530
Message-ID: <CAB78YHynbQ=cR-jDTHpwwVGgDO24fjXETO1Zp88QD=Vkjf+6GQ@mail.gmail.com>
Subject: question about hvc_opal.c
From: Himangi Saraogi <himangi774@gmail.com>
To: jslaby@suse.cz, Greg KH <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary=f46d043c7ffec5672604f9883d14
Cc: Julia Lawall <julia.lawall@lip6.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--f46d043c7ffec5672604f9883d14
Content-Type: text/plain; charset=UTF-8

Hi,

In function hvc_opal_probe I find :

        hp = hvc_alloc(termno, 0, ops, MAX_VIO_PUT_CHARS);
        if (IS_ERR(hp))
                return PTR_ERR(hp);

Earlier, hpc_opal_privs[termno] is assigned pv which is allocated using
kzalloc. Shouldn't there be a kfree(pv) and the array element (which is
global) be made NULL before the return. Also, if array element is set to
NULL on the failure, then some cleanup must be done to undo the effect of
hvc_instantiate as well. Please let me know if the change is desirable.

Thanks.
Himangi

--f46d043c7ffec5672604f9883d14
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>Hi,<br>=C2=A0<br></div>In function hvc=
_opal_probe I find :<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 hp =3D hvc_alloc(te=
rmno, 0, ops, MAX_VIO_PUT_CHARS);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (IS_ERR(hp))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return PTR_ERR(hp);=
<br><br></div>Earlier, hpc_opal_privs[termno] is assigned pv which is alloc=
ated using kzalloc. Shouldn&#39;t there be a kfree(pv) and the array elemen=
t (which is global) be made NULL before the return. Also, if array element =
is set to NULL on the failure, then some cleanup must be done to undo the e=
ffect of hvc_instantiate as well. Please let me know if the change is desir=
able.<br>
<br></div>Thanks.<br></div>Himangi<br><div><div><br></div></div></div>

--f46d043c7ffec5672604f9883d14--
