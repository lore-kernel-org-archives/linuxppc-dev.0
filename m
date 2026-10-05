Return-Path: <linuxppc-dev+bounces-28915-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7395BCA5FE2
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Oct 2026 06:27:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hyqFK6g40z2yjw;
	Mon, 05 Oct 2026 17:27:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791181669;
	cv=none; b=RasqZ+A7Gmtvt++q6WLFswpI1UUSC/lNtxgO/Rta2AilDQE4LAi+mhjVsjYLY83vqe2rJdZ2sfx5CMT5HQuWTagmGlcO6sM4E2inPtJrwUTH1PkvsO7H65ij9Y2pekSDc7Y3ypb3ZGAo6eEkSBvahcpTu//3x3rG7PSGtUXXvJNfVKCuu1qgfN9DkB1BL4P/conh0+yPadGdoHGztwXR+rzAyekJHnU0HGlhQnftCWxI/Gw3gxEvK5V+e0PT3byHmBHEq7gFaKSiCWmwAQM1GD9wn30yMUgXJKfcwtfSwS1hphVCM9j7C6jOwQ7NKGOyz19wut6mcYOtETYbEEcMgw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791181669; c=relaxed/relaxed;
	bh=KWRHNp7m2hNhZ4zXM3os5Hl5nHIxcvWa0uLmAhkFliE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PEK3J0ek26eoIyOTZfJOCG3DCenu/e08bm6tH/EbFbkbI8/AQ7yflI7gfjDzpxhN8koXkL8FThYSiIGNzkxv1TQIPhR3GxkxBOtw0LHZ1rLysug87moT9hCQYJOBi1tk/TU0gxXbHiqM3WvTJclQ3zo1KfmR/mdaOxxrMITz2k2Fvc4DtXUbGR4LgGhoyXZeMgXWvKeaRScUfMyVcO+19/Br2LV088mEIZdR0Qhfqho79ZSVivY0hDRXed7PALIpERE/Og+2XZ2Vi8K+HqG1Bs9PAgFGQJL5CQRl6vgO7wXJfreMiDGkDgea2sfQYaQHQV/XnBM2kY7N6/vUSHA14w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WryLUBJM; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WryLUBJM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hyqFJ3splz2yDm
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Oct 2026 17:27:47 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69516LCd3139378;
	Mon, 5 Oct 2026 06:27:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KWRHNp
	7m2hNhZ4zXM3os5Hl5nHIxcvWa0uLmAhkFliE=; b=WryLUBJMRP/5drkvEbcGc7
	JJA15itYMyKH/Ogh9gDkXowHBe6irF7XE5srMWS4HfwM967zx1SdS46uu/HrTYzd
	3H0t3WSHZHyg50TsU0Ps0bR7247fVt6QWlra/xtVp3/tXK3bH9LGr/Ns8zY+p4aA
	R13t8jEgfLUJaj/YamK0rXas31nIpFWZd9zRgn7P9m7mmMIeg0dZv/VBH+V7NFdf
	tjZDjlXSEuY7WIikmQFo0D4kG1UUkd52hH2Qr2kAk0iSs3+mePB3nvBXwBT5nPuV
	YYPMKCu1lbXViJ8ToWIIb+cQZky6fVsmBPy2GRJe/jAN8yFlmhrYH1sUggZpg2OQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4jgc9p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 06:27:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6956QvZ22165205;
	Mon, 5 Oct 2026 06:27:33 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3c1pmder-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 06:27:33 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6956RW1U11207398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 06:27:32 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9CA25806E;
	Mon,  5 Oct 2026 06:27:31 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D11375806A;
	Mon,  5 Oct 2026 06:27:29 +0000 (GMT)
Received: from [9.67.97.222] (unknown [9.67.97.222])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 06:27:29 +0000 (GMT)
Message-ID: <9879dd0a-2f1c-4833-b7b1-7cfd20ea946e@linux.ibm.com>
Date: Sun, 4 Oct 2026 23:27:29 -0700
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
Subject: Re: [PATCH net-next 5/7] ibmveth: release the pool kobjects when
 probe fails
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
        andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        davemarq@linux.ibm.com, bjking1@linux.ibm.com
References: <f0186ae5ac4f9838b01c23fc42391abc328f814f.1790991039.git.mmc@linux.ibm.com>
 <179107997848.434549.4525032963009141215@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <179107997848.434549.4525032963009141215@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: uwSRGk-KSUo8txCTrcLqyMID0-AC0Igd
X-Proofpoint-GUID: 1U_dth-67-IRF5cFiOPrwYux4ZE6MzSg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyNCBTYWx0ZWRfX+dBlDRjpzvde
 ++tC/jwHaTX+gIs5HxKRLAG1mBnYBP9tuHVCKycZdaFRcw42r0Ij6XCnxF1Ub7yS3a0gMVseCgk
 nqhJg8PwReEusJjoGSylnHiDVWdLu4Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyNCBTYWx0ZWRfX9jLuKTj5x8SF
 r6mSXsuLIuAwBHtAEeaMdWA9CYo+ndFM5Ft2sTzbZJv2KtRkvFpcKqoi+qmkzp7L5unCR7k6bIa
 eNTC+WrhIiny9/S0lTAfR8Cvsxb8+drXPAWJyrXZPPEzKP1tG0onw1si3GjJujgSTImj7ikJ7MK
 5NXh1E8ZZ/+/vWugfpEKWc9fK1y77AuWEKX/IbhKeyPsaDek6xwu+hHnjJO6UYqaCSC/0uVsiyB
 Aay5vAdXwxq6ZnpKG8hu6Qvo+Lr8cm2a/RveCqNmyKTFnC+LotxVaroigthhpDH+TZhaBIAkVRq
 IgrHcl/OBKVqv7MXS6trkwmXh0UAY7IcT7etyF/PnueT/CcfG7YxOC9GAg5aLukgABe9QoaLONu
 8GW++Cd29oFV6BUl2mA4I1smbmamYFh04q3PDKTUyy9nPyL1vOWDz/CHGDQkFNPdqy6oHqU3Fx6
 WM8Y1Ac7wditbBlFbYg==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac34356 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=7DkcN3C0X5N58BSoarIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050024


On 10/3/26 7:12 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [Medium] On the new err_put_pools path in ibmveth_probe()
>    (drivers/net/ethernet/ibm/ibmveth.c), the code calls kobject_put() on…
>
> --
>
> ibmveth: release the pool kobjects when probe fails
>
> This commit adds an err_put_pools unwind label to ibmveth_probe(). The label
> calls kobject_put() on each rx_buff_pool[i].kobj before free_netdev(). It is
> used when either netif_set_real_num_tx_queues() or register_netdev() fails.
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index b89ce389d951f..d5ba2f2650d0f 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> [ ... ]
>
>> @@ -1981,13 +1980,18 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
>>   
>>   	if (rc) {
>>   		netdev_dbg(netdev, "failed to register netdev rc=%d\n", rc);
>> -		free_netdev(netdev);
>> -		return rc;
>> +		goto err_put_pools;
>>   	}
>>   
>>   	netdev_dbg(netdev, "registered\n");
>>   
>>   	return 0;
>> +
>> +err_put_pools:
>> +	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
>> +		kobject_put(&adapter->rx_buff_pool[i].kobj);
>> +	free_netdev(netdev);
>> +	return rc;
>>   }
> [Severity: Medium]
> With CONFIG_DEBUG_KOBJECT_RELEASE=y, can this path still free the pool
> kobjects while their cleanup is pending?
>
> The kobjects are embedded in netdev_priv(netdev), and ktype_veth_pool has
> no release() callback:
>
> static struct kobj_type ktype_veth_pool = {
> 	.release        = NULL,
> 	.sysfs_ops      = &veth_pool_ops,
> 	...
> };
>
> On that config, kobject_release() defers the cleanup to a delayed_work
> that is embedded in the kobject itself:
>
> lib/kobject.c:kobject_release() {
> 	...
> 	INIT_DELAYED_WORK(&kobj->release, kobject_delayed_cleanup);
>
> 	schedule_delayed_work(&kobj->release, delay);
> 	...
> }
>
> free_netdev() then frees the adapter while that work is still armed. The
> work runs 1 to 4 seconds later. kobject_cleanup() then works on freed
> memory: it reads kobj->state_in_sysfs and kobj->name, calls
> __kobject_del(), and drops the parent reference.
>
> Until the work runs, the pool%d active, num and size files under
> /sys/devices/vio/<unit>/ still exist. A read or write goes through
> veth_pool_show() or veth_pool_store(). Both use container_of() to reach
> the freed pool, adapter and netdev.
>
> A re-probe in that window could also fail to add pool0. That is the same
> failure this commit is meant to fix.
>
> The commit message mentions this and refers to ibmveth_remove(), which
> uses the same put-then-free pattern. kobject_cleanup() also reports this
> ktype as one that "does not have a release() function, it is broken and
> must be fixed".
>
> Calling kobject_del() before kobject_put() would remove the sysfs files
> synchronously. However, the delayed_work inside the freed adapter would
> still be armed.
>
> Would it make sense to give the pool kobjects their own lifetime? One
> option is to allocate them separately with a real release() callback.

Yes. v2 adds a release() for the pool kobjects and waits for it before
free_netdev() in both probe and remove():

|https://lore.kernel.org/netdev/cover.1791178212.git.mmc@linux.ibm.com/|


pw-bot: cr

Thanks,

Mingming



