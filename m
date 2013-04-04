Return-Path: <B20052@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe003.messaging.microsoft.com [213.199.154.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 33AEC2C00BE
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2013 18:04:06 +1100 (EST)
Received: from mail79-am1 (localhost [127.0.0.1])	by mail79-am1-R.bigfish.com
 (Postfix) with ESMTP id 0E3AA80197	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Apr 2013 07:04:01 +0000 (UTC)
Received: from AM1EHSMHS006.bigfish.com (unknown [10.3.201.241])	by
 mail79-am1.bigfish.com (Postfix) with ESMTP id CB9843003C9	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2013 07:03:58 +0000 (UTC)
From: Leekha Shaveta-B20052 <B20052@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH 2/5] powerpc/fsl-booke: Add initial silicon device tree
 files for B4860 and B4420
Date: Thu, 4 Apr 2013 07:03:57 +0000
Message-ID: <E12D2F89F87F4A49B0320A4C2DE7E749151B05@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1364886968-9634-1-git-send-email-shaveta@freescale.com>
 <1364930341.24520.15@snotra>
 <E12D2F89F87F4A49B0320A4C2DE7E74915165F@039-SN2MPN1-011.039d.mgd.msft.net>
 <1365007194.25627.1@snotra>
In-Reply-To: <1365007194.25627.1@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Zhao Chenhui-B35336 <B35336@freescale.com>,
 Mehresh Ramneek-B31383 <B31383@freescale.com>,
 Garg Vakul-B16394 <B16394@freescale.com>,
 Lian Minghuan-B31939 <B31939@freescale.com>,
 Tang Yuantian-B29983 <B29983@freescale.com>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 Sethi Varun-B16395 <B16395@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



-----Original Message-----
From: Wood Scott-B07421=20
Sent: Wednesday, April 03, 2013 10:10 PM
To: Leekha Shaveta-B20052
Cc: Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org; Zhao Chenhui-B35336; =
Lian Minghuan-B31939; Garg Vakul-B16394; Tang Yuantian-B29983; Fleming Andy=
-AFLEMING; Mehresh Ramneek-B31383; Sethi Varun-B16395
Subject: Re: [PATCH 2/5] powerpc/fsl-booke: Add initial silicon device tree=
 files for B4860 and B4420

On 04/03/2013 01:42:14 AM, Leekha Shaveta-B20052 wrote:
>=20
>=20
> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Wednesday, April 03, 2013 12:49 AM
> To: Leekha Shaveta-B20052
> Cc: linuxppc-dev@lists.ozlabs.org; Zhao Chenhui-B35336; Lian=20
> Minghuan-B31939; Leekha Shaveta-B20052; Garg Vakul-B16394; Tang=20
> Yuantian-B29983; Fleming Andy-AFLEMING; Mehresh Ramneek-B31383; Sethi
> Varun-B16395
> Subject: Re: [PATCH 2/5] powerpc/fsl-booke: Add initial silicon device=20
> tree files for B4860 and B4420
>=20
> On 04/02/2013 02:16:05 AM, Shaveta Leekha wrote:
> > +/ {
> > +	compatible =3D "fsl,B4860";
> > +
> > +	cpus {
> > +		cpu1: PowerPC,e6500@1 {
> > +			device_type =3D "cpu";
> > +			reg =3D <2 3>;
> > +			next-level-cache =3D <&L2>;
> > +		};
> > +		cpu2: PowerPC,e6500@2 {
> > +			device_type =3D "cpu";
> > +			reg =3D <4 5>;
> > +			next-level-cache =3D <&L2>;
> > +		};
> > +		cpu3: PowerPC,e6500@3 {
> > +			device_type =3D "cpu";
> > +			reg =3D <6 7>;
> > +			next-level-cache =3D <&L2>;
> > +		};
>=20
> The unit addresses need to match "reg".
> [SL] You mean  "@1" should match to "reg =3D <2 3>" ?

Yes, it should be "@2" for that node.

> As each e6500 core in B4860 is dual- threaded, reg property here=20
> represents the thread's identifier in that PA core.
>=20
> So convention used in T4 and B4 is: core 0 having threads 0 and 1,
> 						Core 1 having <2 3> and
> so on....

The convention used in device trees is that the unit address matches the re=
g.

-Scott
[SL] Ok, I can change that. Will make unit address as @2 for <2 3>, @4 for =
<4 5> and so on....

Kumar, please respond here, as I have followed the convention used in T4 de=
vice tree files for
Dual-threaded cores.

Regards,
Shaveta
