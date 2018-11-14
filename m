Return-Path: <SRS0=Q8z7=NZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607EBC43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 04:30:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BB9D2145D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 04:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB9D2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=popple.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42vs4N17JkzF3Ny
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 15:30:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=popple.id.au
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=popple.id.au
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=alistair@popple.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=popple.id.au
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42vs283jmqzF3Kq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 15:28:48 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAE4Pk49098819
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2018 23:28:46 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2nr7dpbfe4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2018 23:28:45 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alistair@popple.id.au>;
 Wed, 14 Nov 2018 04:28:43 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 14 Nov 2018 04:28:41 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAE4SdTs65994812
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 14 Nov 2018 04:28:39 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C92A4C04E;
 Wed, 14 Nov 2018 04:28:39 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D014F4C04A;
 Wed, 14 Nov 2018 04:28:38 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 14 Nov 2018 04:28:38 +0000 (GMT)
Received: from townsend.localnet (unknown [9.81.197.93])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id A9C45A01D5;
 Wed, 14 Nov 2018 15:28:36 +1100 (AEDT)
From: Alistair Popple <alistair@popple.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v3 06/22] powerpc/powernv: Detach npu struct from
 pnv_phb
Date: Wed, 14 Nov 2018 15:28:36 +1100
User-Agent: KMail/5.2.3 (Linux/4.18.0-0.bpo.1-amd64; KDE/5.28.0; x86_64; ; )
In-Reply-To: <20181113082823.2440-7-aik@ozlabs.ru>
References: <20181113082823.2440-1-aik@ozlabs.ru>
 <20181113082823.2440-7-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
x-cbid: 18111404-0008-0000-0000-000002927B51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111404-0009-0000-0000-000021FC8E36
Message-Id: <1686227.ptHs0ZEO6U@townsend>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-14_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=18 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=541 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811140038
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

Hi Alexey,

On Tuesday, 13 November 2018 7:28:07 PM AEDT Alexey Kardashevskiy wrote:
>  static struct npu *npdev_to_npu(struct pci_dev *npdev)
>  {
> -	struct pnv_phb *nphb;
> +	struct pci_controller *hose = pci_bus_to_host(npdev->bus);
> +	struct npu *npu;
> 
> -	nphb = pci_bus_to_host(npdev->bus)->private_data;
> +	list_for_each_entry(npu, &npu2_devices, next)

This is called from the ATSD path which is (or at least has been) quite a 
performance critical path so searching through all the NPUs in a list may be 
problematic.

I guess currently it wont make any practical difference as we only ever have 2 
NPUs, but in future they may get divided into more logical NPUs. Would it be 
possible to store a back-pointer somewhere so we can avoid the lookup?

> +		if (hose == npu->hose)
> +			return npu;
> 
> -	return &nphb->npu;
> +	WARN_ON_ONCE(1);
> +	return NULL;
>  }
> 
>  /* Maximum number of nvlinks per npu */
> @@ -505,6 +531,9 @@ static void acquire_atsd_reg(struct npu_context
> *npu_context, continue;
> 
>  			npu = npdev_to_npu(npdev);
> +			if (!npu)
> +				continue;
> +
>  			mmio_atsd_reg[i].npu = npu;
>  			mmio_atsd_reg[i].reg = get_mmio_atsd_reg(npu);
>  			while (mmio_atsd_reg[i].reg < 0) {
> @@ -701,6 +730,8 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev
> *gpdev,
> 
>  	nphb = pci_bus_to_host(npdev->bus)->private_data;
>  	npu = npdev_to_npu(npdev);
> +	if (!npu)
> +		return ERR_PTR(-ENODEV);
> 
>  	/*
>  	 * Setup the NPU context table for a particular GPU. These need to be
> @@ -821,6 +852,8 @@ void pnv_npu2_destroy_context(struct npu_context
> *npu_context,
> 
>  	nphb = pci_bus_to_host(npdev->bus)->private_data;
>  	npu = npdev_to_npu(npdev);
> +	if (!npu)
> +		return;
>  	nvlink_dn = of_parse_phandle(npdev->dev.of_node, "ibm,nvlink", 0);
>  	if (WARN_ON(of_property_read_u32(nvlink_dn, "ibm,npu-link-index",
>  							&nvlink_index)))
> @@ -898,9 +931,15 @@ int pnv_npu2_init(struct pnv_phb *phb)
>  	struct pci_dev *gpdev;
>  	static int npu_index;
>  	uint64_t rc = 0;
> +	struct pci_controller *hose = phb->hose;
> +	struct npu *npu;
> +	int ret;
> 
> -	phb->npu.nmmu_flush =
> -		of_property_read_bool(phb->hose->dn, "ibm,nmmu-flush");
> +	npu = kzalloc(sizeof(*npu), GFP_KERNEL);
> +	if (!npu)
> +		return -ENOMEM;
> +
> +	npu->nmmu_flush = of_property_read_bool(hose->dn, "ibm,nmmu-flush");
>  	for_each_child_of_node(phb->hose->dn, dn) {
>  		gpdev = pnv_pci_get_gpu_dev(get_pci_dev(dn));
>  		if (gpdev) {
> @@ -914,18 +953,31 @@ int pnv_npu2_init(struct pnv_phb *phb)
>  		}
>  	}
> 
> -	for (i = 0; !of_property_read_u64_index(phb->hose->dn, "ibm,mmio-atsd",
> +	for (i = 0; !of_property_read_u64_index(hose->dn, "ibm,mmio-atsd",
>  							i, &mmio_atsd); i++)
> -		phb->npu.mmio_atsd_regs[i] = ioremap(mmio_atsd, 32);
> +		npu->mmio_atsd_regs[i] = ioremap(mmio_atsd, 32);
> 
> -	pr_info("NPU%lld: Found %d MMIO ATSD registers", phb->opal_id, i);
> -	phb->npu.mmio_atsd_count = i;
> -	phb->npu.mmio_atsd_usage = 0;
> +	pr_info("NPU%d: Found %d MMIO ATSD registers", hose->global_number, i);
> +	npu->mmio_atsd_count = i;
> +	npu->mmio_atsd_usage = 0;
>  	npu_index++;
> -	if (WARN_ON(npu_index >= NV_MAX_NPUS))
> -		return -ENOSPC;
> +	if (WARN_ON(npu_index >= NV_MAX_NPUS)) {
> +		ret = -ENOSPC;
> +		goto fail_exit;
> +	}
>  	max_npu2_index = npu_index;
> -	phb->npu.index = npu_index;
> +	npu->index = npu_index;
> +	npu->hose = hose;
> +
> +	list_add(&npu->next, &npu2_devices);

Guess we don't need any locking here as the list gets setup once during boot 
long before loading the driver and is never modified right?

- Alistair

>  	return 0;
> +
> +fail_exit:
> +	for (i = 0; i < npu->mmio_atsd_count; ++i)
> +		iounmap(npu->mmio_atsd_regs[i]);
> +
> +	kfree(npu);
> +
> +	return ret;
>  }


