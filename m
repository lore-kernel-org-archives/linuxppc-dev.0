Return-Path: <SRS0=m3RD=33=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F98C35247
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Feb 2020 02:22:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA15320838
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Feb 2020 02:22:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA15320838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48DJwc1ksmzDqg4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Feb 2020 13:22:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=leonardo@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48DJtV6kwNzDqcV
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2020 13:20:34 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0172JlO5065969; Thu, 6 Feb 2020 21:20:12 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2xyhmjuy7y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Feb 2020 21:20:12 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0172KCLw066855;
 Thu, 6 Feb 2020 21:20:12 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2xyhmjuy7n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Feb 2020 21:20:12 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0172J20M022683;
 Fri, 7 Feb 2020 02:20:11 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma05wdc.us.ibm.com with ESMTP id 2xykc9srtj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Feb 2020 02:20:11 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0172K9Yt55312662
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 7 Feb 2020 02:20:09 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 890F4112064;
 Fri,  7 Feb 2020 02:20:09 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF816112062;
 Fri,  7 Feb 2020 02:19:50 +0000 (GMT)
Received: from LeoBras (unknown [9.85.188.217])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri,  7 Feb 2020 02:19:50 +0000 (GMT)
Message-ID: <e7f183cc19815ed07822707508d0caf4f7530216.camel@linux.ibm.com>
Subject: Re: [PATCH v6 01/11] asm-generic/pgtable: Adds generic functions to
 track lockless pgtable walks
From: Leonardo Bras <leonardo@linux.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton
 <akpm@linux-foundation.org>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Steven
 Price <steven.price@arm.com>, Robin Murphy <robin.murphy@arm.com>, Mahesh
 Salgaonkar <mahesh@linux.vnet.ibm.com>, Balbir Singh
 <bsingharora@gmail.com>, Reza Arbab <arbab@linux.ibm.com>, Thomas Gleixner
 <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Mike Rapoport
 <rppt@linux.ibm.com>, Michal Suchanek <msuchanek@suse.de>
Date: Thu, 06 Feb 2020 23:19:45 -0300
In-Reply-To: <f55e593c-27d5-df12-602f-ea217f62c5a1@c-s.fr>
References: <20200206030900.147032-1-leonardo@linux.ibm.com>
 <20200206030900.147032-2-leonardo@linux.ibm.com>
 <f55e593c-27d5-df12-602f-ea217f62c5a1@c-s.fr>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-A/nJhzVPw0FwclUgBET/"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-06_04:2020-02-06,
 2020-02-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 mlxlogscore=883 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002070013
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--=-A/nJhzVPw0FwclUgBET/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Christophe, thanks for the feedback!

On Thu, 2020-02-06 at 06:54 +0100, Christophe Leroy wrote:
> > A memory barrier was also added just to make sure there is no speculati=
ve
> > read outside the interrupt disabled area. Other than that, it is not
> > supposed to have any change of behavior from current code.
>=20
> Is that speculative barrier necessary for all architectures ? Does it=20
> impact performance ? Shouldn't this be another patch ?

It makes sense, better keep the code as much as possible as it was. If
any arch finds this barrier needed, it can implement it's own version
of this function (or another patch to add this to generic, if proved to
be needed in every arch).

> > +#ifndef __HAVE_ARCH_LOCKLESS_PGTBL_WALK_CONTROL
> > +/*
> > + * begin_lockless_pgtbl_walk: Must be inserted before a function call =
that does
> > + *   lockless pagetable walks, such as __find_linux_pte()
> > + */
> > +static inline
> > +unsigned long begin_lockless_pgtbl_walk(void)
>=20
> What about keeping the same syntax as local_irq_save(), something like:
>=20
> #define begin_lockless_pgtbl_walk(flags) \
> do {
> 	local_irq_save(flags);
> 	smp_mb();
> } while (0)
>=20

Makes sense. But wouldn't inlining have the same code output?=20

Best regards,
Leonardo Bras


--=-A/nJhzVPw0FwclUgBET/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl48yUEACgkQlQYWtz9S
ttRXxxAAhPXA0Cd48ZAtBfcOadiRsa1Amc03sprshQLV/+pQx2/U47Nl7YqtozUl
pxTnysv8mkdxPHoYnQk5XDRSxTLewF+w3F9hTFAfOM6F3UIA2bUsby0SPIR/04a0
1enrJ6U1qElB8wk/8Ncur2YVPzFgKmgpQI+i1n7NrGIuN2mHmmzrM3OLZf3H0BpL
3jKzZWwIoa3waO81mtVyij8gctwpk2bzoUJGs6XsvBKZMCbZdiZVyWedn5kEpM5m
an0wmHQdta85iK9XysKm55Oe0PYhmm0K9pH4sNYFWuMcC2oKtyizbiV3wq3sjpau
XSg/9koTmUowiQzTIUoCYut0UxuLjD0WfzzoR1EKcb07dFCMwkjn9jDHOQW9eSMo
9PhMEgZ2i1n463YUxhpUYXbZkqML+IQ6VLc4ZgyJdj7c+RVJSbT4GOwxBABnN58p
iEFNVDmoS1+CVUq3Ysvsw2KtM2oGxsn7sx/69KesxEHXiytgs7afyOYacGV0fx5R
OXuNlW3g5ODGdayMcXbEXY0C492e07CnMvTZvbMhwGs7YeIZUb+JfMwFpQAeSP1w
XOYl4h9YxS1sgB2gUSZc0ETfXDeeOxB9RZ1j817ySEMfn/XCUjyexOnsqBnNGbpM
AcWwHPwmdCYOKyWFTcej/u/8fxGkYgYZldd/GxcYTGaFy8IudyM=
=E/z0
-----END PGP SIGNATURE-----

--=-A/nJhzVPw0FwclUgBET/--

