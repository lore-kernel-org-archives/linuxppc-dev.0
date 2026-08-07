Return-Path: <linuxppc-dev+bounces-25546-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F931C5AC7A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 08:23:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGcbl35y6z3bxM;
	Fri, 07 Aug 2026 18:23:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786090995;
	cv=none; b=j24VvJB5iqVa+eedQ0ZDLJjY+1bmsrsuA69w3zIDjqq+lBPNbJ1alrBZrAZ8CX43VgJXOBWRuI1TzGzWnHljM1Y7qADGSX8sQ+RBaJ+Km5qHTWqFQaHDgdl3I/Y4Pitp28M8qHlSnNWyso6SWQ9u1Rz0Hrsb+/LZVEtgLF5W7wKNBymT23oCkuiQAulygmVuGT+9NuO0V2omVM97vd2kLcpiogis0HoqbA6JEB+an9gDkbCW5bENcUc3Ja5FEP6bIbEdH+mY6AsYCw88Zta0sWP+f75f/bvyD1Ciip/dCVY81MsbrvKZsjASgGytlBTLmCp9kZOXtL3hhMkjOUYrsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786090995; c=relaxed/relaxed;
	bh=ynliRmKixaZWlyRby3+emw4oHN+BRxswhvxqmJyE/8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cSOuKXp6RUhV3sgdXIBQhivrkWvtC8O5mL9bPFo/jtBvPGnI8S6gl5m0ePViZNpqW6dU52dhAm9Kwva8+7OMRNXHz1sATOjKb3D30KWKitTZ6n1djXX5FD5PwJYz4TmVT0wAJHMUVZVUHDeiA7mm1yI+pmk91ijCR3wRzkR3GRKlLf8YvFTnEzqJB6AetBBmwR7919J1R3ajoVWiwoxPu4JnzmnFmIeBp9ytuZlSvZZklgGuKl+X5ehbYQBB9H0l/NGmnqmit4OQM/8AaWZW2P57TvWS6HZ4CxxfLrqmgOFM5+axbWmo6k4u4l5eGfMZliZie5wV3s1ZSlS8lPlVog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Lj9RFT2i; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sbhat@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Lj9RFT2i;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sbhat@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGcbk3sw4z3bps
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 18:23:14 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770HX4A4161103;
	Fri, 7 Aug 2026 08:23:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ynliRm
	KixaZWlyRby3+emw4oHN+BRxswhvxqmJyE/8g=; b=Lj9RFT2iWFvSWuw8FnvFFx
	XW5xRqtOkjlxdVBcxA43LLJMJSxmVJ+vN7N0lQfvCXxwaW8dfi4KpvtRb78qDSKz
	5E7kDquC/mvcRDOM84COd5F3EadIaq4irnv6H20fO5xp46z0Gvs4+ycAZR7nWDHM
	3J8HsgolsBz1xIPztKLs86hktmW1iHPBJATyhQQ/Dn57bQXW0OoziJ55MdrypoZ6
	sEtKPfwupXuSTylMKrR75t5MafzrclVnXaQmt27WU6ZX+q4OPUu44lr+IGdbrwdm
	19U+aRJP+NV3PYimwKUI7BojRDITCnqvwff8XU1s89A8GhM3huW/A4IaA5Qyi32Q
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvxyyu0cq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 08:23:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6778BHmw024111;
	Fri, 7 Aug 2026 08:23:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgpqfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 08:23:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6778N5SJ39846384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 08:23:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D944120043;
	Fri,  7 Aug 2026 08:23:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A00320040;
	Fri,  7 Aug 2026 08:23:03 +0000 (GMT)
Received: from [9.39.29.204] (unknown [9.39.29.204])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 08:23:03 +0000 (GMT)
Message-ID: <04e92492-8129-4b47-b103-d8954da8ce74@linux.ibm.com>
Date: Fri, 7 Aug 2026 13:53:01 +0530
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
Subject: Re: [PATCH] [SCSI] qla2xxx: Handle the INTx not connected while
 passing through
To: "Martin K. Petersen" <martin.petersen@oracle.com>, njavali@marvell.com,
        James.Bottomley@HansenPartnership.com
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-scsi@vger.kernel.org
References: <177885270578.1573.14283751510936407585.stgit@linux.ibm.com>
 <178508193511.4027291.4543280548195278135.b4-ty@oracle.com>
Content-Language: en-US
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
In-Reply-To: <178508193511.4027291.4543280548195278135.b4-ty@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=SYrHsPRu c=1 sm=1 tr=0 ts=6a7595ef cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=Zq2QReTLRP5mfbFy0C8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA2MSBTYWx0ZWRfX/DnQrcWUhBUX
 QJhLGxXm7md8i76gZ+0INCtcj/8oKXKiFgaaz451SkUCA2RumUGEENgPgdGGJjel32mFixh68qo
 c6hUfN3bnn/HzSqlT9avqVgPhqpgMBo=
X-Proofpoint-ORIG-GUID: vKjhln2L304VavEzg72Di9zRvC4UhZgP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA2MSBTYWx0ZWRfX/VAcUXQ5IMLY
 swov+lDcxQUj0VdZuRf7KJkod6YIJL8somAT0eBVDxi090WWbIC/D/nKCw22FzXq+PUruxzDkpu
 CmlxhdRfye1IksOXi1n8TcwXsMDUJMQw3hYETaFUpExLAXV60iwEX5rQRd+tkgUUPbjoN4jY7ft
 pUWbXDx6lpBhdWqsm9KARBHN1vZtDLyMRoiUm4LL2EtWSv2OXd7/pICJVaWhPkI+v9+Mp4k2cAd
 xbKN80n5CqHLsh0288XorkXh03FqCHkMWkJ1bcfqjY9VlXGB5xMHCCMu0qgdAIDn4mcOpQEOQEq
 sM6Ewv0kbJYXwkw236e82vKSma+mb9oSxvBjRJSXfgRkiG/vwlcVGTC6lp6B+Z1+OiXZWrIWc0H
 BAhtYB/P8RuSqtc7xhGT+0dkkgDGxhgrPKvruZu3fuZHJtieGYzZ8h07fP1wWFlP4qJA7H65uMF
 BZV1ZDcXJwGvY2ySMXA==
X-Proofpoint-GUID: vKjhln2L304VavEzg72Di9zRvC4UhZgP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070061

Hi Martin,


On 7/29/26 8:25 AM, Martin K. Petersen wrote:
> On Fri, 15 May 2026 13:45:18 +0000, Shivaprasad G Bhat wrote:
> 
>> The PCI_INTERRUPT_PIN reports if the device supports the INTx.
>> However, when the device is assigned to a guest via vfio, the
>> PCI_INTERRUPT_PIN is set to 0(i.e none) if the line is not
>> connected and|or the platform cannot route the interrupt.
>>
>> In such cases, the guest PCI_INTERRUPT_PIN is 0 and the port
>> number becomes -1(255, uint8_t underflow) for qla[25|27|28]xx and
>> qla2031 devices. The flt_region_nvram is never set, and subsequently
>> the lun detection fails. Below warnings show the NVRAM configuration
>> failure.
>>
>> [...]
> 
> Applied to 7.3/scsi-queue, thanks!

Thanks for pulling the patch. Would it possible to get this fix into 7.2 
stream as well?

Regards,
Shivaprasad
</snip>

