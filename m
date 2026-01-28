Return-Path: <linuxppc-dev+bounces-16360-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CFBD25B4B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Jan 2026 12:31:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f1M8P2wSfz2xlK;
	Wed, 28 Jan 2026 23:31:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769603493;
	cv=none; b=ZWrZpFkmdJParWqnDkTeMlVc9SvSz2BzfjJaHOpZVnpy7QSWyJ2WbQ+Dh1yNmvhUy+0lSBEZSpark9YZsRxuSKs+PJwvRLropkwGRNI93KhYKTnMX4Zr4bbYrLWpmGI0aBXB89D6adUVgK4xmBwD9P/1oLV2Ig7o/ZBuQk7D2X3usLixoSrfAoD4EcdAg64UyzM6A4cunEOqWJBIH/wH/qTaw23ccARS28QyutfsXFeb42YEYa8Qk0QBndQvCtdeUvFturzfd46bHQ1u4zW6gdVjCUUMTYIcIwW3QGSusc3rJoLqIdfDVH/5hfu9ijUK74DYY/VmQJm++7UBZsycbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769603493; c=relaxed/relaxed;
	bh=tWaNz6nGIvltazfTcuVkbbMc1q157SSgKquCVG51bDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lIB2iDu3BL4Ae+4gvaZjr+5WXc73i4Qb410hhCVDiEVHTcJptcov9lSN9h9mv5KyD7cg26gmPKQxhENCBaiy0OnKA6taEDLcTghQvk2xpXo/vtn8TM7TMB/cvEMXTOcaPJx/FBtywqUFQwsLSI6K2EUGZTAzoDln896goRp+6NRsJttPxmI8HIXunghbxXzIPQhRrwk/CuGtnpaPJ/76ZdOjD60qW5BnQpifdJBPZSOOXeu778kCHVeQK8feGVhcsC/WXNQjj+SpO4nWFUs1qpEjUVWrnkpcGmaItlIhIIP56DvMI9PFrfUYoUxTixkkSQmi2enAxGL579RABIY3ag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=X5XcT0VF; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=xueshuai@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=X5XcT0VF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=xueshuai@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f1M8N1RGGz2xjK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2026 23:31:31 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769603486; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tWaNz6nGIvltazfTcuVkbbMc1q157SSgKquCVG51bDI=;
	b=X5XcT0VFstBfuc4kZh57tv8fWPh+wOw2ExxxkwVgNXyGqYiq7xK5agQSFZAf4v/UJp4rq8JdYBZmyw7xXWZbL34YjKl4ua9gl4mJDxbd5q+l9NXWTU8IGROw3rhwtKJgasWfUSrpwftjOqtXC3uqKAdkhTPTuk2mRrpbYHGfGmc=
Received: from 30.246.162.115(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wy3OTp4_1769603484 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 28 Jan 2026 20:31:24 +0800
Message-ID: <1af3cb40-778e-4035-870c-30f2062f080d@linux.alibaba.com>
Date: Wed, 28 Jan 2026 20:30:46 +0800
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
Subject: Re: [PATCH v7 4/5] PCI/AER: Clear both AER fatal and non-fatal status
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com, kbusch@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, mahesh@linux.ibm.com,
 oohall@gmail.com, terry.bowman@amd.com, tianruidong@linux.alibaba.com,
 lukas@wunner.de
References: <20260124074557.73961-1-xueshuai@linux.alibaba.com>
 <20260124074557.73961-5-xueshuai@linux.alibaba.com>
 <20260127103931.000058bb@huawei.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260127103931.000058bb@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/27/26 6:39 PM, Jonathan Cameron wrote:
> On Sat, 24 Jan 2026 15:45:56 +0800
> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> 
>> The DPC driver clears AER fatal status for the port that reported the
>> error, but not for the downstream device that deteced the error.  The
>> current recovery code only clears non-fatal AER status, leaving fatal
>> status bits set in the error device.
>>
>> Use pci_aer_raw_clear_status() to clear both fatal and non-fatal error
>> status in the error device, ensuring all AER status bits are properly
>> cleared after recovery.
>>
>> Fixes: aa344bc8b727 ("PCI/ERR: Clear AER status only when we control AER")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Shouldn't this be first patch in series to make it easier to backport?

Yes, you are right. Will move it as the first one.

> 
> Otherwise seems reasonable to me, but others know these flows better than me
> so hopefully we'll get some more review.
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Thanks.

Best Regards,
Shuai

