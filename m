Return-Path: <linuxppc-dev+bounces-16808-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7AAE9E2FF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Feb 2026 12:43:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f9ym771KMz2xlk;
	Wed, 11 Feb 2026 23:43:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770813831;
	cv=none; b=J0pf+mR8LP3pTMOHG3+BRduwQFjYobUeLd3jp/NvRlv+rnAfupSCUk1hC+8Y1xs2kjjbe1H6wKnHw0DZFLcdF0hcQQGsl0XSbNA0lzjnYWY/QURtLCH5+apNwsVXr923pc1I7fg4Tfq/xHq4o4dvOGq9dr+uL2u6DKtAlgJmXIUF65eMb8hhTwPH8wpqbFXo5hivIjFOAjiYqg6S6UblSRVWQabvOKhkUCL0C9s5+ximgMNAVBZ4BWxtCoea0s0P/WZi6zM2LSrPjzSDDA6d+s8v3t3z3cQ20YHHbTa5Zgql1Ri8LuMtj1bmPZ2El4YBxqk6enTr5f65YYFcKRLPEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770813831; c=relaxed/relaxed;
	bh=nvF3yViqgBbFiJpVy33G6Z/vQg2LCKK9VFbBDNSQyEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nsNFJJjmNQ4do7Wj2d4bHLkaLVl81sx3HsE4dLLD/7ijgvoukACiPYQCkH1FqmmpsrHWvOKcOyy0X9xDBz8rZpN5ThDJnkZyjU7M/Hq5zhZl6Uqo1rfqsFkiaKv6fEaGj2LzDiS4kypHmCpokMbBBHlZkade6mOT/8nSChQichazsaTzRCXRvAZWasJqCSdu7zYZDo21NfyyMgGrpA8e4kuvO5Qqu0UivLJTT9iQkjz0uhISpbIPQ4vOi8jhDNbb32YXYi3tQCI8K4vjKmeZ2QLHCwKSH6nsbpkcUrMIt0VrhQHSjw3niyJAmbLMwBiblR4wtAJIOc9T/FuR8OXHIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VGI4mQXR; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=xueshuai@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VGI4mQXR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=xueshuai@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f9ym523jpz2xlM
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2026 23:43:47 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770813821; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=nvF3yViqgBbFiJpVy33G6Z/vQg2LCKK9VFbBDNSQyEY=;
	b=VGI4mQXRqKpB+Lu+7mhe1GWCIwbpWdgrmoEZuNbnphs+bSyTQpOQZmYK74Czc76FQHQiZuYve94i9zBAyViphNz/Ea7b3BIzwqQfVUTs4vWu7NvJ/wtbi70ozUFA9hyYEOBCaeC8JaVRLH+f4WS/Gc0b7buKwLQavq/TFdg0z4c=
Received: from 30.246.162.188(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wz1EWUB_1770813818 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Feb 2026 20:43:39 +0800
Message-ID: <c39b7e1f-8a02-459d-b008-2c620fbee462@linux.alibaba.com>
Date: Wed, 11 Feb 2026 20:42:15 +0800
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
Subject: Re: [PATCH v2] PCI/AER: Only clear error bits in PCIe Device Status
 register
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com, kbusch@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, mahesh@linux.ibm.com,
 oohall@gmail.com, Jonathan.Cameron@huawei.com, terry.bowman@amd.com,
 tianruidong@linux.alibaba.com, zhuo.song@linux.alibaba.com,
 oliver.yang@linux.alibaba.com
References: <20260211054816.22758-1-xueshuai@linux.alibaba.com>
 <aYx3Uy7rE6GM9xq-@wunner.de>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <aYx3Uy7rE6GM9xq-@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/11/26 8:34 PM, Lukas Wunner wrote:
> Isn't there one too many blanks before each of the PCI_EXP_DEVSTA_* macros?
> 
> The available space would be sufficient to accommodate two macros per line,
> so just 2 instead of 4 lines for the macros.
> 
> Otherwise this is:
> Reviewed-by: Lukas Wunner<lukas@wunner.de>

Sure, will send a new patch to fix it.

Thanks.
Shuai

