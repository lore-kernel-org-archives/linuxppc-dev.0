Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFE6C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 03:25:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66F68207E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 03:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66F68207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445GtL3KK5zDqT9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 14:24:58 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 445Grg4HtfzDqSl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 14:23:31 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1M3IPJL112109
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 22:23:29 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qt7rujvya-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 22:23:28 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Fri, 22 Feb 2019 03:23:26 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 22 Feb 2019 03:23:25 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1M3NO7a31260776
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 03:23:24 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7DBD252052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 03:23:24 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id D51495204F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 03:23:23 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 4934BA011F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 14:23:22 +1100 (AEDT)
Date: Fri, 22 Feb 2019 14:23:20 +1100
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/1] powerpc/64: Adjust order in pcibios_init()
References: <f232553753fe148118646c9013a3d962c19b58ec.1550121250.git.sbobroff@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <f232553753fe148118646c9013a3d962c19b58ec.1550121250.git.sbobroff@linux.ibm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-TM-AS-GCONF: 00
x-cbid: 19022203-0012-0000-0000-000002F8B678
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022203-0013-0000-0000-000021304EBF
Message-Id: <20190222032320.GA4334@tungsten.ozlabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-22_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902220020
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

After some consideration, I've decided to post a v2 of this patch that
will make it a bit safer (although I haven't seen any problems with it)
and make it a little easier to refactor some of the EEH code that
interacts with the hooks.

Cheers,
Sam.

On Thu, Feb 14, 2019 at 04:14:42PM +1100, Sam Bobroff wrote:
> The pcibios_init() function for 64 bit PowerPC currently calls
> pci_bus_add_devices() before pcibios_resource_survey(), which seems
> incorrect because it adds devices and attempts to bind their drivers
> before allocating their resources (although no problems seem to be
> apparent).
>=20
> So move the call to pci_bus_add_devices() to after
> pcibios_resource_survey().
>=20
> This will also allow the ppc_md.pcibios_bus_add_device() hooks to
> perform actions that depend on PCI resources, both during rescanning
> (where this is already the case) and at boot time, which should
> support improvements and refactoring.
>=20
> Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
> ---
> Hi everyone,
>=20
> I've tested this on a P9 for both the host and a KVM guest, and the change
> hasn't caused any differences in PCI resource assignments or the general =
boot
> messages.
>=20
> I've also had a go at inspecting most of the code used by pci_bus_add_dev=
ices()
> and pcibios_resource_survey() and it doesn't look like there are going to=
 be
> any changes in behaviour caused by reordering.  It might be worth mention=
ing
> that the hotplug path (see pcibios_finish_adding_to_bus()) already does
> resource allocation before calling pci_bus_add_devices().
>=20
> However, it would be great if someone could test this change on some older
> hardware or comment on wether we should make the same change on 32 bit ma=
chines.
>=20
> Cheers,
> Sam.
>=20
>  arch/powerpc/kernel/pci_64.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
> index 9d8c10d55407..1ce28888dbdb 100644
> --- a/arch/powerpc/kernel/pci_64.c
> +++ b/arch/powerpc/kernel/pci_64.c
> @@ -58,14 +58,16 @@ static int __init pcibios_init(void)
>  	pci_add_flags(PCI_ENABLE_PROC_DOMAINS | PCI_COMPAT_DOMAIN_0);
> =20
>  	/* Scan all of the recorded PCI controllers.  */
> -	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
> +	list_for_each_entry_safe(hose, tmp, &hose_list, list_node)
>  		pcibios_scan_phb(hose);
> -		pci_bus_add_devices(hose->bus);
> -	}
> =20
>  	/* Call common code to handle resource allocation */
>  	pcibios_resource_survey();
> =20
> +	/* Add devices. */
> +	list_for_each_entry_safe(hose, tmp, &hose_list, list_node)
> +		pci_bus_add_devices(hose->bus);
> +
>  	printk(KERN_DEBUG "PCI: Probing PCI hardware done\n");
> =20
>  	return 0;
> --=20
> 2.19.0.2.gcad72f5712
>=20

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEELWWF8pdtWK5YQRohMX8w6AQl/iIFAlxvayIACgkQMX8w6AQl
/iK0bAgAks80BB1EM2TmHimbi25kOisNzoBglirGYVg1gE6dQMorAp5XtAMcy/wz
mDwwxuHZ06LaoADHFVMomw9g13Pgyot54lqxywz+rIRLzXeAtw5WVzeEsixsRqBC
Hu9N1bLHJrfcD/wF2fdPHj7x1QFMrY9Hwaf9HaBa6+akZevAxnU1CpATSD+qp4SN
4AlAwdj6qLU4iLV04MgmSSEQe8Nbt/9XQ2rbZlNYj7rZep9SY4EoOla5KYqXeLrB
+3orwATGcuknpCsdnLGaHvkeL4z+9fr2MJ8mCx8j64Jw2G7yg2KlgzLWGPrlmBqa
wjf8bVi+14x5eLWiNIJqRHssyPWzxg==
=WrfT
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--

