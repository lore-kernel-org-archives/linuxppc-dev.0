Return-Path: <linuxppc-dev+bounces-28230-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A06C9830E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 19:01:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hs0RN3DHcz2yNH;
	Sat, 26 Sep 2026 05:01:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790362880;
	cv=none; b=Z9bbogQpbmvz8o+AMqYdMDDRcIeghfY63KmS2xuRvam03AZD6s+zvLDQ5Tjw6UCA0oRel4TIdfRGTJ1VIzQDTlNRV9Z9AEF18ln1IPRDhsthrlEc7cCrXcy++AlwXFho1Db4xM4vfoYlUJSBYYuCtRUKTgbV7Yk1HrakrAXNPzPpHr2jDERMQkgBNsvfb9In7aSe/YwqrAkFrbWCvyVbonNc+o6KSLFTh4KrDdZ4s/mGAGjqG7lB1DJiQ79P0C3cysRrUh1hrRqj8Vy3pPFz2lIKkLKzeegL2XQnt4kr+c6BdoSP7yeI2ko0Gw3qDxoyR9x4rvfdeIa+vcy37hNBfw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790362880; c=relaxed/relaxed;
	bh=hTaIxdftBS9s0aKtIe/SSscDfRnX/q76Myl7Mmq25ss=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lvdUkbXnl15URUmqe1cVhbDlkqRSVReXnRYqytXB5oonyvqZsG6PUNEX4pwZHfaGtOY/JUwzkV1T14AVNguNHTDSSJY8p2bfwdfD061cgX3OQrMvBZgCa0SFmJQJFBda9tMtav7vdBJ2ZGIIKC2nWOyJV4uenP0qrSeN6cH+SloYZNd7OF0UBTAeZ0Ix7wuPcMeF1kbKWRQOw0NG7KZwbtbSvkCHygV2Utb+VPDqUOnMEqScXTZ2k7PjsuDqbQf+rpoBISjNjwB7wcGf1ZZycuSa+RMCVKED9BC7rI1coclUhAO6tTaI1oIjVPOb2+w5Vg4qmtJ1BoGwIh0JmGJ/Uw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DYa2SgL/; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=davemarq@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DYa2SgL/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=davemarq@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hs0RM2BzLz2yMm
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 05:01:18 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PG6EWv1530717;
	Fri, 25 Sep 2026 19:01:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=hTaIxdftBS9s0aKtIe/SSscDfRnX/q
	76Myl7Mmq25ss=; b=DYa2SgL/eOXaft9FS8tWNxhcCZhx/ykZHGjqcRJxmDipfF
	308MfT3b5Q4m3lCmDYWC97SAPRZT9mrR0tiUmGMT2VyaiM1GTigy3vB6EryyH7Cg
	2of4Ec0q1RP7pCfxBRLhPe9WKsEajk8Q+WZQZClEE2DdB3cVOZLcbgM6ArDjkxU8
	CtusPfPoTDYRxSe30LsA1QraGg+XAoOhzwsD/zqDVamZ3CJA+c+344lV0n7vWxhB
	JaJuccviAUPMJOC2E8bQ59x1P2PeSp2QJ6cIwp2jeBrQw1BXCR3spjA/xvTXt/Ge
	VlNvfDgw/90IPRI8VoGa5TwcYcWwO4Cmb51d9G0g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg30v3t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 19:01:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68PIm0ee3043817;
	Fri, 25 Sep 2026 19:01:08 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvu7efva0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 19:01:08 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PJ153g14811792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 19:01:06 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE0DA5805D;
	Fri, 25 Sep 2026 19:01:05 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00F445805F;
	Fri, 25 Sep 2026 19:01:05 +0000 (GMT)
Received: from d (unknown [9.16.59.154])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 25 Sep 2026 19:01:04 +0000 (GMT)
From: Dave Marquardt <davemarq@linux.ibm.com>
To: Mingming Cao <mmc@linux.ibm.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
        andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com, stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] ibmveth: h_free logical LAN on open-fail after
 register
In-Reply-To: <7a56fbfb9e0674f011f4e310fbd7dfd8e67c30aa.1790357373.git.mmc@linux.ibm.com>
	(Mingming Cao's message of "Fri, 25 Sep 2026 11:05:29 -0700")
References: <cover.1790357373.git.mmc@linux.ibm.com>
	<7a56fbfb9e0674f011f4e310fbd7dfd8e67c30aa.1790357373.git.mmc@linux.ibm.com>
Date: Fri, 25 Sep 2026 14:01:04 -0500
Message-ID: <87jyo917gv.fsf@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: IoX1rp9zmChx61FOk3tzdZ8-hN9d_gfH
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab6c4f5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=Upk1lBxnHq3MJdZ7FDEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3NCBTYWx0ZWRfXywonysU5zfCl
 0sykjRxg7qtMqIiYwklJKwSB/MpbN3jYfpMgms8Y9O46lfmVAzd9AvQOX7Qi5hvzb8rtobPB3ES
 W2x+Oa0XoeaXspujRvYlAEgGiCOXlgFLCQS3uAMEB/WDHfupxkUToiO9Wbz4N05OBEaLV3svru5
 uzwSzgcG5oyNw3JlwS7mSUv/0WYmSJYjkuxNYfbCls5YDOflHacMnqbxi9n6/3fKfVwX6AQSZ/H
 sYUorrPZdgyQgkV3brzpXQxLyOwxKClgr9t2HYERLtlEnq7a408PEeortIQAcCLCpDICp08USMD
 17UzD5QhcVxViMTlP8dq7x5hMmG47TkZKYTyatOSRcIuCnSJYbYBeEFbBufiOj9dQeB63tfjfbT
 01yzuMOKKRvIS5mXhNVELm+/dt7yGccsXLsgv5XZ105XDxGNHR+kb+ckYfvmrkrS3L56LxHs10j
 bPP9yJ03ph/lCG+1YBA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3NCBTYWx0ZWRfX7mB07K0ioE+s
 sLP3T0Mg8xAn+oCArh1x3YiyFYzUSgBXQY8DFL8Px0KCsn7IEFY/RCCKpVbWQdlbvxMXXA8vxFu
 yA3BbCvE/GL/yAbEu80yD/nuDTgqCy4=
X-Proofpoint-GUID: qHkBE4jgKkgIzDOukAyAkToDtDL2AHj0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250074

Mingming Cao <mmc@linux.ibm.com> writes:

> ibmveth_open() registers the logical LAN, then allocates the RX
> buffer pools. A pool failure jumps to out_free_buffer_pools without
> h_free_logical_lan(), so PHYP still owns the buffer-list page when
> it is unmapped. request_irq() failure already issued the hypercall
> before taking the same label.
>
> Move that h_free to the shared post-register unwind so both paths
> deregister before the buffer list is unmapped.
>
> Fixes: d43732ce021f ("ibmveth: properly unwind on init errors")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
> ---
>  drivers/net/ethernet/ibm/ibmveth.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 73e051d26b9d..3e44f6b714d4 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -718,10 +718,6 @@ static int ibmveth_open(struct net_device *netdev)
>  	if (rc != 0) {
>  		netdev_err(netdev, "unable to request irq 0x%x, rc %d\n",
>  			   netdev->irq, rc);
> -		do {
> -			lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
> -		} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
> -
>  		goto out_free_buffer_pools;
>  	}

This code change is good. But I noticed another thing that's a pretty
minor bug of useless code just after this:

	rc = -ENOMEM;

rc isn't used in that code path after it is set. Is there some reason I
do not understand to have this here?

> @@ -737,6 +733,9 @@ static int ibmveth_open(struct net_device *netdev)
>  	return 0;
>  
>  out_free_buffer_pools:
> +	do {
> +		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
> +	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
>  	while (--i >= 0) {
>  		if (adapter->rx_buff_pool[i].active)
>  			ibmveth_free_buffer_pool(adapter,

Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>

