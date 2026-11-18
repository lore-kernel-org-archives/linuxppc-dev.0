Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35497607D6B6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 19:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Dd5cSyo+
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVBfm5J4Kz2xdX;
	Thu, 19 Nov 2026 06:36:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795030576;
	cv=none; b=T5zPpHPRQCI0ZQW7vniH0NXeCfwkW7jOEB0NmdQwQjRC2eQ8Sn5dZVuUq/la/kFkQDNIVqRp3j/CYXfmUIDLx/wV8REejQsJgBjfm1amBVzMOi9JMoL0gSQlk/oNdaN+KmnkfwzYCGn21nUT+GwXYbo3yBgrMNJ+HRzKH9T95ROtv/tyj7gQCoELcbX0yBTfCfqEGRMkUFsPNtp3MvAlwzk6iYmzXwuHjyb3SRha1El5ElcOxzw7MDC6jPOb3GnooWvF2UP7KEDgz5EfH095HiYiotr/Mig88j36lcoU1sME5AHr58nV7Y4f33zbRcCP0ONyhB5Edwoi5vSqR2ed2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795030576; c=relaxed/relaxed;
	bh=UZkCw/PRNjTmgTt2H+rO8Z2cQfMEi2kXyIfcaLv6x2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BZAPGEPWJdhXl/REY6VzP2s3JcnrsKqcLLenbhSEi54PrsaowzbAyJRr5TIE0zwnyOGFynEm+zYIVtCI3qxQhf0REoNzMcHb7/SAnJcZDOGiha/0kQck4ESyXpzecWwkTOcuwiZkwaACZx43Bowc++OvEdIX7IG0bU8RaEUWU8elNqwyavPJuMzUNyYv7Uw5xK8cq97NGqGGduBNnLlFvu7q3bwewVanArn59ikd4dI+PDJTZgEnrjxgKUWhzR/Wujcd3ullaA5QESFZtV6Kj+bK69KG2SQBn2RzFceNXIyrtE3Bcn8u45nCXHGSJkDWveyxdxYJaLFZ650mrDkMVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Dd5cSyo+; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Dd5cSyo+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVBfl54L6z2xSl
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 06:36:14 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIJQ2dk1979587;
	Wed, 18 Nov 2026 19:35:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UZkCw/
	PRNjTmgTt2H+rO8Z2cQfMEi2kXyIfcaLv6x2Q=; b=Dd5cSyo+M+D5Giyrfmpoip
	rBKnOl6MyvPCsJOIajXeffEK4CB42fpo5KHJS73uATwDkUPxnGM9Xy7QfnX1jtqn
	n/1wN6sLelyjG3l7UOl5tOCx+ac/VyMF/JuIwHMe6J11VlvOW1oP2Rez1thI7vsi
	qmM1sGU4MUE+96vZttv4n+X0Gfqb5Ha+41E4ZiQgbZOcZZTR8u/AFLO21hrXA+Hq
	rSNHPuME74p4FUTKaMvQqpyYmYrRjyI+aOwFOqN2oIgoMwfN8UWy54sKJ5xNJqqD
	7kSl9woUbCpBXO0U0+IuUykeFEV1mrM+w3jnmq/lXZVHNBiBszASi9WIhSezUXjw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105vm5s2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 19:35:56 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIJKPXF2454261;
	Wed, 18 Nov 2026 19:35:55 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j17c4t88w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 19:35:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AIJZp7q45678984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 19:35:52 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D229320043;
	Wed, 18 Nov 2026 19:35:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B919320040;
	Wed, 18 Nov 2026 19:35:46 +0000 (GMT)
Received: from [9.39.20.8] (unknown [9.39.20.8])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 19:35:46 +0000 (GMT)
Message-ID: <518b5813-ab4e-413e-9820-556888216090@linux.ibm.com>
Date: Thu, 19 Nov 2026 01:05:45 +0530
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] vfio/spapr_tce: Normalize EEH IOA error injection
 addresses
To: Narayana Murty N <nnmlinux@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Timothy Pearson <tpearson@raptorengineering.com>,
        Alex Williamson <alex@shazbot.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin
 <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, sbhat@linux.ibm.com,
        harshpb@linux.ibm.com
References: <20261023073642.59657-1-nnmlinux@linux.ibm.com>
 <20261023073642.59657-5-nnmlinux@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20261023073642.59657-5-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: hcvBwq2dZt6me__K3g3KOuyb6DtKMiFP
X-Authority-Analysis: v=2.4 cv=HL9WhYtv c=1 sm=1 tr=0 ts=6afdfe1d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=JDjOrm_dj_CcHeg-RfIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 0cFkCGGAEl2b2TR8eQWKhUey1NzTvvnx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA3NiBTYWx0ZWRfX1zWvrC+GChd9
 NtyUvRxR9oGl8tyCR+pG+jbdsTWhDvYNAg7N0r39CdtOD+XXMbDRZXRqupY0Ub0Xwu4YazxAY4n
 BxFwtj4G2toQE4qhqRvS3mrRRqrOeVXF2fDDk09mMXCenqoAo9r55ImPlEmw4Ygt7lOAK2k8Vxa
 I+gK2o/KxcrSuQ/us9HMhfWWtwIPWh894udpiPgnWdGCsx5ZVtpeV0BsOkN5+9kuXVltYoltGmR
 rgJSHY76lY4c88fgK1pIExtossG6afiBaa4nsIz6M+pLiHtAssTYDsIYOIeJnmJ1abjQF1xGbgx
 meW+Cgxr0bYFwCjRp9LTzArKf+X6/1DABxV50rt7SLHoJtFRvNUpSBd23b86OmsHImIy0RXkted
 vVSMZcYqKwsoj1J1CLfWIKuJQneQSINHfBYqGvd8jXuKwSPkjI7Kzh1kqs0cX/6WX2KYqrnnNGn
 NEmimatKrNrA+Nln41w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA3NiBTYWx0ZWRfX6hfWTLw9OnUA
 Z8Nvg/5D8+ZUmUybL83m6ZBx80oO/lptvpIjD94c67YhA2rAwg0j9uiqIOQE0hQNhd8QVSMnC4s
 u2EEKHtsmVtpVXeZRdZQaAmoSHvptfc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180076
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

  I'm finding this commit message a bit difficult to follow.
Could you please rework it to make the changes and their purpose clearer?

On 23/10/26 13:06, Narayana Murty N wrote:
> VFIO_EEH_PE_INJECT_ERR receives a target address from userspace.  For
> userspace such as QEMU, this address may be derived from the host Linux
> BAR resource.  The platform EEH backends, however, expect the PCI/IOA
> bus address used by firmware error-injection interfaces.
>
> Normalize IOA/MMIO error-injection addresses in the sPAPR VFIO EEH
> ioctl path before dispatching to eeh_pe_inject_err().  If the supplied
> address is already a PCI bus BAR address it is left unchanged.  If it is
> a Linux resource address, translate it to the corresponding PCI bus
> address using the BAR-relative offset.
>
> Normalization applies only to EEH_ERR_TYPE_32 and EEH_ERR_TYPE_64 error
> types whose error function targets a memory or IO BAR (load/store memory
> and load/store IO functions, func 0-3 and 6-9).  Config-space functions
> carry PCI config register offsets and DMA functions carry IOVA/TCE
> addresses; these address domains are not PCI BAR addresses and must not
> be translated.  Applying BAR normalization to them would incorrectly
> return -EINVAL, blocking injection entirely for those function codes.
>
> An address and mask pair of zero represents a no-address injection
> (e.g. a function-level error with no specific IOA target) and is passed
> through without BAR translation.
>
> Only standard BARs (BAR0..BAR5) are searched; ROM and bridge resources
> are not IOA bus-error targets.  Unassigned or disabled BARs are skipped:
> pci_resource_len() returns 0 for zero-initialized BARs, and the
> IORESOURCE_UNSET and IORESOURCE_DISABLED flags are checked explicitly to
> avoid false matches against unassigned resources.  Hold
> pci_rescan_remove_lock while traversing PE devices and their BAR
> resources to prevent PCI device removal from racing the lookup.
>
> A pr_debug() is emitted if the address cannot be matched to any BAR, to
> aid debugging without producing noise in the normal path.
Which address are you referring to?


>
> Keep the helper local to VFIO so the address semantics of other
> in-kernel EEH callers remain unchanged.

Which helper are you referring to?


>
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> ---
>   drivers/vfio/vfio_iommu_spapr_tce.c | 140 ++++++++++++++++++++++++++++
>   1 file changed, 140 insertions(+)
>
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
> index 1c0eec228cc6..d831adaa69fb 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -774,6 +774,131 @@ static long tce_iommu_create_default_window(struct tce_container *container)
>   	return ret;
>   }
>   
> +/*
> + * eeh_func_needs_bar_addr - return true for error functions whose addr
> + * argument is a PCI MMIO or IO BAR address.
> + *
> + * Memory and IO load/store functions target specific BAR addresses.
> + * Config-space functions carry PCI config register offsets, and DMA
> + * functions carry IOVA/TCE addresses; neither requires BAR translation.
> + */
> +static bool eeh_func_needs_bar_addr(int func)
> +{
> +	switch (func) {
> +	case EEH_ERR_FUNC_LD_MEM_ADDR:
> +	case EEH_ERR_FUNC_LD_MEM_DATA:
> +	case EEH_ERR_FUNC_LD_IO_ADDR:
> +	case EEH_ERR_FUNC_LD_IO_DATA:
> +	case EEH_ERR_FUNC_ST_MEM_ADDR:
> +	case EEH_ERR_FUNC_ST_MEM_DATA:
> +	case EEH_ERR_FUNC_ST_IO_ADDR:
> +	case EEH_ERR_FUNC_ST_IO_DATA:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static int vfio_spapr_eeh_normalize_addr(struct eeh_pe *pe,
> +					 unsigned long addr,
> +					 unsigned long mask,
Do we really need mask argument?

> +					 unsigned long *normalized)

Too much in a single function. Can you split this function as suggested
for validate_addr_mask_in_pe() in 2/5.

- Sourabh Jain

> +{
> +	struct pci_bus_region region;
> +	struct eeh_dev *edev, *tmp;
> +	struct pci_dev *pdev;
> +	struct resource *res;
> +	resource_size_t pci_start, pci_len;
> +	resource_size_t res_start, res_len;
> +	resource_size_t offset;
> +	int bar, rc = -EINVAL;
> +
> +	if (!pe || !normalized)
> +		return -EINVAL;
> +
> +	/*
> +	 * addr == 0 and mask == 0 indicates a no-address injection (e.g.
> +	 * function-level error with no specific IOA target).  No BAR
> +	 * translation needed.
> +	 */
> +	if (!addr && !mask) {
> +		*normalized = addr;
> +		return 0;
> +	}
> +
> +	/*
> +	 * Walk standard BARs (BAR0..BAR5) of all devices in the PE.
> +	 * Hold pci_rescan_remove_lock to protect pdev lifetime during the
> +	 * traversal: pci_stop_and_remove_bus_device() requires this lock.
> +	 * ROM and bridge resources are not IOA bus-error targets, so the
> +	 * search is limited to PCI_STD_NUM_BARS.
> +	 */
> +	pci_lock_rescan_remove();
> +	eeh_pe_for_each_dev(pe, edev, tmp) {
> +		pdev = eeh_dev_to_pci_dev(edev);
> +		if (!pdev)
> +			continue;
> +
> +		for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
> +			res = &pdev->resource[bar];
> +
> +			/*
> +			 * Skip unassigned or disabled BARs.  On pseries,
> +			 * pcibios_fixup_resources() zero-bases unassigned BARs
> +			 * (start=0, end=size-1) and sets IORESOURCE_UNSET.
> +			 * Use pci_resource_len() which returns 0 when end==0.
> +			 */
> +			if (!pci_resource_len(pdev, bar))
> +				continue;
> +
> +			if (!(res->flags & (IORESOURCE_MEM | IORESOURCE_IO)))
> +				continue;
> +
> +			if (res->flags & (IORESOURCE_UNSET | IORESOURCE_DISABLED))
> +				continue;
> +
> +			pcibios_resource_to_bus(pdev->bus, &region, res);
> +
> +			pci_start = region.start;
> +			pci_len = pci_resource_len(pdev, bar);
> +
> +			/*
> +			 * Case 1: userspace already supplied PCI/IOA
> +			 * bus address.
> +			 */
> +			if ((resource_size_t)addr >= pci_start &&
> +			    ((resource_size_t)addr - pci_start) < pci_len) {
> +				*normalized = addr;
> +				rc = 0;
> +				goto done;
> +			}
> +
> +			/*
> +			 * Case 2: userspace supplied Linux resource/CPU
> +			 * address.  Convert it back to PCI/IOA bus address
> +			 * before calling the platform EEH backend.
> +			 */
> +			res_start = res->start;
> +			res_len = pci_resource_len(pdev, bar);
> +
> +			if ((resource_size_t)addr >= res_start &&
> +			    ((resource_size_t)addr - res_start) < res_len) {
> +				offset = (resource_size_t)addr - res_start;
> +				*normalized = region.start + offset;
> +				rc = 0;
> +				goto done;
> +			}
> +		}
> +	}
> +done:
> +	pci_unlock_rescan_remove();
> +
> +	if (rc)
> +		pr_debug("vfio EEH: addr=0x%lx not found in any PCI bus BAR of PE\n",
> +			 addr);
> +	return rc;
> +}
> +
>   static long vfio_spapr_ioctl_eeh_pe_op(struct iommu_group *group,
>   				       unsigned long arg)
>   {
> @@ -818,6 +943,21 @@ static long vfio_spapr_ioctl_eeh_pe_op(struct iommu_group *group,
>   		if (copy_from_user(&op, (void __user *)arg, minsz))
>   			return -EFAULT;
>   
> +		if ((op.err.type == EEH_ERR_TYPE_32 ||
> +		     op.err.type == EEH_ERR_TYPE_64) &&
> +		    eeh_func_needs_bar_addr(op.err.func)) {
> +			unsigned long normalized;
> +			int ret;
> +
> +			ret = vfio_spapr_eeh_normalize_addr(pe, op.err.addr,
> +							    op.err.mask,
> +							    &normalized);
> +			if (ret)
> +				return ret;
> +
> +			op.err.addr = normalized;
> +		}
> +
>   		return eeh_pe_inject_err(pe, op.err.type, op.err.func,
>   					 op.err.addr, op.err.mask);
>   	default:


