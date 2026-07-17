Return-Path: <linuxppc-dev+bounces-24331-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CA8C4450A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 01:54:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h1XzP0j67z2yVv;
	Fri, 17 Jul 2026 11:54:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784253297;
	cv=none; b=nDPKc75M5W7IMAQLYMkh6k2lcbHje9PKiBWKmDghiTneyh+UrNZGEw7LcXRFSirTRHtJ6lrQgFI5J+gm3KcA6uHvrRx6+ilPJBGNkjWQu5w5gchbbGo4XkFDu0UZFP/vrh4wJ2noO/amnDJlobKbD/CJbI75xUFGNMkVe7fdTFIcxWxHkRZqGxjtxXG/RZZ1YhAIykmyDy/+m13jRYMQwvld/Xb30hl4rUxPJ+GrrFGGvHBH2NFqa+BaBiDXKeHFt4ptyghZjK5yyHrLb6wkLbBuZ/uFaKqEXFehAujABNwd0TOuveLe0oNLNdHNHMGi290MMRbCW8a/w14QPwVJdw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784253297; c=relaxed/relaxed;
	bh=OJEHQmNdEC2sN5f3XgasghSD5UiDB7Syoohr2zDR1uU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IQhCvtxEp7LT43xycaLGLArYo+3Wiyyn46Yy5pwZvPhHU2tU+5o7ViBfCP4sg194Bn3cEql+fOux2yeJluwFWRxEp8u7ia59THCGOgsSE1gmQfDpqaCJYR9O47OkuLuX8fh/7r6AxYuZMc68U3cjgIXcyUB/olAscKkj88sVnvd6ynnZ4jrg1ZNtQUwYcIizeNg0ypXaZShBa7blntn2O0h2xZxwfZjcgOsNEvfaABl0jTE5kxbAVh7RgHRkehVxNndnhT0V/bpgxOdYIzRGDJv2PbQLrdvNOEIBIWeRQbD1xpdxzUtXjec2fLRU0RVgQhGzpVQx37fM19kPlxpH3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SAs53WHi; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SAs53WHi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h1XzN06JQz2yVd
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2026 11:54:55 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GNg8jP355458;
	Fri, 17 Jul 2026 01:54:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OJEHQm
	NdEC2sN5f3XgasghSD5UiDB7Syoohr2zDR1uU=; b=SAs53WHiLGyn7TiOqsw7sX
	GUgu5r0+omM5O0hhlSMLgSFX57U8nBMhCB65ZhB45GWc8ELkr7YVffE7ZpXgwkjn
	2NdE9IvWmEfy2suAShwP/q5J0tMoV2bnykdawRBvZQCfmGN6TjBPVmz3bH9XcqhU
	QXfWrTtN/cTQCYimG7CR1jLzbHmLPrIUnj5Fr56FJn07eKNkjPIyf/PiC5pyZpG+
	43LPtZRXRJTuKtsw94aDddNGUKPUJ4Tfb5EbDMn10VPc75TKFmZqZfQNSLSPxJVv
	oTNgDplm1bde9ydFH52ZLSu1eTOlQy/D08ApFpX8aOTyJsXS+VUDuWTUm3etr9bA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexx33p8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 01:54:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66H1nke2031766;
	Fri, 17 Jul 2026 01:54:41 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nhqkvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 01:54:41 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66H1sdD533227414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 01:54:40 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8F9858055;
	Fri, 17 Jul 2026 01:54:39 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 700E65804B;
	Fri, 17 Jul 2026 01:54:38 +0000 (GMT)
Received: from [9.61.118.188] (unknown [9.61.118.188])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Jul 2026 01:54:38 +0000 (GMT)
Message-ID: <e40c87d8-22d3-4cc2-ab93-8954d442163a@linux.ibm.com>
Date: Thu, 16 Jul 2026 18:54:37 -0700
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
Subject: Re: [PATCH net-next v3 12/15] ibmveth: Expose per-queue buffer pool
 details via sysfs
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        mpe@ellerman.id.au, davemarq@linux.ibm.com
References: <20260706193603.8039-13-mmc@linux.ibm.com>
 <20260714130142.1841365-1-horms@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260714130142.1841365-1-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Iv_nrKtrWsV7sjgzrhz-K84VFoFZa8CD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDAxMyBTYWx0ZWRfXx3k9Q1ETnU2G
 bgnVYDq4pdqZHdKj4KJ1YERs1MVjaYi9lhAKn+Jgdy4bwTWmgUSp7trty27wsnhl2hKGZFjcbz4
 1ARiI033pVxeTI0E62kk/shqhbB4TVIQ0/EeAUZ6E0RPqfWq+eQWisvb8S3CWkTkwBgb6zKwwmq
 1AlIiLY+Er8vzrhM6vtvhF9hWHlNXbgc/Q6SMpAe+IO+lilUi9QToPxEIYcB4qfjFeK4Lewteyg
 KtKzYdHtBklVluOV93mgwRhyQcDItVz2BXCvzYXieulp3ep0p3xlW4s17rgZoelnP5m0YBi1/X4
 9pTc6eDiBv7j554o+t6KkU7jkSJ6EgKmFV/3vnp19Up1vbcA7eW+zCs2Wm+m3czMPB/jx3YkmAA
 xEY527uabcYyhaRlsimSI/FVHcp3Rlm0hcoI78t8e6uz91R6XR0ozn9YZzfZIhhP1um7awBYcyk
 du6uptpBBmfMbbDPkVg==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a598b62 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=c92rfblmAAAA:8
 a=lJdDRbwrhYAqfkbdTpoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: 4l4g8XOIaUIQbgpjgbfUmTn9VVG2Pd37
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDAxMyBTYWx0ZWRfX+Rp2RLip7Qob
 g+rsKPrufPZRSE64pHnsgOHZJXOurASVoUTySThFAT2/jqo1kAzS9m8vtpLe+yLJzQaxE042/XG
 D+39/siQs0ZnOcVaQr4LGow3lwrG/3U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_08,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170013


On 7/14/26 6:01 AM, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> ibmveth: Expose per-queue buffer pool details via sysfs
>
> This commit adds a read-only sysfs attribute buffer_pools to the VIO device
> to expose per-queue buffer pool details dynamically. It outputs runtime per-queue
> buffer pressure metrics like size, active, and available buffers.
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index 4e3f49b6346fd..ecc472ee8f71f 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
>> @@ -2896,6 +2896,52 @@ static const struct net_device_ops ibmveth_netdev_ops = {
> [ ... ]
>> +static ssize_t buffer_pools_show(struct device *dev,
>> +				 struct device_attribute *attr,
>> +				 char *buf)
>> +{
>> +	struct net_device *netdev = dev_get_drvdata(dev);
>> +	struct ibmveth_adapter *adapter = netdev_priv(netdev);
>> +	int len = 0;
>> +	int i, j;
>> +
>> +	len += scnprintf(buf + len, PAGE_SIZE - len,
>> +			 "Queue  Pool  Size  BuffSize  Active  Available\n");
>> +	len += scnprintf(buf + len, PAGE_SIZE - len,
>> +			 "-----  ----  ----  --------  ------  ---------\n");
> [Severity: Medium]
> Does this buffer_pools_show() implementation violate the sysfs "one value
> per file" design rule?
>
> The attribute appears to dump a complex, multi-line ASCII table with headers
> and columns rather than exposing a single value per sysfs file.
*

  Agreed this is more of a diagnostic dump than a sysfs one-value

  attribute. In v4 I’ll move it to debugfs ?

*
>
> [ ... ]
>> @@ -3056,6 +3102,14 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
>>   
>>   	netdev_dbg(netdev, "registered\n");
>>   
>> +	rc = sysfs_create_group(&dev->dev.kobj, &ibmveth_attr_group);
>> +	if (rc) {
>> +		netdev_err(netdev, "failed to create sysfs attributes rc=%d\n", rc);
>> +		unregister_netdev(netdev);
>> +		free_netdev(netdev);
>> +		return rc;
>> +	}
> [Severity: High]
> If userspace brings up the interface immediately after register_netdev()
> succeeds, could adapter->work be scheduled before sysfs_create_group() fails?
>
> If this race occurs, unregister_netdev() does not synchronously cancel the
> work.
>
> Could the global workqueue execute the pending adapter->work item on freed
> memory after free_netdev() is called in this ibmveth_probe() error path?
*

  Good catch. remove() cancels the work, but this probe error path

  did not. Will cancel_work_sync() (and clean pool kobjects) before

  free_netdev() in v4.

*
> [Severity: High]
> This is a pre-existing issue in older error paths of ibmveth_probe(), but it
> is duplicated here: does this error path leak the adapter->rx_buff_pool
> kobjects?
>
> Since kobject_put() is not called on the pool kobjects before free_netdev()
> is executed, the kobjects remain attached to the VIO device with dangling
> pointers to the freed adapter memory.
>
> Could subsequent sysfs accesses to those pool kobjects trigger a
> use-after-free?
*

   Yes — that path (and some older probe failure paths) skip

   kobject_put() on the pool objects. I’ll add a common probe

   cleanup helper in v4 so pool kobjects and the reset work are

   always torn down before free_netdev().

*

Thanks,
Mingming


