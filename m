Return-Path: <xenidis@gmail.com>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1EC902C00C2
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Nov 2012 03:32:48 +1100 (EST)
Received: by mail-ob0-f179.google.com with SMTP id lz20so4568941obb.38
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Nov 2012 08:32:46 -0800 (PST)
Sender: Jimi Xenidis <xenidis@gmail.com>
From: Jimi Xenidis <jimix@pobox.com>
Content-Type: text/plain; charset=us-ascii
Subject: RFC: book3e: DCR MMIO for IBM Blue Gene/Q
Date: Sun, 4 Nov 2012 10:32:43 -0600
Message-Id: <020B0706-E2BD-4A6C-8644-D235278655ED@pobox.com>
To: Ben Herrenschmidt <benh@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v1283)
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I want to use the stuff in arch/platform/sysdev/dcr.c and I have a =
couple of questions:
1) anyone have a good devtree binding for this?
I'm thinking:
	bgq {
		#address-cells =3D <2>;
		#size-cells =3D <2>;
		...

		dcr {
			reg =3D <0x3ff 0xe0000000 0x0 0x08000000>;
			compatible =3D "ibm,bgq-dcr";
			dcr-controller;
			dcr-access-method =3D "mmio";
			dcr-mmio-stride =3D <??>;
		};
	};

I'm not sure what stride I will use since I have yet to figure out the =
DCR numbering in play at the moment, which will be painful.
Also, some clarity to the following would be nice:
	/* Stride is not properly defined yet, default to 0x10 for Axon =
*/
	p =3D of_get_property(dp, "dcr-mmio-stride", NULL);
	stride =3D (p =3D=3D NULL) ? 0x10 : *p;

	/* XXX FIXME: Which property name is to use of the 2 following ? =
*/
	p =3D of_get_property(dp, "dcr-mmio-range", NULL);
	if (p =3D=3D NULL)
		p =3D of_get_property(dp, "dcr-mmio-space", NULL);
	if (p =3D=3D NULL)
		goto done;

I guess my "reg" property is not useful to the code?
Is there a preference over dcr-mmio-range/space or in the absence of =
these to we should use "reg"?

2) I need 64 bit reads and writes
My intention is to have dcr_{read,write}_generic_{mmio,native} take an =
unsigned long for value all the way down.
For the native case, this would make is similar to mtspr and mfspr.
For the MMIO case, the selected in/out size would be based on "#ifdef =
__powerpc64__"

Thoughts?

-jx
