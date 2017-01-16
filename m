Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v2G3L1QHvzDqSQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 01:34:53 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Anton Blanchard' <anton@samba.org>, "behanw@converseincode.com"
 <behanw@converseincode.com>, "ying.huang@intel.com" <ying.huang@intel.com>,
 "a.p.zijlstra@chello.nl" <a.p.zijlstra@chello.nl>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "oleg@redhat.com"
 <oleg@redhat.com>, Segher Boessenkool <segher@kernel.crashing.org>,
 "mingo@elte.hu" <mingo@elte.hu>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: llist code relies on undefined behaviour, upsets llvm/clang
Date: Mon, 16 Jan 2017 14:34:43 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB0264AA5@AcuExch.aculab.com>
References: <20170116083600.47175073@kryten>
In-Reply-To: <20170116083600.47175073@kryten>
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

From: Anton Blanchard
> Sent: 15 January 2017 21:36
> I was debugging a hang on a ppc64le kernel built with clang, and it
> looks to be undefined behaviour with pointer wrapping in the llist code.
>=20
> A test case is below. llist_for_each_entry() does container_of() on a
> NULL pointer, which wraps our pointer negative, then adds the same
> offset back in and expects to get back to NULL. Unfortunately clang
> decides that this can never be NULL and optimises it into an infinite
> loop.
...
> #define llist_for_each_entry(pos, node, member)                         \
>         for ((pos) =3D llist_entry((node), typeof(*(pos)), member);      =
 \
>              &(pos)->member !=3D NULL;                                   =
 \
>              (pos) =3D llist_entry((pos)->member.next, typeof(*(pos)), me=
mber))

Maybe the above could be rewritten as (untested):
		for ((pos) =3D NULL; (!(pos) ? (node) : ((pos)->member.next) || (pos) =3D=
 0) && \
			(((pos) =3D !(pos) ? llist_entry((node), typeof(*(pos)), member) \
					: llist_entry((pos)->member.next, typeof(*(pos)), member)),1); )
Provided the compiler assumes that the loop body is never executed with 'po=
s =3D=3D 0'
it should generate the same code.

	David
