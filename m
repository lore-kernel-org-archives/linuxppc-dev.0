Return-Path: <Kyle.D.Moffett@boeing.com>
Received: from stl-smtpout-01.boeing.com (stl-smtpout-01.boeing.com
	[130.76.96.56])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "stl-smtpout-01.boeing.com",
	Issuer "VeriSign Trust Network" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4B24DB70FB
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 25 Feb 2011 04:55:15 +1100 (EST)
Received: from blv-av-01.boeing.com (blv-av-01.boeing.com [130.247.48.231])
	by stl-smtpout-01.ns.cs.boeing.com (8.14.4/8.14.4/8.14.4/SMTPOUT) with
	ESMTP id p1OHhR5e021806
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 24 Feb 2011 11:43:28 -0600 (CST)
Received: from blv-av-01.boeing.com (localhost [127.0.0.1])
	by blv-av-01.boeing.com (8.14.4/8.14.4/DOWNSTREAM_RELAY) with ESMTP id
	p1OHhRo8006795 for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 24 Feb 2011 09:43:27 -0800 (PST)
Received: from XCH-MWHT-05.mw.nos.boeing.com (xch-mwht-05.mw.nos.boeing.com
	[134.57.119.160])
	by blv-av-01.boeing.com (8.14.4/8.14.4/UPSTREAM_RELAY) with ESMTP id
	p1OHhQTV006779
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 24 Feb 2011 09:43:27 -0800 (PST)
From: "Moffett, Kyle D" <Kyle.D.Moffett@boeing.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 24 Feb 2011 11:43:17 -0600
Subject: mpic_alloc: Differences between of_address_to_resource() and
	of_get_property()+of_translate_address()
Message-ID: <031BE41A-C26B-419E-A515-F88C0BF4CA5D@boeing.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello everyone,

I'm currently cleaning up a new P2020 (mpc85xx) board port for submission a=
nd I was noticing a lot of commonalities between the various ports.

In particular, at least 80% of the mpic_alloc() callers seem to do somethin=
g like this (with more error-checking):

struct resource r;
of_address_to_resource(np, 0, &r);
mpic_alloc(np, r.start, [...]);

But mpic_alloc() itself seems to have some logic for digging the base addre=
ss out of OpenFirmware already:

if (paddr =3D=3D 0 && !(mpic->flags & MPIC_USES_DCR)) {
      const u32 *reg =3D of_get_property(node, "reg", NULL);
      BUG_ON(reg =3D=3D NULL);
      paddr =3D of_translate_address(node, reg);
      BUG_ON(paddr =3D=3D OF_BAD_ADDR);
}

As far as I can tell, the code in mpic_alloc() is a very limited form of of=
_address_to_resource() without a lot of the special cases, but I can't tell=
 what the effect of those special cases would be on the boards relying on m=
pic_alloc(np, 0, [...]);

I'd like to just convert mpic_alloc() to do the of_address_to_resource() in=
ternally (instead of the existing logic), but I'd be afraid of breaking oth=
er systems.

Any comments/advice?

Cheers,
Kyle Moffett
