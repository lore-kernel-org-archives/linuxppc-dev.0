Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F367C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 06:00:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E3DE21A80
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 06:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E3DE21A80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4412fm0xvGzDqXb
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 17:00:16 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4412cT69jJzDqX6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 16:58:17 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1F5rju8096409
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 00:58:14 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qnn8sx01q-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 00:58:14 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Fri, 15 Feb 2019 05:58:13 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 15 Feb 2019 05:58:09 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1F5w8t32883988
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 15 Feb 2019 05:58:08 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC0ADAE04D;
 Fri, 15 Feb 2019 05:58:08 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 36E32AE05F;
 Fri, 15 Feb 2019 05:58:08 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 15 Feb 2019 05:58:08 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id ECDD5A016E;
 Fri, 15 Feb 2019 16:58:06 +1100 (AEDT)
Date: Fri, 15 Feb 2019 16:58:05 +1100
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: "Oliver O'Halloran" <oohall@gmail.com>
Subject: Re: [PATCH v2 6/7] powerpc/eeh: Allow disabling recovery
References: <20190215004817.19961-1-oohall@gmail.com>
 <20190215004817.19961-6-oohall@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dWYAkE0V1FpFQHQ3"
Content-Disposition: inline
In-Reply-To: <20190215004817.19961-6-oohall@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-TM-AS-GCONF: 00
x-cbid: 19021505-4275-0000-0000-0000030FBF68
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021505-4276-0000-0000-0000381DDD37
Message-Id: <20190215055805.GF8338@tungsten.ozlabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-15_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902150043
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


--dWYAkE0V1FpFQHQ3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 11:48:16AM +1100, Oliver O'Halloran wrote:
> Currently when we detect an error we automatically invoke the EEH recovery
> handler. This can be annoying when debugging EEH problems, or when working
> on EEH itself so this patch adds a debugfs knob that will prevent a
> recovery event from being queued up when an issue is detected.
>=20
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> ---
>  arch/powerpc/include/asm/eeh.h  |  1 +
>  arch/powerpc/kernel/eeh.c       | 10 ++++++++++
>  arch/powerpc/kernel/eeh_event.c |  9 +++++++++
>  3 files changed, 20 insertions(+)
>=20
> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/ee=
h.h
> index 478f199d5663..810e05273ad3 100644
> --- a/arch/powerpc/include/asm/eeh.h
> +++ b/arch/powerpc/include/asm/eeh.h
> @@ -220,6 +220,7 @@ struct eeh_ops {
> =20
>  extern int eeh_subsystem_flags;
>  extern u32 eeh_max_freezes;
> +extern bool eeh_debugfs_no_recover;
>  extern struct eeh_ops *eeh_ops;
>  extern raw_spinlock_t confirm_error_lock;
> =20
> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> index 82d22c671c0e..9f20099ce2d9 100644
> --- a/arch/powerpc/kernel/eeh.c
> +++ b/arch/powerpc/kernel/eeh.c
> @@ -111,6 +111,13 @@ EXPORT_SYMBOL(eeh_subsystem_flags);
>   */
>  u32 eeh_max_freezes =3D 5;
> =20
> +/*
> + * Controls whether a recovery event should be scheduled when an
> + * isolated device is discovered. This is only really useful for
> + * debugging problems with the EEH core.
> + */
> +bool eeh_debugfs_no_recover;
> +
>  /* Platform dependent EEH operations */
>  struct eeh_ops *eeh_ops =3D NULL;
> =20
> @@ -1810,6 +1817,9 @@ static int __init eeh_init_proc(void)
>  					   &eeh_enable_dbgfs_ops);
>  		debugfs_create_u32("eeh_max_freezes", 0600,
>  				powerpc_debugfs_root, &eeh_max_freezes);
> +		debugfs_create_bool("eeh_disable_recovery", 0600,
> +				powerpc_debugfs_root,
> +				&eeh_debugfs_no_recover);
>  		eeh_cache_debugfs_init();
>  #endif
>  	}
> diff --git a/arch/powerpc/kernel/eeh_event.c b/arch/powerpc/kernel/eeh_ev=
ent.c
> index 227e57f980df..19837798bb1d 100644
> --- a/arch/powerpc/kernel/eeh_event.c
> +++ b/arch/powerpc/kernel/eeh_event.c
> @@ -126,6 +126,15 @@ int eeh_send_failure_event(struct eeh_pe *pe)
>  	unsigned long flags;
>  	struct eeh_event *event;
> =20
> +	/*
> +	 * If we've manually supressed recovery events via debugfs
> +	 * then just drop it on the floor.
> +	 */
> +	if (eeh_debugfs_no_recover) {
> +		pr_err("EEH: Event dropped due to no_recover setting\n");
> +		return 0;
> +	}
> +

I think it might be clearer if you did the 'no recovery' test at the
call sites (I think there are only a few), instead of inside the
function (and then the next patch wouldn't need to add a wrapper).

>  	event =3D kzalloc(sizeof(*event), GFP_ATOMIC);
>  	if (!event) {
>  		pr_err("EEH: out of memory, event not handled\n");
> --=20
> 2.20.1
>=20

--dWYAkE0V1FpFQHQ3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEELWWF8pdtWK5YQRohMX8w6AQl/iIFAlxmVN4ACgkQMX8w6AQl
/iInrgf/a9M7ExQTnmCeqDZC70vQUbTq/rMSj/+XgFpH212+LPNMRAplatvZHNre
RiNocxPpr+6nUSKYZtzMZ+xW42HqcJB9jpqFqFsi8R4yMyUYRPi5oucCPYe2pSlp
b77ROlKPOb+szZ58UB5gxrVjdHDHJ6OHlxNVSc1Ram0G6JX2O7JJFNAmT9XvNTyp
pDP4RPV2GQrep3mYRau4jPO7T3JeOleT7GuxQCv8B+SdQ5H1sbS5kl9b5kDVn1ot
a/vTYfpnZltKY8ZgdCTRyNJiLpHjtFP30+buV+M+CP+ncHhTnS9KmHr+HI+FY2I7
G5EK5LgpBPMh4jGqOj+zxTbrsQ2V7g==
=au/z
-----END PGP SIGNATURE-----

--dWYAkE0V1FpFQHQ3--

