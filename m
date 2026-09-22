Return-Path: <linuxppc-dev+bounces-27950-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE4E6C982FE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 23:17:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqGGK1dlsz2xlw;
	Wed, 23 Sep 2026 09:17:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790119049;
	cv=none; b=SbFwI1GbwXyDjlQ7sgxmqXD1MAvOuccG6kC1NN0dSxXHg18ueizHJFyO7KATYGDgZFF2SZsv1hKcKu/9na0QaWdkCVYUDIxsgzVLyKtOHNuYZG+h8DribHpWk5P/Q41BoNWEy4SUtyHz+XFIrwpZ+2PwuxTUCm0M/RviHUANwuQ99SDPZocJ2CRaMD8hSYop1eCjaWRwMElzJGlV4AEYEmvWvbNiyZvDfco3w8ySxegj9SEHeJFLxvXBCEVo7QxEThslnfHSKijkmMZsm4oA8vm1ypYp4Xt3plRb3U+OCkFU2aOUyZcmFa2MXw1jpIdirdJCMIIpyALHUCalPwcCqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790119049; c=relaxed/relaxed;
	bh=W4mOqaTr+peJFTZUrXoQ6lkkEWD+g7T5avZDT3doYhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ViXfDl/4j9a7kFy8MQakrEEEVEYKyprwxEhkl3lrzx4+ertuo/TNbVlR1YXEba1adOa6b0sBMYJCltKTKqFSElrkyVvrmJdvtL78ZeKFIfGBBLefwCsJXOD7euuvb4CYbdfRt6GApiKYIDs/rqI4f9nAkBQcGYKTUcljXcChGCxoHRINmicASAnqNb9xU2HWzM0rmRb5A1jb5oKF1Ca3STj9mpS/5PSUAOwp+7YjARKftAWFIfmhgSjOnfzFHWs/RO0uvMp3x1oHZtIshCzOiG2S1hOSg4fe4m8kMGMGdyZDSzUddNPnJuiksB9Lroffszv9AaM8uq8657agNBAANw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XvNtXpGF; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XvNtXpGF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqGGH73HVz2xST
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 09:17:27 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MI76P61129513;
	Tue, 22 Sep 2026 23:17:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=W4mOqa
	Tr+peJFTZUrXoQ6lkkEWD+g7T5avZDT3doYhc=; b=XvNtXpGFI7M64GmAM0eKOn
	Ez9YDnSv+8dHfplWXHdbNINKuesoJgcF07cTREqDEUyvTLscPEU4GzT7WG7dRXzV
	ph+FRYjvCMW38fScAIoExiGbL20KnGMXeGNRy77tzhZlzNmz21B9PCkjzbWNvmny
	H+oWp5g4Ql1ibDax9SDpmQXGpBS5/uSMmr1lphUt0l+uV/5bDcZhyAmK8jxabLTj
	8SrVCsc92PwFakbkC/S0n479H3v6PTgGpu+k8yYImpcERn7PbJHuHr29I7iaC6mG
	54McP5uf5ev+Sj4GnYLRd2LHKBr33fbpbtPV/G1ksugTy3V3P6eM714YF49wQuOw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2gdd9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 23:17:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68MN4GB43239754;
	Tue, 22 Sep 2026 23:17:22 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt67gutg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 23:17:22 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68MNHLs831851082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Sep 2026 23:17:21 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFD0558063;
	Tue, 22 Sep 2026 23:17:20 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19FFC5804B;
	Tue, 22 Sep 2026 23:17:20 +0000 (GMT)
Received: from [9.61.81.35] (unknown [9.61.81.35])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Sep 2026 23:17:19 +0000 (GMT)
Message-ID: <0c5c6aa9-04d4-41fa-8cb4-f5ac55a8f63a@linux.ibm.com>
Date: Tue, 22 Sep 2026 16:19:06 -0700
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
Subject: Re: [PATCH v10 8/9] scsi: ibmvfc: register and use asynchronous sub
 CRQ for events
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com
References: <20260911054832.1311668-1-tyreld@linux.ibm.com>
 <20260911054832.1311668-9-tyreld@linux.ibm.com>
Content-Language: en-US
From: Tyrel Datwyler <tyreld@linux.ibm.com>
In-Reply-To: <20260911054832.1311668-9-tyreld@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: p0jD9hk_-aHqMM7OPqq7qPO1cDHNsAMA
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab30c83 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=dxymRrk4hePnmNfmlPsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDMwNSBTYWx0ZWRfX3E7qb+r7RQ6L
 q3ZCUsY8CRvX5Nunsz1N6aVoJGIqLVlCzcWSZ33QYmo8V30/yGzPZJhuFkkbetDiZHkKhCzJbjV
 x96JShds+DF76h91jp5ZaSJH1bNFRSEldH+2dtEY95SC9gVLQ1e9wlRA8GjlfLblVJP1566IxXL
 XoIAbbaZKmNPWhnOzc9hDQCmDSFunJcONZsT+hkDsIjBPV5j4ODgVqkOVkEhITIekrJ/YzPV0Vr
 13Vx4Bn2UJ3bEC4NjzoHan/xrQTcnSKJE6OhAwQ9R3aPq9gITip9ZZeqC+mIMSJb+x1TPqT7ENN
 cocjj/duD70PfpxG6AHtmRbOcneS3pQ/kVYgxZ8vSjajbCnRf14+F/KCRXXPTWT3jgyKyjjfQIp
 qP+oRoEZmv4Ovj50rCotunX1J2T0Ek822sIHWnsgYkxR563Ih3tq0KpEF6mZKFZN8iC0y9h+hiW
 xKt95m795J7I62nkJEQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDMwNSBTYWx0ZWRfX0rzbB+lbtywZ
 Q1IGzmOfUpGwN7Ocl5paQ6TowgX+6UcDPjPASZzt40xZcM8bqN82cilBaJMRbcoP1tbLs5Ri/Bd
 fpkM/D/UJG426Bd4lc9s3A0n/v142YQ=
X-Proofpoint-GUID: p0jD9hk_-aHqMM7OPqq7qPO1cDHNsAMA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220305

On 9/10/26 10:48 PM, Tyrel Datwyler wrote:
> From: Dave Marquardt <davemarq@linux.ibm.com>
> 
> Wire the async sub-CRQ into the sub-CRQ lifecycle so it is allocated,
> registered, and freed alongside the SCSI channel queues.
> 
> In ibmvfc_init_sub_crqs(), allocate the async sub-CRQ queue buffer via
> ibmvfc_alloc_queue() before allocating the SCSI channels. Register it
> with the VIOS by calling ibmvfc_register_channel() with index -1 (the
> negative-index sentinel introduced in the previous commit). Either
> failure disables multi-queue and aborts init.
> 
> In ibmvfc_release_sub_crqs(), ibmvfc_reenable_crq_queue(), and
> ibmvfc_reset_crq(), deregister and re-register the async sub-CRQ
> alongside the SCSI channel queues.
> 
> In ibmvfc_channel_setup_done(), capture the async sub-CRQ handle
> returned by the VIOS in the channel setup response and store it in
> vhost->async_sub_crq.vios_cookie.
> 
> In ibmvfc_set_login_info(), advertise IBMVFC_USE_ASYNC_SUBQ,
> IBMVFC_CAN_HANDLE_FPIN, and IBMVFC_YES_SCSI capabilities whenever
> multi-queue channels are enabled. IBMVFC_YES_SCSI was previously only
> set for NVMe-enabled configurations; move it to the common multi-queue
> path so it is always advertised when channels are in use.
> 
> Fix a variable-shadowing bug in ibmvfc_register_channel() where the
> irq_failed cleanup loop reused rc for the H_FREE_SUB_CRQ hcall result,
> clobbering the error code returned to the caller. Introduce hcall_rc
> for the cleanup loop instead.

I think this should be its own patch.

> 
> Guard the memset() in ibmvfc_deregister_channel() behind a check of
> scrq->msgs.handle to prevent a NULL dereference when the function is
> called on a queue that was never allocated, such as async_sub_crq when
> multi-queue is disabled or initialization failed before
> ibmvfc_alloc_queue() was reached.

Same with this chunk.

-Tyrel

> 
> Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
> Acked-by: Tyrel Datwyler <tyreld@linux.ibm.com>
> ---
>  drivers/scsi/ibmvscsi/ibmvfc-core.c | 51 +++++++++++++++++++++++++----
>  1 file changed, 44 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
> index c78e221f182a..70a3046135c7 100644
> --- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
> +++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
> @@ -192,6 +192,8 @@ static void ibmvfc_tgt_move_login(struct ibmvfc_target *);
>  
>  static void ibmvfc_dereg_sub_crqs(struct ibmvfc_host *, struct ibmvfc_channels *);
>  static void ibmvfc_reg_sub_crqs(struct ibmvfc_host *, struct ibmvfc_channels *);
> +static void ibmvfc_deregister_channel(struct ibmvfc_host *, struct ibmvfc_channels *, int);
> +static int ibmvfc_register_channel(struct ibmvfc_host *, struct ibmvfc_channels *, int);
>  
>  static const char *unknown_error = "unknown error";
>  
> @@ -964,6 +966,7 @@ static int ibmvfc_reenable_crq_queue(struct ibmvfc_host *vhost)
>  	struct vio_dev *vdev = to_vio_dev(vhost->dev);
>  	unsigned long flags;
>  
> +	ibmvfc_deregister_channel(vhost, &vhost->scsi_scrqs, -1);
>  	ibmvfc_dereg_sub_crqs(vhost, &vhost->scsi_scrqs);
>  	ibmvfc_dereg_sub_crqs(vhost, &vhost->nvme_scrqs);
>  
> @@ -986,6 +989,7 @@ static int ibmvfc_reenable_crq_queue(struct ibmvfc_host *vhost)
>  	spin_unlock(vhost->crq.q_lock);
>  	spin_unlock_irqrestore(&vhost->host->host_lock, flags);
>  
> +	ibmvfc_register_channel(vhost, &vhost->scsi_scrqs, -1);
>  	ibmvfc_reg_sub_crqs(vhost, &vhost->scsi_scrqs);
>  	ibmvfc_reg_sub_crqs(vhost, &vhost->nvme_scrqs);
>  
> @@ -1006,6 +1010,7 @@ static int ibmvfc_reset_crq(struct ibmvfc_host *vhost)
>  	struct vio_dev *vdev = to_vio_dev(vhost->dev);
>  	struct ibmvfc_queue *crq = &vhost->crq;
>  
> +	ibmvfc_deregister_channel(vhost, &vhost->scsi_scrqs, -1);
>  	ibmvfc_dereg_sub_crqs(vhost, &vhost->scsi_scrqs);
>  	ibmvfc_dereg_sub_crqs(vhost, &vhost->nvme_scrqs);
>  
> @@ -1042,6 +1047,7 @@ static int ibmvfc_reset_crq(struct ibmvfc_host *vhost)
>  	spin_unlock(vhost->crq.q_lock);
>  	spin_unlock_irqrestore(&vhost->host->host_lock, flags);
>  
> +	ibmvfc_register_channel(vhost, &vhost->scsi_scrqs, -1);
>  	ibmvfc_reg_sub_crqs(vhost, &vhost->scsi_scrqs);
>  	ibmvfc_reg_sub_crqs(vhost, &vhost->nvme_scrqs);
>  
> @@ -1584,9 +1590,11 @@ static void ibmvfc_set_login_info(struct ibmvfc_host *vhost)
>  
>  	if (vhost->mq_enabled || vhost->using_channels) {
>  		login_info->capabilities |= cpu_to_be64(IBMVFC_CAN_USE_CHANNELS);
> +		login_info->capabilities |= cpu_to_be64(IBMVFC_USE_ASYNC_SUBQ);
> +		login_info->capabilities |= cpu_to_be64(IBMVFC_CAN_HANDLE_FPIN);
> +		login_info->capabilities |= cpu_to_be64(IBMVFC_YES_SCSI);
>  		if (vhost->nvme_enabled) {
>  			login_info->capabilities |= cpu_to_be64(IBMVFC_YES_NVMEOF);
> -			login_info->capabilities |= cpu_to_be64(IBMVFC_YES_SCSI);
>  			login_info->capabilities |= cpu_to_be64(IBMVFC_CAN_USE_WWPN_ALL);
>  		}
>  	}
> @@ -5811,6 +5819,7 @@ static void ibmvfc_channel_setup_done(struct ibmvfc_event *evt)
>  		for (i = 0; i < nvme->active_queues; i++)
>  			nvme->scrqs[i].vios_cookie =
>  				be64_to_cpu(setup->channel_handles[scsi->active_queues + i]);
> +		vhost->async_sub_crq.vios_cookie = be64_to_cpu(setup->async_sub_crq_handle);
>  
>  		ibmvfc_dbg(vhost, "Using %u SCSI channels\n",
>  			   scsi->active_queues);
> @@ -5870,6 +5879,7 @@ static void ibmvfc_channel_setup(struct ibmvfc_host *vhost)
>  		for (i = 0; i < nvme_channels; i++)
>  			setup_buf->channel_handles[scsi_channels + i] =
>  				cpu_to_be64(nvme->scrqs[i].cookie);
> +		setup_buf->async_sub_crq_handle = cpu_to_be64(vhost->async_sub_crq.cookie);
>  	}
>  
>  	ibmvfc_init_event(evt, ibmvfc_channel_setup_done, IBMVFC_MAD_FORMAT);
> @@ -6834,6 +6844,7 @@ static int ibmvfc_register_channel(struct ibmvfc_host *vhost,
>  	bool is_async = index < 0;
>  	struct ibmvfc_queue *scrq = !is_async ? &channels->scrqs[index] : &vhost->async_sub_crq;
>  	int rc = -ENOMEM;
> +	int hcall_rc;
>  
>  	ENTER;
>  
> @@ -6902,8 +6913,8 @@ static int ibmvfc_register_channel(struct ibmvfc_host *vhost,
>  
>  irq_failed:
>  	do {
> -		rc = plpar_hcall_norets(H_FREE_SUB_CRQ, vdev->unit_address, scrq->cookie);
> -	} while (rc == H_BUSY || H_IS_LONG_BUSY(rc));
> +		hcall_rc = plpar_hcall_norets(H_FREE_SUB_CRQ, vdev->unit_address, scrq->cookie);
> +	} while (hcall_rc == H_BUSY || H_IS_LONG_BUSY(hcall_rc));
>  reg_failed:
>  	LEAVE;
>  	return rc;
> @@ -6953,8 +6964,10 @@ static void ibmvfc_deregister_channel(struct ibmvfc_host *vhost,
>  	}
>  
>  	/* Clean out the queue */
> -	memset(scrq->msgs.crq, 0, PAGE_SIZE);
> -	scrq->cur = 0;
> +	if (scrq->msgs.handle) {
> +		memset(scrq->msgs.crq, 0, PAGE_SIZE);
> +		scrq->cur = 0;
> +	}
>  
>  	LEAVE;
>  }
> @@ -6971,7 +6984,9 @@ static void ibmvfc_reg_sub_crqs(struct ibmvfc_host *vhost,
>  	for (i = 0; i < channels->max_queues; i++) {
>  		if (ibmvfc_register_channel(vhost, channels, i)) {
>  			for (j = i; j > 0; j--)
> -				ibmvfc_deregister_channel(vhost, channels, j - 1);
> +				ibmvfc_deregister_channel(
> +					vhost, channels, j - 1);
> +
>  			vhost->do_enquiry = 0;
>  			return;
>  		}
> @@ -7026,16 +7041,26 @@ static int ibmvfc_alloc_channels(struct ibmvfc_host *vhost,
>  
>  static void ibmvfc_init_sub_crqs(struct ibmvfc_host *vhost)
>  {
> +	int rc = 0;
> +
>  	ENTER;
>  	if (!vhost->mq_enabled)
>  		return;
>  
> -	if (ibmvfc_alloc_channels(vhost, &vhost->scsi_scrqs)) {
> +	rc = ibmvfc_alloc_queue(vhost, &vhost->async_sub_crq, IBMVFC_SUB_CRQ_FMT);
> +	if (rc) {
>  		vhost->do_enquiry = 0;
>  		vhost->mq_enabled = 0;
>  		return;
>  	}
>  
> +	/* register async_sub_crq channel */
> +	if (ibmvfc_register_channel(vhost, &vhost->scsi_scrqs, -1))
> +		goto free_async_sub_crq;
> +
> +	if (ibmvfc_alloc_channels(vhost, &vhost->scsi_scrqs))
> +		goto deregister_async_sub_crq;
> +
>  	ibmvfc_reg_sub_crqs(vhost, &vhost->scsi_scrqs);
>  
>  	if (vhost->nvme_enabled) {
> @@ -7046,6 +7071,15 @@ static void ibmvfc_init_sub_crqs(struct ibmvfc_host *vhost)
>  	}
>  
>  	LEAVE;
> +	return;
> +
> + deregister_async_sub_crq:
> +	ibmvfc_deregister_channel(vhost, &vhost->scsi_scrqs, -1);
> +free_async_sub_crq:
> +	ibmvfc_free_queue(vhost, &vhost->async_sub_crq);
> +	vhost->do_enquiry = 0;
> +	vhost->mq_enabled = 0;
> +	return;
>  }
>  
>  static void ibmvfc_release_channels(struct ibmvfc_host *vhost,
> @@ -7069,6 +7103,9 @@ static void ibmvfc_release_channels(struct ibmvfc_host *vhost,
>  static void ibmvfc_release_sub_crqs(struct ibmvfc_host *vhost)
>  {
>  	ENTER;
> +	ibmvfc_deregister_channel(vhost, &vhost->scsi_scrqs, -1);
> +	ibmvfc_free_queue(vhost, &vhost->async_sub_crq);
> +
>  	if (!vhost->scsi_scrqs.scrqs)
>  		return;
>  


