Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40fWQC36hGzDrpY
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 May 2018 15:29:23 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w475TJxN124145
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 May 2018 01:29:20 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2htejhbk9j-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 May 2018 01:29:20 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Mon, 7 May 2018 06:29:16 +0100
Date: Mon, 7 May 2018 15:29:11 +1000
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 02/13] powerpc/eeh: Add final message for successful
 recovery
References: <cover.1525242772.git.sbobroff@linux.ibm.com>
 <e2cc8562dcce1d8bc38084bc45414c048b5a441d.1525242772.git.sbobroff@linux.ibm.com>
 <874ljo9ljl.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="raC6veAxrt5nqIoY"
In-Reply-To: <874ljo9ljl.fsf@concordia.ellerman.id.au>
Message-Id: <20180507052910.GC18123@tungsten.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--raC6veAxrt5nqIoY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 12:55:42PM +1000, Michael Ellerman wrote:
> Sam Bobroff <sbobroff@linux.ibm.com> writes:
>=20
> > Add a single log line at the end of successful EEH recovery, so that
> > it's clear that event processing has finished.
> >
> > Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
> > ---
> >  arch/powerpc/kernel/eeh_driver.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh=
_driver.c
> > index 56a60b9eb397..07e0a42035ce 100644
> > --- a/arch/powerpc/kernel/eeh_driver.c
> > +++ b/arch/powerpc/kernel/eeh_driver.c
> > @@ -910,6 +910,7 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
> >  	pr_info("EEH: Notify device driver to resume\n");
> >  	eeh_pe_dev_traverse(pe, eeh_report_resume, NULL);
> > =20
> > +	pr_info("EEH: Recovery successful.\n");
>=20
> Is it possible for recovery for multiple devices to be interleaved?
>=20
> Should that message include the device?

No, all the calls are serialized. They're only called from
eeh_event_handler() which is in the main loop of a kernel thread (see
eeh_event_init()).

> cheers
>=20

--raC6veAxrt5nqIoY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEELWWF8pdtWK5YQRohMX8w6AQl/iIFAlrv5CYACgkQMX8w6AQl
/iLr8ggAl1YIuJlg2v5BFWgkgH0MKmcHxPJlm0XLe19wonolYwe5jSx0uB5jJf10
eGns1hioRCDyMimfR5GAEU/1CbR+EhOO/UQLBmXeRpACawyajFO52uGgmmsSvAQ3
XdrIonU5u8GIeQWOkZt2qWHQwzThjGMY3XWCcdWdSp8z1OV3h4W+++6MW3FbB3nS
0Mbnmj3LovfQvSN3Ry6uaBdPYogMGr+V+ar+Bm2NQmsMrN/hYRo9rpqm/YmNNK6O
HsJilzL3y72gsdOLZY9ZVoNMK0DwXPkABNkMzvS3y0jbm9ZNsO6HMV9LONvg4IVt
DS0HohqbtLoiczeNmPxZ1pdY0hlUeQ==
=oQXh
-----END PGP SIGNATURE-----

--raC6veAxrt5nqIoY--
