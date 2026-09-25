Return-Path: <linuxppc-dev+bounces-28231-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC144C9830E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 19:08:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hs0bY15SJz2yNH;
	Sat, 26 Sep 2026 05:08:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790363305;
	cv=none; b=Tlu8jVrheMsnwaqlWLzkjsLvkO21j/D2XgWGYUadQauvsKc4WiklcXhdG2s5QISNnv9WmoIIauLRILHxpFIvA/PF4rvMiBkFQy158kWd9BvdRpNeRD6D2Uk9bSY1d5yqNwzNtAyMaKykF7EoND6BB4/IU4D6ynx9M/zMxIZJipZxqe70sh4HGGwteh2Ob10ChClNaODhyVqRKV8Oh/NOBhmhvTdUn21UmqJHK2bE0u+jtamDfVw7ASWHm038x6pHrjTnSodRd43EH/wJpK4EmJ8Y6TFKNZf+nLkegI16fDKxFJ0QrNUApQLsG5Hx0SSvN3HNtoaltaegENSVjoXxtg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790363305; c=relaxed/relaxed;
	bh=MA6UEwiYd5ogH0sMx09PLSV5wmVjs8c/eNl8l425zHQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bMBHpaJLkad5/dyseQZZUyLa9gNnxyXpAS3nJZe7pGXzOyCAs+orNHnt6R/bMf/coLYYpVRVypuKzEmI+wa+e3piy/bqgzowlSuyAqFID+lqQJs2wwT7s2uaHHjKhGGHwfuj2SLLPsD9CKLqF2hPqWO0GAR15pjykWm3GAvaunTisqvxb0u8c6ErM35VrwgFkh3ffdazaQtsK37W/K5uAge4avRyM++kxUeRPW4XM7qrk72OhGRRBXFd25By3XQtatpOnKwv9IixkvQt3B/Q7paFQuZ/jEzupLSJ5yhC94nEb+7xw43VJ0P4gyVqI9BkzfwnzGMiHExdg7XonTd1WA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=q0P+p4ZB; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=davemarq@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=q0P+p4ZB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=davemarq@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hs0bX1kF6z2yMm
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 05:08:23 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PJ5TlF711728;
	Fri, 25 Sep 2026 19:08:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=MA6UEwiYd5ogH0sMx09PLSV5wmVjs8
	c/eNl8l425zHQ=; b=q0P+p4ZBcrjsvXn4yEiJq3cCGvrsMDtiumiOwss6P12CyZ
	cBkbNzmA9SXYDQIFopkNTgD9SkD/7gCQZju37ZxVoVrOXlVD3V9V2JYzSaZlFmD8
	7pnvHN5p15LlCirRc99vOh7e32uc4rVtERNua0NbR6cQqiTZY+uDxy0nXdfG+0Lp
	QZQTazRuhyz+4ukFIDeYH7SwW0iq9hp2DGTxrgMDeJgLHRkjYmTeT9tG9G1dJLfi
	5IoaGeLCoNyQRfXHVGhDX/N4qqJw59No0ee5yYmkrhDHAVwwHvGlRLzme7hnmXBN
	sGspDYllufsnfnT398cMRKO3J1gCF3d8GuFIhMhw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqypn9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 19:08:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68PImR0h130658;
	Fri, 25 Sep 2026 19:08:11 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbu93k7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 19:08:11 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PJ89Uc30081758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 19:08:09 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 773FB58054;
	Fri, 25 Sep 2026 19:08:09 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B686A58045;
	Fri, 25 Sep 2026 19:08:08 +0000 (GMT)
Received: from d (unknown [9.16.59.154])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 25 Sep 2026 19:08:08 +0000 (GMT)
From: Dave Marquardt <davemarq@linux.ibm.com>
To: Mingming Cao <mmc@linux.ibm.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
        andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com, stable@vger.kernel.org
Subject: Re: [PATCH net 2/2] ibmveth: fix TX LTB and filter unwind on open-fail
In-Reply-To: <d14314c2b10f125f5e578782484ba3cc50564d53.1790357373.git.mmc@linux.ibm.com>
	(Mingming Cao's message of "Fri, 25 Sep 2026 11:05:30 -0700")
References: <cover.1790357373.git.mmc@linux.ibm.com>
	<d14314c2b10f125f5e578782484ba3cc50564d53.1790357373.git.mmc@linux.ibm.com>
Date: Fri, 25 Sep 2026 14:08:08 -0500
Message-ID: <87fqyx1753.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
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
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab6c69c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=7IaaROpGTpDGSeW4PiYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3NiBTYWx0ZWRfX8wu0hJAnPWnn
 kjmJUcbgtpObQ3NWiqF1cPlU3ChXuK3KE+y2pH1+USZQJENLi5N3cbqzJENPATFrlvyKfhcFce8
 Hejq7L8Kg8kFcdJCJYhgkH3MbSULYMCLPRnHZakYxEg2+6coB+QX4hFxCEWFXf15kzCMHnb8OMi
 4CzhdCSfZkAjsecYl5bRHOwYNQFVsgQM93T+qsBhy4XqDQUOdTeXCAZwbewsckv1tfvBH3GIYE6
 jAGCB12aEPNNMiv6rigZRyiRfU0M8XNnGJjIjZjnw8SCM9GomEpeDYP0ROrq45AR27A1gfZvgnN
 KZil0P41KqKwCVQAngi0mE0GqxBfW6TK16pc9AlZFqNBlGVJQ0bpC7rdHX5Fxo1Ts9L+I0nb7kv
 vBvPNU+b/564/GfIXeM7PUCSY4AzZA0MLBE2H1GAievA54zYUuS8tr1ri2fGUv7gOxLen1cQ1W2
 LoWU4jeGn9rbUSLholQ==
X-Proofpoint-ORIG-GUID: fvNnSfnAC9mp_V-dVAMU5fDwGNFKrfC3
X-Proofpoint-GUID: SWoglV9uMmL2toe3TsugYA7LprriscG8
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3NiBTYWx0ZWRfX0QBFfQL2jtUS
 JsxObfYTvJD26y44tjdenXeof9QcYc0K3Qh5sTQ2XFmRVPBBXALLKbPXBqxrxur20adTdmgttqz
 ArBbDSwbx4/zWQOWonZZ5aA0urG0ZKQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1011 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250076

Mingming Cao <mmc@linux.ibm.com> writes:

> out_free_buffer_pools reuses open()'s loop index for the TX LTB
> walk. After the pool unwind i is -1, so the TX buffers allocated
> earlier are leaked. request_irq() failure has the same leak.
>
> The TX-fail goto on that walk also skips dma_unmap of the filter
> list (pre-existing since the LTB was added). Rewrite the TX walk
> to real_num_tx_queues with a pointer check, and unmap the filter
> list before those frees.
>
> Fixes: d926793c1de9 ("ibmveth: Implement multi queue on xmit")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
> ---
>  drivers/net/ethernet/ibm/ibmveth.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 3e44f6b714d4..abebdb1fc262 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -553,10 +553,15 @@ static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
>  
>  static void ibmveth_free_tx_ltb(struct ibmveth_adapter *adapter, int idx)
>  {
> +	void *ptr = adapter->tx_ltb_ptr[idx];
> +
> +	if (!ptr)
> +		return;
> +
> +	adapter->tx_ltb_ptr[idx] = NULL;
>  	dma_unmap_single(&adapter->vdev->dev, adapter->tx_ltb_dma[idx],
>  			 adapter->tx_ltb_size, DMA_TO_DEVICE);
> -	kfree(adapter->tx_ltb_ptr[idx]);
> -	adapter->tx_ltb_ptr[idx] = NULL;
> +	kfree(ptr);
>  }
>  
>  static int ibmveth_allocate_tx_ltb(struct ibmveth_adapter *adapter, int idx)
> @@ -667,7 +672,7 @@ static int ibmveth_open(struct net_device *netdev)
>  
>  	for (i = 0; i < netdev->real_num_tx_queues; i++) {
>  		if (ibmveth_allocate_tx_ltb(adapter, i))
> -			goto out_free_tx_ltb;
> +			goto out_unmap_filter_list;
>  	}
>  
>  	adapter->rx_queue.index = 0;
> @@ -745,10 +750,8 @@ static int ibmveth_open(struct net_device *netdev)
>  	dma_unmap_single(dev, adapter->filter_list_dma, 4096,
>  			 DMA_BIDIRECTIONAL);
>  
> -out_free_tx_ltb:
> -	while (--i >= 0) {
> +	for (i = netdev->real_num_tx_queues - 1; i >= 0; i--)
>  		ibmveth_free_tx_ltb(adapter, i);
> -	}
>  
>  out_unmap_buffer_list:
>  	dma_unmap_single(dev, adapter->buffer_list_dma, 4096,

Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>

