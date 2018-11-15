Return-Path: <SRS0=6gsd=N2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB73C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 02:59:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 103FE21582
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 02:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 103FE21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42wR045SB1zF110
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 13:59:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=sbobroff@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42wQy072s1zF3QC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 13:57:09 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAF2s3rQ090367
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 21:57:07 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2nrx1fvv9p-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 21:57:06 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Thu, 15 Nov 2018 02:57:04 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 15 Nov 2018 02:57:01 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAF2v1jF59310162
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 15 Nov 2018 02:57:01 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E3AB642045;
 Thu, 15 Nov 2018 02:57:00 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8EBB64203F;
 Thu, 15 Nov 2018 02:57:00 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 15 Nov 2018 02:57:00 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 7618EA0111;
 Thu, 15 Nov 2018 13:56:59 +1100 (AEDT)
Date: Thu, 15 Nov 2018 13:56:58 +1100
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel] powerpc/powernv/ioda1: Remove dead code for a
 single device PE
References: <20181016023003.41327-1-aik@ozlabs.ru>
 <29169ab5-ba2e-3b39-1ef2-04e5c9bf04e1@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <29169ab5-ba2e-3b39-1ef2-04e5c9bf04e1@ozlabs.ru>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-TM-AS-GCONF: 00
x-cbid: 18111502-0020-0000-0000-000002E835B8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111502-0021-0000-0000-000021374DC6
Message-Id: <20181115025657.GA19578@tungsten.ozlabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-14_20:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=18 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811150024
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


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 08, 2018 at 04:45:04PM +1100, Alexey Kardashevskiy wrote:
> Ping?
>=20
>=20
> On 16/10/2018 13:30, Alexey Kardashevskiy wrote:
> > At the moment PNV_IODA_PE_DEV is only used for NPU PEs which are not
> > present on IODA1 machines (i.e. POWER7) so let's remove a piece of
> > dead code.
> >=20
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > ---
> >=20
> > We might actually want to get rid of the entire IODA1 there.
> > ---
> >  arch/powerpc/platforms/powernv/pci-ioda.c | 10 +---------
> >  1 file changed, 1 insertion(+), 9 deletions(-)
> >=20
> > diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/p=
latforms/powernv/pci-ioda.c
> > index cde7102..78b61f0 100644
> > --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> > +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> > @@ -2367,15 +2367,7 @@ static void pnv_pci_ioda1_setup_dma_pe(struct pn=
v_phb *phb,
> >  	pe->table_group.tce32_size =3D tbl->it_size << tbl->it_page_shift;
> >  	iommu_init_table(tbl, phb->hose->node);
> > =20
> > -	if (pe->flags & PNV_IODA_PE_DEV) {
> > -		/*
> > -		 * Setting table base here only for carrying iommu_group
> > -		 * further down to let iommu_add_device() do the job.
> > -		 * pnv_pci_ioda_dma_dev_setup will override it later anyway.
> > -		 */
> > -		set_iommu_table_base(&pe->pdev->dev, tbl);
> > -		iommu_add_device(&pe->pdev->dev);
> > -	} else if (pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL))
> > +	if (pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL))
> >  		pnv_ioda_setup_bus_dma(pe, pe->pbus, true);
> > =20
> >  	return;
> >=20
>=20
> --=20
> Alexey
>=20

Looks good to me. It's pretty easy to see that PNV_IODA_PE_DEV is only
set for PHBs that are PNV_PHB_NPU_NVLINK or PNV_PHB_NPU_OCAPI, so:

Reviewed-by: Sam Bobroff <sbobroff@linux.ibm.com>

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEELWWF8pdtWK5YQRohMX8w6AQl/iIFAlvs4HEACgkQMX8w6AQl
/iIKuQf/cjFDyCuYGSMr5BflBU5BeKo7tCAkbtlHG20zDuIyileJZCdGfNTOpQUs
kNrrbFU+IKZTJ7ykJwvo3DI2dL8VTSuoJCB7ebBMOA0rRIkHDOVk20jFj4WPGTB4
81QOYWEfoxbote2KseB9msFIAdWVK27dCWcAnnhlo6ehWy+0g1UD9PvXIuS3D0le
lXFtw5VitG1s+Am4TCACtLLGFyZ6ALMJCpbWdS5814fGi8szIVXFg93BF2RfS2Ju
g5DaOkd22JXhoiRl5SkRjg/f+U8dWhFFCDo1Gwg4f6Ot/fLoesXGvGZSafLJax7k
xhAjwk3kiYmuxzRGM/lD5cy4cJeM7g==
=YNKo
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--

