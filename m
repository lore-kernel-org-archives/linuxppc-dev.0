Return-Path: <linuxppc-dev+bounces-20665-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E692CCD3427
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2026 02:28:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDNvK3Kdfz2xQB;
	Mon, 11 May 2026 12:28:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778466525;
	cv=none; b=Ixzfm+5FgIbZDEmZaJ/QAxoum5SEb6KnV3GsB4j/A+WJrntYlGvGrMSHHdTu+87not//r04ThwK70xzW9k+bQkiHYty2iIN7A9q/PAJxP6RrGU6NmGkgUE40BAYz7GYi6hLqdAhNgwikVf5lxlUPHM8jmFtRWP1vROU8wRf5ku2MNF5FqjNWFIy0WBrxF/51VNuTvRz2jr1yjnAXpxKk/sIVqggZnmT8SZDxGOcijoHSHS+lEN6WHM8rCkwha4Czn0+TzVP/xXx0bMiTU+EuCF8RNR6NyNu+ruzkrT21P7Rn4Tra/w0yHg9B1MiofgN/GW8yoAFAiFfLbKs1zaMQbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778466525; c=relaxed/relaxed;
	bh=RGd/sNA6L7/NuO0BBncvDnIjeuHtz/zOrx7Jsjb24Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hu/5JdL1ZsFmmjh71x7W5Pyub1BoNC6pDggs0B9mq31n1okHJ/xEcskco9ey4+YQ3QoZJH6IMJCTOIadp3ZzWHoKgCWhlannpDizQBmUuOEEPc2dWtR1xF3bTA2KMbOfpdbBUP9UoU2pbFPbmf1aHqoafAbX6wS1Mcgm0hEQmYy+ZBhZcLKh4UtozZfrz2Rs7EbeAYmxKFDUsxO9Y6WwKdQmFkbdwbErxFdfLbtbATADUMqHELit2WruQYyLXJYgOnXZPIEcO/TYIYPyMGNgL+rku27PjyasoTHuw0PHJYK156YslMPychRnwxQc84wmyhIuuPm61Xe62se+k/xFPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DG+GqYm8; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DG+GqYm8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gDNvH6fBQz2xFl
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 12:28:43 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64AHP9n1388328
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 02:28:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RGd/sN
	A6L7/NuO0BBncvDnIjeuHtz/zOrx7Jsjb24Lo=; b=DG+GqYm8wflYfmtgjqJ4NV
	5GgU4flB+Xy1JgkhX8bQeSfCZIuIRWOa1sbwAjUDKbl4SXSrhe4N2cTCzT4PT92z
	o7o546EHH/dY8lQYaabzMRxk/arxbR0XZPLFDzaaEYhvh7XT6DocXwfPLVmSK6lQ
	HjE8dQ7CSLD1Xvs5nLZYIcX5NoOmukgxOKIAr2ZnJwhmOAH/zKOdLi9A21W79IRj
	OUbI1EVIhvU7IoJbyW3TCybSYfNSvnj1eoRukZqhK7rPPKEVsVyMLyBxCj1bhJrI
	A5Zs73QkuX+t4n2v4wgIh1Go4m9la1MwYwkP9qFfYA4Yy6mJ/ME4N/RIN8C43NyQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1ubdnwjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 02:28:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64B2OY7p012886
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 02:28:39 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e2f8q3h70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 02:28:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64B2SZM048103696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 02:28:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1A1B2004B;
	Mon, 11 May 2026 02:28:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 157AD20040;
	Mon, 11 May 2026 02:28:34 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.2.213])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 May 2026 02:28:33 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Athira Rajeev <atrajeev@linux.ibm.com>
Cc: hbathini@linux.ibm.com, sshegde@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Subject: Re: [PATCH 1/3] powerpc/pseries/htmdump: Free the global buffers in htmdump module exit
Date: Mon, 11 May 2026 07:58:32 +0530
Message-ID: <177846637458.1289230.14791639667292800432.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260314132432.25581-1-atrajeev@linux.ibm.com>
References: <20260314132432.25581-1-atrajeev@linux.ibm.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BezoFLt2 c=1 sm=1 tr=0 ts=6a013ed8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=sAhxefCUTY11gdAXkRIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: tX9h18ihJg6q-UF-qcgLnYECJPdqAEpQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDAyMiBTYWx0ZWRfX9Ighkb3ILERA
 /1VatG5MkuRwQktx/BafxOlNRDVvkqCc+HbqxO8u84KecchTV+JplGI6nZfRTjWZ/Zye9kHbXS+
 w+CID2N8acnRh7JDGy9F6+VbMblMErazcsegMGczRGX7lvYh7FPTpbpYdlG0psVaCYX5fesXdvj
 E2dXek7gmcL+eRbaBI61WuWC97xjs67mHP21T/o1SygYULS6X1uDw+XRk2th+7MDf3vIibOLzV4
 ki8F9lao3iHf5ZiDF6EGL5/WCTt9ImogH0Ru3DDDrCDfhQz1VGkZ7omzRWkbaYFCcmSrFe2YZb7
 bBxJUbfguysedG4DYnPdgrWiOtklhlVzIok8meEagN6Uu4hVOfBbCYQy1GKq7iu5MC1OIO98U/C
 ijcOmRTit67yakvYElr4+nq+FtMKoNDxul8V86JH3ml91OUtr4m4pderXR8zySbufNu7fcpAGx8
 wQOEkgivW+hJ5sVNHuQ==
X-Proofpoint-ORIG-GUID: tX9h18ihJg6q-UF-qcgLnYECJPdqAEpQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110022

On Sat, 14 Mar 2026 18:54:30 +0530, Athira Rajeev wrote:
> htmdump modules uses global memory buffers to capture
> details like capabilities, status of specified HTM, read the
> trace buffer. These are initialized during module init and
> hence needs to be freed in module exit.
> 
> Patch adds freeing of the memory in module exit. The change
> also includes minor clean up for the variable name. The
> read call back for the debugfs interface file saves filp->private_data
> to local variable name which is same as global variable
> name for the memory buffers. Rename these local variable
> names.
> 
> [...]

Applied to powerpc/fixes.

[1/3] powerpc/pseries/htmdump: Free the global buffers in htmdump module exit
      https://git.kernel.org/powerpc/c/54d54f33813d7911555226b4220737177a2ba8d6
[2/3] powerpc/pseries/htmdump: Fix the offset value used in processor configuration dump
      https://git.kernel.org/powerpc/c/4ec6ade73f1626a74d46e61ff247cf2b1b96446b
[3/3] powerpc/pseries/htmdump: Fix the offset value used in htm status dump
      https://git.kernel.org/powerpc/c/0031424cbc0a6eafc56a8f9201a4a69d3649981e

cheers

