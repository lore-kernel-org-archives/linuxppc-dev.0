Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6B1C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 05:35:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 917BF207E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 05:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 917BF207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445Kn73syfzDqV3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 16:35:39 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 445KlD026wzDqPj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 16:33:59 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1M5TSA0144376
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 00:33:55 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qta38a17y-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 00:33:55 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Fri, 22 Feb 2019 05:33:53 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 22 Feb 2019 05:33:51 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1M5Xod832505920
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 22 Feb 2019 05:33:51 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DBEC9A405D;
 Fri, 22 Feb 2019 05:33:50 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 46452A405B;
 Fri, 22 Feb 2019 05:33:50 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 22 Feb 2019 05:33:50 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 3E32CA0138;
 Fri, 22 Feb 2019 16:33:49 +1100 (AEDT)
Date: Fri, 22 Feb 2019 16:33:48 +1100
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: Oliver <oohall@gmail.com>
Subject: Re: [PATCH 1/1] powerpc/64: Adjust order in pcibios_init()
References: <f232553753fe148118646c9013a3d962c19b58ec.1550121250.git.sbobroff@linux.ibm.com>
 <20190222032320.GA4334@tungsten.ozlabs.ibm.com>
 <CAOSf1CFezjdgu1idFXmGoXUof0kPyAFcii30MMXXiuoVj0mJ7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
Content-Disposition: inline
In-Reply-To: <CAOSf1CFezjdgu1idFXmGoXUof0kPyAFcii30MMXXiuoVj0mJ7w@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-TM-AS-GCONF: 00
x-cbid: 19022205-0028-0000-0000-0000034B94A8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022205-0029-0000-0000-00002409DBF3
Message-Id: <20190222053347.GB4334@tungsten.ozlabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-22_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902220036
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2019 at 03:31:57PM +1100, Oliver wrote:
> On Fri, Feb 22, 2019 at 2:24 PM Sam Bobroff <sbobroff@linux.ibm.com> wrot=
e:
> >
> > Hey all,
> >
> > After some consideration, I've decided to post a v2 of this patch that
> > will make it a bit safer (although I haven't seen any problems with it)
> > and make it a little easier to refactor some of the EEH code that
> > interacts with the hooks.
>=20
> Can you be a little more specific?

Sure:

When the original patch moves pci_bus_add_devices() to after
pcibios_resource_survey(), this also causes the pcibios_fixup hook
to move, because it's called at the end of pcibios_resource_survey().

So pcibios_fixup would run before pcibios_bus_add_device and while I
don't think that will actually cause problems, there doesn't seem to be
any reason to change the order either. So, I think it would be better
to extract the pcibios_fixup hook out of pcibios_resource_survey() and
call it from pcibios_init after the devices are added, preserving that
ordering.

That's the general reasoning but more specifically, I want to refactor
the EEH code around adding devices, and it seems like I'm going to
need the handlers in that order so that pcibios_bus_add_device() can
probe for EEH support in devices before the EEH post init code needs to
know if any were found.

> > Cheers,
> > Sam.
> >
> > On Thu, Feb 14, 2019 at 04:14:42PM +1100, Sam Bobroff wrote:
> > > The pcibios_init() function for 64 bit PowerPC currently calls
> > > pci_bus_add_devices() before pcibios_resource_survey(), which seems
> > > incorrect because it adds devices and attempts to bind their drivers
> > > before allocating their resources (although no problems seem to be
> > > apparent).
> > >
> > > So move the call to pci_bus_add_devices() to after
> > > pcibios_resource_survey().
> > >
> > > This will also allow the ppc_md.pcibios_bus_add_device() hooks to
> > > perform actions that depend on PCI resources, both during rescanning
> > > (where this is already the case) and at boot time, which should
> > > support improvements and refactoring.
> > >
> > > Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
> > > ---
> > > Hi everyone,
> > >
> > > I've tested this on a P9 for both the host and a KVM guest, and the c=
hange
> > > hasn't caused any differences in PCI resource assignments or the gene=
ral boot
> > > messages.
> > >
> > > I've also had a go at inspecting most of the code used by pci_bus_add=
_devices()
> > > and pcibios_resource_survey() and it doesn't look like there are goin=
g to be
> > > any changes in behaviour caused by reordering.  It might be worth men=
tioning
> > > that the hotplug path (see pcibios_finish_adding_to_bus()) already do=
es
> > > resource allocation before calling pci_bus_add_devices().
> > >
> > > However, it would be great if someone could test this change on some =
older
> > > hardware or comment on wether we should make the same change on 32 bi=
t machines.
> > >
> > > Cheers,
> > > Sam.
> > >
> > >  arch/powerpc/kernel/pci_64.c | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_6=
4.c
> > > index 9d8c10d55407..1ce28888dbdb 100644
> > > --- a/arch/powerpc/kernel/pci_64.c
> > > +++ b/arch/powerpc/kernel/pci_64.c
> > > @@ -58,14 +58,16 @@ static int __init pcibios_init(void)
> > >       pci_add_flags(PCI_ENABLE_PROC_DOMAINS | PCI_COMPAT_DOMAIN_0);
> > >
> > >       /* Scan all of the recorded PCI controllers.  */
> > > -     list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
> > > +     list_for_each_entry_safe(hose, tmp, &hose_list, list_node)
> > >               pcibios_scan_phb(hose);
> > > -             pci_bus_add_devices(hose->bus);
> > > -     }
> > >
> > >       /* Call common code to handle resource allocation */
> > >       pcibios_resource_survey();
> > >
> > > +     /* Add devices. */
> > > +     list_for_each_entry_safe(hose, tmp, &hose_list, list_node)
> > > +             pci_bus_add_devices(hose->bus);
> > > +
> > >       printk(KERN_DEBUG "PCI: Probing PCI hardware done\n");
> > >
> > >       return 0;
> > > --
> > > 2.19.0.2.gcad72f5712
> > >
>=20

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEELWWF8pdtWK5YQRohMX8w6AQl/iIFAlxvibUACgkQMX8w6AQl
/iK5BQf/cXBz54Reqx33EFqFoSs1UXJl2xZm2ADNTZsst+so0Obc2Tqp+P2RSrzR
FVLCmj0GU/iMX6ZhJJJtgr+2aQrtkphde9Znh22VqfrwS0eJn5l0hrvFfALFZl0t
R0juFFJ71gbyKmpyMkG8/TkgbWimxB69198fx/btdftnYLX7OelT2QpU4E9ZsuoL
SqRJYmeay8J1vTMUZdB7yaodIC9rymnKFitD3lbg0P9xJwHa64bh1JvIqgj4i7aJ
ovXoFm0CJlCkQZmBwQSKJ0gk/3IC2ht9p5aCvOS1Zte7CaF6I1G4FJsS32c34rWw
6vU/s4tu/8g5jyugfU2m8UNbT3CqHw==
=Vrbe
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--

