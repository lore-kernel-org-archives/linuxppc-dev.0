Return-Path: <SRS0=YLyy=SL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17BAC10F13
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 03:32:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47BF0213F2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 03:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47BF0213F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dXss71FVzDqJh
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 13:32:33 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44dXr53t9XzDq9R
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2019 13:31:00 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x393SmUW080874
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Apr 2019 23:30:56 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2rrgw8mwdf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Apr 2019 23:30:56 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Tue, 9 Apr 2019 04:30:54 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 9 Apr 2019 04:30:53 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x393UqkA47972458
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 9 Apr 2019 03:30:52 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 20A53A4040;
 Tue,  9 Apr 2019 03:30:52 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 82577A4059;
 Tue,  9 Apr 2019 03:30:51 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue,  9 Apr 2019 03:30:51 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 05A60A01C9;
 Tue,  9 Apr 2019 13:30:48 +1000 (AEST)
Date: Tue, 9 Apr 2019 13:30:46 +1000
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH 5/8] powerpc/eeh: Add eeh_show_enabled()
References: <cover.1553050609.git.sbobroff@linux.ibm.com>
 <ad8cf11e3151fd39c6a9deedc0098d50274c75e4.1553050609.git.sbobroff@linux.ibm.com>
 <26b7c0de-4192-eae5-f8aa-94073b3e768e@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Content-Disposition: inline
In-Reply-To: <26b7c0de-4192-eae5-f8aa-94073b3e768e@ozlabs.ru>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-TM-AS-GCONF: 00
x-cbid: 19040903-0028-0000-0000-0000035EBC53
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040903-0029-0000-0000-0000241DD860
Message-Id: <20190409033046.GB11437@tungsten.ozlabs.ibm.com>
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


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2019 at 05:02:23PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 20/03/2019 13:58, Sam Bobroff wrote:
> > Move the EEH enabled message into it's own function so that future
> > work can call it from multiple places.
> >=20
> > Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
> > ---
> >  arch/powerpc/include/asm/eeh.h |  3 +++
> >  arch/powerpc/kernel/eeh.c      | 16 +++++++++++-----
> >  2 files changed, 14 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/=
eeh.h
> > index fe4cf7208890..e217ccda55d0 100644
> > --- a/arch/powerpc/include/asm/eeh.h
> > +++ b/arch/powerpc/include/asm/eeh.h
> > @@ -289,6 +289,7 @@ struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe);
> > =20
> >  struct eeh_dev *eeh_dev_init(struct pci_dn *pdn);
> >  void eeh_dev_phb_init_dynamic(struct pci_controller *phb);
> > +void eeh_show_enabled(void);
> >  void eeh_probe_devices(void);
> >  int __init eeh_ops_register(struct eeh_ops *ops);
> >  int __exit eeh_ops_unregister(const char *name);
> > @@ -338,6 +339,8 @@ static inline bool eeh_enabled(void)
> >          return false;
> >  }
> > =20
> > +static inline void eeh_show_enabled(void) { }
> > +
> >  static inline bool eeh_phb_enabled(void)
> >  {
> >  	return false;
> > diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> > index b14d89547895..3dcff29cb9b3 100644
> > --- a/arch/powerpc/kernel/eeh.c
> > +++ b/arch/powerpc/kernel/eeh.c
> > @@ -163,6 +163,16 @@ static int __init eeh_setup(char *str)
> >  }
> >  __setup("eeh=3D", eeh_setup);
> > =20
> > +void eeh_show_enabled(void)
> > +{
> > +	if (eeh_has_flag(EEH_FORCE_DISABLED))
> > +		pr_info("EEH: PCI Enhanced I/O Error Handling DISABLED (by eeh=3Doff=
)\n");
> > +	else if (eeh_enabled())
>=20
>=20
> I'd make it eeh_has_flag(EEH_ENABLED) for clarity.

OK, sounds good.

>=20
> > +		pr_info("EEH: PCI Enhanced I/O Error Handling ENABLED (capable adapt=
er found)\n");
> > +	else
> > +		pr_info("EEH: PCI Enhanced I/O Error Handling DISABLED (no capable a=
dapter found)\n");
> > +}
> > +
> >  /*
> >   * This routine captures assorted PCI configuration space data
> >   * for the indicated PCI device, and puts them into a buffer
> > @@ -1166,11 +1176,7 @@ void eeh_probe_devices(void)
> >  		pdn =3D hose->pci_data;
> >  		traverse_pci_dn(pdn, eeh_ops->probe, NULL);
> >  	}
> > -	if (eeh_enabled())
> > -		pr_info("EEH: PCI Enhanced I/O Error Handling Enabled\n");
> > -	else
> > -		pr_info("EEH: No capable adapters found\n");
> > -
> > +	eeh_show_enabled();
>=20
>=20
> This line moves later in the series so I'd just merge this patch into
> 8/8 to reduce number of lines moving withing the patchset.

Oh, good idea. I'll do it.

> In general the whole point of the EEH_ENABLED flag is fading away. Its
> meaning now is that "at least somewhere in the box for at least one
> device with enabled EEH" which does not seem extremely useful as we have
> a pci_dev or pe pretty much everywhere we look at eeh_enabled() and
> pdev->dev.archdata.edev can tell if eeh is enabled for a device.
> Although I am pretty sure this is in your list already :)

Yes. :-)

>=20
> >  }
> > =20
> >  /**
> >=20
>=20
> --=20
> Alexey
>=20

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEELWWF8pdtWK5YQRohMX8w6AQl/iIFAlysEd4ACgkQMX8w6AQl
/iK+DAf/SMZtzd98JgRmDPCS0dTnv9SdW8sqL4mXmVuTPkEnfXduuoQgzj8Sbkbc
qWLj0+xR42rx/cCUHWWY2uDd9hDZDxkSZY4OAOOGBJnSC2J6ebBMGk3tSuFNnw6Q
LEnU8WUKGwX2sUW/tlgeAmHtdV3HpMIObL2tNbd3q5fZe2Yu+iOOdV8whsWZMuyR
83OxyQQ0vyfg80Z41VoWJi3NWiM5LUtlZlDQP85tckviNU4HHgdS+fYnNjXe5NaV
GJYryIIHGKStAgk2WmIxTcZ7IsjXPPf9PEKfqJbaz+3fHn4Asx7Gq0QSdG3EMtwy
KYsT0D92SewdnJOt7B/Q04G7CoDFpg==
=fc7G
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--

