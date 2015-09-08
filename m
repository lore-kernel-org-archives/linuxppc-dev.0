Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x232.google.com (mail-pa0-x232.google.com
 [IPv6:2607:f8b0:400e:c03::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B88461A0163
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Sep 2015 12:59:36 +1000 (AEST)
Received: by pacfv12 with SMTP id fv12so113151951pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2015 19:59:34 -0700 (PDT)
Date: Tue, 8 Sep 2015 10:59:23 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [v2,3/6] powerpc: kill mfvtb()
Message-ID: <20150908025923.GD24733@pek-khao-d1.corp.ad.wrs.com>
References: <1440415228-8006-4-git-send-email-haokexin@gmail.com>
 <20150907092942.1EF38140281@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/3yNEOqWowh/8j+e"
In-Reply-To: <20150907092942.1EF38140281@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--/3yNEOqWowh/8j+e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 07, 2015 at 07:29:42PM +1000, Michael Ellerman wrote:
> On Mon, 2015-24-08 at 11:20:25 UTC, Kevin Hao wrote:
> > This function is only used by get_vtb(). They are almost the same
> > except the reading from the real register. Move the mfspr() to
> > get_vtb() and kill the function mfvtb(). With this, we can eliminate
> > the use of cpu_has_feature() in very core header file like reg.h.
> > This is a preparation for the use of jump label for cpu_has_feature().
>=20
> I don't mind this change. But can you elaborate a bit on the issue with u=
sing
> cpu_has_feature() in reg.h? Just so I can understand the problem.
>=20
> I assume you ended up in a big mess of includes when you tried to include
> jump_label.h from reg.h?

Yes, the "jump_leabel.h" already include "reg.h" implicitly.=20
   from arch/powerpc/include/asm/cache.h:6:0,
   from include/linux/cache.h:5,
   from include/linux/printk.h:8,
   from include/linux/kernel.h:14,
   from include/asm-generic/bug.h:13,
   from arch/powerpc/include/asm/bug.h:127,
   from include/linux/bug.h:4,
   from include/linux/jump_label.h:81,

So including "jump_label.h" from "reg.h" will cause a recursive header
inclusion problem.

Thanks,
Kevin

--/3yNEOqWowh/8j+e
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV7k8FAAoJEJNY7TDerrFxoZAH/jfogt0jdg+Nso9PtC96h4gc
id1gIkb/VBuge5D//S2J17qxmaFEoSzmRLLMJskWIF03+M0Hpyeh0aT+5tzEvcf0
zjsxxJYZ8eNfDmQf4NF/9YwOLzn8vYXyKJED/Xxosj0xwK8xti0Ti7r96S7dp5Bh
bajJ2KA4mK1GT2ME9Czlj5tyNwfsNlzDH9RL6aMMckmM7vguVdt9p0uhPnOS4OBx
/GFIg5tzQ1pDDV+wrwSrHqDaSaF8wEuS3B/1FkgeKu9x63U/IJCWFqlPjFy9Bgl/
jFyxg/ntHJzHeMWjfquNEgja4v1M5CsmMk4b4OBC4QKo8/XWMVv5bsR3Hona1qQ=
=x/7c
-----END PGP SIGNATURE-----

--/3yNEOqWowh/8j+e--
