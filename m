Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-x230.google.com (mail-pd0-x230.google.com
 [IPv6:2607:f8b0:400e:c02::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0D61D2C0090
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Mar 2014 18:46:26 +1100 (EST)
Received: by mail-pd0-f176.google.com with SMTP id r10so715569pdi.21
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Mar 2014 00:46:23 -0700 (PDT)
Date: Thu, 13 Mar 2014 15:46:13 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 9/9] powerpc/pm: support deep sleep feature on T1040
Message-ID: <20140313074613.GD26692@pek-khao-d1.corp.ad.wrs.com>
References: <1394168285-32275-1-git-send-email-chenhui.zhao@freescale.com>
 <1394168285-32275-9-git-send-email-chenhui.zhao@freescale.com>
 <1394586624.13761.132.camel@snotra.buserror.net>
 <20140312055755.GA17203@pek-khao-d1.corp.ad.wrs.com>
 <1394646185.13761.145.camel@snotra.buserror.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="cQXOx3fnlpmgJsTP"
In-Reply-To: <1394646185.13761.145.camel@snotra.buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org, Chenhui Zhao <chenhui.zhao@freescale.com>,
 Jason.Jin@freescale.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--cQXOx3fnlpmgJsTP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2014 at 12:43:05PM -0500, Scott Wood wrote:
> > Shouldn't we use "readback, sync" here? The following is quoted form t4=
240RM:
> >   To guarantee that the results of any sequence of writes to configurat=
ion
> >   registers are in effect, the final configuration register write shoul=
d be
> >   immediately followed by a read of the same register, and that should =
be
> >   followed by a SYNC instruction. Then accesses can safely be made to m=
emory
> >   regions affected by the configuration register write.
>=20
> I agree that the sync before the readback is probably not necessary,
> since transactions to the same address should already be ordered.
>=20
> A sync after the readback helps if you're trying to order the readback
> with subsequent memory accesses, though in that case wouldn't a sync
> alone (no readback) be adequate?

No, we don't just want to order the subsequent memory access here.
The 'write, readback, sync' is the required sequence if we want to make
sure that the writing to CCSR register does really take effect.

>  Though maybe not always -- see the
> comment near the end of fsl_elbc_write_buf() in
> drivers/mtd/nand_fsl_elbc.c.  I guess the readback does more than just
> make sure the device has seen the write, ensuring that the device has
> finished the transaction to the point of acting on another one.

Agree.

>=20
> The data dependency plus isync sequence, which is done by the normal I/O
> accessors used from C code, orders the readback versus all future
> instructions (not just I/O).  The delay loop is not I/O.

According to the PowerISA, the sequence 'load, date dependency, isync' only
order the load accesses. So if we want to order all the storage access as w=
ell
as execution synchronization, we should choose sync here.

Thanks,
Kevin

--cQXOx3fnlpmgJsTP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJTIWJFAAoJEJNY7TDerrFxnSEH/0paHHq8090PGw8y7vRdA/ji
FYQhy9BalQVsYBSW96ZRzixEmEPaQ4f0PJiENH36ni4iTCk8gFUNT47wGiBOOxLg
IztuXIhyJlK93gIZEW63SKrbPvOs8M56ACxAtG5UKV9qBPeYX6e+o5C4xmlhXAOr
6V2CJQ5WaeeZZArGgGvSmR+fLQkMCEcLbnIjEMpUfO2rUt1eo2+Fd4sB+sZJpLQt
uM9NYLQ+zgixtADrjq1JPTU+LPpTdrU6Ody+WbqzPWTtnL0YZvN8+SPViteatYDY
tMxiZUbadOgqgrd4xJbtMcMDqQ8eAB9RvNJoHY//HwvadV73Gw5ceKJTTN1GP58=
=1D0C
-----END PGP SIGNATURE-----

--cQXOx3fnlpmgJsTP--
