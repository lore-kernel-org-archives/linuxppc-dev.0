Return-Path: <SRS0=nZGU=SK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23367C282CE
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 06:52:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B87020870
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 06:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B87020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=tempfail smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44d1Lq4FPmzDqK6
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 16:52:19 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44d1K46bMWzDqCR
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Apr 2019 16:50:47 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x386nL8q034095
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Apr 2019 02:50:44 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2rqx6kgmaq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Apr 2019 02:50:44 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Mon, 8 Apr 2019 07:50:42 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 8 Apr 2019 07:50:40 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x386odGe53149702
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Apr 2019 06:50:39 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A74D342057;
 Mon,  8 Apr 2019 06:50:39 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1CE9C42054;
 Mon,  8 Apr 2019 06:50:39 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  8 Apr 2019 06:50:39 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (unknown [9.81.196.4])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id DBBEEA0190;
 Mon,  8 Apr 2019 16:50:37 +1000 (AEST)
Date: Mon, 8 Apr 2019 16:50:36 +1000
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH 2/8] powerpc/eeh: Clear stale EEH_DEV_NO_HANDLER flag
References: <cover.1553050609.git.sbobroff@linux.ibm.com>
 <28b287eb3939b1941bd46b2ed9a6981a577568c4.1553050609.git.sbobroff@linux.ibm.com>
 <fd1acf72-aefe-233f-cd01-e89846551e08@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <fd1acf72-aefe-233f-cd01-e89846551e08@ozlabs.ru>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-TM-AS-GCONF: 00
x-cbid: 19040806-0016-0000-0000-0000026C5F69
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040806-0017-0000-0000-000032C8808C
Message-Id: <20190408065035.GA21472@tungsten.ozlabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-08_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=18 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904080064
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


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2019 at 05:02:57PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 20/03/2019 13:58, Sam Bobroff wrote:
> > The EEH_DEV_NO_HANDLER flag is used by the EEH system to prevent the
> > use of driver callbacks in drivers that have been bound part way
> > through the recovery process. This is necessary to prevent later stage
> > handlers from being called when the earlier stage handlers haven't,
> > which can be confusing for drivers.
>=20
> The flag is used from eeh_pe_report()->eeh_pe_report_edev which is
> called many times from eeh_handle_normal_event() (and you clear the flag
> here unconditionally) and once from eeh_handle_special_event() - so this
> is actually the only case now when the flag matters. Is my understanding
> correct? Also is not clearing the flag correct in that case? I do not
> quite understand eeh_handle_normal_event vs. eeh_handle_special_event
> business though.

I'm not sure I fully understand your question, but here's the situation:

* EEH is detected on a PCI device that has no driver bound but there is
  a driver that COULD bind.
* eeh_handle_normal_event() follows the "EEH: Reset with hotplug
  activity" path because the device doesn't (currently) have a driver
  that supports EEH.
* eeh_reset_device() removes the device (pci_hp_remove_devices()).
* eeh_reset_device() re-discovers the device with pci_hp_add_devices().
* As part of re-discovery the PCI subsystem will bind the available driver.
* eeh_handle_normal_event() calls eeh_report_resume() (via eeh_pe_report()).

If the (newly bound) driver has a resume() handler, then
eeh_report_resume() will call it and AFAIK this will cause a problem for
some drivers because their error_detected() handler wasn't called first.

The fix for this is to have eeh_add_device_late() set EEH_DEV_NO_HANDLER
so that we can detect that the device has been added DURING recovery,
and avoid calling it's handlers later.

I see what you mean about the eeh_handle_special_event() case, where
EEH_DEV_NO_HANDLER isn't cleared before calling eeh_pe_report(), and I
think it's a bug! I'll fix it in the next version.

(Cleaning up that flag is on my list. I don't think it's a very good
solution.)

> >=20
> > However, the flag is set for all devices that are added after boot
> > time and only cleared at the end of the EEH recovery process. This
> > results in hot plugged devices erroneously having the flag set during
> > the first recovery after they are added (causing their driver's
> > handlers to be incorrectly ignored).
> >=20
> > To remedy this, clear the flag at the beginning of recovery
> > processing. The flag is still cleared at the end of recovery
> > processing, although it is no longer really necessary.
>=20
> Then may be remove that redundant clearing?

I don't really mind either way; clearing it when we are finished with
recovery seems "cleaner" to me but it doesn't have any function. (In
any case, I think I will eventually want to remove it.)

> >=20
> > Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
> > ---
> >  arch/powerpc/kernel/eeh_driver.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh=
_driver.c
> > index 6f3ee30565dd..4c34b9901f15 100644
> > --- a/arch/powerpc/kernel/eeh_driver.c
> > +++ b/arch/powerpc/kernel/eeh_driver.c
> > @@ -819,6 +819,10 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
> >  		result =3D PCI_ERS_RESULT_DISCONNECT;
> >  	}
> > =20
> > +	eeh_for_each_pe(pe, tmp_pe)
> > +		eeh_pe_for_each_dev(tmp_pe, edev, tmp)
> > +			edev->mode &=3D ~EEH_DEV_NO_HANDLER;
> > +
> >  	/* Walk the various device drivers attached to this slot through
> >  	 * a reset sequence, giving each an opportunity to do what it needs
> >  	 * to accomplish the reset.  Each child gets a report of the
> >=20
>=20
> --=20
> Alexey
>=20

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEELWWF8pdtWK5YQRohMX8w6AQl/iIFAlyq7zIACgkQMX8w6AQl
/iIvIgf+I1mUe7RXt8iHTTboy5kOwgsALBKB680EpQrTQN2Wv511ldYW0q1sFSFn
s9PpeeEFgeADVdffruUs+fmmLqmXWquJovNzvGzxTnQDczCPGqgDRiHw3k8HQjGB
jv+LhTIAzak/1IPK4p7XY+phk09lVz6PzObojHYzmOaTx4tcislNzUIwPfkChAps
TQIxtgLpgDKuOYYb6nI9yZIZULMVGmEb0U0v7oiV+bziwiOd+FSPoxbJj0KGMXBb
zO+tx9w8UlyNYfNyjMGFi4W9QeebPCRAz/IcERTkWvx+zOxUXNf7sOZSz2jFOidG
3TCr0EeJpKuSfeB8082G4CX7N5yllw==
=GCYU
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--

