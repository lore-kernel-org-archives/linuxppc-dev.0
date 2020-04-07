Return-Path: <SRS0=EQUS=5X=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246EAC2BA1A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2020 16:36:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 952BB2072A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2020 16:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 952BB2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48xY2C0Vn8zDqW5
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2020 02:36:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=leonardo@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48xXyV0QxTzDqLs
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2020 02:33:05 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 037GWCOF109057; Tue, 7 Apr 2020 12:32:55 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 306mjdwncb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Apr 2020 12:32:55 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 037GV4UU008867;
 Tue, 7 Apr 2020 16:32:54 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma02dal.us.ibm.com with ESMTP id 306hv6yww7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Apr 2020 16:32:54 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 037GWrMc46858584
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Apr 2020 16:32:53 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C5F1AC062;
 Tue,  7 Apr 2020 16:32:53 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A9D6AC05E;
 Tue,  7 Apr 2020 16:32:50 +0000 (GMT)
Received: from LeoBras (unknown [9.85.172.25])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  7 Apr 2020 16:32:50 +0000 (GMT)
Message-ID: <dfa8c0d60f171b5cd475d6a5441e94d4dbafbc77.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/1] powerpc/kernel: Enables memory hot-remove after
 reboot on pseries guests
From: Leonardo Bras <leonardo@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 07 Apr 2020 13:32:41 -0300
In-Reply-To: <20200407040046.GA12609@in.ibm.com>
References: <20200402195156.626430-1-leonardo@linux.ibm.com>
 <20200403143831.GA12662@in.ibm.com>
 <6c09a6e1a1f790ad87a2591ff8f8a6e1c7d6b079.camel@linux.ibm.com>
 <20200407040046.GA12609@in.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-6w+DgFjDZwO6PZH9+FP6"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-07_07:2020-04-07,
 2020-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=677
 clxscore=1015 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004070131
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Claudio Carvalho <cclaudio@linux.ibm.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Hari Bathini <hbathini@linux.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, bharata@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org, Allison Randal <allison@lohutok.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--=-6w+DgFjDZwO6PZH9+FP6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Michael,

Would it be ok to add this patch for 5.7 ? Or too late?

Regards,

On Tue, 2020-04-07 at 09:30 +0530, Bharata B Rao wrote:
> On Mon, Apr 06, 2020 at 12:41:01PM -0300, Leonardo Bras wrote:
> > Hello Bharata,
> >=20
> > On Fri, 2020-04-03 at 20:08 +0530, Bharata B Rao wrote:
> > > The patch would be more complete with the following change that ensur=
es
> > > that DRCONF_MEM_HOTREMOVABLE flag is set for non-boot-time hotplugged
> > > memory too. This will ensure that ibm,dynamic-memory-vN property
> > > reflects the right flags value for memory that gets hotplugged
> > > post boot.
> > >=20
> >=20
> > You just sent that on a separated patchset, so I think it's dealt with.
> > Do you have any other comments on the present patch?
>=20
> None, thanks.
>=20
> Regards,
> Bharata.
>=20

--=-6w+DgFjDZwO6PZH9+FP6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl6MqykACgkQlQYWtz9S
ttRMzA/+PmdXf6V5z8ndbT/KNBi9gdUk91oks3AMHhMzDPDchaVqeEL8DVlp5Coz
kOU2f2oIef2yRAlFNbSU2BFgzTe2E28AezUj9O4+TqCw+SSeimAfAqhxR/avZYXJ
+TFXctQFvmUPKFnNFySgjhBqqBi1iF4C9yWpw+cJbr8Soc5OTlMTjXkgaXEddjip
+WIs4sCJCAvfoIEmIDqbE64BIjwEGP0Hm2vp+Kb0/BjcmZBbXCReZ2VNz5+pqQCX
+KEfIT02zRgl8WV1jDg6FGHA9ImOBPLaEvAEmYKaNjDiZYCNo3LULipa5++pevmc
30jjTj44k+fYIuSDcVB87P9HbS+bNxow7y2wCG8kqZZHDItLvBWR3tnnNzgX8vr3
iyZB+yJgw0YR4yQ/agPJgOqkIeSbQcYsQtI/U8C7m4dlNKxlsk3QTwFq0iJnj2g3
SqtACtJmr383hjRnkowLMvIY8ETCQTGdMfipfFD2lHY0qVvoMefAHrpAt1dFHaqK
QNJFicFyua2INKMt/3NJd4HEp43ltAgdUpA1GFVHx40HDQn3wfgHRewBC21fhmJL
9orQ6tluAMaCC/EFbny7RyW4zqNO3R+3fuhlyTi1GWs3nXrxy9RecA3MmL6AsEK6
JnN5awDDilnCmswf5d5bBBC/MFwozTl2ZTG4Lg3cOSPmG21h04Q=
=+f+k
-----END PGP SIGNATURE-----

--=-6w+DgFjDZwO6PZH9+FP6--

