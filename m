Return-Path: <SRS0=6gsd=N2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C697DC43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 03:26:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 039D32086A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 03:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 039D32086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42wRbt6jZgzF3Xl
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 14:26:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42wRYW3wMXzF3JV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 14:24:31 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAF3O4D4075871
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 22:24:28 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ns0uj0100-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 22:24:28 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Thu, 15 Nov 2018 03:24:26 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 15 Nov 2018 03:24:24 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAF3ONgZ8388940
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 15 Nov 2018 03:24:23 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F0D4CAE055;
 Thu, 15 Nov 2018 03:24:22 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 512A4AE04D;
 Thu, 15 Nov 2018 03:24:22 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 15 Nov 2018 03:24:22 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id B0DDBA0195;
 Thu, 15 Nov 2018 14:24:20 +1100 (AEDT)
Date: Thu, 15 Nov 2018 14:24:19 +1100
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel] powerpc/powernv/ioda: Reduce a number of hooks in
 pnv_phb
References: <20181016023409.42238-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
Content-Disposition: inline
In-Reply-To: <20181016023409.42238-1-aik@ozlabs.ru>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-TM-AS-GCONF: 00
x-cbid: 18111503-4275-0000-0000-000002E12D70
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111503-4276-0000-0000-000037EE43B9
Message-Id: <20181115032418.GB19578@tungsten.ozlabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-14_20:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=18 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811150028
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


--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2018 at 01:34:09PM +1100, Alexey Kardashevskiy wrote:
> fixup_phb() is never used, this removes it.
>=20
> pick_m64_pe() and reserve_m64_pe() are always defined for all powernv
> PHBs: they are initialized by pnv_ioda_parse_m64_window() which is
> called unconditionally from pnv_pci_init_ioda_phb() which initializes
> all known PHB types on powernv so we can open code them.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/platforms/powernv/pci.h      | 4 ----
>  arch/powerpc/platforms/powernv/pci-ioda.c | 9 +++------
>  2 files changed, 3 insertions(+), 10 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platform=
s/powernv/pci.h
> index 8b37b28..2131373 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -115,11 +115,7 @@ struct pnv_phb {
>  			 unsigned int hwirq, unsigned int virq,
>  			 unsigned int is_64, struct msi_msg *msg);
>  	void (*dma_dev_setup)(struct pnv_phb *phb, struct pci_dev *pdev);
> -	void (*fixup_phb)(struct pci_controller *hose);
>  	int (*init_m64)(struct pnv_phb *phb);
> -	void (*reserve_m64_pe)(struct pci_bus *bus,
> -			       unsigned long *pe_bitmap, bool all);
> -	struct pnv_ioda_pe *(*pick_m64_pe)(struct pci_bus *bus, bool all);
>  	int (*get_pe_state)(struct pnv_phb *phb, int pe_no);
>  	void (*freeze_pe)(struct pnv_phb *phb, int pe_no);
>  	int (*unfreeze_pe)(struct pnv_phb *phb, int pe_no, int opt);
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index 78b61f0..15a4556 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -518,8 +518,6 @@ static void __init pnv_ioda_parse_m64_window(struct p=
nv_phb *phb)
>  		phb->init_m64 =3D pnv_ioda1_init_m64;
>  	else
>  		phb->init_m64 =3D pnv_ioda2_init_m64;
> -	phb->reserve_m64_pe =3D pnv_ioda_reserve_m64_pe;
> -	phb->pick_m64_pe =3D pnv_ioda_pick_m64_pe;
>  }
> =20
>  static void pnv_ioda_freeze_pe(struct pnv_phb *phb, int pe_no)
> @@ -1161,8 +1159,8 @@ static struct pnv_ioda_pe *pnv_ioda_setup_bus_PE(st=
ruct pci_bus *bus, bool all)
>  		pe =3D &phb->ioda.pe_array[phb->ioda.root_pe_idx];
> =20
>  	/* Check if PE is determined by M64 */
> -	if (!pe && phb->pick_m64_pe)
> -		pe =3D phb->pick_m64_pe(bus, all);
> +	if (!pe)
> +		pe =3D pnv_ioda_pick_m64_pe(bus, all);

What about the cases where pnv_ioda_parse_m64_window() returns before
setting pick_m64_pe or reserve_m64_pe?

For example, if !firmware_has_feature(FW_FEATURE_OPAL).  In that case,
it looks like this change would cause pnv_ioda_pick_m64_pe() to be
called, and it would try to perform an OPAL call without OPAL support.

(Is it even possible to have powernv without OPAL?)

> =20
>  	/* The PE number isn't pinned by M64 */
>  	if (!pe)
> @@ -3395,8 +3393,7 @@ static void pnv_pci_setup_bridge(struct pci_bus *bu=
s, unsigned long type)
>  		return;
> =20
>  	/* Reserve PEs according to used M64 resources */
> -	if (phb->reserve_m64_pe)
> -		phb->reserve_m64_pe(bus, NULL, all);
> +	pnv_ioda_reserve_m64_pe(bus, NULL, all);
> =20
>  	/*
>  	 * Assign PE. We might run here because of partial hotplug.
> --=20
> 2.11.0
>=20

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEELWWF8pdtWK5YQRohMX8w6AQl/iIFAlvs5t0ACgkQMX8w6AQl
/iJjiwf/fpelkkzf70bJOiAMBaXNTfdLdNKNv0BtKzr5kEj6MHOdUEyGAmgYx5nV
CD/dJ5+f9KLzx4Za7pDHKI6UkHzpBgD8+XwZPMj9KoGskfc73b4JbYm1mKiSOOOj
NDfQa8gBFDx7ReuoBkZvCZkwXJxjovWeuf+aaW+GXZEzMkJTe1Fw6W4aBOhlcUkj
lIPBEVmtKeMUNRsHqzd6aK5pq/GZdaLSZ/BeEIrJNr939fqmwv7n6SPm8765YiuG
ZYWylI4Axx72ip5qWBF6/pSK9cXHz43F3FyFJ5K2+bks0C6K2HUaR0AkV+lJ97aE
GH463mwEGkppNY3QU1MQ6SA7eBjhmw==
=22gt
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--

