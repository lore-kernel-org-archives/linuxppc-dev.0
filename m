Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40fWYz2mGHzF14h
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 May 2018 15:36:07 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w475TILk136626
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 May 2018 01:36:04 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2htc6byugf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 May 2018 01:36:04 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Mon, 7 May 2018 06:36:03 +0100
Date: Mon, 7 May 2018 15:35:58 +1000
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: Russell Currey <ruscur@russell.cc>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 02/13] powerpc/eeh: Add final message for successful
 recovery
References: <cover.1525242772.git.sbobroff@linux.ibm.com>
 <e2cc8562dcce1d8bc38084bc45414c048b5a441d.1525242772.git.sbobroff@linux.ibm.com>
 <874ljo9ljl.fsf@concordia.ellerman.id.au>
 <1525414108.2560.3.camel@russell.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="q9KOos5vDmpwPx9o"
In-Reply-To: <1525414108.2560.3.camel@russell.cc>
Message-Id: <20180507053557.GD18123@tungsten.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--q9KOos5vDmpwPx9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 04:08:28PM +1000, Russell Currey wrote:
> On Fri, 2018-05-04 at 12:55 +1000, Michael Ellerman wrote:
> > Sam Bobroff <sbobroff@linux.ibm.com> writes:
> >=20
> > > Add a single log line at the end of successful EEH recovery, so
> > > that
> > > it's clear that event processing has finished.
> > >=20
> > > Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
> > > ---
> > >  arch/powerpc/kernel/eeh_driver.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/arch/powerpc/kernel/eeh_driver.c
> > > b/arch/powerpc/kernel/eeh_driver.c
> > > index 56a60b9eb397..07e0a42035ce 100644
> > > --- a/arch/powerpc/kernel/eeh_driver.c
> > > +++ b/arch/powerpc/kernel/eeh_driver.c
> > > @@ -910,6 +910,7 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
> > >  	pr_info("EEH: Notify device driver to resume\n");
> > >  	eeh_pe_dev_traverse(pe, eeh_report_resume, NULL);
> > > =20
> > > +	pr_info("EEH: Recovery successful.\n");
> > Is it possible for recovery for multiple devices to be interleaved?
> >=20
> > Should that message include the device?
>=20
> Pretty sure EEH will only process a single error at a time so this
> *should* always let you infer from context, but PHB and PE should
> probably be included anyway.  It'd be cool to move pe_{err/warn/info}()
> out of powernv for messages like this.

While we only process a single "event" at a time, that event covers the
initial PE, or possibly it's parent or PHB, and any dependent PEs so I
thought it could be misleading to show only a single one for that
message -- I wanted something to indicate that the whole "event" had
finished (since that was otherwise not really clear to me). Does that
seem reasonable?

I'm sorry but I don't understand what you mean by moving some functions
out of powernv, could you explain more?

> - Russell
>=20
> >=20
> > cheers
>=20

--q9KOos5vDmpwPx9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEELWWF8pdtWK5YQRohMX8w6AQl/iIFAlrv5b0ACgkQMX8w6AQl
/iKZIwf+O83bpw9eRjlh4+coDG3V/56e5ut4S2Y2T3pY1nFnKFBMFcxooS5YSu3U
yO2hyWWwLGCyVckylYTdTejVN4fK5iBkPQR3zZHSwG76lb4C7+tFSy7baOTMSo5a
rHmGpPKe80LeEaICGHcFAGPwYRzwVa4qb7FQGVZC8naYQdsj42AdMEE/SSroD+Qe
1Y6XfRCeI/ZxO1n/uyrDOxGTYkv5OtPUv5qAWepa2BJrkwYf7vMxKqeUNLoohX2s
Et3fnfYmh9l3vWrw5iCdbUusfPnw8iOGLrf+5qPdo2oi7fcxhi6Paol8IPo9Ry5Y
iAumplfqWbyIzxgRS1q4w8gVF67h3A==
=A04O
-----END PGP SIGNATURE-----

--q9KOos5vDmpwPx9o--
