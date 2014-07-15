Return-Path: <vincent@bernat.im>
Received: from bart.luffy.cx (unknown [IPv6:2a01:4f8:130:64e3::7])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8D0DC1A1F63
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:48:23 +1000 (EST)
From: Vincent Bernat <vincent@bernat.im>
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH] ppc/xmon: use isxdigit/isspace/isalnum from ctype.h
References: <1405409302-5299-1-git-send-email-vincent@bernat.im>
 <063D6719AE5E284EB5DD2968C1650D6D17272643@AcuExch.aculab.com>
Date: Tue, 15 Jul 2014 11:38:51 +0200
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D17272643@AcuExch.aculab.com>
 (David Laight's message of "Tue, 15 Jul 2014 08:55:07 +0000")
Message-ID: <m3pph7x8pg.fsf@neo.luffy.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 =E2=9D=A6 15 juillet 2014 08:55 GMT, David Laight <David.Laight@ACULAB.COM=
>=C2=A0:

>> Use linux/ctype.h instead of defining custom versions of
>> isxdigit/isspace/isalnum.
>
> ...
>> -#define isspace(c)	(c =3D=3D ' ' || c =3D=3D '\t' || c =3D=3D 10 || c =
=3D=3D 13 || c =3D=3D 0)
>
> That is different from the version in linux/ctype.h
> Especially for 'c =3D=3D 0', but probably also vertical tab and form feed.

OK. Looking more carefully, the one in ctype.h is 9-13 (11 is vertical
tab, 12 is form feed), 32 and 160 (non-breaking space, not ASCII).

For isxdigit, this is the same. For isalnum, the one in ctype.h does
accept non ASCII chars from 223.

Also, in xmon.c, isxdigit is defined twice.
--=20
Parenthesise to avoid ambiguity.
            - The Elements of Programming Style (Kernighan & Plauger)
