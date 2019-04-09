Return-Path: <SRS0=YLyy=SL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB5CC10F13
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 03:34:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D34421473
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 03:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D34421473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dXvS6pzNzDqFS
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 13:33:56 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44dXrh6RfPzDqJR
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2019 13:31:32 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x393SlVS110762
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Apr 2019 23:31:30 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rrhbwv3af-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Apr 2019 23:31:29 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Tue, 9 Apr 2019 04:31:28 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 9 Apr 2019 04:31:25 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x393VOxo58261668
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 9 Apr 2019 03:31:24 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 719AA11C058;
 Tue,  9 Apr 2019 03:31:24 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C8EC911C050;
 Tue,  9 Apr 2019 03:31:23 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue,  9 Apr 2019 03:31:23 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id BD0BAA01C9;
 Tue,  9 Apr 2019 13:31:22 +1000 (AEST)
Date: Tue, 9 Apr 2019 13:31:21 +1000
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH 8/8] powerpc/eeh: Remove eeh_probe_devices() and
 eeh_addr_cache_build()
References: <cover.1553050609.git.sbobroff@linux.ibm.com>
 <f43eac2b2adf92848afc3304cabd770c9bc976ce.1553050609.git.sbobroff@linux.ibm.com>
 <f3acd337-3222-0cdd-4784-b71cbaa44566@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5QAgd0e35j3NYeGe"
Content-Disposition: inline
In-Reply-To: <f3acd337-3222-0cdd-4784-b71cbaa44566@ozlabs.ru>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-TM-AS-GCONF: 00
x-cbid: 19040903-0016-0000-0000-0000026CBDE9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040903-0017-0000-0000-000032C8E3C3
Message-Id: <20190409033121.GC11437@tungsten.ozlabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-09_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=18 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904090023
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


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2019 at 05:05:49PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 20/03/2019 13:58, Sam Bobroff wrote:
> > Now that EEH support for all devices (on PowerNV and pSeries) is
> > provided by the pcibios bus add device hooks, eeh_probe_devices() and
> > eeh_addr_cache_build() are redundant and can be removed.
> >=20
> > Note that previously on pSeries, useless EEH sysfs files were created
> > for some devices that did not have EEH support and this change
> > prevents them from being created.
> >=20
> > Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
> > ---
> >  arch/powerpc/include/asm/eeh.h               |  6 ----
> >  arch/powerpc/kernel/eeh.c                    | 13 --------
> >  arch/powerpc/kernel/eeh_cache.c              | 32 --------------------
> >  arch/powerpc/platforms/powernv/eeh-powernv.c |  5 ++-
> >  arch/powerpc/platforms/pseries/pci.c         |  3 +-
> >  5 files changed, 3 insertions(+), 56 deletions(-)
> >=20
> > diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/=
eeh.h
> > index 791b9e6fcc45..f1eca1757cbc 100644
> > --- a/arch/powerpc/include/asm/eeh.h
> > +++ b/arch/powerpc/include/asm/eeh.h
> > @@ -290,13 +290,11 @@ struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe);
> >  struct eeh_dev *eeh_dev_init(struct pci_dn *pdn);
> >  void eeh_dev_phb_init_dynamic(struct pci_controller *phb);
> >  void eeh_show_enabled(void);
> > -void eeh_probe_devices(void);
> >  int __init eeh_ops_register(struct eeh_ops *ops);
> >  int __exit eeh_ops_unregister(const char *name);
> >  int eeh_check_failure(const volatile void __iomem *token);
> >  int eeh_dev_check_failure(struct eeh_dev *edev);
> >  void eeh_addr_cache_init(void);
> > -void eeh_addr_cache_build(void);
> >  void eeh_add_device_early(struct pci_dn *);
> >  void eeh_add_device_tree_early(struct pci_dn *);
> >  void eeh_add_device_late(struct pci_dev *);
> > @@ -347,8 +345,6 @@ static inline bool eeh_phb_enabled(void)
> >  	return false;
> >  }
> > =20
> > -static inline void eeh_probe_devices(void) { }
> > -
> >  static inline void *eeh_dev_init(struct pci_dn *pdn, void *data)
> >  {
> >  	return NULL;
> > @@ -365,8 +361,6 @@ static inline int eeh_check_failure(const volatile =
void __iomem *token)
> > =20
> >  static inline void eeh_addr_cache_init(void) { }
> > =20
> > -static inline void eeh_addr_cache_build(void) { }
> > -
> >  static inline void eeh_add_device_early(struct pci_dn *pdn) { }
> > =20
> >  static inline void eeh_add_device_tree_early(struct pci_dn *pdn) { }
> > diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> > index 217e14bb1fb6..cd2abbe41497 100644
> > --- a/arch/powerpc/kernel/eeh.c
> > +++ b/arch/powerpc/kernel/eeh.c
> > @@ -1166,19 +1166,6 @@ static struct notifier_block eeh_reboot_nb =3D {
> >  	.notifier_call =3D eeh_reboot_notifier,
> >  };
> > =20
> > -void eeh_probe_devices(void)
> > -{
> > -	struct pci_controller *hose, *tmp;
> > -	struct pci_dn *pdn;
> > -
> > -	/* Enable EEH for all adapters */
> > -	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
> > -		pdn =3D hose->pci_data;
> > -		traverse_pci_dn(pdn, eeh_ops->probe, NULL);
> > -	}
> > -	eeh_show_enabled();
> > -}
> > -
> >  /**
> >   * eeh_init - EEH initialization
> >   *
> > diff --git a/arch/powerpc/kernel/eeh_cache.c b/arch/powerpc/kernel/eeh_=
cache.c
> > index f93dd5cf6a39..c40078d036af 100644
> > --- a/arch/powerpc/kernel/eeh_cache.c
> > +++ b/arch/powerpc/kernel/eeh_cache.c
> > @@ -278,38 +278,6 @@ void eeh_addr_cache_init(void)
> >  	spin_lock_init(&pci_io_addr_cache_root.piar_lock);
> >  }
> > =20
> > -/**
> > - * eeh_addr_cache_build - Build a cache of I/O addresses
> > - *
> > - * Build a cache of pci i/o addresses.  This cache will be used to
> > - * find the pci device that corresponds to a given address.
> > - * This routine scans all pci busses to build the cache.
> > - * Must be run late in boot process, after the pci controllers
> > - * have been scanned for devices (after all device resources are known=
).
> > - */
> > -void eeh_addr_cache_build(void)
> > -{
> > -	struct pci_dn *pdn;
> > -	struct eeh_dev *edev;
> > -	struct pci_dev *dev =3D NULL;
> > -
> > -	for_each_pci_dev(dev) {
> > -		pdn =3D pci_get_pdn_by_devfn(dev->bus, dev->devfn);
> > -		if (!pdn)
> > -			continue;
> > -
> > -		edev =3D pdn_to_eeh_dev(pdn);
> > -		if (!edev)
> > -			continue;
> > -
> > -		dev->dev.archdata.edev =3D edev;
> > -		edev->pdev =3D dev;
> > -
> > -		eeh_addr_cache_insert_dev(dev);
> > -		eeh_sysfs_add_device(dev);
> > -	}
> > -}
> > -
> >  static int eeh_addr_cache_show(struct seq_file *s, void *v)
> >  {
> >  	struct pci_io_addr_range *piar;
> > diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerp=
c/platforms/powernv/eeh-powernv.c
> > index 81b0923cc55f..6a08f4fab255 100644
> > --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
> > +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
> > @@ -240,9 +240,7 @@ int pnv_eeh_post_init(void)
> >  	struct pnv_phb *phb;
> >  	int ret =3D 0;
> > =20
> > -	/* Probe devices & build address cache */
> > -	eeh_probe_devices();
> > -	eeh_addr_cache_build();
> > +	eeh_show_enabled();
> > =20
> >  	/* Register OPAL event notifier */
> >  	eeh_event_irq =3D opal_event_request(ilog2(OPAL_EVENT_PCI_ERROR));
> > @@ -360,6 +358,7 @@ static int pnv_eeh_find_ecap(struct pci_dn *pdn, in=
t cap)
> >  	return 0;
> >  }
> > =20
> > +
>=20
> Unrelated new line. Otherwise

Thanks, I'll fix it as part of merging in patch #5.

>=20
> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>=20
>=20
>=20
>=20
> >  /**
> >   * pnv_eeh_probe - Do probe on PCI device
> >   * @pdn: PCI device node
> > diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platfo=
rms/pseries/pci.c
> > index 7be80882c08d..7c781b04fb15 100644
> > --- a/arch/powerpc/platforms/pseries/pci.c
> > +++ b/arch/powerpc/platforms/pseries/pci.c
> > @@ -242,8 +242,7 @@ void __init pSeries_final_fixup(void)
> > =20
> >  	pSeries_request_regions();
> > =20
> > -	eeh_probe_devices();
> > -	eeh_addr_cache_build();
> > +	eeh_show_enabled();
> >  #ifdef CONFIG_EEH
> >  	if (eeh_enabled())
> >  		eeh_add_flag(EEH_PHB_ENABLED);
> >=20
>=20
> --=20
> Alexey
>=20

--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEELWWF8pdtWK5YQRohMX8w6AQl/iIFAlysEggACgkQMX8w6AQl
/iLcwQgAlwGCacxjJbsP7HCXFgzC6IMyUz8M8psCWiYAgxK1tmU2OkJkwyRrCQtE
FJqtV+xdE9IKLdaQGlEQdE/9Z5b70LIlD2hh9As+lO2lyE/OXLn0KQGe/QuH+E8m
p2XmPmT/HR6YPf4L5H9FaspeF2/RI9XVq8sEDnyXZ9p2iEbRESfg6Q6cAnxHApoj
hn8u6jKl6DAUYwM7zeYTLrgXPwI4yFt+RbFzYPF7ujugaI4HCd1qgZuRh3iUAsPd
hE5yaPj0xRBqJ60PsmBULcJQe1h6Auf1R1NxyPwzP+c64ocuUUvQHyjDERm5XjZ6
FqcUNv6mhJlBk3+Esj8wXUUSCl3wDA==
=vO66
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--

