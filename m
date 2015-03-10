Return-Path: <haokexin@gmail.com>
Received: from mail-qg0-x22f.google.com (mail-qg0-x22f.google.com
 [IPv6:2607:f8b0:400d:c04::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3816D1A0B83
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 23:32:55 +1100 (AEDT)
Received: by qgfh3 with SMTP id h3so1255277qgf.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 05:32:52 -0700 (PDT)
Date: Tue, 10 Mar 2015 20:32:44 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc64: use fixed lock token for !CONFIG_PPC_SPLPAR
Message-ID: <20150310123244.GC8745@pek-khao-d1.corp.ad.wrs.com>
References: <1425727183-30880-1-git-send-email-haokexin@gmail.com>
 <1425884006.4636.234.camel@kernel.crashing.org>
 <1425946518.19022.5.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
In-Reply-To: <1425946518.19022.5.camel@ellerman.id.au>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2015 at 11:15:18AM +1100, Michael Ellerman wrote:
> On Mon, 2015-03-09 at 17:53 +1100, Benjamin Herrenschmidt wrote:
> > On Sat, 2015-03-07 at 19:19 +0800, Kevin Hao wrote:
> > > It makes no sense to use a variant lock token on a platform which
> > > doesn't support for shared-processor logical partitions. Actually we
> > > can eliminate a memory load by using a fixed lock token on these
> > > platforms.
> >=20
> > Does this provide an actual measurable benefit ? I found that the lock
> > token was quite handy for debugging ...
>=20
> Yeah. It can be very useful to know which cpu holds a lock when you get i=
nto a
> dead lock.
>=20
> Unless you can show this is a performance boost I'm inclined to leave it =
as-is.

I am not sure if there is more suitable benchmark for spinlock. I tried the
perf locking benchmark got from here [1]. The test was running on a t4240rdb
board with xfs rootfs. I have run the following commands four times before =
and
after applying this patch.
    ./perf record ./perf bench locking vfs; ./perf report

Before:
3.06%  locking-vfs  [kernel.kallsyms]   [k] ._raw_spin_lock
3.04%  locking-vfs  [kernel.kallsyms]   [k] ._raw_spin_lock
3.03%  locking-vfs  [kernel.kallsyms]   [k] ._raw_spin_lock
3.00%  locking-vfs  [kernel.kallsyms]   [k] ._raw_spin_lock

After:
3.05%  locking-vfs  [kernel.kallsyms]   [k] ._raw_spin_lock=20
2.97%  locking-vfs  [kernel.kallsyms]   [k] ._raw_spin_lock
2.96%  locking-vfs  [kernel.kallsyms]   [k] ._raw_spin_lock
2.97%  locking-vfs  [kernel.kallsyms]   [k] ._raw_spin_lock

[1] http://lkml.iu.edu/hypermail/linux/kernel/1412.1/01419.html

Thanks,
Kevin

--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU/uRsAAoJEJNY7TDerrFx3h8IAMwCqnIqQVW1DNUXCgI0jjpU
XRx5us3iIOo2+YbdYwW17Fva5tEFLjmt/8Ambs2zZWe071cdHPkkfhsud8juI0jj
eQbWeVlpfR+7OqcKSsPkO5ekAIuMpdkplWo7H+E1cNGadEezhHIkfJ7plZZYcJ2e
LDlOZhQDatIFmo4RMEJM/hxRec7hDrWkKEJHUPHst/lfw1lm0YjjruYmWsMCQKYz
YwkISPzvH7ED5pixOWF1Ib+fnFyMkM6DnnTj97A3gzt6zMRjywn3M6rovmnS/NxI
Boevqr98VCjngS3UwCHNC9x2HqxPgBCoHj+mzEmBB1ahSj8BOEwvypPJ9BKJzUI=
=bx1R
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--
