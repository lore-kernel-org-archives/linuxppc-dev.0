Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D578CC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 05:12:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B6602192D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 05:12:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B6602192D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4411bP6dH2zDqdh
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 16:12:17 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4411Yh3pg2zDqPQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 16:10:47 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1F597rJ016598
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 00:10:45 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qnj2gw6uc-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 00:10:45 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Fri, 15 Feb 2019 05:10:43 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 15 Feb 2019 05:10:41 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1F5Aepd55836862
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 15 Feb 2019 05:10:40 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F1798A405B;
 Fri, 15 Feb 2019 05:10:39 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5CAE0A4057;
 Fri, 15 Feb 2019 05:10:39 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 15 Feb 2019 05:10:39 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id EF806A016E;
 Fri, 15 Feb 2019 16:10:37 +1100 (AEDT)
Date: Fri, 15 Feb 2019 16:10:36 +1100
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: "Oliver O'Halloran" <oohall@gmail.com>
Subject: Re: [PATCH v2 1/7] powerpc/eeh: Use debugfs_create_u32 for
 eeh_max_freezes
References: <20190215004817.19961-1-oohall@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <20190215004817.19961-1-oohall@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-TM-AS-GCONF: 00
x-cbid: 19021505-0016-0000-0000-00000256B232
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021505-0017-0000-0000-000032B0E592
Message-Id: <20190215051036.GA8338@tungsten.ozlabs.ibm.com>
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


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 11:48:11AM +1100, Oliver O'Halloran wrote:
> There's no need to the custom getter/setter functions so we should remove
> them in favour of using the generic one. While we're here, change the type
> of eeh_max_freeze to u32 and print the value in decimal rather than
> hex because printing it in hex makes no sense.
>=20
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>

Reviewed-by: Sam Bobroff <sbobroff@linux.ibm.com>

> ---
> v2: Replaced uint32_t with u32.
> ---
>  arch/powerpc/include/asm/eeh.h |  2 +-
>  arch/powerpc/kernel/eeh.c      | 21 +++------------------
>  2 files changed, 4 insertions(+), 19 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/ee=
h.h
> index 8b596d096ebe..2daecd677855 100644
> --- a/arch/powerpc/include/asm/eeh.h
> +++ b/arch/powerpc/include/asm/eeh.h
> @@ -219,7 +219,7 @@ struct eeh_ops {
>  };
> =20
>  extern int eeh_subsystem_flags;
> -extern int eeh_max_freezes;
> +extern u32 eeh_max_freezes;
>  extern struct eeh_ops *eeh_ops;
>  extern raw_spinlock_t confirm_error_lock;
> =20
> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> index ae05203eb4de..d021f5abeec5 100644
> --- a/arch/powerpc/kernel/eeh.c
> +++ b/arch/powerpc/kernel/eeh.c
> @@ -109,7 +109,7 @@ EXPORT_SYMBOL(eeh_subsystem_flags);
>   * frozen count in last hour exceeds this limit, the PE will
>   * be forced to be offline permanently.
>   */
> -int eeh_max_freezes =3D 5;
> +u32 eeh_max_freezes =3D 5;
> =20
>  /* Platform dependent EEH operations */
>  struct eeh_ops *eeh_ops =3D NULL;
> @@ -1796,22 +1796,8 @@ static int eeh_enable_dbgfs_get(void *data, u64 *v=
al)
>  	return 0;
>  }
> =20
> -static int eeh_freeze_dbgfs_set(void *data, u64 val)
> -{
> -	eeh_max_freezes =3D val;
> -	return 0;
> -}
> -
> -static int eeh_freeze_dbgfs_get(void *data, u64 *val)
> -{
> -	*val =3D eeh_max_freezes;
> -	return 0;
> -}
> -
>  DEFINE_DEBUGFS_ATTRIBUTE(eeh_enable_dbgfs_ops, eeh_enable_dbgfs_get,
>  			 eeh_enable_dbgfs_set, "0x%llx\n");
> -DEFINE_DEBUGFS_ATTRIBUTE(eeh_freeze_dbgfs_ops, eeh_freeze_dbgfs_get,
> -			 eeh_freeze_dbgfs_set, "0x%llx\n");
>  #endif
> =20
>  static int __init eeh_init_proc(void)
> @@ -1822,9 +1808,8 @@ static int __init eeh_init_proc(void)
>  		debugfs_create_file_unsafe("eeh_enable", 0600,
>  					   powerpc_debugfs_root, NULL,
>  					   &eeh_enable_dbgfs_ops);
> -		debugfs_create_file_unsafe("eeh_max_freezes", 0600,
> -					   powerpc_debugfs_root, NULL,
> -					   &eeh_freeze_dbgfs_ops);
> +		debugfs_create_u32("eeh_max_freezes", 0600,
> +				powerpc_debugfs_root, &eeh_max_freezes);
>  #endif
>  	}
> =20
> --=20
> 2.20.1
>=20

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEELWWF8pdtWK5YQRohMX8w6AQl/iIFAlxmScIACgkQMX8w6AQl
/iJCmgf/ZepaNPmmn3TidcltdCsuz1G5OCJcv5jXsd3rOzirZqmsWIvwuJKrM8HU
/YrkJLmd1flth35T9fPK3Zhzmm2ilo53ckPv7iswJ/lBeIEPMT8zqnMn10/z9yEU
KRin5apAjC5vwXarUXqxU52JDMqCMfh3iARKeLlte8DdQQyCB0G3jZ7R/x3bnBDC
3ysi68+WeViWF7aSPBWGjaP+yLOut43+xeemSWbr5hvV03VVe83vVSEv8YyfTD/p
3pkSzPWV+yp5U1sgfdJxz7LYoe94dywO3bhm9h3Y91b1b+Zd5xJPC01hm0iSgOSo
e/+/vE6ZbeqqiXqXE/SrP4K5sMQFpw==
=akte
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--

