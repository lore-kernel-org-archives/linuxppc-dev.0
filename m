Return-Path: <linuxppc-dev+bounces-24996-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC04AC53200
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 11:58:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h99pd2Vvtz2xwP;
	Wed, 29 Jul 2026 21:58:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785326329;
	cv=none; b=inmxkHTYqsMLgMHNtX75GZxQhv6k78YyygkuNNHmL4LpuxzPuT942DYW7gi/9iWRsrs+O+Unkf59TwuSMUP4qk1eZYqzAlpu0u+h4/ZVXwPxNiHDlwAnZxN9V0C0UBJjwjqN+f5ew/9iiPO31fehAbpjAO0xm+rir9Ys44I9I4usEDaJHdLwH2oJGCq7Acydg5+TMzrgh2HiynweFCFdmgqTEYpMzbWU6K08IzyEKj6QO3cLT7bN4+Tx89Z6RAFX9yKELyeq52C96N5SWyhWH2x//ewZCC+BcORsZmrsfPY+6Fs5Cd45Qwo+N5FSGG1LzBRSeDRAPFFiDJxJZFbmsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785326329; c=relaxed/relaxed;
	bh=IMLIJy5K+V1KFSJoFVS5kB5zbFlvRA0wTQQev5uwOYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WX1S5MZD/hV/cUnq1pCz6a+vnf6F3y1TR4XCb0muH7odlVBSm1K0Hcn+fa3ZEJeoXN6jiP2YGEKn00+wGoOp/f11SU/9+jtwffgY/twyKfis0nAI9Q1cDlg8MZaW3/hYCzKBAoYfQnOCW2dYEK6QuReRc5GOCPShh8NdjPD/QQiB48LGNetct/4AAZ7ArRrQ1ZzsG4IABJ1Er8iVZOYcDgyQXg8e0k3jImj94k/aQanzrrdUWntTDWzxo4nzujg9fSU63/65tIy+gQ3mWvjAnsqvnX7WSbJEWFSLE8n2yzp4K2BPy/fg1ajwlRMbbxRuuxno2Qz22OIftn3yl4NxqQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=obE8Cn4l; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=obE8Cn4l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h99pc1xllz2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 21:58:47 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TBI56t3953689;
	Wed, 29 Jul 2026 11:58:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IMLIJy
	5K+V1KFSJoFVS5kB5zbFlvRA0wTQQev5uwOYM=; b=obE8Cn4lQtm0TRPp1PPCCp
	OVdkhqiP8tOz2EBjQp7u58YYrCT0O/RFUrQisuI20kCmT/yZYd3cIwghedHJOjNy
	TVGYcMNd7SXbjgjP410Mdko++Q5SX6v4DoTeV85hEV3Gmfx+MgRGsLiVZgappiVw
	tsFeCFLqDCRK9prsrXaBGPtPFM2ZBSXMHwbEb0sayn/AeoCIEEjq5DqPeQ2KoIp1
	W1+FbvIyUwAEZTNYziptoxoOD5I/pKLWdPB7KCn2iwSNwI+GANApMxcLDFaK6mQT
	Ivpesxs8WVyP4ZStsGSjl9RhIS/tX5wbWLV30ub2zjz9v4yb7gPtRvPvJS2DmGdg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyj9pca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 11:58:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TBuF85014077;
	Wed, 29 Jul 2026 11:58:32 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgebjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 11:58:32 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TBwW5j31785566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 11:58:32 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A75358053;
	Wed, 29 Jul 2026 11:58:32 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34B1358043;
	Wed, 29 Jul 2026 11:58:28 +0000 (GMT)
Received: from [9.43.93.217] (unknown [9.43.93.217])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 11:58:27 +0000 (GMT)
Message-ID: <9759b052-d95a-4835-b252-146ec114db0d@linux.ibm.com>
Date: Wed, 29 Jul 2026 17:28:26 +0530
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
Subject: Re: [PATCH v2] powerpc: Move CONFIG_QE_GPIO to SoC
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin
 <npiggin@gmail.com>, Qiang Zhao <qiang.zhao@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org
References: <9a7131d15a94e2017877e628f0e97f9aa2e0aae9.1785140877.git.chleroy@kernel.org>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <9a7131d15a94e2017877e628f0e97f9aa2e0aae9.1785140877.git.chleroy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA5NyBTYWx0ZWRfX9Qv12SdRGKdV
 O5qBuw0QJRqxOr846gYR7O0pkNDka9+aQ4yrR9w+L7dV2gzzmwb7B29A64hQp0Rfc5+58G3dKdB
 rL7SdV51sCHUy23o5kblRGg6j8DQMIM=
X-Proofpoint-GUID: 804KBYjedgKlQRFvQnsJPgulInbxiJP-
X-Proofpoint-ORIG-GUID: _u5JEvL4JraQDTsUjubds0jTmKLLyyWZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA5NyBTYWx0ZWRfXx5i973mDxkzk
 dT5ySa4qiycRmNfyhAu1Baz+z5KZt77pq3/FHKrM2cXCVKa27Ww/a4XoLtshs2GwzwMV6KVexgY
 HJpOhw8c5N4fPWVVsMUZI6iqNtdEtLiySnZLc90l6/ltuMtDdv80gmofcmOU/FzroLWl4hQQGGh
 eDAonRXrU7ej9EhH4F9bIZZD4Fr2+wvMJ9WboiDnnFO7zOr9kGn+fnFmKAgL8x5IjOL8BtANTN5
 yY35dkcLatzgSKmGV0RyDK3Mc/MyMinTjX8IFO+lvkrQoszntUTvQtTZ4uO844W3XeRTXVe7hhh
 Q3DtzbSgi/J01gylhJM8xAV2m0eM0cwtdecmi359QMohtmKZCUKuF3tieTGtvMyjXlu4kZwpWsB
 kI/UTXZ2i5Mm5AjfnW9ZNzT97SK0guC3YAgHa8VJc40hjld5A6s+9xbtShCUvaCiAfgQYfI/QfE
 z1VJXtUv9fEPgB7MDkQ==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a69eaea cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=IKTH_r9ZaJ-rAjPogqsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290097


On 7/27/26 2:15 PM, Christophe Leroy (CS GROUP) wrote:
> Commit 7aa1aa6ecec2 ("QE: Move QE from arch/powerpc to drivers/soc")
> moved QE into drivers/soc including gpio.c but left CONFIG_QE_GPIO
> in powerpc's Kconfig.
>
> Move it to SoC as well as it is the only place it is used:
>
>    drivers/soc/fsl/qe/Makefile:obj-$(CONFIG_QE_GPIO)       += gpio.o qe_ports_ic.o
>    include/soc/fsl/qe/qe.h:#ifdef CONFIG_QE_GPIO
>    include/soc/fsl/qe/qe.h:#endif /* CONFIG_QE_GPIO */
>
> There is also a dependency in USB subsystem for CONFIG_USB_FHCI_HCD:
>
>    drivers/usb/host/Kconfig:	depends on QE_GPIO && QUICC_ENGINE
>
> Because that USB driver selects CONFIG_FSL_GTM which is specific to
> powerpc, it has to depend on CONFIG_PPC.

Acked-by: Madhavan Srinivasan <maddy@linux.ibm.com>


>
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> ---
> v2: Add a dependency on CONFIG_PPC for CONFIG_USB_FHCI_HCD
> ---
>   arch/powerpc/platforms/Kconfig | 8 --------
>   drivers/soc/fsl/qe/Kconfig     | 8 ++++++++
>   drivers/usb/host/Kconfig       | 1 +
>   3 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
> index c4e61843d9d9..2f797ac6f1b3 100644
> --- a/arch/powerpc/platforms/Kconfig
> +++ b/arch/powerpc/platforms/Kconfig
> @@ -228,14 +228,6 @@ config TAU_AVERAGE
>   
>   	  If in doubt, say N here.
>   
> -config QE_GPIO
> -	bool "QE GPIO support"
> -	depends on QUICC_ENGINE
> -	select GPIOLIB
> -	help
> -	  Say Y here if you're going to use hardware that connects to the
> -	  QE GPIOs.
> -
>   config CPM2
>   	bool "Enable support for the CPM2 (Communications Processor Module)"
>   	depends on (FSL_SOC_BOOKE && PPC32) || PPC_82xx
> diff --git a/drivers/soc/fsl/qe/Kconfig b/drivers/soc/fsl/qe/Kconfig
> index eb03f42ab978..b35a8fd30ebf 100644
> --- a/drivers/soc/fsl/qe/Kconfig
> +++ b/drivers/soc/fsl/qe/Kconfig
> @@ -67,3 +67,11 @@ config QE_USB
>   	default y if USB_FSL_QE
>   	help
>   	  QE USB Controller support
> +
> +config QE_GPIO
> +	bool "QE GPIO support"
> +	depends on QUICC_ENGINE
> +	select GPIOLIB
> +	help
> +	  Say Y here if you're going to use hardware that connects to the
> +	  QE GPIOs.
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index b3b1ec696bf5..10cff12a3f31 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -611,6 +611,7 @@ config USB_UHCI_ASPEED
>   config USB_FHCI_HCD
>   	tristate "Freescale QE USB Host Controller support"
>   	depends on QE_GPIO && QUICC_ENGINE
> +	depends on PPC
>   	select FSL_GTM
>   	select QE_USB
>   	help

