Return-Path: <linuxppc-dev+bounces-23760-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F677C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 04:43:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gw57V1szbz2xll;
	Wed, 08 Jul 2026 14:43:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783485782;
	cv=none; b=IagMnrQK/WoURumIqScZn8yQHPSD7wcAnuPJDE4t8svBu5Q81WID8gLSF0/osn/Xpq1kD03p9tnCYwXK8n8UwTqehY1cttIUW56UqOeV7IlUd85VwH+TmTJ8/qI7YSWyzT715xuRktKDkdhbGO9VDAALSTAbQs03U575qxb3iVZKt+7H5eYVYXZvbZqQ+T4Oc+FvcSIQhHoOlHLDhTwoQPeYTLwfWeZK6qetFXZoj9yblKG4gnxcmSn5YNVwtY7qhMcOoIFENbJxWHoTcOM89ysgBKRJQ02RDNHQwtF+ykmMwf8hma4XBlESOd5AF7MtauAjxH3Wz5iVOiACnIZ3KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783485782; c=relaxed/relaxed;
	bh=jpSARjNMTO7tkUwQpXYWECWs7Yf7icxt6U5QhEl88Bs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OjMRWSx2rd95mMvyFmJlOB3PJ+8XQ1hZ+BEIOzS80eYsKN55x6gJtfSgR3ZPeXWTtXee3eryr9CSy42euz/DKfR2pAEfaVmuXb584byn+/9xKPuMH0rIIJrVP27eYQWn9+1IGiGWjczREvpgGjDNxO+690ju+32UZ7UvYZo2BoQ2sGsTMD5S1RcrpFmtm6mLOBNmoHsYcl839XDf4t46Ph46OhzHf68DYfJ+hzsHPhPOKBsT5qdXAog8mcYF2xMu2GU2v9i/vD4RTSz5IxAE0EdzWzYLIzB/tfQZdsYJvqt16ri3IMo1pDiTu6BaWvHfDNIQtQFDW3X1uAG5QptPCg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=k2tXOH0J; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=k2tXOH0J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gw57T0Q9Tz2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 14:43:00 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667MmpO41572269;
	Wed, 8 Jul 2026 04:42:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=jpSARjNMTO7tkUwQpXYWECWs7Yf7ic
	xt6U5QhEl88Bs=; b=k2tXOH0JDC7Vxyz+j4RPkKlmFliojKfpLirtgUbW8og3cb
	RU83TeS9LPY+O086H0jM3Tn0itFEy2O5xHotdzjF8iSf9UFqXNLRiMYF2OqrdZsi
	fnR1cYQocbvy2pNsGTxjYVE904Fh+ODrGkdmpLu13yUpj0qwFJ5emPZ8RlropbdP
	2+fEh2EXvA7cyeG7fGeM0twpfn7nmS+q86OEVhTZl9riRZrXwg9J+I4dwyypEsON
	46XGGmxcoEanXztnDC7F45xX7n00oTeP27gjT+gICPepXpsBFFWZiW/uU3SLKbwu
	Z1Gwk5Ffj33C7DDBGOVhsoUgXZtNOL6SkBrs/Cdg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknj596-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 04:42:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6684YbUk022152;
	Wed, 8 Jul 2026 04:42:43 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqg5qum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 04:42:43 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6684ggSj29950670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jul 2026 04:42:42 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F88A5805E;
	Wed,  8 Jul 2026 04:42:42 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99D0A58051;
	Wed,  8 Jul 2026 04:42:37 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.43.110.190])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with SMTP;
	Wed,  8 Jul 2026 04:42:37 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Wed, 08 Jul 2026 10:12:36 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Narayana Murty N <nnmlinux@linux.ibm.com>, mahesh@linux.ibm.com,
        mpe@ellerman.id.au, maddy@linux.ibm.com
Cc: oohall@gmail.com, npiggin@gmail.com, chleroy@kernel.org,
        nnmlinux@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, sbhat@linux.ibm.com,
        harshpb@linux.ibm.com
Subject: Re: [PATCH 1/1] powerpc/eeh: Prevent EEH false positives on PMCSR
 reads in D3cold
In-Reply-To: <20260703033649.41633-1-nnmlinux@linux.ibm.com>
References: <20260703033649.41633-1-nnmlinux@linux.ibm.com>
Date: Wed, 08 Jul 2026 10:12:35 +0530
Message-ID: <87v7aqt7lw.fsf@vajain21.in.ibm.com>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4dd544 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=dpxSy2U3sTv6v8GiW_EA:9
X-Proofpoint-GUID: 43HePlObJyVtXvguXJxchz18_O9Pe2w5
X-Proofpoint-ORIG-GUID: at1XYvFTcslIdBrbjfKr4uCm1Tf2gCVG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDAzOCBTYWx0ZWRfX9jW57vU4p9MV
 N885EWCryKJNPy7e63iWFCBRurJOQVwfmjEnYeeSb5ocVpDx94/oodYA/5YzVmGhL4h/4tEn78h
 yH8pR2ekfX9pWLXw/QSL++yoA/qdXvw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDAzOCBTYWx0ZWRfX+WVjDz1wftVr
 m4LsvvoA8pExSGyfaErq+kcf9p3dl0W/Vif0G/Nv2Tnv87mv1LnDhRWr8uVdlIcCrWI13lJmGYZ
 7z8QrE7Zcj5WTymhti3D8qnU0E++ktrWibYPNWdnYBH9F8hOm5+bH5ivu2JRstMsAyzi9rmwQ52
 g8sUd+VkfBa2ZfWoeL9EAkPu6q5JcM562IRgagIv6A3veDkYqBZKcr80knh1QIyx44QY7SkpkLn
 MlrSyqTzxB+1VcxxVDM6fGPFjudEUYfDXmfaQMMvaPVrqoefnZnXRa9DmSoVDajrqMpr2SAXMg3
 AXNHgjaaFVP63YQ3BTqgcgpYBK5Y/277PRFxqFRHC62oRcyL/vau0Trr9mYf9NhtBz+rO/+U4UB
 LI1lrlTTSAMeCmTxLVWaOqK2rfMG9lkaiydnmGDAPLwYDZ1fvgfwlluLEzCNWVI7OA2K50jqMEd
 bT2aYOrQ1Z3mU66B6Kw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080038

Hi Narayana,

Thanks for the patch. My review comments inline below:
Narayana Murty N <nnmlinux@linux.ibm.com> writes:

> On pseries systems, RTAS-based PCI config space reads can trigger
> false EEH events when attempting to read the Power Management Control
> Status Register (PMCSR) while a device is in D3cold state. This occurs
> because the device is powered off and cannot respond to config space
> accesses, causing the platform to report an error condition.
Can you share more details of the test-case(s) in which PMCSR register
read is triggered while the PCI device is in D3Cold state.


>
> This patch addresses the issue by:
>
> 1. Caching PM capability information in struct eeh_dev:
>    - pm_cap: Offset of the PM capability structure
>    - pmcsr_offset: Absolute config space offset of PMCSR register
>
> 2. Synchronizing PM capability data between pci_dev and eeh_dev:
>    - During device probe (eeh_probe_device), copy pm_cap from pci_dev
>    - During early init (pseries_eeh_init_edev), discover pm_cap via
>      firmware before pci_dev exists
>
> 3. Intercepting PMCSR reads in D3cold state:
>    - In rtas_pci_dn_write_config, detect PMCSR read attempts
>    - Check if device is in D3cold via pdev->current_state
>    - Return synthetic success value instead of performing RTAS call
>    - Prevents hardware access that would trigger false EEH event
>
> The fix handles both early boot (before pci_dev exists) and runtime
> scenarios, ensuring PM capability information is always available when
> needed. By blocking RTAS reads to PMCSR when devices are in D3cold,
> we prevent spurious EEH events while maintaining proper error detection
> for genuine hardware failures.

The patch is adding extra branch in rtas_pci_dn_write_config() which is
the hot path for PCI device config space access. Can you share details
on the extra overhead the patch introduces in rtas_pci_dn_write_config()

That being said:
I prefer access to PMCSR being fixed at the call sites which may be
trigerring EEH you have mentioned above instead of adding a constant
overhead to rtas_pci_dn_write_config() 

>
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/eeh.h               |  9 +++++++
>  arch/powerpc/kernel/eeh.c                    | 16 ++++++++++++
>  arch/powerpc/kernel/rtas_pci.c               | 26 ++++++++++++++++++++
>  arch/powerpc/platforms/pseries/eeh_pseries.c | 16 ++++++++++++
>  4 files changed, 67 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
> index b7ebb4ac2c71..224a3adcd34e 100644
> --- a/arch/powerpc/include/asm/eeh.h
> +++ b/arch/powerpc/include/asm/eeh.h
> @@ -139,6 +139,15 @@ struct eeh_dev {
>  	int pcie_cap;			/* Saved PCIe capability	*/
>  	int aer_cap;			/* Saved AER capability		*/
>  	int af_cap;			/* Saved AF capability		*/
> +	/*
> +	 * Cached PCI PM capability information.
> +	 * pm_cap == 0 means the device does not have PCI PM capability
> +	 * or it has not been discovered yet.
> +	 * pmcsr_offset is the absolute config-space offset of PMCSR:
> +	 *     pm_cap + PCI_PM_CTRL
> +	 */
> +	u8 pm_cap;
> +	u16 pmcsr_offset;
>  	struct eeh_pe *pe;		/* Associated PE		*/
>  	struct list_head entry;		/* Membership in eeh_pe.edevs	*/
>  	struct list_head rmv_entry;	/* Membership in rmv_list	*/
> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> index bb836f02101c..4402166df8c0 100644
> --- a/arch/powerpc/kernel/eeh.c
> +++ b/arch/powerpc/kernel/eeh.c
> @@ -997,6 +997,21 @@ int eeh_init(struct eeh_ops *ops)
>  	return eeh_event_init();
>  }
>  
> +#ifdef CONFIG_EEH
> +static void eeh_sync_pm_cap(struct eeh_dev *edev, struct pci_dev *pdev)
> +{
> +	if (!edev || !pdev)
> +		return;
> +
> +	/*
> +	 * Prefer PCI core cached PM capability once pci_dev exists.
> +	 * If pm_cap is zero, clear pmcsr_offset as well.
> +	 */
> +	edev->pm_cap = pdev->pm_cap;
> +	edev->pmcsr_offset = pdev->pm_cap ? pdev->pm_cap + PCI_PM_CTRL : 0;
> +}
> +#endif
> +
>  /**
>   * eeh_probe_device() - Perform EEH initialization for the indicated pci device
>   * @dev: pci device for which to set up EEH
> @@ -1050,6 +1065,7 @@ void eeh_probe_device(struct pci_dev *dev)
>  	/* bind the pdev and the edev together */
>  	edev->pdev = dev;
>  	dev->dev.archdata.edev = edev;
> +	eeh_sync_pm_cap(edev, dev);
>  	eeh_addr_cache_insert_dev(dev);
>  	eeh_sysfs_add_device(dev);
>  }
> diff --git a/arch/powerpc/kernel/rtas_pci.c b/arch/powerpc/kernel/rtas_pci.c
> index fccf96e897f6..9668cd0411e1 100644
> --- a/arch/powerpc/kernel/rtas_pci.c
> +++ b/arch/powerpc/kernel/rtas_pci.c
> @@ -95,6 +95,24 @@ static int rtas_pci_read_config(struct pci_bus *bus,
>  	return ret;
>  }
>  
> +static bool eeh_handle_pmcsr_read(struct eeh_dev *edev, int size,
> +				  u32 *val, int *pcibios_ret)
> +{
> +	struct pci_dev *pdev;
> +
> +	if (!edev)
> +		return false;
> +
> +	pdev = edev->pdev;
> +	if (!pdev || pdev->current_state != PCI_D3cold)
> +		return false;
> +
> +	*val = EEH_IO_ERROR_VALUE(size);
> +	*pcibios_ret = PCIBIOS_SUCCESSFUL;
> +
> +	return true;
> +}
> +
>  int rtas_pci_dn_write_config(struct pci_dn *pdn, int where, int size, u32 val)
>  {
>  	unsigned long buid, addr;
> @@ -108,6 +126,14 @@ int rtas_pci_dn_write_config(struct pci_dn *pdn, int where, int size, u32 val)
>  	if (pdn->edev && pdn->edev->pe &&
>  	    (pdn->edev->pe->state & EEH_PE_CFG_BLOCKED))
>  		return PCIBIOS_SET_FAILED;
> +
> +	if (unlikely(pdn->edev && pdn->edev->pmcsr_offset &&
> +		     size == 2 && where == pdn->edev->pmcsr_offset)) {
> +		int pcibios_ret;
> +
> +		if (eeh_handle_pmcsr_read(pdn->edev, size, &val, &pcibios_ret))
> +			return pcibios_ret;
> +	}
>  #endif
>  
>  	addr = rtas_config_addr(pdn->busno, pdn->devfn, where);
> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
> index b12ef382fec7..0e7efb4bf2d4 100644
> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
> @@ -351,6 +351,21 @@ static struct eeh_pe *pseries_eeh_pe_get_parent(struct eeh_dev *edev)
>  	return NULL;
>  }
>  
> +static void pseries_eeh_init_pm_cap(struct pci_dn *pdn, struct eeh_dev *edev)
> +{
> +	edev->pm_cap = 0;
> +	edev->pmcsr_offset = 0;
> +
> +	if (!pdn || !edev)
> +		return;
> +
> +	edev->pm_cap = pseries_eeh_find_cap(pdn, PCI_CAP_ID_PM);
> +	if (!edev->pm_cap)
> +		return;
> +
> +	edev->pmcsr_offset = edev->pm_cap + PCI_PM_CTRL;
> +}
> +
>  /**
>   * pseries_eeh_init_edev - initialise the eeh_dev and eeh_pe for a pci_dn
>   *
> @@ -408,6 +423,7 @@ static void pseries_eeh_init_edev(struct pci_dn *pdn)
>  	edev->pcix_cap = pseries_eeh_find_cap(pdn, PCI_CAP_ID_PCIX);
>  	edev->pcie_cap = pseries_eeh_find_cap(pdn, PCI_CAP_ID_EXP);
>  	edev->aer_cap = pseries_eeh_find_ecap(pdn, PCI_EXT_CAP_ID_ERR);
> +	pseries_eeh_init_pm_cap(pdn, edev);
>  	edev->mode &= 0xFFFFFF00;
>  	if ((pdn->class_code >> 8) == PCI_CLASS_BRIDGE_PCI) {
>  		edev->mode |= EEH_DEV_BRIDGE;
> -- 
> 2.51.1
>
>

-- 
Cheers
~ Vaibhav

