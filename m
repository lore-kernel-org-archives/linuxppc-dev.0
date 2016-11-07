Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tC8hn2c2lzDt26
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2016 22:04:24 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Lino Sanfilippo' <LinoSanfilippo@gmx.de>, Joe Perches <joe@perches.com>,
 David Miller <davem@davemloft.net>, "lsanfil@marvell.com"
 <lsanfil@marvell.com>
CC: "madalin.bucur@nxp.com" <madalin.bucur@nxp.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "corbet@lwn.net"
 <corbet@lwn.net>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "oss@buserror.net" <oss@buserror.net>, "ppc@mindchasers.com"
 <ppc@mindchasers.com>, "pebolle@tiscali.nl" <pebolle@tiscali.nl>,
 "joakim.tjernlund@transmode.se" <joakim.tjernlund@transmode.se>, Randy Dunlap
 <rdunlap@infradead.org>
Subject: RE: Coding Style: Reverse XMAS tree declarations ?
Date: Mon, 7 Nov 2016 11:00:49 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB021646E@AcuExch.aculab.com>
References: <20161103.155816.642712588084106823.davem@davemloft.net>
 <1478242438.1924.31.camel@perches.com> <581C6A7D.8030704@marvell.com>
 <20161104.110759.1093635654135143910.davem@davemloft.net>
 <1478281455.1924.41.camel@perches.com>
 <31ace8dd-1e42-2762-6367-028068d4d816@gmx.de>
In-Reply-To: <31ace8dd-1e42-2762-6367-028068d4d816@gmx.de>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Lino Sanfilippo
> Sent: 04 November 2016 20:07
...
> In this case it is IMHO rather the declaration + initialization that make=
s
> "bar" hard to find at one glance, not the use of RXT. You could do someth=
ing like
>=20
>  	[longish list of reverse xmas tree identifiers...]
>  	struct foobarbaz *qux;
>  	struct foo *bar;
>=20
>  	bar =3D longish_function(args, ...);
>=20
> to increase readability.
>=20
> Personally I find it more readable to always use a separate line for init=
ializations
> by means of functions (regardless of whether the RXT scheme is used or no=
t).

I find it best to only use initialisers for 'variables' that are (mostly) c=
onstant.
If something need to be set to NULL in case a search fails, set it to NULL
just before the loop.
Don't put initialisation on the declaration 'because you can'.

Difficulty in spotting the type of a variable is why (IMHO) you should
but all declarations at the top of a function
(except, maybe, temporaries needed for a few lines).

	David
