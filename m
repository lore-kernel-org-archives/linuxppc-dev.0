Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216E8C282C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 04:39:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BBEE222B6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 04:39:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BBEE222B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zmyd0CS9zDqQC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 15:39:37 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zmww2ykjzDqMF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 15:38:05 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1D4TQ0E078163
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 23:38:01 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qmavy2pcv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 23:38:01 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Wed, 13 Feb 2019 04:38:00 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 13 Feb 2019 04:37:58 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1D4bv1o20185232
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 13 Feb 2019 04:37:57 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B097A11C054;
 Wed, 13 Feb 2019 04:37:57 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A1C911C050;
 Wed, 13 Feb 2019 04:37:57 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 13 Feb 2019 04:37:57 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id EFABEA0132;
 Wed, 13 Feb 2019 15:37:55 +1100 (AEDT)
Date: Wed, 13 Feb 2019 15:37:54 +1100
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: "Oliver O'Halloran" <oohall@gmail.com>
Subject: Re: [PATCH 7/7] powerpc/eeh: Add eeh_force_recover to debugfs
References: <20190208030802.10805-1-oohall@gmail.com>
 <20190208030802.10805-7-oohall@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <20190208030802.10805-7-oohall@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-TM-AS-GCONF: 00
x-cbid: 19021304-0012-0000-0000-000002F50FF7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021304-0013-0000-0000-0000212C8727
Message-Id: <20190213042948.GA28303@tungsten.ozlabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-13_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902130031
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


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 08, 2019 at 02:08:02PM +1100, Oliver O'Halloran wrote:
> This patch adds a debugfs interface to force scheduling a recovery event.
> This can be used to recover a specific PE or schedule a "special" recovery
> even that checks for errors at the PHB level.
> To force a recovery of a normal PE, use:
>=20
>  echo '<#pe>:<#phb>' > /sys/kernel/debug/powerpc/eeh_force_recover

How about placing these in the per-PHB debugfs directory?
echo '<#pe>' > /sys/kernel/debug/powerpc/PCI0000/eeh_force_recover

> To force a scan broken PHBs:
>=20
>  echo 'null' > /sys/kernel/debug/powerpc/eeh_force_recover

And keep this one where it is, and just trigger with any write (or a '1'
or whatever)?

Sam.

> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> ---
>  arch/powerpc/include/asm/eeh_event.h |  1 +
>  arch/powerpc/kernel/eeh.c            | 60 ++++++++++++++++++++++++++++
>  arch/powerpc/kernel/eeh_event.c      | 25 +++++++-----
>  3 files changed, 76 insertions(+), 10 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/eeh_event.h b/arch/powerpc/include/=
asm/eeh_event.h
> index 9884e872686f..6d0412b846ac 100644
> --- a/arch/powerpc/include/asm/eeh_event.h
> +++ b/arch/powerpc/include/asm/eeh_event.h
> @@ -33,6 +33,7 @@ struct eeh_event {
> =20
>  int eeh_event_init(void);
>  int eeh_send_failure_event(struct eeh_pe *pe);
> +int __eeh_send_failure_event(struct eeh_pe *pe);
>  void eeh_remove_event(struct eeh_pe *pe, bool force);
>  void eeh_handle_normal_event(struct eeh_pe *pe);
>  void eeh_handle_special_event(void);
> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> index 92809b137e39..63b91a4918c9 100644
> --- a/arch/powerpc/kernel/eeh.c
> +++ b/arch/powerpc/kernel/eeh.c
> @@ -1805,6 +1805,63 @@ static int eeh_enable_dbgfs_get(void *data, u64 *v=
al)
> =20
>  DEFINE_DEBUGFS_ATTRIBUTE(eeh_enable_dbgfs_ops, eeh_enable_dbgfs_get,
>  			 eeh_enable_dbgfs_set, "0x%llx\n");
> +
> +static ssize_t eeh_force_recover_write(struct file *filp,
> +				const char __user *user_buf,
> +				size_t count, loff_t *ppos)
> +{
> +	struct pci_controller *hose;
> +	uint32_t phbid, pe_no;
> +	struct eeh_pe *pe;
> +	char buf[20];
> +	int ret;
> +
> +	ret =3D simple_write_to_buffer(buf, sizeof(buf), ppos, user_buf, count);
> +	if (!ret)
> +		return -EFAULT;
> +
> +	/*
> +	 * When PE is NULL the event is a "special" event. Rather than
> +	 * recovering a specific PE it forces the EEH core to scan for failed
> +	 * PHBs and recovers each. This needs to be done before any device
> +	 * recoveries can occur.
> +	 */
> +	if (!strncmp(buf, "null", 4)) {
> +		pr_err("sending failure event\n");
> +		__eeh_send_failure_event(NULL);
> +		return count;
> +	}
> +
> +	ret =3D sscanf(buf, "%x:%x", &phbid, &pe_no);
> +	if (ret !=3D 2)
> +		return -EINVAL;
> +
> +	hose =3D pci_find_hose_for_domain(phbid);
> +	if (!hose)
> +		return -ENODEV;
> +
> +	/* Retrieve PE */
> +	pe =3D eeh_pe_get(hose, pe_no, 0);
> +	if (!pe)
> +		return -ENODEV;
> +
> +	/*
> +	 * We don't do any state checking here since the detection
> +	 * process is async to the recovery process. The recovery
> +	 * thread *should* not break even if we schedule a recovery
> +	 * from an odd state (e.g. PE removed, or recovery of a
> +	 * non-isolated PE)
> +	 */
> +	__eeh_send_failure_event(pe);
> +
> +	return ret < 0 ? ret : count;
> +}
> +
> +static const struct file_operations eeh_force_recover_fops =3D {
> +	.open	=3D simple_open,
> +	.llseek	=3D no_llseek,
> +	.write	=3D eeh_force_recover_write,
> +};
>  #endif
> =20
>  static int __init eeh_init_proc(void)
> @@ -1820,6 +1877,9 @@ static int __init eeh_init_proc(void)
>  		debugfs_create_bool("eeh_disable_recovery", 0600,
>  				powerpc_debugfs_root,
>  				&eeh_debugfs_no_recover);
> +		debugfs_create_file_unsafe("eeh_force_recover", 0600,
> +				powerpc_debugfs_root, NULL,
> +				&eeh_force_recover_fops);
>  		eeh_cache_debugfs_init();
>  #endif
>  	}
> diff --git a/arch/powerpc/kernel/eeh_event.c b/arch/powerpc/kernel/eeh_ev=
ent.c
> index 19837798bb1d..539aca055d70 100644
> --- a/arch/powerpc/kernel/eeh_event.c
> +++ b/arch/powerpc/kernel/eeh_event.c
> @@ -121,20 +121,11 @@ int eeh_event_init(void)
>   * the actual event will be delivered in a normal context
>   * (from a workqueue).
>   */
> -int eeh_send_failure_event(struct eeh_pe *pe)
> +int __eeh_send_failure_event(struct eeh_pe *pe)
>  {
>  	unsigned long flags;
>  	struct eeh_event *event;
> =20
> -	/*
> -	 * If we've manually supressed recovery events via debugfs
> -	 * then just drop it on the floor.
> -	 */
> -	if (eeh_debugfs_no_recover) {
> -		pr_err("EEH: Event dropped due to no_recover setting\n");
> -		return 0;
> -	}
> -
>  	event =3D kzalloc(sizeof(*event), GFP_ATOMIC);
>  	if (!event) {
>  		pr_err("EEH: out of memory, event not handled\n");
> @@ -153,6 +144,20 @@ int eeh_send_failure_event(struct eeh_pe *pe)
>  	return 0;
>  }
> =20
> +int eeh_send_failure_event(struct eeh_pe *pe)
> +{
> +	/*
> +	 * If we've manually supressed recovery events via debugfs
> +	 * then just drop it on the floor.
> +	 */
> +	if (eeh_debugfs_no_recover) {
> +		pr_err("EEH: Event dropped due to no_recover setting\n");
> +		return 0;
> +	}
> +
> +	return __eeh_send_failure_event(pe);
> +}
> +
>  /**
>   * eeh_remove_event - Remove EEH event from the queue
>   * @pe: Event binding to the PE
> --=20
> 2.20.1
>=20

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEELWWF8pdtWK5YQRohMX8w6AQl/iIFAlxjnyEACgkQMX8w6AQl
/iIxBAf/bjCGrHytU2Kj1CfAjKw1zf2xzAzeDNzIYqv0nUoDOLS/1q0rbUKwaVQx
EKaQ/daU4OQXVGbB9SPOT1cp68dxXGmX7OZl9pf4oH0jYz361oiyOur906wIHl8d
jkwlcp/oPOkGpH3NzHOgHQSsE2No8YkCLg/3NbionPqXtAr4plVJOwTsjpXgCLAK
k3QXmGp+QBB8EoXD+7jQteLq+pEJ2bymmHVXwz/fFu5NhH0y7CVKQAIjdNVseOE/
tTjw1OBEXL2LgpQ7gUzVIKhtfNxOxUhwbsOK880b38eLksdTUdMNvkRTEKcJwRdK
1tukV8kRp85eFDCmbc4CqgHTHl9XfQ==
=m3i4
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--

