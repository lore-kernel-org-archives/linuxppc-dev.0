Return-Path: <SRS0=vwdz=N7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FC6C43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 03:54:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD86520831
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 03:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD86520831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42zWzH4yzczF3Rd
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 14:54:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42zWwV5m78zF3LM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 14:51:38 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAK3n8pk094451
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2018 22:51:36 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2nv5uaj043-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2018 22:51:35 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Tue, 20 Nov 2018 03:51:33 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 20 Nov 2018 03:51:30 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAK3pToO57540688
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 20 Nov 2018 03:51:29 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3BF5F11C05B;
 Tue, 20 Nov 2018 03:51:29 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9AFF111C04C;
 Tue, 20 Nov 2018 03:51:28 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 20 Nov 2018 03:51:28 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 89D22A01E8;
 Tue, 20 Nov 2018 14:51:25 +1100 (AEDT)
Date: Tue, 20 Nov 2018 14:51:24 +1100
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH kernel] powerpc/powernv/eeh/npu: Fix uninitialized
 variables in opal_pci_eeh_freeze_status
References: <20181119042517.45075-1-aik@ozlabs.ru>
 <877eh831id.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Content-Disposition: inline
In-Reply-To: <877eh831id.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-TM-AS-GCONF: 00
x-cbid: 18112003-0020-0000-0000-000002EA9B5D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112003-0021-0000-0000-00002139CAF0
Message-Id: <20181120035123.GB9175@tungsten.ozlabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-20_01:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=18 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811200032
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 Oliver O'Halloran <oohall@gmail.com>, Reza Arbab <arbab@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 20, 2018 at 01:51:06PM +1100, Michael Ellerman wrote:
> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
>=20
> > The current implementation of the OPAL_PCI_EEH_FREEZE_STATUS call in
> > skiboot's NPU driver does not touch the pci_error_type parameter so
> > it might have garbage but the powernv code analyzes it nevertheless.
> >
> > This initializes pcierr and fstate to zero in all call sites.
> >
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > ---
>=20
> Can we tag this with a Fixes? And seems like it should probably go to
> stable, or can we not trigger this path on older kernels?
>=20
> cheers

Hmm, it's triggered by use on an NPU PE so that would be any kernel that
can run on P8 or later (AFAIK).

It looks like the issue was present earlier, but the code was last
touched when it was moved, in...

40ae5f693f6a ("powerpc/powernv: Drop PHB operation get_state()")

=2E.. which was back in v4.1.

Sam.

> > Without this, this happens:
> >
> > pnv_eeh_get_phb_diag: Failure -7 getting PHB#6 diag-data
> > EEH: PHB#6 failure detected, location: N/A
> > CPU: 23 PID: 5939 Comm: qemu-system-ppc Not tainted 4.19.0-le_f5a7bb7_a=
ikATfstn1-p1 torvalds#106
> > Call Trace:
> > [c000003fea9df9c0] [c000000000a990ec] dump_stack+0xb0/0xf4 (unreliable)
> > [c000003fea9dfa00] [c000000000038480] eeh_dev_check_failure+0x1f0/0x5f0
> > [c000003fea9dfaa0] [c0000000000a2768] pnv_pci_read_config+0x128/0x160
> > [c000003fea9dfae0] [c0000000005d2b0c] pci_bus_read_config_dword+0x9c/0x=
f0
> > [c000003fea9dfb40] [c0000000005df3d4] pci_save_state+0x64/0x250
> > [c000003fea9dfbc0] [c0000000005e0730] pci_dev_save_and_disable+0x70/0xa0
> > [c000003fea9dfbf0] [c0000000005e4078] pci_try_reset_function+0x48/0xc0
> > [c000003fea9dfc20] [c00800001cbc1b1c] vfio_pci_ioctl+0x334/0xea0 [vfio_=
pci]
> > [c000003fea9dfcf0] [c00800001ca9046c] vfio_device_fops_unl_ioctl+0x44/0=
x70 [vfio]
> > [c000003fea9dfd10] [c00000000039fd84] do_vfs_ioctl+0xd4/0xa00
> > [c000003fea9dfdb0] [c0000000003a07b4] ksys_ioctl+0x104/0x120
> > [c000003fea9dfe00] [c0000000003a07f8] sys_ioctl+0x28/0x80
> > [c000003fea9dfe20] [c00000000000b3a4] system_call+0x5c/0x70
> > EEH: Detected error on PHB#6
> > EEH: This PCI device has failed 1 times in the last hour and will be pe=
rmanently disabled after 5 fail
> > ures.
> > EEH: Notify device drivers to shutdown
> > EEH: Beginning: 'error_detected(IO frozen)'
> > EEH: PE#d (PCI 0006:00:00.0): not actionable (1,1,0)
> > EEH: PE#d (PCI 0006:00:00.1): not actionable (1,1,0)
> > EEH: PE#c (PCI 0006:00:01.0): Invoking vfio-pci->error_detected(IO froz=
en)
> > EEH: PE#c (PCI 0006:00:01.0): vfio-pci driver reports: 'can recover'
> > EEH: PE#c (PCI 0006:00:01.1): Invoking vfio-pci->error_detected(IO froz=
en)
> > EEH: PE#c (PCI 0006:00:01.1): vfio-pci driver reports: 'can recover'
> > EEH: PE#b (PCI 0006:00:02.0): Invoking vfio-pci->error_detected(IO froz=
en)
> > EEH: PE#b (PCI 0006:00:02.0): vfio-pci driver reports: 'can recover'
> > EEH: PE#b (PCI 0006:00:02.1): Invoking vfio-pci->error_detected(IO froz=
en)
> > EEH: PE#b (PCI 0006:00:02.1): vfio-pci driver reports: 'can recover'
> > EEH: Finished:'error_detected(IO frozen)' with aggregate recovery state=
:'can recover'
> > EEH: Collect temporary log
> > pnv_pci_dump_phb_diag_data: Unrecognized ioType 0
> > EEH: Reset without hotplug activity
> > iommu: Removing device 0006:00:01.0 from group 4
> > iommu: Removing device 0006:00:01.1 from group 4
> > iommu: Removing device 0006:00:02.0 from group 4
> > iommu: Removing device 0006:00:02.1 from group 4
> > pnv_ioda_freeze_pe: Failure -7 freezing PHB#6-PE#0
> > pnv_eeh_restore_config: Can't reinit PCI dev 0x0 (-7)
> > pnv_eeh_restore_config: Can't reinit PCI dev 0x1 (-7)
> > pnv_eeh_restore_config: Can't reinit PCI dev 0x8 (-7)
> > pnv_eeh_restore_config: Can't reinit PCI dev 0x9 (-7)
> > pnv_eeh_restore_config: Can't reinit PCI dev 0x10 (-7)
> > pnv_eeh_restore_config: Can't reinit PCI dev 0x11 (-7)
> > pnv_eeh_restore_config: Can't reinit PCI dev 0x0 (-7)
> > pnv_eeh_restore_config: Can't reinit PCI dev 0x1 (-7)
> > pnv_eeh_restore_config: Can't reinit PCI dev 0x8 (-7)
> > pnv_eeh_restore_config: Can't reinit PCI dev 0x9 (-7)
> > pnv_eeh_restore_config: Can't reinit PCI dev 0x10 (-7)
> > pnv_eeh_restore_config: Can't reinit PCI dev 0x11 (-7)
> > EEH: Sleep 5s ahead of partial hotplug
> > pci 0004:04     : [PE# 00] Setting up window#0 0..3fffffff pg=3D1000
> > pci 0004:05     : [PE# 18] Setting up window#0 0..3fffffff pg=3D1000
> > pci 0004:06     : [PE# 30] Setting up window#0 0..3fffffff pg=3D1000
> > pci 0006:00:00.0: [PE# 0d] Setting up window 0..3fffffff pg=3D1000
> > pci 0006:00:01.0: [PE# 0c] Setting up window 0..3fffffff pg=3D1000
> > pci 0006:00:02.0: [PE# 0b] Setting up window 0..3fffffff pg=3D1000
> > EEH: Beginning: 'slot_reset'
> > EEH: PE#d (PCI 0006:00:00.0): not actionable (1,1,0)
> > EEH: PE#d (PCI 0006:00:00.1): not actionable (1,1,0)
> > EEH: Finished:'slot_reset' with aggregate recovery state:'none'
> > EEH: Notify device driver to resume
> > EEH: Beginning: 'resume'
> > EEH: PE#d (PCI 0006:00:00.0): not actionable (1,1,0)
> > EEH: PE#d (PCI 0006:00:00.1): not actionable (1,1,0)
> > EEH: Finished:'resume'
> > EEH: Recovery successful.
> > ---
> >  arch/powerpc/platforms/powernv/eeh-powernv.c | 8 ++++----
> >  arch/powerpc/platforms/powernv/pci-ioda.c    | 4 ++--
> >  arch/powerpc/platforms/powernv/pci.c         | 4 ++--
> >  3 files changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerp=
c/platforms/powernv/eeh-powernv.c
> > index abc0be7..f380789 100644
> > --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
> > +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
> > @@ -564,8 +564,8 @@ static void pnv_eeh_get_phb_diag(struct eeh_pe *pe)
> >  static int pnv_eeh_get_phb_state(struct eeh_pe *pe)
> >  {
> >  	struct pnv_phb *phb =3D pe->phb->private_data;
> > -	u8 fstate;
> > -	__be16 pcierr;
> > +	u8 fstate =3D 0;
> > +	__be16 pcierr =3D 0;
> >  	s64 rc;
> >  	int result =3D 0;
> > =20
> > @@ -603,8 +603,8 @@ static int pnv_eeh_get_phb_state(struct eeh_pe *pe)
> >  static int pnv_eeh_get_pe_state(struct eeh_pe *pe)
> >  {
> >  	struct pnv_phb *phb =3D pe->phb->private_data;
> > -	u8 fstate;
> > -	__be16 pcierr;
> > +	u8 fstate =3D 0;
> > +	__be16 pcierr =3D 0;
> >  	s64 rc;
> >  	int result;
> > =20
> > diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/p=
latforms/powernv/pci-ioda.c
> > index dd80744..72b5cc0 100644
> > --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> > +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> > @@ -604,8 +604,8 @@ static int pnv_ioda_unfreeze_pe(struct pnv_phb *phb=
, int pe_no, int opt)
> >  static int pnv_ioda_get_pe_state(struct pnv_phb *phb, int pe_no)
> >  {
> >  	struct pnv_ioda_pe *slave, *pe;
> > -	u8 fstate, state;
> > -	__be16 pcierr;
> > +	u8 fstate =3D 0, state;
> > +	__be16 pcierr =3D 0;
> >  	s64 rc;
> > =20
> >  	/* Sanity check on PE number */
> > diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platfo=
rms/powernv/pci.c
> > index 13aef23..db230a35 100644
> > --- a/arch/powerpc/platforms/powernv/pci.c
> > +++ b/arch/powerpc/platforms/powernv/pci.c
> > @@ -602,8 +602,8 @@ static void pnv_pci_handle_eeh_config(struct pnv_ph=
b *phb, u32 pe_no)
> >  static void pnv_pci_config_check_eeh(struct pci_dn *pdn)
> >  {
> >  	struct pnv_phb *phb =3D pdn->phb->private_data;
> > -	u8	fstate;
> > -	__be16	pcierr;
> > +	u8	fstate =3D 0;
> > +	__be16	pcierr =3D 0;
> >  	unsigned int pe_no;
> >  	s64	rc;
> > =20
> > --=20
> > 2.17.1
>=20

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEELWWF8pdtWK5YQRohMX8w6AQl/iIFAlvzhLYACgkQMX8w6AQl
/iJzwQgAmqNlpbu2uErEkblR+QgtylVC7BKrI3OJkmR5a8A1cKEFppFUNSGnLqZx
ItEV3EBe9se9jF14QcTamtgR1vO0fMJDsVlYYTx0cGw4q5hmjxcQxu8v8Rc5wS6S
5FARtgGLJtn5f2x6ZO62tElFSoZUK7Vmq5IH4bRGuFi198lXIGzaiXEcuLFZfDOo
O8G17kohofYV9lWV1HNqw7LvQuz2B9dF4L8P7sgX1eWyCuqfTaEeH1kC4A5hMH/N
7ZjnyNVsVzJytmZocuGV85aitMf0u0Q3l6NRPunNXPbGcqTf+OsKeoOdtTMYv1AO
Lrc6YTQ7DSWNdkm4W+QM1KRd1H96SA==
=ewwj
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--

