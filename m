Return-Path: <linuxppc-dev+bounces-22665-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7F6CD98DE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 22:10:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfPSt4JJrz2yR5;
	Tue, 16 Jun 2026 08:10:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781561438;
	cv=none; b=kBnGKkdSkvjx/5C9g5szo52EHwBaUeFGsUh3sK9KtjbinGHlZdXUQWP01WtCeze16IL5eyVtrmqvARDNi7PnDh8m8sQsCAVhItPpCjehhp6TQ/LWun4R4OHQCk1/5yqzNwnQeYzDXBmEd8A+0Znze6XpFh8JegiKXuvUcBorzZztI4UGFlzWRZVigt6VSSOQKtfY8b0u/AifKSEkrL+L9wAiwm0CmdCXO7EK9bI/MXylYGLdX6gLAaRDd/hz3Xhzr5BJ4DRtCUKXW9cmme9O0UqHIINVSAP+p/C4Yhq8PT4AeHfoP6yhoB5TC8qHFuOKi4LD5V3uvqqDznoDE8fzMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781561438; c=relaxed/relaxed;
	bh=iH9QAQq46y1roEF0KMppZuAkKYE9+lSMeDxbXlNbcA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SnAdEYSgdBFXj+RGeVmPC8wIqzjIEr82aTvvZAE3OzmxZqcGmzAXxUKZtXEwtMmBesdTBAItJ2muBtnxiKDF9y1+TCbrfWpn5Wac2ytCKzDqMGmoJHjA/hMfzdYwHDoboMaJwMuWgq/qhAGz0tM+AJ53V57p9h5cTvTU9NiODKPK0zTdEoM70IT6ZCAa9ueEkxhEGMxv3U/lCt5GszQX6NG+pzmlp1uTbLyqOPUzq1tucW1VKqI/LmwBuRHBNKctUJL0CnZTisxGOrsRlNmeLebN+BzO5IVdRwEQ896yhcoIHZ7gcDFSBKRG1dihQeYV2ONbbTi8znsWIC33i2rz5Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Qh+M1AUt; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Qh+M1AUt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfPSs3Kg5z2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 08:10:36 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FJIZ0A3317950;
	Mon, 15 Jun 2026 22:10:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iH9QAQ
	q46y1roEF0KMppZuAkKYE9+lSMeDxbXlNbcA0=; b=Qh+M1AUtCW4o8CY+BYdKeZ
	a6tJOVCRzpUyN5g0hD0wrEXJmFLwdAr3loQtGJDLTqRi8AX7z9nb05R23XbV6bv3
	3rBayNRYP1mj2pWz5XHvtgKH5xMSLrN4rDw1ZdXDwO9YTPztw8Suhgtmq79CH/kG
	zhiLubjo7q70Q1TQqC2TU0Y2FBfe3Ajj2UEeKGoLekO7WDPd5IT7DvNvlpk0znIV
	NMcfqtjfdyCOyQtwlczikMW0FVfT1JT4HyWE03Frxetf9RCUpLoQ2m2lEEHGS2gt
	TQqkGzDTB+wk4/cuHtq7jYxmIWfZEWg5ez5aBEPu5Zec5ExqlUc4kpt2fxpjRaDg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1v2aaqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 22:10:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FM4gtU016585;
	Mon, 15 Jun 2026 22:10:25 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4esk1h0h6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 22:10:25 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65FMAO7N31916572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 22:10:24 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75EC658059;
	Mon, 15 Jun 2026 22:10:24 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BF8F5805D;
	Mon, 15 Jun 2026 22:10:23 +0000 (GMT)
Received: from [9.61.95.246] (unknown [9.61.95.246])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Jun 2026 22:10:23 +0000 (GMT)
Message-ID: <d8ad1826-5e13-446d-98ce-e7d6dd5c8f73@linux.ibm.com>
Date: Mon, 15 Jun 2026 15:10:23 -0700
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
Subject: Re: [PATCH v2 1/7] ibmvfc: add basic FPIN support
To: Dave Marquardt <davemarq@linux.ibm.com>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Brian King <brking@linux.ibm.com>,
        Greg Joyce <gjoyce@linux.ibm.com>,
        Kyle Mahlkuch <kmahlkuc@linux.ibm.com>
References: <20260608-ibmvfc-fpin-support-v2-0-d41f540fba5c@linux.ibm.com>
 <20260608-ibmvfc-fpin-support-v2-1-d41f540fba5c@linux.ibm.com>
 <d99205f7-8467-4918-8102-4b84620fd0ff@linux.ibm.com>
 <87o6hbo7z5.fsf@linux.ibm.com>
Content-Language: en-US
From: Tyrel Datwyler <tyreld@linux.ibm.com>
In-Reply-To: <87o6hbo7z5.fsf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIzMSBTYWx0ZWRfX2CLoEM+nMahp
 SkB+/malsd9cfflEOZxtgeijSwyR4pMrrwZs9XijDSoVYqIDrI+2pIkUl/Itrr/vZQMxowS8x5R
 jDck1rAyu+Z7uxgp6x4Eqoa6W95mXRw=
X-Proofpoint-GUID: 9jWXkrDL0SROPEpT3wxlsMg2wjvCSTkY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIzMSBTYWx0ZWRfX1VCBqDzEgBTP
 nwR9w+kPKusHKIbk0pLGK4y3PuGgY7dXB5cCDmQVLNPt8VsxB42rlXXxzk4yRKbWL7kN1+F3y8Z
 wOH+/CrrCabCoii5Vb0GibPOcAJcYzFyvP2sr0C8pjYP8zg2+FXLnFpKcIg3FZ7V45py7AH8Su0
 5Win3bhzY6UctCav7sagl8fiksgle1fCnxCKuyK8ere2XkMA7wwluV5vKE2/ZrjCsA0rSS7soU6
 AD9khI/D0Zwe1AGzZBIU9/bl5z0qknn3xPUk31Sor/UAHa1wrGtEA160sjR1+kOdrsfpjLNUNzz
 Fgv/HLYbJI5fu5had+F1cpKGmdFqtdKjDizj/ubUNX6TljZqxQHtRW4GGESSnJay5+oF9x7pJBw
 aCQNEm9ysOsaWb0eiTnYyvUkifHe+eGWsk5eTh3pY9oE75s/mNCC3CB0/4PK9jMsc3qcM5J3AT/
 /iyAAkkhiCyT5VSclEQ==
X-Proofpoint-ORIG-GUID: j3bqzW6bHW3gXmEkDcv15fclUAdHgw9f
X-Authority-Analysis: v=2.4 cv=Dd0nbPtW c=1 sm=1 tr=0 ts=6a307852 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=pZH4V2gORhnGOHh3lNUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150231

On 6/15/26 1:37 PM, Dave Marquardt wrote:
> Tyrel Datwyler <tyreld@linux.ibm.com> writes:
> 
>> On 6/8/26 11:30 AM, Dave Marquardt via B4 Relay wrote:
>>> From: Dave Marquardt <davemarq@linux.ibm.com>
>>>
>>> Add support for basic FPIN messages to the ibmvfc driver. This includes
>>>
>>> - adding FPIN handling support to the async event handler
>>> - offloading processing of FPIN messages to a work queue
>>> - converting the VIOS FPIN message to a struct fc_els_fpin as used by
>>>   the Linux kernel
>>> - passing the converted struct fc_els_fpin to fc_host_fpin_rcv for
>>>   processing
>>>

<snip>

>>> +static void ibmvfc_process_async_work(struct work_struct *work)
>>> +{
>>> +	struct ibmvfc_async_work *aw;
>>> +	struct ibmvfc_async_crq *crq;
>>> +	struct ibmvfc_target *tgt;
>>> +	struct ibmvfc_host *vhost;
>>> +	struct fc_els_fpin *fpin;
>>> +
>>> +	aw = container_of(work, struct ibmvfc_async_work, async_work_s);
>>> +	crq = aw->crq;
>>> +	vhost = aw->vhost;
>>> +
>>> +	if (!crq->scsi_id && !crq->wwpn && !crq->node_name)
>>> +		goto end;
>>> +	list_for_each_entry(tgt, &vhost->targets, queue) {
>>
>> Should we be holding the host lock when iterateing targets?
> 
> fc_host_fpin_rcv assumes no locks are held. I built a kernel with
> LOCKDEP, PROVE_LOCKING, DEBUG_SPINLOCK et al defined, and got some
> deadlocks. Some of the routines fc_host_fpin_rcv call acquire the host
> lock also.
> 
> I'l change this code to use list_for_each_entry_safe. Is that enough for
> safety in this case?
> 

No, the _safe version is only if you are potentially doing removals in the code
block while iterating the list.

Can't we assume every target in our tgt list is unique and we only need to
iterate until we find the matching target? In that case you can take the lock
iterate the list, break on a found match, copy whatever data is necessary from
the tgt, and then drop the lock and call fc_host_fpin_rcv.

-Tyrel

