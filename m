Return-Path: <galak@codeaurora.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.11.231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B75631A021A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Sep 2014 01:44:38 +1000 (EST)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [RFC PATCH] dt:numa: adding numa node mapping for memory nodes.
From: Kumar Gala <galak@codeaurora.org>
In-Reply-To: <1410944189-3608-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
Date: Wed, 17 Sep 2014 08:37:30 -0700
Message-Id: <A4205FCA-D4DE-48A4-B19F-58400A3FBF5C@codeaurora.org>
References: <1410944189-3608-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
To: Ganapatrao Kulkarni <ganapatrao.kulkarni@caviumnetworks.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>,
 Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Rob Herring <robh+dt@kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-arm-kernel@lists.infradead.org, gpkulkarni@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 17, 2014, at 1:56 AM, Ganapatrao Kulkarni =
<ganapatrao.kulkarni@caviumnetworks.com> wrote:

> From: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>=20
> This patch adds property "nid" to memory node to provide the memory =
range to
> numa node id mapping.
>=20
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>=20
> =97

Adding the PPC guys as they=92ve been doing NUMA on IBM Power Servers =
for years with OF/DT.  So we should really try and follow what they=92ve =
done.

> Documentation/devicetree/bindings/numa.txt | 58 =
++++++++++++++++++++++++++++++
> 1 file changed, 58 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/numa.txt
>=20
> diff --git a/Documentation/devicetree/bindings/numa.txt =
b/Documentation/devicetree/bindings/numa.txt
> new file mode 100644
> index 0000000..c4a94f2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/numa.txt
> @@ -0,0 +1,58 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +numa id binding description
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +1 - Introduction
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +The device node  property "nid(numa node id)" can be added to memory
> +device node to map the range of memory addresses as defined in =
property "reg".
> +The property "nid" maps the memory range to the numa node id, which =
is used to
> +find the local and remory pages on numa aware systems.
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +2 - nid property
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +Numa node id, "nid" is required property of memory device node for=20
> +numa enabled platforms.
> +
> +|------------------------------------------------------|
> +|Property Type  | Usage | Value Type | Definition      |
> +|------------------------------------------------------|
> +|  nid          |  R    |    <u32>   | Numa Node id    |
> +|               |       |            | for this memory |
> +|------------------------------------------------------|
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> +4 - Example memory nodes with numa node id mapping
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> +
> +Example 1 (2 memory nodes, each mapped to a numa node.):
> +
> +	memory@00000000 {
> +		device_type =3D "memory";
> +		reg =3D <0x0 0x00000000 0x0 0x80000000>;
> +		nid =3D <0x0>;
> +	};
> +
> +	memory@10000000000 {
> +		device_type =3D "memory";
> +		reg =3D <0x100 0x00000000 0x0 0x80000000>;
> +		nid =3D <0x1>;
> +	};
> +
> +Example 2 (multiple memory ranges in each memory node and mapped to =
numa node):
> +
> +	memory@00000000 {
> +		device_type =3D "memory";
> +		reg =3D <0x0 0x00000000 0x0 0x80000000>,
> +		      <0x0 0x80000000 0x0 0x80000000>;
> +		nid =3D <0x0>;
> +	};
> +
> +	memory@10000000000 {
> +		device_type =3D "memory";
> +		reg =3D <0x100 0x00000000 0x0 0x80000000>,
> +		      <0x100 0x80000000 0x0 0x80000000>;
> +		nid =3D <0x1>;
> +	};
> --=20
> 1.8.1.4
>=20

--=20
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, =
hosted by The Linux Foundation
