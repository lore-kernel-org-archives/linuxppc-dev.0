Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B70C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 05:15:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 848572192D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 05:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 848572192D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4411gV3TQlzDqcN
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 16:15:50 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4411bw4VsvzDqdW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 16:12:44 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1F58t6t131850
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 00:12:42 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qnn8sv8e2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 00:12:42 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Fri, 15 Feb 2019 05:12:40 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 15 Feb 2019 05:12:39 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1F5Ccq955967942
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Feb 2019 05:12:38 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0A18DA4064;
 Fri, 15 Feb 2019 05:12:38 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6A0C0A4054;
 Fri, 15 Feb 2019 05:12:37 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 15 Feb 2019 05:12:37 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 36E1FA016E;
 Fri, 15 Feb 2019 16:12:36 +1100 (AEDT)
Date: Fri, 15 Feb 2019 16:12:35 +1100
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: "Oliver O'Halloran" <oohall@gmail.com>
Subject: Re: [PATCH v2 3/7] powerpc/eeh_cache: Add a way to dump the EEH
 address cache
References: <20190215004817.19961-1-oohall@gmail.com>
 <20190215004817.19961-3-oohall@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LwW0XdcUbUexiWVK"
Content-Disposition: inline
In-Reply-To: <20190215004817.19961-3-oohall@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-TM-AS-GCONF: 00
x-cbid: 19021505-0028-0000-0000-00000348CF24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021505-0029-0000-0000-00002406FD4E
Message-Id: <20190215051234.GC8338@tungsten.ozlabs.ibm.com>
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


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 11:48:13AM +1100, Oliver O'Halloran wrote:
> Adds a debugfs file that can be read to view the contents of the EEH
> address cache. This is pretty similar to the existing
> eeh_addr_cache_print() function, but that function is intended to debug
> issues inside of the kernel since it's #ifdef`ed out by default, and writ=
es
> into the kernel log.
>=20
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>

Reviewed-by: Sam Bobroff <sbobroff@linux.ibm.com>

> ---
> v2: Added missing #endif
>     Replaced while loop with a for
> ---
>  arch/powerpc/include/asm/eeh.h  |  3 +++
>  arch/powerpc/kernel/eeh.c       |  1 +
>  arch/powerpc/kernel/eeh_cache.c | 30 ++++++++++++++++++++++++++----
>  3 files changed, 30 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/ee=
h.h
> index 2daecd677855..478f199d5663 100644
> --- a/arch/powerpc/include/asm/eeh.h
> +++ b/arch/powerpc/include/asm/eeh.h
> @@ -460,6 +460,9 @@ static inline void eeh_readsl(const volatile void __i=
omem *addr, void * buf,
>  		eeh_check_failure(addr);
>  }
> =20
> +
> +void eeh_cache_debugfs_init(void);
> +
>  #endif /* CONFIG_PPC64 */
>  #endif /* __KERNEL__ */
>  #endif /* _POWERPC_EEH_H */
> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> index d021f5abeec5..82d22c671c0e 100644
> --- a/arch/powerpc/kernel/eeh.c
> +++ b/arch/powerpc/kernel/eeh.c
> @@ -1810,6 +1810,7 @@ static int __init eeh_init_proc(void)
>  					   &eeh_enable_dbgfs_ops);
>  		debugfs_create_u32("eeh_max_freezes", 0600,
>  				powerpc_debugfs_root, &eeh_max_freezes);
> +		eeh_cache_debugfs_init();
>  #endif
>  	}
> =20
> diff --git a/arch/powerpc/kernel/eeh_cache.c b/arch/powerpc/kernel/eeh_ca=
che.c
> index b2c320e0fcef..5c5697cced41 100644
> --- a/arch/powerpc/kernel/eeh_cache.c
> +++ b/arch/powerpc/kernel/eeh_cache.c
> @@ -26,6 +26,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/atomic.h>
>  #include <asm/pci-bridge.h>
> +#include <asm/debugfs.h>
>  #include <asm/ppc-pci.h>
> =20
> =20
> @@ -298,9 +299,30 @@ void eeh_addr_cache_build(void)
>  		eeh_addr_cache_insert_dev(dev);
>  		eeh_sysfs_add_device(dev);
>  	}
> +}
> =20
> -#ifdef DEBUG
> -	/* Verify tree built up above, echo back the list of addrs. */
> -	eeh_addr_cache_print(&pci_io_addr_cache_root);
> -#endif
> +static int eeh_addr_cache_show(struct seq_file *s, void *v)
> +{
> +	struct pci_io_addr_range *piar;
> +	struct rb_node *n;
> +
> +	spin_lock(&pci_io_addr_cache_root.piar_lock);
> +	for (n =3D rb_first(&pci_io_addr_cache_root.rb_root); n; n =3D rb_next(=
n)) {
> +		piar =3D rb_entry(n, struct pci_io_addr_range, rb_node);
> +
> +		seq_printf(s, "%s addr range [%pap-%pap]: %s\n",
> +		       (piar->flags & IORESOURCE_IO) ? "i/o" : "mem",
> +		       &piar->addr_lo, &piar->addr_hi, pci_name(piar->pcidev));
> +	}
> +	spin_unlock(&pci_io_addr_cache_root.piar_lock);
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(eeh_addr_cache);
> +
> +void eeh_cache_debugfs_init(void)
> +{
> +	debugfs_create_file_unsafe("eeh_address_cache", 0400,
> +			powerpc_debugfs_root, NULL,
> +			&eeh_addr_cache_fops);
>  }
> --=20
> 2.20.1
>=20

--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEELWWF8pdtWK5YQRohMX8w6AQl/iIFAlxmSkIACgkQMX8w6AQl
/iLOvAf/cmvoSKp7mLWZFxE7609xaclxfN9nqrsLrlyL++E0bi2SE/0ArGqVwpzy
tJnNVIX5OkMW8SGRSKVyw192vQ/PfRkqtlwYJ308kkXdn0GvZabZVNqSW+t28eFN
fj5n+AqN2HSDXKof1hb+hQ7YZnZ4l6SuMi5TXkwX1w23kUhFKlNwsTMjUINEScdJ
W+JGOCcJt9YZF3Ml9Wizxv7N+LM+oQYP/yesC+yPHMDBwN6JvA5ZLuMTBXQbEO0V
g1sOUWlqDMXABPfI3yDrckyspusa9U+8NMkTjGkPNkdcDr4ckweVXjdvNZebM/LS
HfUYkltmXrHTVyfzmPQn310NjQ9KJg==
=C2jl
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--

