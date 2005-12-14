Return-Path: <robbinmathew@gmail.com>
Received: from xproxy.gmail.com (xproxy.gmail.com [66.249.82.193])
	by ozlabs.org (Postfix) with ESMTP id BDCF168890
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Dec 2005 01:28:41 +1100 (EST)
Received: by xproxy.gmail.com with SMTP id i27so92710wxd
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Dec 2005 06:28:40 -0800 (PST)
Message-ID: <5b74ec4d0512140628y42986bc0h2f107e788dd115b6@mail.gmail.com>
Date: Wed, 14 Dec 2005 19:58:40 +0530
From: Robin Mathew <robbinmathew@gmail.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_40198_13588484.1134570520102"
Subject: 8260 ethernet driver multicast problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_40198_13588484.1134570520102
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
I was encountering a problem with the receipt of multicast packets from eth
interface in 8260 platform. The issue was traced to the fcc_enet.c driver. =
A
stray return in the set_multicast_list function was the culprit.

The following is the changes that I have made-

Index: fcc_enet.c
@@ -1488,7 +1488,6 @@

     cep =3D (struct fcc_enet_private *)dev->priv;

-return;
     /* Get pointer to FCC area in parameter RAM.
     */
     ep =3D (fcc_enet_t *)dev->base_addr;


Can you please tell me whether there is any issue with setting the driver i=
n
multicast or promiscous mode. Was this change deliberately done or is it
really a bug?

Thanks in advance,
Robin

------=_Part_40198_13588484.1134570520102
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br>
I was encountering a problem with the receipt of multicast packets from
eth interface in 8260 platform. The issue was traced to the fcc_enet.c
driver. A stray return in the set_multicast_list function was the
culprit.<br>
<br>
The following is the changes that I have made-<br>
<br>
Index: fcc_enet.c<br>
@@ -1488,7 +1488,6 @@<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp; &nbsp;cep =3D (struct fcc_enet_private *)dev-&gt;priv;<b=
r>
&nbsp;<br>
-return;<br>
&nbsp;&nbsp;&nbsp; &nbsp;/* Get pointer to FCC area in parameter RAM.<br>
&nbsp;&nbsp;&nbsp; &nbsp;*/<br>
&nbsp;&nbsp;&nbsp; &nbsp;ep =3D (fcc_enet_t *)dev-&gt;base_addr;<br>
<br>
<br>
Can you please tell me whether there is any issue with setting the
driver in multicast or promiscous mode. Was this change deliberately
done or is it really a bug?<br>
<br>
Thanks in advance,<br>
Robin<br>

------=_Part_40198_13588484.1134570520102--
