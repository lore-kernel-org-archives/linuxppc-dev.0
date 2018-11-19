Return-Path: <SRS0=K8Qv=N6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A681CC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 23:30:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2976020851
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 23:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2976020851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42zQ7W0HWSzF20f
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 10:30:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42zQ4g6CcHzF3Sx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 10:28:19 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAJNNx1j073463
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2018 18:28:17 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2nv572ukey-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2018 18:28:16 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Mon, 19 Nov 2018 23:28:15 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 19 Nov 2018 23:28:11 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAJNSBED51183740
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 19 Nov 2018 23:28:11 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 00A0DAE057;
 Mon, 19 Nov 2018 23:28:11 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 557CAAE055;
 Mon, 19 Nov 2018 23:28:10 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 19 Nov 2018 23:28:10 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id E1579A01E8;
 Tue, 20 Nov 2018 10:28:08 +1100 (AEDT)
Date: Tue, 20 Nov 2018 10:28:07 +1100
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel] powerpc/powernv/eeh/npu: Fix uninitialized
 variables in opal_pci_eeh_freeze_status
References: <20181119042517.45075-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <20181119042517.45075-1-aik@ozlabs.ru>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-TM-AS-GCONF: 00
x-cbid: 18111923-4275-0000-0000-000002E37DCD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111923-4276-0000-0000-000037F0A257
Message-Id: <20181119232807.GA9175@tungsten.ozlabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-19_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=18 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811190205
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
Cc: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 Oliver O'Halloran <oohall@gmail.com>, Reza Arbab <arbab@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 19, 2018 at 03:25:17PM +1100, Alexey Kardashevskiy wrote:
> The current implementation of the OPAL_PCI_EEH_FREEZE_STATUS call in
> skiboot's NPU driver does not touch the pci_error_type parameter so
> it might have garbage but the powernv code analyzes it nevertheless.
>=20
> This initializes pcierr and fstate to zero in all call sites.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

The skiboot code for npu2_freeze_status() is just:

	*freeze_state =3D OPAL_EEH_STOPPED_NOT_FROZEN;
	return OPAL_SUCCESS;

It looks like npu_freeze_status() is affected as well. I think we
could consider these skiboot bugs, but this still seems like an
improvement.

Reviewed-by: Sam Bobroff <sbobroff@linux.ibm.com>

> ---
>=20
> Without this, this happens:
>=20
> pnv_eeh_get_phb_diag: Failure -7 getting PHB#6 diag-data
> EEH: PHB#6 failure detected, location: N/A
> CPU: 23 PID: 5939 Comm: qemu-system-ppc Not tainted 4.19.0-le_f5a7bb7_aik=
ATfstn1-p1 torvalds#106
> Call Trace:
> [c000003fea9df9c0] [c000000000a990ec] dump_stack+0xb0/0xf4 (unreliable)
> [c000003fea9dfa00] [c000000000038480] eeh_dev_check_failure+0x1f0/0x5f0
> [c000003fea9dfaa0] [c0000000000a2768] pnv_pci_read_config+0x128/0x160
> [c000003fea9dfae0] [c0000000005d2b0c] pci_bus_read_config_dword+0x9c/0xf0
> [c000003fea9dfb40] [c0000000005df3d4] pci_save_state+0x64/0x250
> [c000003fea9dfbc0] [c0000000005e0730] pci_dev_save_and_disable+0x70/0xa0
> [c000003fea9dfbf0] [c0000000005e4078] pci_try_reset_function+0x48/0xc0
> [c000003fea9dfc20] [c00800001cbc1b1c] vfio_pci_ioctl+0x334/0xea0 [vfio_pc=
i]
> [c000003fea9dfcf0] [c00800001ca9046c] vfio_device_fops_unl_ioctl+0x44/0x7=
0 [vfio]
> [c000003fea9dfd10] [c00000000039fd84] do_vfs_ioctl+0xd4/0xa00
> [c000003fea9dfdb0] [c0000000003a07b4] ksys_ioctl+0x104/0x120
> [c000003fea9dfe00] [c0000000003a07f8] sys_ioctl+0x28/0x80
> [c000003fea9dfe20] [c00000000000b3a4] system_call+0x5c/0x70
> EEH: Detected error on PHB#6
> EEH: This PCI device has failed 1 times in the last hour and will be perm=
anently disabled after 5 fail
> ures.
> EEH: Notify device drivers to shutdown
> EEH: Beginning: 'error_detected(IO frozen)'
> EEH: PE#d (PCI 0006:00:00.0): not actionable (1,1,0)
> EEH: PE#d (PCI 0006:00:00.1): not actionable (1,1,0)
> EEH: PE#c (PCI 0006:00:01.0): Invoking vfio-pci->error_detected(IO frozen)
> EEH: PE#c (PCI 0006:00:01.0): vfio-pci driver reports: 'can recover'
> EEH: PE#c (PCI 0006:00:01.1): Invoking vfio-pci->error_detected(IO frozen)
> EEH: PE#c (PCI 0006:00:01.1): vfio-pci driver reports: 'can recover'
> EEH: PE#b (PCI 0006:00:02.0): Invoking vfio-pci->error_detected(IO frozen)
> EEH: PE#b (PCI 0006:00:02.0): vfio-pci driver reports: 'can recover'
> EEH: PE#b (PCI 0006:00:02.1): Invoking vfio-pci->error_detected(IO frozen)
> EEH: PE#b (PCI 0006:00:02.1): vfio-pci driver reports: 'can recover'
> EEH: Finished:'error_detected(IO frozen)' with aggregate recovery state:'=
can recover'
> EEH: Collect temporary log
> pnv_pci_dump_phb_diag_data: Unrecognized ioType 0
> EEH: Reset without hotplug activity
> iommu: Removing device 0006:00:01.0 from group 4
> iommu: Removing device 0006:00:01.1 from group 4
> iommu: Removing device 0006:00:02.0 from group 4
> iommu: Removing device 0006:00:02.1 from group 4
> pnv_ioda_freeze_pe: Failure -7 freezing PHB#6-PE#0
> pnv_eeh_restore_config: Can't reinit PCI dev 0x0 (-7)
> pnv_eeh_restore_config: Can't reinit PCI dev 0x1 (-7)
> pnv_eeh_restore_config: Can't reinit PCI dev 0x8 (-7)
> pnv_eeh_restore_config: Can't reinit PCI dev 0x9 (-7)
> pnv_eeh_restore_config: Can't reinit PCI dev 0x10 (-7)
> pnv_eeh_restore_config: Can't reinit PCI dev 0x11 (-7)
> pnv_eeh_restore_config: Can't reinit PCI dev 0x0 (-7)
> pnv_eeh_restore_config: Can't reinit PCI dev 0x1 (-7)
> pnv_eeh_restore_config: Can't reinit PCI dev 0x8 (-7)
> pnv_eeh_restore_config: Can't reinit PCI dev 0x9 (-7)
> pnv_eeh_restore_config: Can't reinit PCI dev 0x10 (-7)
> pnv_eeh_restore_config: Can't reinit PCI dev 0x11 (-7)
> EEH: Sleep 5s ahead of partial hotplug
> pci 0004:04     : [PE# 00] Setting up window#0 0..3fffffff pg=3D1000
> pci 0004:05     : [PE# 18] Setting up window#0 0..3fffffff pg=3D1000
> pci 0004:06     : [PE# 30] Setting up window#0 0..3fffffff pg=3D1000
> pci 0006:00:00.0: [PE# 0d] Setting up window 0..3fffffff pg=3D1000
> pci 0006:00:01.0: [PE# 0c] Setting up window 0..3fffffff pg=3D1000
> pci 0006:00:02.0: [PE# 0b] Setting up window 0..3fffffff pg=3D1000
> EEH: Beginning: 'slot_reset'
> EEH: PE#d (PCI 0006:00:00.0): not actionable (1,1,0)
> EEH: PE#d (PCI 0006:00:00.1): not actionable (1,1,0)
> EEH: Finished:'slot_reset' with aggregate recovery state:'none'
> EEH: Notify device driver to resume
> EEH: Beginning: 'resume'
> EEH: PE#d (PCI 0006:00:00.0): not actionable (1,1,0)
> EEH: PE#d (PCI 0006:00:00.1): not actionable (1,1,0)
> EEH: Finished:'resume'
> EEH: Recovery successful.
> ---
>  arch/powerpc/platforms/powernv/eeh-powernv.c | 8 ++++----
>  arch/powerpc/platforms/powernv/pci-ioda.c    | 4 ++--
>  arch/powerpc/platforms/powernv/pci.c         | 4 ++--
>  3 files changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/=
platforms/powernv/eeh-powernv.c
> index abc0be7..f380789 100644
> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
> @@ -564,8 +564,8 @@ static void pnv_eeh_get_phb_diag(struct eeh_pe *pe)
>  static int pnv_eeh_get_phb_state(struct eeh_pe *pe)
>  {
>  	struct pnv_phb *phb =3D pe->phb->private_data;
> -	u8 fstate;
> -	__be16 pcierr;
> +	u8 fstate =3D 0;
> +	__be16 pcierr =3D 0;
>  	s64 rc;
>  	int result =3D 0;
> =20
> @@ -603,8 +603,8 @@ static int pnv_eeh_get_phb_state(struct eeh_pe *pe)
>  static int pnv_eeh_get_pe_state(struct eeh_pe *pe)
>  {
>  	struct pnv_phb *phb =3D pe->phb->private_data;
> -	u8 fstate;
> -	__be16 pcierr;
> +	u8 fstate =3D 0;
> +	__be16 pcierr =3D 0;
>  	s64 rc;
>  	int result;
> =20
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index dd80744..72b5cc0 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -604,8 +604,8 @@ static int pnv_ioda_unfreeze_pe(struct pnv_phb *phb, =
int pe_no, int opt)
>  static int pnv_ioda_get_pe_state(struct pnv_phb *phb, int pe_no)
>  {
>  	struct pnv_ioda_pe *slave, *pe;
> -	u8 fstate, state;
> -	__be16 pcierr;
> +	u8 fstate =3D 0, state;
> +	__be16 pcierr =3D 0;
>  	s64 rc;
> =20
>  	/* Sanity check on PE number */
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platform=
s/powernv/pci.c
> index 13aef23..db230a35 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -602,8 +602,8 @@ static void pnv_pci_handle_eeh_config(struct pnv_phb =
*phb, u32 pe_no)
>  static void pnv_pci_config_check_eeh(struct pci_dn *pdn)
>  {
>  	struct pnv_phb *phb =3D pdn->phb->private_data;
> -	u8	fstate;
> -	__be16	pcierr;
> +	u8	fstate =3D 0;
> +	__be16	pcierr =3D 0;
>  	unsigned int pe_no;
>  	s64	rc;
> =20
> --=20
> 2.17.1
>=20

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEELWWF8pdtWK5YQRohMX8w6AQl/iIFAlvzRwEACgkQMX8w6AQl
/iIXiwf9ExbJnd4XH/JnTzeZjdPVrk8qR+R16+aCbmbjxdy3+/LxuVP/WJLzlhne
AUY5ubkMNZeLc621NLIMwNq9NguQpgKHYIvHiY4ykxj3LG6yrwEcHqsRVJMuA5IM
PsY+ZX6cW9VNoZCocSw/+SRna5RT7Dl5nFMcxfinE1tN1aOq8libxGp9xPGQjp7F
eXn9ySUHpD8p0ak5qDVdsasQjIv3JkR+y2Oq1LYIErZ88c/ftyzGAdU54VkdMfjo
4H+bJDKIdI3pZfv+/ir3fZ6fjjKw6PC1bZL9DibrhQOX5FFS2theE4xQ1TR4d6hZ
BYNJYQXJF6rUNji3hw/Di35pl93pQA==
=+3gn
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--

