Return-Path: <linuxppc-dev+bounces-22658-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FA0CD98DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 19:54:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfLSK2cbvz3btP;
	Tue, 16 Jun 2026 05:54:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781553297;
	cv=none; b=ay6LsEZYy0lzJ/tQsY3dMIUbmgyGTqkzLTKU/GOYIEI97EWKX8U3Z/jttOu8iB1OxBTSGhv/E4RyQSfmRALJZF/VBAAsQLkvDpLz69Lbq64KoXYixDrpT8ugJ34WSi3uJ/v6bhQcUKdjZYnRMSXFO2r/rkJOTBU2eRihKzKW2B2KZ1M5B4XdbCIWUy106LnUn3POUZ/FCHxjxI6ns4glWnuX07kvfhE4OEeEkr3qVtWrR7ZOQ8dUZy47OI8xKqz+ZkIcOpQr+y8WQL6AJvghdvQXzT/DpW9XNbtwcBLrkBgAq6YMPURwh22qh3Qne7Sz7ZCcmuuzpO08d9mlwzG2oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781553297; c=relaxed/relaxed;
	bh=mh+LGvwO2uJvmOs3z+dciFGp1Pbu97IVh/PMyOWPorI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g7Wd5Q6CxJ8MDuX8aCZQ1WOa52usjcmEMxMZ0ZoFZ5is6vyt2LYjdan6CuoG2waVwg/aDCaFIxEITtJQqxocueOQNsWt2dJpFgEtficXyHO9iw4qodvZvbCPr7pe12ScgjwF36tK06tfTgcluZn8GCGb5DQmked8dFir+q3t2J3Y72KU0kXCUJD6k+pNshDs76M9pnIy4xn+07EMF52qiiAzksSU8kNgkYBagLwwXUUYy2qLHM+GRIlg80zG5mXfrcIbLxhT0W8KNRaSLgcVNaZeDHHu5q1SJMZo+V4pbAbiIfuNWbctm5QcQNJUGNYhRqzWTgAM4M28/XDHi3EnEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PIMDb91/; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PIMDb91/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfLSJ2P0dz3btJ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 05:54:55 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FJILEE3289731;
	Mon, 15 Jun 2026 19:54:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mh+LGv
	wO2uJvmOs3z+dciFGp1Pbu97IVh/PMyOWPorI=; b=PIMDb91/PkmOXhEJE7u2ku
	/wlNNxM+c/zVEBvZnry8iNXiEIJkmkhzUriHpjrGbbdmE/+BKBG9RNAwz9iheBp6
	yTlh7kz93WslA0vv9Wuse+WoQMWTshGIs0gEt1h+3wJaBdYc9g5Fg6wTSUY/v0vK
	shcWn8o+X4JjhdgQDjMV6hfzD1D05UDBx+eyFd3BSPO5P6O3X58doQ4AIu6e+3Dg
	BtySp9INj2Qmd5eO2+FAQ2chUuaM/BVpoFx7G3TgcZj8Gr/FDytG3hjo2lg4IGny
	zoh4s1G4igtOCfTDaXoXnEq+TpKnRLVZeRmoAWRja+TqL1Y6+OaswTCuSq+kg/9g
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es23njbus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 19:54:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FJnfnH008318;
	Mon, 15 Jun 2026 19:54:45 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4esk1h0380-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 19:54:45 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65FJshKD54985112
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 19:54:43 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A5EF58055;
	Mon, 15 Jun 2026 19:54:43 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AEC4758043;
	Mon, 15 Jun 2026 19:54:42 +0000 (GMT)
Received: from [9.61.95.246] (unknown [9.61.95.246])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Jun 2026 19:54:42 +0000 (GMT)
Message-ID: <09278991-08df-4b99-9076-8f90689412ee@linux.ibm.com>
Date: Mon, 15 Jun 2026 12:54:42 -0700
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
Subject: Re: [PATCH v2 5/7] ibmvfc: allocate asynchronous sub-queue
To: davemarq@linux.ibm.com,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Brian King <brking@linux.ibm.com>,
        Greg Joyce <gjoyce@linux.ibm.com>,
        Kyle Mahlkuch <kmahlkuc@linux.ibm.com>
References: <20260608-ibmvfc-fpin-support-v2-0-d41f540fba5c@linux.ibm.com>
 <20260608-ibmvfc-fpin-support-v2-5-d41f540fba5c@linux.ibm.com>
Content-Language: en-US
From: Tyrel Datwyler <tyreld@linux.ibm.com>
In-Reply-To: <20260608-ibmvfc-fpin-support-v2-5-d41f540fba5c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=6a305886 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=yFGOjSDTXq2hfcOwzZ8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIwOSBTYWx0ZWRfX9VoasedxrgC7
 wnHLwxeN9b3zIdu9x/QgigdYXlkXyKfTXGZ9KGm9xyhUsYMoMc//o4nTOg9zJXBFJjyQVx20mrT
 Aa3pidmrIhxkq5haFqaily0mgxoHfFSr90vHqh9coGYUvtlqM5LGKTSCArsK3jVcqTzSTX1jtuz
 vVT8QjxCK0wllRJsPK4NtPA3H8Voc9O3ugBs9iG9Lh55Z8SvRl1PY4RedCNnnfQHJNMpGX9xJUu
 iG0hI4dAo6iolbzrepdvuJbxOYjR4JW1JxurBdcV9mTGrACQFiWOOZbwB+d7PfQy/I6QJLTTtVq
 6Mlusudw/j9S6NQwgl0rQwdhgSKvecFUMyzeAP/mWFT77URYxjdp/OA1FAe8ERpR0MBg9ZJtQg6
 8Tn5RDuO2b1QmE6g7mNl/fsGgoSJV8OqG63Q/8QYNqapZcfs4DVruixJT1GJGpmiSnDxiIobY/h
 PsXF+8P0cxl7coAxkoA==
X-Proofpoint-GUID: wAHLPjN05jkuEPvXk6LzOSPiHN2kM7y2
X-Proofpoint-ORIG-GUID: vwTfv69ay2jNXuGf-S_yAJcV2c5T0cIj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIwOSBTYWx0ZWRfX0yV/xHnEVmK2
 yxWrNacjxsz2c1UPtY0uTntxkwCqBywtJD8gJ9OiT7xk+5kPpE0aLn/PgaFiiHfAY9LxOnpfnth
 nFc02hHgADDTyi4kKmiWbJqaOeZE7dk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150209

On 6/8/26 11:30 AM, Dave Marquardt via B4 Relay wrote:
> From: Dave Marquardt <davemarq@linux.ibm.com>
> 
> Allocate and set up the asynchronous sub-queue for asynchronous
> events, as required for full and extended FPIN support.
> ---
>  drivers/scsi/ibmvscsi/ibmvfc.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
> index a18861808325..ad1f5636e879 100644
> --- a/drivers/scsi/ibmvscsi/ibmvfc.c
> +++ b/drivers/scsi/ibmvscsi/ibmvfc.c
> @@ -5352,6 +5352,8 @@ static void ibmvfc_channel_setup_done(struct ibmvfc_event *evt)
>  			for (i = 0; i < active_queues; i++)
>  				scrqs->scrqs[i].vios_cookie =
>  					be64_to_cpu(setup->channel_handles[i]);
> +			scrqs->async_scrq->vios_cookie =
> +				be64_to_cpu(setup->asyncSubqHandle);
>  
>  			ibmvfc_dbg(vhost, "Using %u channels\n",
>  				   vhost->scsi_scrqs.active_queues);
> @@ -5402,6 +5404,7 @@ static void ibmvfc_channel_setup(struct ibmvfc_host *vhost)
>  		setup_buf->num_scsi_subq_channels = cpu_to_be32(num_channels);
>  		for (i = 0; i < num_channels; i++)
>  			setup_buf->channel_handles[i] = cpu_to_be64(scrqs->scrqs[i].cookie);
> +		setup_buf->asyncSubqHandle = cpu_to_be64(scrqs->async_scrq->cookie);
>  	}
>  
>  	ibmvfc_init_event(evt, ibmvfc_channel_setup_done, IBMVFC_MAD_FORMAT);
> @@ -6369,6 +6372,24 @@ static int ibmvfc_alloc_channels(struct ibmvfc_host *vhost,
>  	if (!channels->scrqs)
>  		return -ENOMEM;
>  
> +	channels->async_scrq = kzalloc_obj(*channels->async_scrq, GFP_KERNEL);
> +
> +	if (!channels->async_scrq) {
> +		kfree(channels->scrqs);
> +		channels->scrqs = NULL;
> +		return -ENOMEM;

This failure cleanup code starts duplicating here.

> +	}
> +
> +	rc = ibmvfc_alloc_queue(vhost, channels->async_scrq,
> +				IBMVFC_SUB_CRQ_FMT);
> +	if (rc) {
> +		kfree(channels->scrqs);
> +		channels->scrqs = NULL;
> +		kfree(channels->async_scrq);
> +		channels->async_scrq = NULL;

Again here plus freeing channels->scrqs memory.

> +		return rc;
> +	}
> +
>  	for (i = 0; i < channels->max_queues; i++) {
>  		scrq = &channels->scrqs[i];
>  		rc = ibmvfc_alloc_queue(vhost, scrq, IBMVFC_SUB_CRQ_FMT);
> @@ -6380,6 +6401,9 @@ static int ibmvfc_alloc_channels(struct ibmvfc_host *vhost,
>  			kfree(channels->scrqs);
>  			channels->scrqs = NULL;
>  			channels->active_queues = 0;
> +			ibmvfc_free_queue(vhost, channels->async_scrq);
> +			kfree(channels->async_scrq);
> +			channels->async_scrq = NULL;

And then again here. Could use goto to do the frees at the end of the function.

free_async:
	kfree(channels->async_scrq);
	channels->async = NULL;
free_scrqs:
	kfree(channels->scrqs);
	channels->scrqs = NULL;

return rc;

>  			return rc;
>  		}
>  	}
> @@ -6418,6 +6442,10 @@ static void ibmvfc_release_channels(struct ibmvfc_host *vhost,
>  
>  		kfree(channels->scrqs);
>  		channels->scrqs = NULL;
> +
> +		ibmvfc_free_queue(vhost, channels->async_scrq);

Looks like missing kfree(channels->async_scrq) here.

-Tyrel

> +		channels->async_scrq = NULL;
> +
>  		channels->active_queues = 0;
>  	}
>  }
> 


