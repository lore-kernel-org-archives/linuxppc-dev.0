Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x233.google.com (mail-pa0-x233.google.com
 [IPv6:2607:f8b0:400e:c03::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 000301A0052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2015 13:18:09 +1000 (AEST)
Received: by pacdd16 with SMTP id dd16so33722393pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 20:18:08 -0700 (PDT)
Date: Fri, 21 Aug 2015 11:17:55 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/8] jump_label: no need to acquire the jump_label_mutex
 in jump_lable_init()
Message-ID: <20150821031755.GA12451@pek-khao-d1.corp.ad.wrs.com>
References: <1440072876-8321-1-git-send-email-haokexin@gmail.com>
 <1440072876-8321-2-git-send-email-haokexin@gmail.com>
 <20150820182903.GA3161@worktop.event.rightround.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
In-Reply-To: <20150820182903.GA3161@worktop.event.rightround.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2015 at 08:29:03PM +0200, Peter Zijlstra wrote:
> On Thu, Aug 20, 2015 at 08:14:29PM +0800, Kevin Hao wrote:
> > The jump_label_init() run in a very early stage, even before the
> > sched_init(). So there is no chance for concurrent access of the
> > jump label table.
>=20
> It also doesn't hurt to have it. Its better to be consistent and
> conservative with locking unless there is a pressing need.

Yes, it has no real hurt. IMHO it may cause confusion that the function
jump_label_init() may run in two different thread context simultaneously.=
=20
Anyway if you guys don't think so, I can drop this patch.

Thanks,
Kevin

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV1phjAAoJEJNY7TDerrFxcRkIAK85pTmDd+3LMtLVu3SU0s99
Ulpcehjic2P/dU0iEZymHqJ+ukqM9fn9ckWrYQbllxqXCTXaYF5q/j3ut7a9U9sp
T32uyS+XedsL+/scIy5S2vCDDbUhZvE7jI1eipSteqYTWQ5JnAfKGK/xmcQwAfUo
w8Jws3kKFcLh+OvbzNTmb6Oj5zfWl+Kpy76fVn8RuzL4bG2pSvtlBnlMmvDWartf
Cj0iR+F/F+QyaElgJqM/7Uyouq93BSZFoDLEQib4OQSJJkVz5/4fEw+v00DXawNF
NO+0RhWOf8YEy1FBEJHGh8vd9ZImHMenBy8T55Fw9hYlBmqTdTQW421bJodGfAo=
=Dzs+
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
