Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FF2C10F03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 22:01:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6901A2148D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 22:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CRj0BqMb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6901A2148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pcq62tWYzDqWb
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 08:01:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=mchehab+samsung@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="CRj0BqMb"; dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pbnS442vzDqQC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 07:15:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hTGDBgd+f+9t75xdg2kpPSeHSPz3XSe9d3maOhynR+I=; b=CRj0BqMb4HZdXyx4qv1l554gFf
 dajp+cCQkGn1MURrw1GL1TpYdveA2LEGXKojaUBR/u17WPrsOWKseUqYoOM1Bqvq3r34MWXPlrlVb
 sEYXN12ImDzQN57S7kAsmIHVrSnfqPeF38nL2AMbFHNele5JJLUEHlZFv7ZM/UGbCHw4SS3oNs2w3
 iZ9WPkfvCQsHQjzBFX/9IxQWLJq9rqzxio6VoXtzVNw6FqjDoz3wiFmTbC74nxF4aJniYlQc/2T1P
 Wimt8YKrSP7C88Hb7dWEXr5PqWpC7TIdwTF4ary3D4NgWI2QxdlGDz33VjbGEDLZW4XjIa7o4WMNZ
 hu+L72tA==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231]
 helo=coco.lan)
 by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hJ2kj-0003zU-El; Tue, 23 Apr 2019 21:14:57 +0000
Date: Tue, 23 Apr 2019 18:14:50 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH v4 14/63] Documentation: ACPI: move dsd/graph.txt to
 firmware-guide/acpi and convert to reST
Message-ID: <20190423181450.3120530d@coco.lan>
In-Reply-To: <20190423162932.21428-15-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
 <20190423162932.21428-15-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: fenghua.yu@intel.com, x86@kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, mingo@redhat.com,
 Bjorn Helgaas <bhelgaas@google.com>, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Em Wed, 24 Apr 2019 00:28:43 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
>=20
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  .../acpi/dsd/graph.rst}                       | 157 +++++++++---------
>  Documentation/firmware-guide/acpi/index.rst   |   1 +
>  2 files changed, 81 insertions(+), 77 deletions(-)
>  rename Documentation/{acpi/dsd/graph.txt =3D> firmware-guide/acpi/dsd/gr=
aph.rst} (56%)
>=20
> diff --git a/Documentation/acpi/dsd/graph.txt b/Documentation/firmware-gu=
ide/acpi/dsd/graph.rst
> similarity index 56%
> rename from Documentation/acpi/dsd/graph.txt
> rename to Documentation/firmware-guide/acpi/dsd/graph.rst
> index b9ce910781dc..e0baed35b037 100644
> --- a/Documentation/acpi/dsd/graph.txt
> +++ b/Documentation/firmware-guide/acpi/dsd/graph.rst
> @@ -1,8 +1,11 @@
> -Graphs
> +.. SPDX-License-Identifier: GPL-2.0
> =20
> +=3D=3D=3D=3D=3D=3D
> +Graphs
> +=3D=3D=3D=3D=3D=3D
> =20
>  _DSD
> -----
> +=3D=3D=3D=3D
> =20
>  _DSD (Device Specific Data) [7] is a predefined ACPI device
>  configuration object that can be used to convey information on
> @@ -30,7 +33,7 @@ hierarchical data extension array on each depth.
> =20
> =20
>  Ports and endpoints
> --------------------
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
>  The port and endpoint concepts are very similar to those in Devicetree
>  [3]. A port represents an interface in a device, and an endpoint
> @@ -38,9 +41,9 @@ represents a connection to that interface.
> =20
>  All port nodes are located under the device's "_DSD" node in the hierarc=
hical
>  data extension tree. The data extension related to each port node must b=
egin
> -with "port" and must be followed by the "@" character and the number of =
the port
> -as its key. The target object it refers to should be called "PRTX", wher=
e "X" is
> -the number of the port. An example of such a package would be:
> +with "port" and must be followed by the "@" character and the number of =
the
> +port as its key. The target object it refers to should be called "PRTX",=
 where
> +"X" is the number of the port. An example of such a package would be::
> =20
>      Package() { "port@4", PRT4 }
> =20
> @@ -49,7 +52,7 @@ data extension key of the endpoint nodes must begin with
>  "endpoint" and must be followed by the "@" character and the number of t=
he
>  endpoint. The object it refers to should be called "EPXY", where "X" is =
the
>  number of the port and "Y" is the number of the endpoint. An example of =
such a
> -package would be:
> +package would be::
> =20
>      Package() { "endpoint@0", EP40 }
> =20
> @@ -62,85 +65,85 @@ of that port shall be zero. Similarly, if a port may =
only have a single
>  endpoint, the number of that endpoint shall be zero.
> =20
>  The endpoint reference uses property extension with "remote-endpoint" pr=
operty
> -name followed by a reference in the same package. Such references consis=
t of the
> +name followed by a reference in the same package. Such references consis=
t of
>  the remote device reference, the first package entry of the port data ex=
tension
>  reference under the device and finally the first package entry of the en=
dpoint
> -data extension reference under the port. Individual references thus appe=
ar as:
> +data extension reference under the port. Individual references thus appe=
ar as::
> =20
>      Package() { device, "port@X", "endpoint@Y" }
> =20
> -In the above example, "X" is the number of the port and "Y" is the numbe=
r of the
> -endpoint.
> +In the above example, "X" is the number of the port and "Y" is the numbe=
r of
> +the endpoint.
> =20
>  The references to endpoints must be always done both ways, to the
>  remote endpoint and back from the referred remote endpoint node.
> =20
> -A simple example of this is show below:
> +A simple example of this is show below::
> =20
>      Scope (\_SB.PCI0.I2C2)
>      {
> -	Device (CAM0)
> -	{
> -	    Name (_DSD, Package () {
> -		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> -		Package () {
> -		    Package () { "compatible", Package () { "nokia,smia" } },
> -		},
> -		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
> -		Package () {
> -		    Package () { "port@0", PRT0 },
> -		}
> -	    })
> -	    Name (PRT0, Package() {
> -		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> -		Package () {
> -		    Package () { "reg", 0 },
> -		},
> -		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
> -		Package () {
> -		    Package () { "endpoint@0", EP00 },
> -		}
> -	    })
> -	    Name (EP00, Package() {
> -		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> -		Package () {
> -		    Package () { "reg", 0 },
> -		    Package () { "remote-endpoint", Package() { \_SB.PCI0.ISP, "port@4=
", "endpoint@0" } },
> -		}
> -	    })
> -	}
> +        Device (CAM0)
> +        {
> +            Name (_DSD, Package () {
> +                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> +                Package () {
> +                    Package () { "compatible", Package () { "nokia,smia"=
 } },
> +                },
> +                ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
> +                Package () {
> +                    Package () { "port@0", PRT0 },
> +                }
> +            })
> +            Name (PRT0, Package() {
> +                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> +                Package () {
> +                    Package () { "reg", 0 },
> +                },
> +                ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
> +                Package () {
> +                    Package () { "endpoint@0", EP00 },
> +                }
> +            })
> +            Name (EP00, Package() {
> +                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> +                Package () {
> +                    Package () { "reg", 0 },
> +                    Package () { "remote-endpoint", Package() { \_SB.PCI=
0.ISP, "port@4", "endpoint@0" } },
> +                }
> +            })
> +        }
>      }
> =20
>      Scope (\_SB.PCI0)
>      {
> -	Device (ISP)
> -	{
> -	    Name (_DSD, Package () {
> -		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
> -		Package () {
> -		    Package () { "port@4", PRT4 },
> -		}
> -	    })
> -
> -	    Name (PRT4, Package() {
> -		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> -		Package () {
> -		    Package () { "reg", 4 }, /* CSI-2 port number */
> -		},
> -		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
> -		Package () {
> -		    Package () { "endpoint@0", EP40 },
> -		}
> -	    })
> -
> -	    Name (EP40, Package() {
> -		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> -		Package () {
> -		    Package () { "reg", 0 },
> -		    Package () { "remote-endpoint", Package () { \_SB.PCI0.I2C2.CAM0, =
"port@0", "endpoint@0" } },
> -		}
> -	    })
> -	}
> +        Device (ISP)
> +        {
> +            Name (_DSD, Package () {
> +                ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
> +                Package () {
> +                    Package () { "port@4", PRT4 },
> +                }
> +            })
> +
> +            Name (PRT4, Package() {
> +                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> +                Package () {
> +                    Package () { "reg", 4 }, /* CSI-2 port number */
> +                },
> +                ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
> +                Package () {
> +                    Package () { "endpoint@0", EP40 },
> +                }
> +            })
> +
> +            Name (EP40, Package() {
> +                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> +                Package () {
> +                    Package () { "reg", 0 },
> +                    Package () { "remote-endpoint", Package () { \_SB.PC=
I0.I2C2.CAM0, "port@0", "endpoint@0" } },
> +                }
> +            })
> +        }
>      }
> =20
>  Here, the port 0 of the "CAM0" device is connected to the port 4 of
> @@ -148,27 +151,27 @@ the "ISP" device and vice versa.
> =20
> =20
>  References
> -----------
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
>  [1] _DSD (Device Specific Data) Implementation Guide.
> -    <URL:http://www.uefi.org/sites/default/files/resources/_DSD-implemen=
tation-guide-toplevel-1_1.htm>,
> +    http://www.uefi.org/sites/default/files/resources/_DSD-implementatio=
n-guide-toplevel-1_1.htm,
>      referenced 2016-10-03.
> =20
> -[2] Devicetree. <URL:http://www.devicetree.org>, referenced 2016-10-03.
> +[2] Devicetree. http://www.devicetree.org, referenced 2016-10-03.
> =20
>  [3]=C2=A0Documentation/devicetree/bindings/graph.txt
> =20
>  [4] Device Properties UUID For _DSD.
> -    <URL:http://www.uefi.org/sites/default/files/resources/_DSD-device-p=
roperties-UUID.pdf>,
> +    http://www.uefi.org/sites/default/files/resources/_DSD-device-proper=
ties-UUID.pdf,
>      referenced 2016-10-04.
> =20
>  [5] Hierarchical Data Extension UUID For _DSD.
> -    <URL:http://www.uefi.org/sites/default/files/resources/_DSD-hierarch=
ical-data-extension-UUID-v1.1.pdf>,
> +    http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-=
data-extension-UUID-v1.1.pdf,
>      referenced 2016-10-04.
> =20
>  [6] Advanced Configuration and Power Interface Specification.
> -    <URL:http://www.uefi.org/sites/default/files/resources/ACPI_6_1.pdf>,
> +    http://www.uefi.org/sites/default/files/resources/ACPI_6_1.pdf,
>      referenced 2016-10-04.
> =20
>  [7] _DSD Device Properties Usage Rules.
> -    Documentation/acpi/DSD-properties-rules.txt
> +    :doc:`../DSD-properties-rules`
> diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/=
firmware-guide/acpi/index.rst
> index bedcb0b242a2..f81cfbcb6878 100644
> --- a/Documentation/firmware-guide/acpi/index.rst
> +++ b/Documentation/firmware-guide/acpi/index.rst
> @@ -8,6 +8,7 @@ ACPI Support
>     :maxdepth: 1
> =20
>     namespace
> +   dsd/graph
>     enumeration
>     osi
>     method-customizing



Thanks,
Mauro
