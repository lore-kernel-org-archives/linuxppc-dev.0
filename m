Return-Path: <linuxppc-dev+bounces-29090-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04B7CA6018
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Oct 2026 11:39:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1Pz96pgyz2yr0;
	Fri, 09 Oct 2026 22:39:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791545973;
	cv=none; b=KYr6O/TmrUuF7fxCoKC295Us078VPuNsGGKtsyLDtCp5ETYcV0UlNNafHX4hCqAyBp4AfWDqQozp5NFjvkqhqKu5O/C+tVd4f683xi+9AAMgzgWD67/MlNPHuYtEpIKxYSde0R2QE8iZh46Bbxxb7z4HaRXoP4obbJm/GqV+dlxKyVbknRNK+YB4EvxNO7xg7cCOyz0oueUIvbJIzO99r6uBS24RHBbLsqKlwnSypYC6K0vp6vuZgr1e/VUXyOo7Hlb9txETMRHCF3r5n6vNIL6KqgSD2RedDfT3hGhG/c5Gop7WJ4qbYKZnTnWeRJ0suOUWewkN3M5jAuXGbYzVkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791545973; c=relaxed/relaxed;
	bh=frbc1baQqWe/mpJv3xogK/lCPrQ3j/t7YFJYnj7uamU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AOxGaFq1nhTlQl7Ih0ralNRySpTlBSr76+ekC3sH+yxkOHEznbI83jd7k50G7TOY/wILFMxeG1dnAwcRqgIWsMJ8ko0S69CUkUfgsIRLHibKUDpqImoUCrkdtmkwibxIja/rtljAOL8uFI3QxdiLSsuIzZen1Gy+6ibOhbR8Nbx5vqxEg2r8nwMxgI/rAkax+XDDH3OhYevA/Lp5GIPhsPNXoDVW+DYMEEIVhhb0c+QKhnmmZPEevfGDl+HycbQWnWQt42gsfyZxqwHzwxPEHY00k/XVdTvtav3SiWrIWjFJlzdL4k11l9ZHLwpE0LwPaxhzet+wmBIHjxHISRkKJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gQjRgpMt; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=avinash@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gQjRgpMt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=avinash@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1Pz850YJz2yjp
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Oct 2026 22:39:31 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998ZSHZ2007491;
	Fri, 9 Oct 2026 11:39:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=frbc1b
	aQqWe/mpJv3xogK/lCPrQ3j/t7YFJYnj7uamU=; b=gQjRgpMtfqnC0hStwZSE0S
	6Rys1hGxgXgxyJ2+2+lYCsnXtGj9y2Awkv56BrUz81m2wcXlc2+R4uIuj6gxSQV0
	bREVgaQt67Y0JdwGJA/vq1vwQ5BT7HHZKuOyysE1feEtcntkjh4zt/KYBGpqrXmS
	n5ylxsFayCdR9x1Nh94nSd2pHrgVuC8/67XtdcN+VtOeJsN+ctbJCUL6tuV04/9V
	yhtIWYCRPMnFFbnJfiz0BX5CIW+ohI0Dvvx6I3DIySO4xy6VyCRCC2tOyC6+QkTT
	ZF7iKgSSe2U5f+wU2h2LicU4OtodZ+tC33b/eW8W4uVvKUZAxaZwQnR42o5WHugA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjwad9v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 11:39:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6998I1j5559738;
	Fri, 9 Oct 2026 11:39:20 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h6udd0wqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 11:39:20 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699BdIC129032988
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 11:39:18 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CA1D5805F;
	Fri,  9 Oct 2026 11:39:18 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 391EE5805E;
	Fri,  9 Oct 2026 11:39:14 +0000 (GMT)
Received: from [9.39.24.183] (unknown [9.39.24.183])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 11:39:13 +0000 (GMT)
Message-ID: <4e2d9b0a-86b7-4c92-a6fe-994debe89122@linux.ibm.com>
Date: Fri, 9 Oct 2026 17:09:12 +0530
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: quirks: Add warm reset quirk for IBM Spyre
 accelerator
To: mahesh@linux.ibm.com
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, bhelgaas@google.com,
        npiggin@gmail.com, chleroy@kernel.org, sbhat@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Avinash Roy <avinash.roy1@linux.ibm.com>
References: <20260821123401.1375297-1-avinash@linux.ibm.com>
 <apZOqDGq16sTPZYP@linux.ibm.com>
Content-Language: en-US
From: Avinash Roy <avinash@linux.ibm.com>
In-Reply-To: <apZOqDGq16sTPZYP@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: yT35uhABl-5lw6PaybfVssFwIRiVrOPr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0NiBTYWx0ZWRfX2Q8ee3j4ELk6
 uoiKZY7eeCahbwNVjXaaKwApj+IYZF44UqOWWRjNbgnZ8FSAlFdM2gp+Y7XN5Bv7VNwYgfZ0NF7
 ksKd2vywtFJ4nt+72Wd9Lx8JbrHou37w5NGs0hZ3x/icN2kcKrGogS+gafoda6h4FtrHyEbvWBH
 Wp6bGIYhPHj1AHtVQLXrpjAvKD67jZ7hAbGQet8kMw7hLJQExYD/KE/jv60O8nX8VDQof8x2pjx
 FtF/lA46LiLfz85Oy4gyjH6gpc3QT3ULWiY8YuCinWeaxhySVDYwVvTVoDdprWPdPvgSpMQQMkT
 bSAaA806ciMImOF7AvjlJUwpBW5N+5oCMhlXNLb7f/Ug5wG13vrsKzJoML+bkHlnP2PjU4qkLr6
 ZlHMAe1yXGQ4CrgBCBGnbVQfBwXOU+0l4esT+7afuloQfp72xcO4PgMTcoxlsm6akc8VLUeoJH6
 ofHrywuRUNI+3a8Q9xQ==
X-Authority-Analysis: v=2.4 cv=cIt1IVeN c=1 sm=1 tr=0 ts=6ac8d269 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pFy-_tqO5D2utgubRJ4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0NiBTYWx0ZWRfXzi6/KyleNLeS
 bFtkBNOF1EdwQZs+2/3wVCF1P36NRR66LbrfwhVlx9YKxNC8CHO5B2+2L16UfNtkDc10Yrj2c0/
 XG0uRMXCiAFRz/uA/++A61dO/kJ1ygg=
X-Proofpoint-ORIG-GUID: qr9bZ4NJLHaHU-lQOu81TFEZ9wRcjB7z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090046


On 9/1/26 9:39 AM, Mahesh J Salgaonkar wrote:
> On 2026-08-21 18:04:01 Fri, Avinash Roy wrote:
>> From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
>>
>> The IBM Spyre accelerator (PCI ID 1014:06a7) requires a dedicated warm
>> reset method for reliable EEH recovery on pSeries/ppc64 platforms.
>>
>> FLR alone is insufficient because it does not re-initialize firmware
>> state machine for the current version of the card. The existing API
>> pci_set_pcie_reset_state() is used to drive the platform-level
>> PERST# using the EEH interfaces by adding a device specific quirk.
>>
>> The reset function is placed in arch/powerpc/platforms/pseries/pci.c
>> where the EEH infrastructure is already present, declared in
>> pseries.h, and registered in the generic pci_dev_reset_methods[] table
>> in drivers/pci/quirks.c under a CONFIG_PPC_PSERIES guard.
>>
>> This reset method is only registered when CONFIG_PPC_PSERIES is enabled,
>> so it is not available on other platforms.
>>
>> Reset sequence:
>>    - Assert PERST# via pcie_warm_reset, hold 250 ms
>>    - Deassert PERST# via pcie_deassert_reset
>>    - Wait 250 ms for PCIe link retrain 	
>>
>> Signed-off-by: Avinash Roy <avinash.roy1@linux.ibm.com>
>> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
>>
>> ---
>> Changelog
>> v1: https://lore.kernel.org/linux-pci/20260805125100.1-1-avinash.roy1@linux.ibm.com/
>>
>>     Reworded the commit message to highlight the warm reset requirement being
>>     a need of the current card and not a platform deficiency.
>>
>> diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
>> index 84e4ffe957a8..7aa58d57208f 100644
>> --- a/arch/powerpc/platforms/pseries/pci.c
>> +++ b/arch/powerpc/platforms/pseries/pci.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/kernel.h>
>>   #include <linux/pci.h>
>>   #include <linux/string.h>
>> +#include <linux/delay.h>
>>   
>>   #include <asm/eeh.h>
>>   #include <asm/pci-bridge.h>
>> @@ -236,6 +237,41 @@ static void fixup_winbond_82c105(struct pci_dev* dev)
>>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_WINBOND, PCI_DEVICE_ID_WINBOND_82C105,
>>   			 fixup_winbond_82c105);
>>   
>> +/*
>> + * Reset Spyre adapter using pci_set_pcie_reset_state()
>> + * This is specifically for PPC platforms where EEH (Enhanced Error Handling)
>> + * requires this reset method for proper device recovery.
>> + */
>> +int reset_spyre(struct pci_dev *dev, bool probe)
>> +{
>> +	int ret;
>> +
>> +	if (probe)
>> +		return 0;
>> +
>> +	/* Assert warm reset */
>> +	ret = pci_set_pcie_reset_state(dev, pcie_warm_reset);
>> +	if (ret) {
>> +		pci_err(dev, "Failed to assert reset: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* Wait for reset to take effect */
>> +	msleep(250);
> How did you arriver on this number ? Is this time defined by
> hardware/firmware specs for reset ?  Also, Can you #define the value 250
> and use macro instead of constant numbmer.

This was the delay shared by the hardware team derived from their 
calibrations.

Thanks,
Avinash
>
>> +
>> +	/* Deassert reset */
>> +	ret = pci_set_pcie_reset_state(dev, pcie_deassert_reset);
>> +	if (ret) {
>> +		pci_err(dev, "Failed to deassert reset: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* Wait for device to recover */
>> +	msleep(250);
> same here.
>
>> +
>> +	return 0;
>> +}
>> +
> Thanks,
> -Mahesh.
>

