Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 088E0B7161
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 03:36:06 +1000 (EST)
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by ozlabs.org (Postfix) with ESMTP id 37F72DDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 03:36:04 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so743234ywt.39
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 10:36:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090611165527.GB28028@pengutronix.de>
References: <1244576781.3455.0@antares>
	<fa686aa40906110927w60a5a74alaa3420b9bf3f3e44@mail.gmail.com>
	<20090611165527.GB28028@pengutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 11 Jun 2009 11:28:50 -0600
Message-ID: <fa686aa40906111028w6311b244pe934400d0c6f44f8@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mpc52xx/mtd: fix mtd-ram access for 16-bit Local
	Plus Bus
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>,
	dwmw2@infradead.org, Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 11, 2009 at 10:55 AM, Wolfram Sang<w.sang@pengutronix.de> wrote=
:
>> Blech. =A0ugly #ifdef and not really multiplatform safe (yeah, I know it
>> shouldn't break non-5200 platforms, but it does have an undesirable
>> impact). =A0There's got to be a better way.
>
> What about putting the special memcpy in asm/io.h (like it is done for ee=
h)?

It is a beefy enough function that it is probably a net loss to make
it an inline static in the header file.  It should be an exported
function.

> Will this cause too much overhead for a memcpy which does not go to the L=
PB?

It doesn't solve my concerns.  bankwidth=3D=3D2 is the wrong test; plenty
of non-mpc5200 platforms could have the same property set without
needing the workaround.

inline_map_copy_to is used in exactly 2 places in drivers/mtd/* and
include/linux/mtd/*:
1) the definition of map_copy_to() in include/linux/mtd/map.h
- map_copy_to() is only used by maprap_write() which is a mtd_info hook.
2) the definition of simple_map_copy_to() in drivers/mtd/maps/map_funcs.c
- a map_info hook.

So; the solution to me seems to be on an MPC5200 platform replace the
offending hooks with MPC5200 specific variants at runtime.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
