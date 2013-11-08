Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-x236.google.com (mail-pd0-x236.google.com
 [IPv6:2607:f8b0:400e:c02::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5F1F82C00C4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Nov 2013 12:55:01 +1100 (EST)
Received: by mail-pd0-f182.google.com with SMTP id q10so1442441pdj.27
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Nov 2013 17:54:56 -0800 (PST)
Date: Fri, 8 Nov 2013 09:54:46 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/85xx: don't init the mpic ipi for the SoC which
 has doorbell support
Message-ID: <20131108015446.GA31761@pek-khao-d1.corp.ad.wrs.com>
References: <1383808637-26769-1-git-send-email-haokexin@gmail.com>
 <1383845691.23598.125.camel@snotra.buserror.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
In-Reply-To: <1383845691.23598.125.camel@snotra.buserror.net>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 07, 2013 at 11:34:51AM -0600, Scott Wood wrote:
> On Thu, 2013-11-07 at 15:17 +0800, Kevin Hao wrote:
> > It makes no sense to initialize the mpic ipi for the SoC which has
> > doorbell support. So set the smp_85xx_ops.probe to NULL for this
> > case. Since the smp_85xx_ops.probe is also used in function
> > smp_85xx_setup_cpu() to check if we need to invoke
> > mpic_setup_this_cpu(), we introduce a new setup_cpu function
> > smp_85xx_basic_setup() to remove this dependency.
>=20
> Is there any harm caused by setting up the IPIs?

No real harm. Just make no sense to do so and it does cause confusion
when you cat /proc/interrupts and get something like this:
  507:          0          0   OpenPIC   2043 Edge      ipi call function
  508:          0          0   OpenPIC   2044 Edge      ipi reschedule
  509:          0          0   OpenPIC   2045 Edge      ipi call function s=
ingle
  DBL:       7053      10137   Doorbell interrupts

>=20
> What about other MPIC setup, such as setting the current task priority
> register?

This is done by the invoking of function mpic_setup_this_cpu() in
smp_85xx_setup_cpu().

> BTW, what exactly is probe() supposed to be doing?

It is supposed to do the platform specific smp initialization and then retu=
rn
the CPU count.

>  It looks like its
> main effect (with smp_mpic_probe) is to request IPIs, but the caller
> seems to treat it mainly as a way to determine CPU count.
>=20
> I looked at the caller of .probe() (which is smp_prepare_cpus()) to see
> what happens when probe is NULL, and the handling of max_cpus doesn't
> make much sense.  At first I was concerned by the gratuitous difference
> between smp_mpic_probe() using cpu_possible_mask versus
> smp_prepare_cpus() using NR_CPUS, but the value isn't even used (all the
> code that consumed max_cpus after setting it has been removed), and the
> value passed in to smp_prepare_cpus() is ignored.

Yes, the return value of .probe makes no sense now. Actually there is alrea=
dy
a patch to remove the check of the return value of .probe in function
smp_prepare_cpus().
  http://patchwork.ozlabs.org/patch/260574/

Thanks,
Kevin
>=20
> -Scott
>=20
>=20
>=20

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJSfERmAAoJEJNY7TDerrFxSbAH/2FBXYzKJJAfftrrjcUoZYnT
vgRhvHyh+JpTY7gZCR5ytkb9eO9Wru7ep73E7xYVU+t0coecFKMNujVcqCfFqKJN
K6hUgrH8wRYYa+EznkOKpDYyQqixSxWBOYek5+/Utyx//8KFNckKb8VdKvMw4ooq
UxVuZxh6PVKvrsn6cRrq4j68N6/z01BOotcHsOMrILgj7vhIS+aXOreUpfFFTyYA
9Z3yUGrbdaiMjM0M+o0cap9BamVrR7gmM1sxsxQaMxZYdj01RIT5QZ4J6c2JUyy+
UjcIwHrdGMnvOh9fpFUaT/ICpAeOIb5jaEnaNGc83ywMOMVVIdHE5Hv900NWzts=
=bQMP
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
