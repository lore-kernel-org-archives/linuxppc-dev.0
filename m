Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id DBA0DB6F81
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Aug 2011 18:59:01 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP
	id 17007-05 for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Aug 2011 09:58:52 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: build failure with gcc 4.6.0 "array subscript is above array
	bounds"
Date: Thu, 18 Aug 2011 09:58:46 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AE32@saturn3.aculab.com>
In-Reply-To: <1313656032.5010.247.camel@zakaz.uk.xensource.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Ian Campbell" <Ian.Campbell@citrix.com>, <linuxppc-dev@lists.ozlabs.org>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> Subject: build failure with gcc 4.6.0 "array subscript is=20
> above array bounds"
...
> That corresponds to:
> 	tmp =3D ((unsigned long *)child->thread.fpr)
> 		[TS_FPRWIDTH * (index - PT_FPR0)];
>=20
> child->thread.fpr is "double fpr[32][TS_FPRWIDTH]".
>=20
> index has already been bounds checked so we know it is <=3D PT_FPSCR.

That code looks gross....
I think it is trying to index a 2D array with a single index
and type-pun the lookup.
I'm not sure how the array size (for the subscript error)
is determined in the presence of the cast, but without
the cast the index would have to be less than 32.
I also suspect this is failing when gcc inlines the function
from a call where 'index' is a constant.

Possibly the code should read:
   tmp =3D (unsigned long *)child->thread.fpr[index - PT_FPRO];
although index may have been scaled by 'sizeof double/sizeof long'.

	David
