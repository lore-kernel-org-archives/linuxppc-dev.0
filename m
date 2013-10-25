Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 071922C00E3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Oct 2013 21:00:54 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 00863-02 for <linuxppc-dev@lists.ozlabs.org>;
 Fri, 25 Oct 2013 11:00:44 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: [PATCH] [RFC] Emulate "lwsync" to run standard user land on e500
 cores
Date: Fri, 25 Oct 2013 10:58:16 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B73B1@saturn3.aculab.com>
In-Reply-To: <CE506A05CAAF2A42B6F5840E6093C92D08895AC8@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1382081880-6666-1-git-send-email-wd@denx.de>
 <39CCEB38-1D9B-4918-B8F4-148D4E90FE21@kernel.crashing.org>
 <1382523314.3926.21.camel@aoeu.buserror.net>
 <BE5B0245-4ED1-4E3F-ADB1-F6A70C8FE3E1@kernel.crashing.org>
 <1382607919.9395.56.camel@pasglop>
 <6BFC8EB0-1A75-41C3-985A-E3ED14846710@kernel.crashing.org>
 <alpine.LRH.2.00.1310241556390.31001@ra8135-ec1.am.freescale.net>,
 <26976A96-8DF8-44EB-8B9B-E23200738F4E@kernel.crashing.org>
 <CE506A05CAAF2A42B6F5840E6093C92D08895AC8@039-SN1MPN1-005.039d.mgd.msft.net>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Yang James-RA8135" <RA8135@freescale.com>,
 "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> This is not a distro issue. It's a libstdc++ portability issue. =
libstdc++
> hardcodes lwsync unless __NO_LWSYNC__ is explicitly defined,
> which you only get with -mcpu=3D8540/-mcpu=3D8548.  When compiled
> for any powerpc target other than -mcpu=3D8540/-mcpu=3D8548, including
> the default -mcpu=3Dcommon,  libstdc++ will end up containing lwsync.
> There is no way to explicitly request libstdc++ to be built without =
lwsync
> with an -mcpu target other than 8540/8548.
>=20
> The issue is easily demonstrated by running a program that throws a
> C++ exception: __cxa_throw() is called, which has an lwsync.  This
> results in an illegal instruction exception when run on an =
e500v1/e500v2.

Perhaps libstc++ should be working out at run time whether lwsync is =
valid?

	David
