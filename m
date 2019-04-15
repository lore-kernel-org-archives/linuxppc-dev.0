Return-Path: <SRS0=spRZ=SR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,SUBJ_ALL_CAPS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DF5C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 03:42:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49D622075B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 03:42:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D622075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44jDpy6NRWzDqKP
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 13:42:50 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44jDnJ1w6RzDqGJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 13:41:22 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3F3XZIa048115
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Apr 2019 23:41:19 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rvcjm3sn3-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Apr 2019 23:41:18 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Mon, 15 Apr 2019 04:41:17 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 15 Apr 2019 04:41:14 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3F3fDKW61538444
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 03:41:13 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8BEA4A405F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 03:41:13 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E415DA4054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 03:41:12 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 03:41:12 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id DA256A01FB;
 Mon, 15 Apr 2019 13:41:11 +1000 (AEST)
Date: Mon, 15 Apr 2019 13:41:10 +1000
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/8]
References: <cover.1553050609.git.sbobroff@linux.ibm.com>
 <b0406238-9480-3423-20ef-27c29c31b313@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <b0406238-9480-3423-20ef-27c29c31b313@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-TM-AS-GCONF: 00
x-cbid: 19041503-4275-0000-0000-00000327CD54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041503-4276-0000-0000-00003836F576
Message-Id: <20190415034109.GA9045@tungsten.ozlabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-15_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904150022
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


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 05:55:33PM -0700, Tyrel Datwyler wrote:
> On 03/19/2019 07:58 PM, Sam Bobroff wrote:
> > Hi all,
> >=20
> > This patch set adds support for EEH recovery of hot plugged devices on =
pSeries
> > machines. Specifically, devices discovered by PCI rescanning using
> > /sys/bus/pci/rescan, which includes devices hotplugged by QEMU's device=
_add
> > command. (pSeries doesn't currently use slot power control for hotplugg=
ing.)
>=20
> Slight nit that its not that pSeries doesn't support slot power control
> hotplugging, its that QEMU pSeries guests don't support it. We most defin=
itely
> use the slot power control for hotplugging in PowerVM pSeries Linux guest=
s. More

Ah, I think I see what you mean: pSeries can (and does!) use slot power
control for hotplugging, it's just that Linux doesn't. Right :-) I'll
change it to "Linux on pSeries doesn't...." for the next version.

> specifically we had to work around short comings in the rpaphp driver when
> dealing with QEMU. This being that while at initial glance the design imp=
lies
> that it had multiple devices per PHB in mind, it didn't, and only actually
> supported a single slot per PHB. Further, when we developed the QEMU pci =
hotplug
> feature we had to deal with only having a single PHB per QEMU guest and a=
s a
> result needed a way to plug multiple pci devices into a single PHB. Hence=
, came
> the pci rescan work around in drmgr.
>=20
> Mike Roth and I have had discussions over the years to get the slot power
> control hotplugging working properly with QEMU, and while I did get the R=
PA
> hotplug driver fixed to register all available slots associated with a PH=
B, EEH
> remained an issue. So, I'm very happy to see this patchset get that worki=
ng with
> the rescan work around.
>=20
> >=20
> > As a side effect this also provides EEH support for devices removed by
> > /sys/bus/pci/devices/*/remove and re-discovered by writing to /sys/bus/=
pci/rescan,
> > on all platforms.
>=20
> +1, this seems like icing on the cake. ;)

Yes :-)

Although maybe I should mention that we can't really benefit from this
on PowerNV *yet* because there seem to be some other problems with
removing and re-scanning devices: in my tests devices are often unusable
after being rediscovered.

(I'm hoping to take a look at that soon.)

> >=20
> > The approach I've taken is to use the fact that the existing
> > pcibios_bus_add_device() platform hooks (which are used to set up EEH on
> > Virtual Function devices (VFs)) are actually called for all devices, so=
 I've
> > widened their scope and made other adjustments necessary to allow them =
to work
> > for hotplugged and boot-time devices as well.
> >=20
> > Because some of the changes are in generic PowerPC code, it's
> > possible that I've disturbed something for another PowerPC platform. I'=
ve tried
> > to minimize this by leaving that code alone as much as possible and so =
there
> > are a few cases where eeh_add_device_{early,late}() or eeh_add_sysfs_fi=
les() is
> > called more than once. I think these can be looked at later, as duplica=
te calls
> > are not harmful.
> >=20
> > The patch "Convert PNV_PHB_FLAG_EEH" isn't strictly necessary and I'm n=
ot sure
> > if it's better to keep it, because it simplifies the code or drop it, b=
ecause
> > we may need a separate flag per PHB later on. Thoughts anyone?
> >=20
> > The first patch is a rework of the pcibios_init reordering patch I post=
ed
> > earlier, which I've included here because it's necessary for this set.
> >=20
> > I have done some testing for PowerNV on Power9 using a modified pnv_php=
 module
> > and some testing on pSeries with slot power control using a modified rp=
aphp
> > module, and the EEH-related parts seem to work.
>=20
> I'm interested in what modifications with rpaphp. Its unclear if you are =
saying
> rpaphp modified so that slot power hotplug works with a QEMU pSeries gues=
t? If
> thats the case it would be optimal to get that upstream and remove the wo=
rk
> rescan workaround for guests that don't need it.

Unfortunately no, I didn't do enough work to really get it working.  I
just wanted to get an idea of how that code path interacted with the EEH
code I was changing, so that hopefully when we get to fixing it, the EEH
part will be easier to do.

The hack I tested with was:

- rtas_errd changed so that it doesn't pass -V to drmgr (-V seems to
  trigger drmgr to use the PCI rescan system rather that slot power
  control).
- of_pci_parse_addrs() changed so that if the assigned-addresses node
  is missing (which it is when the guest is running under QEMU/KVM) we
  call pci_setup_device() to configure the BARs.

It did look pretty good -- the EEH part may actually work fine once we get
the rest sorted out.

>=20
> -Tyrel
>=20
> >=20
> > Cheers,
> > Sam.
> >=20
> > Sam Bobroff (8):
> >   powerpc/64: Adjust order in pcibios_init()
> >   powerpc/eeh: Clear stale EEH_DEV_NO_HANDLER flag
> >   powerpc/eeh: Convert PNV_PHB_FLAG_EEH to global flag
> >   powerpc/eeh: Improve debug messages around device addition
> >   powerpc/eeh: Add eeh_show_enabled()
> >   powerpc/eeh: Initialize EEH address cache earlier
> >   powerpc/eeh: EEH for pSeries hot plug
> >   powerpc/eeh: Remove eeh_probe_devices() and eeh_addr_cache_build()
> >=20
> >  arch/powerpc/include/asm/eeh.h               | 19 +++--
> >  arch/powerpc/kernel/eeh.c                    | 33 ++++-----
> >  arch/powerpc/kernel/eeh_cache.c              | 29 +-------
> >  arch/powerpc/kernel/eeh_driver.c             |  4 ++
> >  arch/powerpc/kernel/of_platform.c            |  3 +-
> >  arch/powerpc/kernel/pci-common.c             |  4 --
> >  arch/powerpc/kernel/pci_32.c                 |  4 ++
> >  arch/powerpc/kernel/pci_64.c                 | 12 +++-
> >  arch/powerpc/platforms/powernv/eeh-powernv.c | 41 +++++------
> >  arch/powerpc/platforms/powernv/pci.c         |  7 +-
> >  arch/powerpc/platforms/powernv/pci.h         |  2 -
> >  arch/powerpc/platforms/pseries/eeh_pseries.c | 75 +++++++++++---------
> >  arch/powerpc/platforms/pseries/pci.c         |  7 +-
> >  13 files changed, 122 insertions(+), 118 deletions(-)
> >=20
>=20

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEELWWF8pdtWK5YQRohMX8w6AQl/iIFAlyz/U8ACgkQMX8w6AQl
/iLQ8wf8CiPdRV/cQW+eCE0jj7U069M3krYqrw7lt2BQpqfpFHp7c4FlcsgC7vPa
HZ6/M9RK6iirdtDoskMZRCNyEWCHZ5fx+yWgL4cnERxCtXqCwTWwxfb77k11nr9m
CVysBROUNN5wpxktB3PqQfl96hW8h/dMO0d7MHnhf0gAMTUUFwFj2R2o5fSXixHx
pMBY/rzSzEVwQ1hezi8yyTr+UeK0gZfcvZIblBxUUKDhyH+d4IqBITLfaidTW/LH
X0vSO7R573541DnBcSeA/QGvkOBVsQZtTBmewEqHGa0YY6eOtCvNckl+SD0KRF/j
hjv07OHSz3vG53hRHkw7BS9rTWnbKA==
=re/8
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--

