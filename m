Return-Path: <linuxppc-dev+bounces-27434-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54500C88E7D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 16:21:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hknMJ4Vggz2y8m;
	Wed, 16 Sep 2026 02:21:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789489276;
	cv=none; b=gyyK83hvSdExk5NGL2GDjmaQyYioTh5gfzuBnJyjs7xyKGDdXRzKDN4U+TSJTaLgS1/SERwRXkKPhdtlYRBBoDUTnjIX5i3ErjrCj9PbMHQN74K0WOCOlWZnbdFjhpMfwARKZWQrwSAxRLb8xzmPtzyt6zilxFUIjA8K1ZJe1o/yV+mR1rKKoPJ0L1b3Iu0nBUB2stvwVAYGd6YlKkrhsVKNVKHjwp6u/VYazDS+qHFKVCBCHHAm77r7YbMtW/6mLtz4wgrbK2MavwCrogarGbD2vfTQqyzj9dlgDDv27qkmoGuJ6rbiEZll5Iy1uHpgHnnkLD2XbxjoHsmB19viKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789489276; c=relaxed/relaxed;
	bh=088vigp3Hb/aomEJev51nqYbnKdSslA1N/8NyWyNqDg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=QctbAjF3rWgKUWZCeIJtrQD8lCERybkfRwP5Sb+VBnRK01NMaCzq1zOm+bX75+hZpdMVzmj6Sj1uXsvKIn/v3Vnp+TTb2xC6WJdBLY+uUmIEwkm179slmfZe1SwAeaTbJRNDcA4fnkeveSWWUOa9RFD8JIxB81exvVNTVeSB1MtQu48J4C2lLNdZ28Le1dNmk2C6rLp1Ux3xKLx3OQurHmrK5Ginpw+OaGRmkdxQnByW/mKemVMxIyppVGHVdcCFNPJcVFiY0hcTw5Rem0dJeZPhS3mySaPcEffQjPpAZDgd4kv/G8o2YTlSl7JKvKZpsL7UoDClsBmRVDq7BKHrvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iiz0gGGt; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=wenxiong@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iiz0gGGt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=wenxiong@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hknMH5j7lz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 02:21:15 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FFVWG21206911
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 16:21:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=088vig
	p3Hb/aomEJev51nqYbnKdSslA1N/8NyWyNqDg=; b=iiz0gGGtYkmD48NImOURUC
	zTpWD1FzupdkyqfL4cPxVXvNeEr1fXR9arms/oFBz+lcbHY/nVZNv24U1RPW3N7W
	KRid8mQdXENrEud7VA0aCZ9TqMo+8QZk9Gnbvh4CCfW9oF6ZRll1ExtvfdnyzNvs
	NkoIAQugadc+NI6zHnvQo9vR51fkQHNqiKoo+V5wZGZYUdOlucze4imf8c1B71pe
	RooboEM6U1J4qutjLGUV6aGMMkvlQPw8XJKKRsk5hbeZsjz7kztc8TyEa68efGKu
	d9lhQvyPPqOrU2PYdPxu8cVYF6BIT6OLJE8x9xykI/bEjA5jIXYwndRnIL0YXfiA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf502su-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 16:21:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68FFAbWa4140781
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 16:21:12 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gq03bt5aa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 16:21:12 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68FGLBAe30736782
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Sep 2026 16:21:11 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92AE158056;
	Tue, 15 Sep 2026 16:21:11 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 080975803F;
	Tue, 15 Sep 2026 16:21:11 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Sep 2026 16:21:10 +0000 (GMT)
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
Date: Tue, 15 Sep 2026 11:21:10 -0500
From: Wen Xiong <wenxiong@linux.ibm.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, haren@linux.ibm.com,
        tyreld@linux.ibm.com
Subject: Re: [PATCH V2] error path improvement in dlpar add
In-Reply-To: <d353a67a-cbda-467a-9c6b-f2770b34d1ae@linux.ibm.com>
References: <20260204223844.11441-1-wenxiong@linux.ibm.com>
 <d353a67a-cbda-467a-9c6b-f2770b34d1ae@linux.ibm.com>
Message-ID: <21ecc3d1abfdb8d9f940039ec936df93@linux.ibm.com>
X-Sender: wenxiong@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: O8sxt_LKsZ7dIyXHquM3wyhhvyowuVzl
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDIzNCBTYWx0ZWRfX7t/IR5Lt9YKD
 mwdP61olVbSFdObgahB1+4GJ0+iANYnDqRUSzI8d1BP5uSbU9oQT0/6ATvFTnV39qh1BfeZvLMm
 evGCR8zWQ7RFyupfuigrjLCEnLCOSX0=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aa97079 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=TjW-olUbMP97OrzH7uUA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: O8sxt_LKsZ7dIyXHquM3wyhhvyowuVzl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDIzNCBTYWx0ZWRfXyeTi4WZrpExC
 e5m7c1XajFkYwltDJdGmN2mO4ngZLT9fk5vhv9x4Y4sH0hOTOo1P95TAP6mqeGD/7CYfc+ynZBg
 vc+ipZ7uSbgglqOQ1IMwquO3AiDFgyFhIJKp5JZTj92ed+0ujhg6+Nr20iZBNg4US1RKI2UTtmr
 NGTSkVLTKj4QR79AJxlb7NaBNesH1a1SL1XlAB9mA454tInDuWUPcGWj0KkQmqf4L8HbHvsGMxh
 AWf87abTS1Qq4Bdk+F2P0Ri/DoV7nG7POJ6V/MvZooOdjQ02PLtwUDhUfKQRvCOy3EEiQ9JCovz
 qe7M91NefrL2InbKFY8ih90j2mE5DdK9K739cvkieYtKESkwxCbYvuHYPPRNf6tPNWZL2pZGrFT
 Bee51lWuXQ37ynWe3TZkQ7MaEpCW5XkT9UgnMsqKKd9ZiNnImRBsgYuuXuCGt5WFpyJyb0PWLzO
 beFf9CFD0aYF59CCp0Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150234


> Overall I think the intent is correct, however the commit message
> should also be tightened up a bit to make the problem and the expected
> behavior more descriptive.
> 
> Thanks,
> --Nilay
Hi Nilay,

Thanks for reviewing the patch.
I will take a look at soone.

Wendy

