Return-Path: <SRS0=Q8z7=NZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657BCC43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 04:59:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C14BB21780
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 04:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14BB21780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=popple.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42vsjf0rrDzF3Pv
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 15:59:34 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42vsgf0W84zF3Pb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 15:57:49 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAE4rarC004861
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2018 23:57:47 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2nrcg1hss4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2018 23:57:47 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alistair@popple.id.au>;
 Wed, 14 Nov 2018 04:57:45 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 14 Nov 2018 04:57:41 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAE4vdcm59047952
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 14 Nov 2018 04:57:39 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AA8065204F;
 Wed, 14 Nov 2018 04:57:39 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0D0B85204E;
 Wed, 14 Nov 2018 04:57:39 +0000 (GMT)
Received: from townsend.localnet (unknown [9.81.197.93])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id C07C1A01D5;
 Wed, 14 Nov 2018 15:57:37 +1100 (AEDT)
From: Alistair Popple <alistair@popple.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v3 07/22] powerpc/powernv/npu: Move OPAL calls away
 from context manipulation
Date: Wed, 14 Nov 2018 15:57:37 +1100
User-Agent: KMail/5.2.3 (Linux/4.18.0-0.bpo.1-amd64; KDE/5.28.0; x86_64; ; )
In-Reply-To: <20181113082823.2440-8-aik@ozlabs.ru>
References: <20181113082823.2440-1-aik@ozlabs.ru>
 <20181113082823.2440-8-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
x-cbid: 18111404-0028-0000-0000-000003199A44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111404-0029-0000-0000-000023D60320
Message-Id: <2793658.kiX7AcRqs3@townsend>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-14_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=21 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811140043
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

> -	/*
> -	 * Setup the NPU context table for a particular GPU. These need to be
> -	 * per-GPU as we need the tables to filter ATSDs when there are no
> -	 * active contexts on a particular GPU. It is safe for these to be
> -	 * called concurrently with destroy as the OPAL call takes appropriate
> -	 * locks and refcounts on init/destroy.
> -	 */
> -	rc = opal_npu_init_context(nphb->opal_id, mm->context.id, flags,
> -				PCI_DEVID(gpdev->bus->number, gpdev->devfn));
> -	if (rc < 0)
> -		return ERR_PTR(-ENOSPC);
> -

This will prevent any drivers from setting up contexts with different MSR 
values (which is what the flags argument is for) than a standard userspace 
context (MSR_DR | MSR_PR | MSR_HV). In practice this currently never happens 
and I'm unsure if that's ever likely to change.

We should at least return an error if flags != (MSR_DR | MSR_PR | MSR_HV).

>  	/*
>  	 * We store the npu pci device so we can more easily get at the
>  	 * associated npus.
> @@ -755,9 +738,6 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev
> *gpdev, if (npu_context->release_cb != cb ||
>  			npu_context->priv != priv) {
>  			spin_unlock(&npu_context_lock);
> -			opal_npu_destroy_context(nphb->opal_id, mm->context.id,
> -						PCI_DEVID(gpdev->bus->number,
> -							gpdev->devfn));
>  			return ERR_PTR(-EINVAL);
>  		}
> 
> @@ -783,9 +763,6 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev
> *gpdev,
> 
>  		if (rc) {
>  			kfree(npu_context);
> -			opal_npu_destroy_context(nphb->opal_id, mm->context.id,
> -					PCI_DEVID(gpdev->bus->number,
> -						gpdev->devfn));
>  			return ERR_PTR(rc);
>  		}
> 
> @@ -838,7 +815,6 @@ void pnv_npu2_destroy_context(struct npu_context
> *npu_context, struct pci_dev *gpdev)
>  {
>  	int removed;
> -	struct pnv_phb *nphb;
>  	struct npu *npu;
>  	struct pci_dev *npdev = pnv_pci_get_npu_dev(gpdev, 0);
>  	struct device_node *nvlink_dn;
> @@ -847,10 +823,6 @@ void pnv_npu2_destroy_context(struct npu_context
> *npu_context, if (WARN_ON(!npdev))
>  		return;
> 
> -	if (!firmware_has_feature(FW_FEATURE_OPAL))
> -		return;
> -
> -	nphb = pci_bus_to_host(npdev->bus)->private_data;
>  	npu = npdev_to_npu(npdev);
>  	if (!npu)
>  		return;
> @@ -859,8 +831,6 @@ void pnv_npu2_destroy_context(struct npu_context
> *npu_context, &nvlink_index)))
>  		return;
>  	WRITE_ONCE(npu_context->npdev[npu->index][nvlink_index], NULL);
> -	opal_npu_destroy_context(nphb->opal_id, npu_context->mm->context.id,
> -				PCI_DEVID(gpdev->bus->number, gpdev->devfn));
>  	spin_lock(&npu_context_lock);
>  	removed = kref_put(&npu_context->kref, pnv_npu2_release_context);
>  	spin_unlock(&npu_context_lock);
> @@ -892,9 +862,6 @@ int pnv_npu2_handle_fault(struct npu_context *context,
> uintptr_t *ea, /* mmap_sem should be held so the struct_mm must be present
> */
>  	struct mm_struct *mm = context->mm;
> 
> -	if (!firmware_has_feature(FW_FEATURE_OPAL))
> -		return -ENODEV;
> -
>  	WARN_ON(!rwsem_is_locked(&mm->mmap_sem));
> 
>  	for (i = 0; i < count; i++) {
> @@ -923,15 +890,11 @@ int pnv_npu2_handle_fault(struct npu_context *context,
> uintptr_t *ea, }
>  EXPORT_SYMBOL(pnv_npu2_handle_fault);
> 
> -int pnv_npu2_init(struct pnv_phb *phb)
> +int pnv_npu2_init(struct pci_controller *hose)
>  {
>  	unsigned int i;
>  	u64 mmio_atsd;
> -	struct device_node *dn;
> -	struct pci_dev *gpdev;
>  	static int npu_index;
> -	uint64_t rc = 0;
> -	struct pci_controller *hose = phb->hose;
>  	struct npu *npu;
>  	int ret;
> 
> @@ -940,18 +903,6 @@ int pnv_npu2_init(struct pnv_phb *phb)
>  		return -ENOMEM;
> 
>  	npu->nmmu_flush = of_property_read_bool(hose->dn, "ibm,nmmu-flush");
> -	for_each_child_of_node(phb->hose->dn, dn) {
> -		gpdev = pnv_pci_get_gpu_dev(get_pci_dev(dn));
> -		if (gpdev) {
> -			rc = opal_npu_map_lpar(phb->opal_id,
> -				PCI_DEVID(gpdev->bus->number, gpdev->devfn),
> -				0, 0);
> -			if (rc)
> -				dev_err(&gpdev->dev,
> -					"Error %lld mapping device to LPAR\n",
> -					rc);
> -		}
> -	}
> 
>  	for (i = 0; !of_property_read_u64_index(hose->dn, "ibm,mmio-atsd",
>  							i, &mmio_atsd); i++)
> @@ -981,3 +932,57 @@ int pnv_npu2_init(struct pnv_phb *phb)
> 
>  	return ret;
>  }
> +
> +int pnv_npu2_map_lpar_dev(struct pci_dev *gpdev, unsigned int lparid,
> +		unsigned long msr)
> +{
> +	int ret;
> +	struct pci_dev *npdev = pnv_pci_get_npu_dev(gpdev, 0);
> +	struct pci_controller *hose;
> +	struct pnv_phb *nphb;
> +
> +	if (!npdev)
> +		return -ENODEV;
> +
> +	hose = pci_bus_to_host(npdev->bus);
> +	nphb = hose->private_data;
> +
> +	dev_dbg(&gpdev->dev, "Map LPAR opalid=%llu lparid=%u\n",
> +			nphb->opal_id, lparid);
> +	/*
> +	 * Currently we only support radix and non-zero LPCR only makes sense
> +	 * for hash tables so skiboot expects the LPCR parameter to be a zero.
> +	 */
> +	ret = opal_npu_map_lpar(nphb->opal_id,
> +			PCI_DEVID(gpdev->bus->number, gpdev->devfn), lparid,
> +			0 /* LPCR bits */);
> +	if (ret) {
> +		dev_err(&gpdev->dev, "Error %d mapping device to LPAR\n", ret);
> +		return ret;
> +	}
> +
> +	dev_dbg(&gpdev->dev, "init context opalid=%llu msr=%lx\n",
> +			nphb->opal_id, msr);
> +	ret = opal_npu_init_context(nphb->opal_id, 0/*__unused*/, msr,
> +			PCI_DEVID(gpdev->bus->number, gpdev->devfn));
> +	if (ret < 0)
> +		dev_err(&gpdev->dev, "Failed to init context: %d\n", ret);
> +	else
> +		ret = 0;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pnv_npu2_map_lpar_dev);
> +
> +void pnv_npu2_map_lpar(struct pnv_ioda_pe *gpe, unsigned long msr)
> +{
> +	int ret;
> +	struct pci_dev *gpdev;
> +
> +	list_for_each_entry(gpdev, &gpe->pbus->devices, bus_list) {
> +		ret = pnv_npu2_map_lpar_dev(gpdev, 0, msr);
> +		if (ret < 0)
> +			dev_err(&gpdev->dev, "Failed to init context: %d\n",
> +					ret);
> +	}
> +}
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c
> b/arch/powerpc/platforms/powernv/pci-ioda.c index c78c204..ec235ca 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1271,19 +1271,20 @@ static void pnv_ioda_setup_npu_PEs(struct pci_bus
> *bus)
> 
>  static void pnv_pci_ioda_setup_PEs(void)
>  {
> -	struct pci_controller *hose, *tmp;
> +	struct pci_controller *hose;
>  	struct pnv_phb *phb;
>  	struct pci_bus *bus;
>  	struct pci_dev *pdev;
> +	struct pnv_ioda_pe *pe;
> 
> -	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
> +	list_for_each_entry(hose, &hose_list, list_node) {
>  		phb = hose->private_data;
>  		if (phb->type == PNV_PHB_NPU_NVLINK) {
>  			/* PE#0 is needed for error reporting */
>  			pnv_ioda_reserve_pe(phb, 0);
>  			pnv_ioda_setup_npu_PEs(hose->bus);
>  			if (phb->model == PNV_PHB_MODEL_NPU2)
> -				pnv_npu2_init(phb);
> +				pnv_npu2_init(hose);
>  		}
>  		if (phb->type == PNV_PHB_NPU_OCAPI) {
>  			bus = hose->bus;
> @@ -1291,6 +1292,14 @@ static void pnv_pci_ioda_setup_PEs(void)
>  				pnv_ioda_setup_dev_PE(pdev);
>  		}
>  	}
> +	list_for_each_entry(hose, &hose_list, list_node) {
> +		phb = hose->private_data;
> +		if (phb->type != PNV_PHB_IODA2)
> +			continue;
> +
> +		list_for_each_entry(pe, &phb->ioda.pe_list, list)
> +			pnv_npu2_map_lpar(pe, MSR_DR | MSR_PR | MSR_HV);
> +	}
>  }
> 
>  #ifdef CONFIG_PCI_IOV


