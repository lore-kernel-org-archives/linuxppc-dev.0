Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id CE036B6F8C
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Aug 2011 03:26:00 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP id 27200-02 for <linuxppc-dev@ozlabs.org>;
	Wed, 10 Aug 2011 18:25:55 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: union/struct representations for MAS Registers
Date: Wed, 10 Aug 2011 18:25:57 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AE25@saturn3.aculab.com>
In-Reply-To: <B952E5AF-98EF-46CE-B30F-7E1EA55C33AC@pobox.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Jimi Xenidis" <jimix@pobox.com>, "Kumar Gala" <galak@kernel.crashing.org>
Cc: Linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> I have some and use them in some code, they represent ISA=20
> 2.06 MAVN=3D1 (version 2)
> Can I keep them?
> if so, should I put them somewhere useful to others?
>=20
> Examples:
> union mas1 {
> 	u32 _val;
> 	struct {
> 		u32 v:1;
> 		u32 iprot:1;
> 		u32 tid:14;
> 		u32 _reserved_1:2;
> 		u32 ind:1;
> 		u32 ts:1;
> 		u32 tsize:4;
> 		u32 _reserved_2:8;
> 	};
> };

Bitfields are rather non-portable, the compiler has a lot of choice
about how to align the bits in memory.
Their use to map anything physical is doomed to portabilily issues.

	David
