Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA388C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 05:14:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AC4F206DD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 05:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AC4F206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4411dM3bMwzDqW7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 16:13:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=sbobroff@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4411ZP36kpzDqcG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 16:11:25 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1F59177122978
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 00:11:22 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qnpqy8ur8-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 00:11:22 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Fri, 15 Feb 2019 05:11:21 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 15 Feb 2019 05:11:19 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1F5BI003670282
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 15 Feb 2019 05:11:18 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1369FAE04D;
 Fri, 15 Feb 2019 05:11:18 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B70A4AE051;
 Fri, 15 Feb 2019 05:11:17 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 15 Feb 2019 05:11:17 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 80799A016E;
 Fri, 15 Feb 2019 16:11:16 +1100 (AEDT)
Date: Fri, 15 Feb 2019 16:11:15 +1100
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: "Oliver O'Halloran" <oohall@gmail.com>
Subject: Re: [PATCH v2 2/7] powerpc/eeh_cache: Add pr_debug() prints for
 insert/remove
References: <20190215004817.19961-1-oohall@gmail.com>
 <20190215004817.19961-2-oohall@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline
In-Reply-To: <20190215004817.19961-2-oohall@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-TM-AS-GCONF: 00
x-cbid: 19021505-0012-0000-0000-000002F5F838
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021505-0013-0000-0000-0000212D77BE
Message-Id: <20190215051114.GB8338@tungsten.ozlabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-15_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902150037
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 11:48:12AM +1100, Oliver O'Halloran wrote:
> The EEH address cache is used to map a physical MMIO address back to a PCI
> device. It's useful to know when it's being manipulated, but currently th=
is
> requires recompiling with #define DEBUG set. This is pointless since we
> have dynamic_debug nowdays, so remove the #ifdef guard and add a pr_debug=
()
> for the remove case too.
>=20
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>

Reviewed-by: Sam Bobroff <sbobroff@linux.ibm.com>

> ---
>  arch/powerpc/kernel/eeh_cache.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/eeh_cache.c b/arch/powerpc/kernel/eeh_ca=
che.c
> index 201943d54a6e..b2c320e0fcef 100644
> --- a/arch/powerpc/kernel/eeh_cache.c
> +++ b/arch/powerpc/kernel/eeh_cache.c
> @@ -157,10 +157,8 @@ eeh_addr_cache_insert(struct pci_dev *dev, resource_=
size_t alo,
>  	piar->pcidev =3D dev;
>  	piar->flags =3D flags;
> =20
> -#ifdef DEBUG
>  	pr_debug("PIAR: insert range=3D[%pap:%pap] dev=3D%s\n",
>  		 &alo, &ahi, pci_name(dev));
> -#endif
> =20
>  	rb_link_node(&piar->rb_node, parent, p);
>  	rb_insert_color(&piar->rb_node, &pci_io_addr_cache_root.rb_root);
> @@ -240,6 +238,8 @@ static inline void __eeh_addr_cache_rmv_dev(struct pc=
i_dev *dev)
>  		piar =3D rb_entry(n, struct pci_io_addr_range, rb_node);
> =20
>  		if (piar->pcidev =3D=3D dev) {
> +			pr_debug("PIAR: remove range=3D[%pap:%pap] dev=3D%s\n",
> +				 &piar->addr_lo, &piar->addr_hi, pci_name(dev));
>  			rb_erase(n, &pci_io_addr_cache_root.rb_root);
>  			kfree(piar);
>  			goto restart;
> --=20
> 2.20.1
>=20

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEELWWF8pdtWK5YQRohMX8w6AQl/iIFAlxmSfIACgkQMX8w6AQl
/iIIeAf/ZTDDLhkAibJjwf5YOcfcwcQyzlRgun7CV5v+uy67ABrPLQgQBBbin4dL
997GFTnY8FiL5/dnHp3KBm1BSr8KoOTan+8hYuvuyZWQ9HrRDPnJn2TITWpMqhzQ
7mkLu21RbGXUdU8NzhLEHdXvh9eGwMg+lMbeay3EBtCZLE594IYChYJXWdrTkbrW
LrNu48iXc0yy+VQ7L4gnnat2cGCA0nV9CksRwXy7hfvdkyMzHt8e6G2ph5RCJExi
FAIf92tV2cMt8W9dgVrA0IuQq77dFUNJMIgjV6lsSeC1WZLfguiCTZxS0oLp8E0J
wE0QRFJEl25depA5nEZ3VAAWQvHPZQ==
=v9wp
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--

