Return-Path: <linuxppc-dev+bounces-24129-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD14C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 18:04:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzVhC2wGwz2xPb;
	Tue, 14 Jul 2026 04:04:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783965883;
	cv=none; b=OIwzO/S3PUXwELFGQWVDViTmBtwEaskuLyuKUm5pD/eorOkuSFt9qLhEaqEQTqqlK5VjkF7CGQrlxHcc7nBCnDMZmnzLlxn1zINdcoohC09/jjLcqduTleJRcuV2vM34lrVyKnIWeP1vSUuHWXi3nMma6FEjgsoBKk4NUozXhR4kuhn74Z/NeMdZpMNexzqzTsRHAMXx3CibKpytD/GFE00iKlEiJkBA5kRMGbPD2JkQF6aNrdrehXLLQ9lo6hXdj0B6bPgR4ix325rzyGFjyLHrmYoIZCgoNq7LWpNarb0F7eXUhU42FE0IxEmmY2ziY0VAmneUYIOPrlqX6O6LJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783965883; c=relaxed/relaxed;
	bh=tclAGFfYE4PDh26UAOa0dyz/xTkdP8eKsBQeSZPbdtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BZZNa+adE7WeHjI5KlhV/PlMI6BVnKndn8cVv/MbS5okSHXVJOIXDMFsciz9aYKShJyRYhtH9f3/7Z+cGr6HZ7O/K3rHevSKnB4VHVNtl+84uKWQGP2xDx03t0EwdIGoYsLpb4ut4CEUK8GZO3F4BnnXUK6zmIveBQ4G4A9JzO3SAjEUA3zZw2grIbfUUsN26yAvByq1L+nngkaiC1UC91S/yinKxgERnzuFHQlS27X1U38kk/wA/EKDW0wQE4G/pkXF9QMIbtWGzOY+303wXDox7xZ3EOhAHwzEy+Jb28EMke9a6fk5Ax4Zmri3k8v7oL5T+230WmgBCiIUR9l4/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PyU85Imi; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PyU85Imi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzVhB4vBrz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 04:04:41 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DFEYkc2856299;
	Mon, 13 Jul 2026 18:04:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tclAGF
	fYE4PDh26UAOa0dyz/xTkdP8eKsBQeSZPbdtg=; b=PyU85ImigTtEAyoWVmOGKu
	u31cFgnlO8qBP0m9ReuLfwSVIugOpDcrzwlPlW+bgIkxcNrldaeYJZcZx6izTT4G
	bSd56dfmjOxhnxoKV8YIv2xnLvhryRwMBtcOuUROgkfUGpdky1RmK7g1OVR1Dafk
	z+WD5cvUTK7PDxftDAYjRxMO0yBKeygnpLphUm7/Q+gp+WhO6iIQCGYe4YjhmmLt
	NcscoQ5KV/G9jjdVhknbVZd8cv3cPI6cJ0lVzQDHs53zbYKen1nKTp8WZV+cumCw
	d7MvP0GL4z9Ly5FJmZva9KOtyIdMQ3HxR7Qlhr+hcQGud0XEzTRdUoa//4uUUhSg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegt26ae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 18:04:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DI4brq019696;
	Mon, 13 Jul 2026 18:04:37 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15jq094-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 18:04:37 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DI4aC817040006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 18:04:36 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CD9458052;
	Mon, 13 Jul 2026 18:04:36 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A18C858056;
	Mon, 13 Jul 2026 18:04:35 +0000 (GMT)
Received: from [9.61.45.33] (unknown [9.61.45.33])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 18:04:35 +0000 (GMT)
Message-ID: <0fd580ed-b879-471d-9d4e-249999b63086@linux.ibm.com>
Date: Mon, 13 Jul 2026 11:04:34 -0700
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
Subject: Re: [PATCH 00/29] ibmvfc: Add NVMe-FC support
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: james.bottomley@hansenpartnership.com, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        brking@linux.ibm.com, davemarq@linux.ibm.com
References: <20260623013035.3436640-1-tyreld@linux.ibm.com>
 <yq1wlv0dqws.fsf@ca-mkp.ca.oracle.com>
Content-Language: en-US
From: Tyrel Datwyler <tyreld@linux.ibm.com>
In-Reply-To: <yq1wlv0dqws.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SAAf7CZVD3wfYUx2qksRI4ut0a2Qvr82
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE4NCBTYWx0ZWRfXxwnEyWTzMsWx
 lACQW4MwhHErGnPLLEqIU2vvS/RMuJ+Wcs+vNzgyR5oW86m4DwQ12DKFH3LbrTc/vVIyWleDcfn
 VUAF3AZe6f3AyZyyN5knpm70Uw43YAU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE4NCBTYWx0ZWRfXztkI7LfsZ+Mi
 KpFMlUNIwpSl8CVq6iHa5PqteXFpPQiYPwz4nQj19pLbOCt33xkeRH9+Cj6JTnalGaN+5RItPes
 rgR0cxfgwDakVzq+F4WQpT4jNHsdRMDbajfQ8QkUrwNHj092md/CxK93c7hHgLBaJZGztSpuBxD
 1mTA3Vzyyqszy00wDbJUlVox+BasGafyTl9iPB+N3ZbaOczJVTK46jiT/i9QoQ8OMaNZnyfxwNs
 98isstsd7EETjcgS74YriOLWFoN73J/hetCJXbhyoeKRHZDai++MS+Z8daTK/muYW+We5mKvAkd
 znhxqKmB8D/bassyvhQ41v8Q67UR9agJPq69NEcatBAWirICv+t+nGqzhxhKQ31sX0bIedmSgzB
 dOZ+nIfVeLv0eoSl6NNZLxb80GRu7gSIE6AHMNHc6fLVT1L9cD0ImVdMK1VdVUvW+tat1WpMyw0
 l6gUasTCpJODZM7txQw==
X-Authority-Analysis: v=2.4 cv=IqMutr/g c=1 sm=1 tr=0 ts=6a5528b6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=06I0Qw02cvwELWbZNJIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: SAAf7CZVD3wfYUx2qksRI4ut0a2Qvr82
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130184

On 7/12/26 11:06 AM, Martin K. Petersen wrote:
> 
> Tyrel,
> 
>> This patch series adds NVMe-FC protocol support to the ibmvfc driver,
>> enabling IBM POWER virtual Fibre Channel adapters to handle both SCSI
>> and NVMe storage traffic through a unified driver architecture.
> 
> Applied to 7.3/scsi-staging, thanks!
> 

Martin,

Can you drop this series from the staging branch? I've got a v2 respin that I
will get sent out today or tomorrow that addresses issues raised by the Sashiko
review. In particular I clearly had a bad rebase somewhere where I dropped/left
out some of the remote port processing code. There are also several fixes for
long standing edge case bugs that Sashiko points out with both the NVMf work and
Dave's FPIN series.

Thanks,

-Tyrel

