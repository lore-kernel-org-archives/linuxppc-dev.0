Return-Path: <linuxppc-dev+bounces-26434-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2284AC624D0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2026 08:40:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZblz2TPmz2xLG;
	Wed, 02 Sep 2026 18:40:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788338447;
	cv=none; b=fwqQdI9k9as/5FsLhnMKQVl8rXncnhLOVhOVMU8cQHdkxAVxX6wadFoCjSzLOEOsthAFTezKbVydZEA4eQx75ipi39On/tOfGYpXhOEGPyxtLupgHGnCEXxB9Mb+VENkViEe9UZ8VMOrGwMZofHu6OXwcG1oLIGWMKEaq/Vpz08kjvstkl/IjASCQUu685QjObiut275iVvgvgmp3j8jJkyFEcthlHF+BM1RfX/MmQ6arRWQQk+ZwrcBiWsJiEcl6ywaXiDToReZX5X+kNLGnXMJfyFPwgKU5XzgZwuAlUgwq+7q/N+C8a48jqQY3YCFksM9wnSIoMIUEy6JNplP+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788338447; c=relaxed/relaxed;
	bh=G0a/zWqfSIg+dcjUg7KWBjpbdRqkTWWjHihunYmWn8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D4G4Yk+qfBXhUNX0sODw4ocU/hZt8LTudoOQpfUQh3mPTSs281rdNX25+BNmu7NlMTFxUnKrK4+Yp+/necwUJfzB8bOHVYZMMrCcLiajSr+vD3PEsBB2Ty6+iUriO1ahFVH/K0hNn6D8xzXK3FHkUigIWn95C/OLTaAa535t2Whbt9jrjpBNlrJl2R+g/JodESU6FbruhcjqdeXR0ma7rjvpCXenuizdH4jKuzKzmsbUcfQQgMXahKTiwz6a13fMPgAJUDC87E98I+t6q8zwD3L1aBp7sNfRvRIKFqoYd86ryvPrp7+Spvs6fjr8lHXzO90cdo+yyjxlGCZBVsNoKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QfEXpsKb; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QfEXpsKb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZbly45Jfz2xBK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2026 18:40:46 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6826VYV33438175;
	Wed, 2 Sep 2026 08:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=G0a/zW
	qfSIg+dcjUg7KWBjpbdRqkTWWjHihunYmWn8c=; b=QfEXpsKbaK8IIhbaD252d1
	y5JYcv3aebn34fdlualOJuAr/PfqASBrB+u7qld9i09LjUipm9l5wwJqEU4J3aoU
	reSrdoN6OZ08QYx8xjK66h2xw/IUEwPs37eg1b0qXkWKmwLicMhm6ZZBYRzhay2Y
	MpE7l8wVinJ4ioQJaY6MxpFmvaREAb7eRGO9k+bw+OTO4edKCgXXaNLxtSpXiwnH
	7Nn/9qgH5bH/7pu1dP30FzQTljGc1Anfv5M+BxTyL9yKv4YD8SbYPydUfpPnzyH3
	rYx98FBqwbd2cKtPEA0xKUs1TxHIA/u1086hSOrRuPL/X/LcoUeCOZoijdKGns6A
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq54wat9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 08:40:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6828QP5s020397;
	Wed, 2 Sep 2026 08:40:43 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gccey8exq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 08:40:43 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6828e0E021299880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Sep 2026 08:40:00 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F3CD58059;
	Wed,  2 Sep 2026 08:40:41 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1290858068;
	Wed,  2 Sep 2026 08:40:39 +0000 (GMT)
Received: from [9.123.9.83] (unknown [9.123.9.83])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Sep 2026 08:40:38 +0000 (GMT)
Message-ID: <afd6fdc7-0fae-4fcf-b30a-a69294d26576@linux.ibm.com>
Date: Wed, 2 Sep 2026 14:10:37 +0530
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
Subject: Re: scsi: ibmvfc: Add Kconfig dependency on NVME_FC to prevent link
 failure
To: pavrampu <pavrampu@linux.ibm.com>, tyreld@linux.ibm.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        brking@linux.ibm.com, linux-kernel@vger.kernel.org,
        davemarq@linux.ibm.com
References: <327877a29337aa526cc50ac88fbddb86@linux.ibm.com>
Content-Language: en-GB
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <327877a29337aa526cc50ac88fbddb86@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA3NSBTYWx0ZWRfX2GONLxbT5ley
 O3f8SGH8RIeZxRyM3t4BRBXcOcKuQUBz4z8QDx4oOKL5f875gnfS4LH3H14OlNl81vLCeNvHiGy
 4vr+EfzwPgHZMTr/aivb+9pBDcIjFuJZv927hsGw/ZJj1akOJAINipB8m81vaetniRNYcPLX+qG
 noz6hWJt34ewPAAq5MK6kJziYZVRpOY1PQ5x62QYAFfgAIJuAqmuKjbcrrAKoZPjgR18P3u72g9
 t2SMvEl28Cut7OeZfK7GqZ6SfgQLdtf2+7FJeUOQObgruLkPV8tZHAkhEFyo1Hqm+moSrPwXiA3
 LQwsjl4hVkae/q4/Dyhsl8rTTJnmMMj1RDXV+Y2DplQCgCS4WTkqHO6A5XHWbhqdJW8T+Cy4ELw
 6nLCpGsCY11QNIeh4kKI3OZtKWeOMd0wGKaNJNPLyrz1ileANbYlO9repMXTyVCQpOPw1IWDRz+
 hzUscZJ5/jk9X2oQgTw==
X-Proofpoint-ORIG-GUID: g227ejspB4Rwy6ygrI9IrzfV-v5bGmKh
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a97e10c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=rqf9Ed0saxO1yiMWrtYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: g227ejspB4Rwy6ygrI9IrzfV-v5bGmKh
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA3NSBTYWx0ZWRfX93f/GhDZ5m9+
 twCv2xuA+RfWYMt3vF1fu32rwB+2xLeTtMFiy7rsbtCNCe9DWMKu0eypPdiT8WCI2C3AN0t9Tvn
 IlF3Ke1wAIXEBvDIRHVOMo2YyMtHz70=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_01,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1011 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020075


On 02/09/26 1:55 pm, pavrampu wrote:
> Hi,
>
> I am seeing below build failure with latest linux-next repo.
>
> Description:
>
> Building the kernel with CONFIG_SCSI_IBMVFC=y and CONFIG_NVME_FC=m 
> results in a link failure when building vmlinux:
>
> Build failure logs:
>
> ld: drivers/scsi/ibmvscsi/ibmvfc-nvme.o: in function 
> `ibmvfc_nvme_register_remoteport':
> ibmvfc-nvme.c:488: undefined reference to `nvme_fc_register_remoteport'
> ld: drivers/scsi/ibmvscsi/ibmvfc-nvme.o: in function 
> `ibmvfc_nvme_unregister_remoteport':
> ibmvfc-nvme.c:515: undefined reference to `nvme_fc_unregister_remoteport'
> ld: drivers/scsi/ibmvscsi/ibmvfc-nvme.o: in function 
> `ibmvfc_nvme_register':
> ibmvfc-nvme.c:536: undefined reference to `nvme_fc_register_localport'
> ld: drivers/scsi/ibmvscsi/ibmvfc-nvme.o: in function 
> `ibmvfc_nvme_unregister':
> ibmvfc-nvme.c:565: undefined reference to `nvme_fc_unregister_localport'
> ld: drivers/scsi/ibmvscsi/ibmvfc-nvme.o: in function 
> `ibmvfc_nvme_unregister':
> ibmvfc-nvme.c:565: undefined reference to `nvme_fc_unregister_localport'
> ld: drivers/scsi/ibmvscsi/ibmvfc-core.c:6798: undefined reference to 
> `nvme_fc_rescan_remoteport'


Below simple check in Kconfig fixes the build failure.

If this is acceptable, then I will send a formal patch.

# git diff
diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 4a2af0f702e1..6612d5d445e2 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -753,6 +753,7 @@ config SCSI_IBMVFC
         tristate "IBM Virtual FC support"
         depends on PPC_PSERIES && SCSI
         depends on SCSI_FC_ATTRS
+      depends on NVME_FC || NVME_FC=n
         help
           This is the IBM POWER Virtual FC Client


Regards,

Venkat.

>
> If you happen to fix this, please add below tag.
>
> Reported-by: Pavithra <pavrampu@linux.ibm.com>
>
> Thanks,
> Pavithra

