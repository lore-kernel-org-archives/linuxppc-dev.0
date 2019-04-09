Return-Path: <SRS0=YLyy=SL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A98CC10F13
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 01:43:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 761BE20818
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 01:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 761BE20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dVS94PhqzDqJt
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 11:43:37 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44dVQV2JMYzDqHm
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2019 11:42:08 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x391ciHx116400
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Apr 2019 21:42:05 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rrdyaqt0d-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Apr 2019 21:42:05 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Tue, 9 Apr 2019 02:42:03 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 9 Apr 2019 02:42:01 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x391g0FS61079804
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 9 Apr 2019 01:42:00 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 69F9452054;
 Tue,  9 Apr 2019 01:42:00 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id CB07552052;
 Tue,  9 Apr 2019 01:41:59 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 8E1CAA01E5;
 Tue,  9 Apr 2019 11:41:58 +1000 (AEST)
Date: Tue, 9 Apr 2019 11:41:57 +1000
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH 3/8] powerpc/eeh: Convert PNV_PHB_FLAG_EEH to global flag
References: <cover.1553050609.git.sbobroff@linux.ibm.com>
 <17f0dc9c30a139f19dceefd09689d34c3ad01a17.1553050609.git.sbobroff@linux.ibm.com>
 <680b2264-93a8-6c75-88c1-ad0520b8e8a7@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
In-Reply-To: <680b2264-93a8-6c75-88c1-ad0520b8e8a7@ozlabs.ru>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-TM-AS-GCONF: 00
x-cbid: 19040901-0016-0000-0000-0000026CB8E6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040901-0017-0000-0000-000032C8DE85
Message-Id: <20190409014156.GA11437@tungsten.ozlabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-09_01:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=18 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904090009
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


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2019 at 05:02:44PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 20/03/2019 13:58, Sam Bobroff wrote:
> > The PHB flag, PNV_PHB_FLAG_EEH, is set (on PowerNV) individually on
> > each PHB once the EEH subsystem is ready. It is the only use of the
> > flags member of the phb struct.
>=20
>=20
> Then why to keep pnv_phb::flags?

No reason. I'll remove it in the next version.

> > However there is no need to store this separately on each PHB, so
> > convert it to a global flag. For symmetry, the flag is now also set
> > for pSeries; although it is currently unused it may be useful in the
> > future.
>=20
> Just using eeh_enabled() instead of (phb->flags & PNV_PHB_FLAG_EEH)
> seems easier and cleaner; also pseries does not use it so there is no
> point defining it there either.

I do want to do that. However, eeh_enabled() seems to be slightly
different from PNV_PHB_FLAG_EEH:

- eeh_enabled() is true as soon as the first device with EEH support is
  detected.
- eeh_phb_enabled() is true after EEH support has been enabled on every
  device that supports it.

So I was concerned that using eeh_enabled() would cause problems in
pnv_pci_config_check_eeh() if EEH was detected *during* the initial PCI
scanning phase when eeh_enabled() was true but EEH had not yet been set
up on the device or PHB where it was detected.

Does that make sense?

Would it be reasonable to keep this patch as it is for now and
investigate cleaning it up in a future patch?

> >=20
> > Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
> > ---
> >  arch/powerpc/include/asm/eeh.h               | 11 +++++++++++
> >  arch/powerpc/platforms/powernv/eeh-powernv.c | 14 +++-----------
> >  arch/powerpc/platforms/powernv/pci.c         |  7 +++----
> >  arch/powerpc/platforms/powernv/pci.h         |  2 --
> >  arch/powerpc/platforms/pseries/pci.c         |  4 ++++
> >  5 files changed, 21 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/=
eeh.h
> > index 3613a56281f2..fe4cf7208890 100644
> > --- a/arch/powerpc/include/asm/eeh.h
> > +++ b/arch/powerpc/include/asm/eeh.h
> > @@ -43,6 +43,7 @@ struct pci_dn;
> >  #define EEH_VALID_PE_ZERO	0x10	/* PE#0 is valid		     */
> >  #define EEH_ENABLE_IO_FOR_LOG	0x20	/* Enable IO for log		     */
> >  #define EEH_EARLY_DUMP_LOG	0x40	/* Dump log immediately		     */
> > +#define EEH_PHB_ENABLED		0x80	/* PHB recovery uses EEH	     */
> > =20
> >  /*
> >   * Delay for PE reset, all in ms
> > @@ -245,6 +246,11 @@ static inline bool eeh_enabled(void)
> >  	return eeh_has_flag(EEH_ENABLED) && !eeh_has_flag(EEH_FORCE_DISABLED);
> >  }
> > =20
> > +static inline bool eeh_phb_enabled(void)
> > +{
> > +	return eeh_has_flag(EEH_PHB_ENABLED);
> > +}
> > +
> >  static inline void eeh_serialize_lock(unsigned long *flags)
> >  {
> >  	raw_spin_lock_irqsave(&confirm_error_lock, *flags);
> > @@ -332,6 +338,11 @@ static inline bool eeh_enabled(void)
> >          return false;
> >  }
> > =20
> > +static inline bool eeh_phb_enabled(void)
> > +{
> > +	return false;
> > +}
> > +
> >  static inline void eeh_probe_devices(void) { }
> > =20
> >  static inline void *eeh_dev_init(struct pci_dn *pdn, void *data)
> > diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerp=
c/platforms/powernv/eeh-powernv.c
> > index 6fc1a463b796..f0a95f663810 100644
> > --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
> > +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
> > @@ -264,22 +264,14 @@ int pnv_eeh_post_init(void)
> >  		return ret;
> >  	}
> > =20
> > -	if (!eeh_enabled())
> > +	if (eeh_enabled())
> > +		eeh_add_flag(EEH_PHB_ENABLED);
> > +	else
> >  		disable_irq(eeh_event_irq);
> > =20
> >  	list_for_each_entry(hose, &hose_list, list_node) {
> >  		phb =3D hose->private_data;
> > =20
> > -		/*
> > -		 * If EEH is enabled, we're going to rely on that.
> > -		 * Otherwise, we restore to conventional mechanism
> > -		 * to clear frozen PE during PCI config access.
> > -		 */
> > -		if (eeh_enabled())
> > -			phb->flags |=3D PNV_PHB_FLAG_EEH;
> > -		else
> > -			phb->flags &=3D ~PNV_PHB_FLAG_EEH;
> > -
> >  		/* Create debugfs entries */
> >  #ifdef CONFIG_DEBUG_FS
> >  		if (phb->has_dbgfs || !phb->dbgfs)
> > diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platfo=
rms/powernv/pci.c
> > index 307181fd8a17..d2b50f3bf6b1 100644
> > --- a/arch/powerpc/platforms/powernv/pci.c
> > +++ b/arch/powerpc/platforms/powernv/pci.c
> > @@ -717,10 +717,9 @@ int pnv_pci_cfg_write(struct pci_dn *pdn,
> >  static bool pnv_pci_cfg_check(struct pci_dn *pdn)
> >  {
> >  	struct eeh_dev *edev =3D NULL;
> > -	struct pnv_phb *phb =3D pdn->phb->private_data;
> > =20
> >  	/* EEH not enabled ? */
> > -	if (!(phb->flags & PNV_PHB_FLAG_EEH))
> > +	if (!eeh_phb_enabled())
> >  		return true;
> > =20
> >  	/* PE reset or device removed ? */
> > @@ -761,7 +760,7 @@ static int pnv_pci_read_config(struct pci_bus *bus,
> > =20
> >  	ret =3D pnv_pci_cfg_read(pdn, where, size, val);
> >  	phb =3D pdn->phb->private_data;
> > -	if (phb->flags & PNV_PHB_FLAG_EEH && pdn->edev) {
> > +	if (eeh_phb_enabled() && pdn->edev) {
> >  		if (*val =3D=3D EEH_IO_ERROR_VALUE(size) &&
> >  		    eeh_dev_check_failure(pdn->edev))
> >                          return PCIBIOS_DEVICE_NOT_FOUND;
> > @@ -789,7 +788,7 @@ static int pnv_pci_write_config(struct pci_bus *bus,
> > =20
> >  	ret =3D pnv_pci_cfg_write(pdn, where, size, val);
> >  	phb =3D pdn->phb->private_data;
> > -	if (!(phb->flags & PNV_PHB_FLAG_EEH))
> > +	if (!eeh_phb_enabled())
> >  		pnv_pci_config_check_eeh(pdn);
> > =20
> >  	return ret;
> > diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platfo=
rms/powernv/pci.h
> > index 8e36da379252..eb0add61397b 100644
> > --- a/arch/powerpc/platforms/powernv/pci.h
> > +++ b/arch/powerpc/platforms/powernv/pci.h
> > @@ -85,8 +85,6 @@ struct pnv_ioda_pe {
> >  	struct list_head	list;
> >  };
> > =20
> > -#define PNV_PHB_FLAG_EEH	(1 << 0)
> > -
> >  struct pnv_phb {
> >  	struct pci_controller	*hose;
> >  	enum pnv_phb_type	type;
> > diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platfo=
rms/pseries/pci.c
> > index 37a77e57893e..7be80882c08d 100644
> > --- a/arch/powerpc/platforms/pseries/pci.c
> > +++ b/arch/powerpc/platforms/pseries/pci.c
> > @@ -244,6 +244,10 @@ void __init pSeries_final_fixup(void)
> > =20
> >  	eeh_probe_devices();
> >  	eeh_addr_cache_build();
> > +#ifdef CONFIG_EEH
> > +	if (eeh_enabled())
> > +		eeh_add_flag(EEH_PHB_ENABLED);
> > +#endif
> > =20
> >  #ifdef CONFIG_PCI_IOV
> >  	ppc_md.pcibios_sriov_enable =3D pseries_pcibios_sriov_enable;
> >=20
>=20
> --=20
> Alexey
>=20

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEELWWF8pdtWK5YQRohMX8w6AQl/iIFAlyr+F0ACgkQMX8w6AQl
/iJZvAgAj3W+FWcQEWcIQ4LlL/iRd0Z4/a42Kw7zoYk0w8zo8+jW8K867ZeuyLEB
Q0/ug12sc1pYECAdIPrrkdIWcjgUoGiS5nU9AErqd7FTpcyUhJqGvHTAHQROCAl7
U6jwgjEDTPXplIw0T3ndfPEMszg+KbhLZt2ThuTjDlgGIIg9phegc/w7YVNunC0F
Dpixl0UXKKGsaGeIzDeWSVZYl5W8e5waxvzZgkAPcf9nffUcPO3RDAa/xtjckm4s
oPlVpL4lQhPyMqLn2ctSC6BbJMT7gQJcobhaE7f5zu+N9MI51e/tB7jNAyjV/8ja
tC8V3uUBpI3z/2S5KcLt4F0i5d/RvA==
=RrmT
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--

