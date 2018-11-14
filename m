Return-Path: <SRS0=Q8z7=NZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698CBC43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 03:44:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35D0C2145D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 03:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35D0C2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=popple.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42vr2c2XkfzF3Qf
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 14:44:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=popple.id.au
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=popple.id.au
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=alistair@popple.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=popple.id.au
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42vr0T4rSczF3LH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 14:42:17 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAE3dCAf062798
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2018 22:42:15 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2nr7drt349-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2018 22:42:14 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alistair@popple.id.au>;
 Wed, 14 Nov 2018 03:42:12 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 14 Nov 2018 03:42:09 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAE3g7nM60686518
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 14 Nov 2018 03:42:07 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BA6565204E;
 Wed, 14 Nov 2018 03:42:07 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 13A8352050;
 Wed, 14 Nov 2018 03:42:07 +0000 (GMT)
Received: from townsend.localnet (unknown [9.81.197.93])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id EC9B1A01D0;
 Wed, 14 Nov 2018 14:42:05 +1100 (AEDT)
From: Alistair Popple <alistair@popple.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v3 05/22] powerpc/powernv/npu: Add helper to access
 struct npu for NPU device
Date: Wed, 14 Nov 2018 14:42:05 +1100
User-Agent: KMail/5.2.3 (Linux/4.18.0-0.bpo.1-amd64; KDE/5.28.0; x86_64; ; )
In-Reply-To: <20181113082823.2440-6-aik@ozlabs.ru>
References: <20181113082823.2440-1-aik@ozlabs.ru>
 <20181113082823.2440-6-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
x-cbid: 18111403-4275-0000-0000-000002E0A2DA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111403-4276-0000-0000-000037EDB45E
Message-Id: <5327772.Kf1u9AHZax@townsend>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-14_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=18 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811140031
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
Cc: Jose Ricardo Ziviani <joserz@linux.ibm.com>,
 Sam Bobroff <sbobroff@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>, kvm-ppc@vger.kernel.org,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Leonardo Augusto =?ISO-8859-1?Q?Guimar=E3es?= Garcia <lagarcia@br.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Reviewed-by: Alistair Popple <alistair@popple.id.au>

On Tuesday, 13 November 2018 7:28:06 PM AEDT Alexey Kardashevskiy wrote:
> This step is to help removing the npu struct from pnv_phb so it
> can be used by pseries as well.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  arch/powerpc/platforms/powernv/npu-dma.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c
> b/arch/powerpc/platforms/powernv/npu-dma.c index 91d488f..9f48831 100644
> --- a/arch/powerpc/platforms/powernv/npu-dma.c
> +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> @@ -327,6 +327,18 @@ struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct
> pnv_ioda_pe *npe) return gpe;
>  }
> 
> +/*
> + * NPU2 ATS
> + */
> +static struct npu *npdev_to_npu(struct pci_dev *npdev)
> +{
> +	struct pnv_phb *nphb;
> +
> +	nphb = pci_bus_to_host(npdev->bus)->private_data;
> +
> +	return &nphb->npu;
> +}
> +
>  /* Maximum number of nvlinks per npu */
>  #define NV_MAX_LINKS 6
> 
> @@ -478,7 +490,6 @@ static void acquire_atsd_reg(struct npu_context
> *npu_context, int i, j;
>  	struct npu *npu;
>  	struct pci_dev *npdev;
> -	struct pnv_phb *nphb;
> 
>  	for (i = 0; i <= max_npu2_index; i++) {
>  		mmio_atsd_reg[i].reg = -1;
> @@ -493,8 +504,7 @@ static void acquire_atsd_reg(struct npu_context
> *npu_context, if (!npdev)
>  				continue;
> 
> -			nphb = pci_bus_to_host(npdev->bus)->private_data;
> -			npu = &nphb->npu;
> +			npu = npdev_to_npu(npdev);
>  			mmio_atsd_reg[i].npu = npu;
>  			mmio_atsd_reg[i].reg = get_mmio_atsd_reg(npu);
>  			while (mmio_atsd_reg[i].reg < 0) {
> @@ -690,7 +700,7 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev
> *gpdev, }
> 
>  	nphb = pci_bus_to_host(npdev->bus)->private_data;
> -	npu = &nphb->npu;
> +	npu = npdev_to_npu(npdev);
> 
>  	/*
>  	 * Setup the NPU context table for a particular GPU. These need to be
> @@ -764,7 +774,7 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev
> *gpdev, */
>  	WRITE_ONCE(npu_context->npdev[npu->index][nvlink_index], npdev);
> 
> -	if (!nphb->npu.nmmu_flush) {
> +	if (!npu->nmmu_flush) {
>  		/*
>  		 * If we're not explicitly flushing ourselves we need to mark
>  		 * the thread for global flushes
> @@ -810,7 +820,7 @@ void pnv_npu2_destroy_context(struct npu_context
> *npu_context, return;
> 
>  	nphb = pci_bus_to_host(npdev->bus)->private_data;
> -	npu = &nphb->npu;
> +	npu = npdev_to_npu(npdev);
>  	nvlink_dn = of_parse_phandle(npdev->dev.of_node, "ibm,nvlink", 0);
>  	if (WARN_ON(of_property_read_u32(nvlink_dn, "ibm,npu-link-index",
>  							&nvlink_index)))


