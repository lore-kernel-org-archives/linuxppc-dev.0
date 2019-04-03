Return-Path: <SRS0=3bX/=SF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAD7C4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 09:08:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1C2A20882
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 09:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VKvmVjET";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DAdJOtkS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1C2A20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Z0cQ6XRszDqQH
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 20:08:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=codeaurora.org
 (client-ip=198.145.29.96; helo=smtp.codeaurora.org;
 envelope-from=mojha@codeaurora.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=codeaurora.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=codeaurora.org header.i=@codeaurora.org
 header.b="VKvmVjET"; 
 dkim=pass (1024-bit key) header.d=codeaurora.org header.i=@codeaurora.org
 header.b="DAdJOtkS"; dkim-atps=neutral
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Z0Zf6CdGzDq5n
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 20:07:06 +1100 (AEDT)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id C580760FF3; Wed,  3 Apr 2019 09:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1554282424;
 bh=DSkCp9suFSm4FVR7lP7OaPdF+0wJ9sUbA+7BjvF6/Vg=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=VKvmVjETsbPcwmyJZ4ok8k3io9VuoCG2Dq9yGrgoLQ55Z+HvASwnC020Skuf/jxGf
 hCxU9SC5JG06QP6jXeR9Qww+/lyaXKLf9OwEQoFKyIaEyBRDFNFwrtOcEtKpvfHqc8
 so49R8F36H20LFlyuuv5WtNlWUUvqkwaXXNpNy0Q=
Received: from [10.204.79.83]
 (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: mojha@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id DFA7560CED;
 Wed,  3 Apr 2019 09:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1554282421;
 bh=DSkCp9suFSm4FVR7lP7OaPdF+0wJ9sUbA+7BjvF6/Vg=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=DAdJOtkSSd4SGLKPI6NOUeT+OQbMP132UMTpZTGKarLBd5VvBFIgbsucXAkUqiN0g
 YMrxv4p6hGfNXNrdWnzDmZjWvsJYkG915hfi1rzjCwPtm1np7aFapO3cjNeIIdT0vu
 ebXgKIofIwzrY7J1xDCbCrb4bGEesepNbSJQ+9C8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DFA7560CED
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH -next] ibmvnic: remove set but not used variable 'netdev'
To: Yue Haibing <yuehaibing@huawei.com>, davem@davemloft.net,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 tlfalcon@linux.ibm.com, jallen@linux.ibm.com
References: <20190403075409.29384-1-yuehaibing@huawei.com>
From: Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <1fda3007-ace5-a3fc-4a1d-22120fec6717@codeaurora.org>
Date: Wed, 3 Apr 2019 14:36:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190403075409.29384-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


On 4/3/2019 1:24 PM, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/net/ethernet/ibm/ibmvnic.c: In function '__ibmvnic_reset':
> drivers/net/ethernet/ibm/ibmvnic.c:1971:21: warning: variable 'netdev' set but not used [-Wunused-but-set-variable]
>
> It's never used since introduction in
> commit ed651a10875f ("ibmvnic: Updated reset handling")
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   drivers/net/ethernet/ibm/ibmvnic.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
> index 25b8e04..20c4e08 100644
> --- a/drivers/net/ethernet/ibm/ibmvnic.c
> +++ b/drivers/net/ethernet/ibm/ibmvnic.c
> @@ -1968,13 +1968,11 @@ static void __ibmvnic_reset(struct work_struct *work)
>   {
>   	struct ibmvnic_rwi *rwi;
>   	struct ibmvnic_adapter *adapter;
> -	struct net_device *netdev;
>   	bool we_lock_rtnl = false;
>   	u32 reset_state;
>   	int rc = 0;
>   
>   	adapter = container_of(work, struct ibmvnic_adapter, ibmvnic_reset);
> -	netdev = adapter->netdev;
>   
>   	/* netif_set_real_num_xx_queues needs to take rtnl lock here
>   	 * unless wait_for_reset is set, in which case the rtnl lock
