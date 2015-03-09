Return-Path: <haokexin@gmail.com>
Received: from mail-qg0-x22b.google.com (mail-qg0-x22b.google.com
 [IPv6:2607:f8b0:400d:c04::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 97C2E1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Mar 2015 12:13:24 +1100 (AEDT)
Received: by qgdz60 with SMTP id z60so25140712qgd.5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Mar 2015 18:13:22 -0700 (PDT)
Date: Mon, 9 Mar 2015 09:13:14 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: book3e_64: fix the align size for paca_struct
Message-ID: <20150309011314.GA13617@pek-khao-d1.corp.ad.wrs.com>
References: <1425726893-30605-1-git-send-email-haokexin@gmail.com>
 <1425806006.4636.223.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
In-Reply-To: <1425806006.4636.223.camel@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 08, 2015 at 08:13:26PM +1100, Benjamin Herrenschmidt wrote:
> On Sat, 2015-03-07 at 19:14 +0800, Kevin Hao wrote:
> > All the cache line size of the current book3e 64bit SoCs are 64 bytes.
> > So we should use this size to align the member of paca_struct.
> > With this change we save 192 bytes. Also change it to __aligned(size)
> > since it is preferred over __attribute__((aligned(size))).
>=20
> Why should we favor the book3e CPUs over the book3s ones ?

Why do you think so? This only change the align size of the paca_struct's
members which are private to book3e CPUs, and should not have any effect
to book3s ones. Did I miss something?

Thanks,
Kevin

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU/POqAAoJEJNY7TDerrFxPx4H/Rv8AmHkBOnJhrK0ueNJuDp+
orOQUt3+HHHDSUmtxA2eplWbf/s7S/U+s97QyzITFB/H9PGVO7ymrSm1aNiXCK/2
bpMxMcYMXG8q/0KDgbrfJNKRBakb+7lLo3VqwTe1PUN3nOFI8yE5mLeZA+kjstqA
OvYgki26m/ZynMEeZZrkbQhBXNgtRyBLiWO9qnjp8AKJzcqbZgZLYMTXswUntTx5
abwgQ+OmMwrlaHpGEXXxY+aHJpm/IfTX4ZTc0J6/fkCPqk2WOu7wFnNJN05kzpRw
PA9NTLtLlQ5DAe/wCMkg5aNet6QU4/U5IZDxgeOEa/gWTezXaeyD5B28JjOwDnM=
=ixj+
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
