Return-Path: <SRS0=XXYE=IV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD74C433DB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Mar 2021 16:28:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B38261477
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Mar 2021 16:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B38261477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F4cHq02s7z30hV
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Mar 2021 03:28:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.a=rsa-sha256 header.s=20150623 header.b=eDO9wyI0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.dk (client-ip=2607:f8b0:4864:20::d30;
 helo=mail-io1-xd30.google.com; envelope-from=axboe@kernel.dk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel-dk.20150623.gappssmtp.com
 header.i=@kernel-dk.20150623.gappssmtp.com header.a=rsa-sha256
 header.s=20150623 header.b=eDO9wyI0; dkim-atps=neutral
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F4cHM0Pcsz2yhF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Mar 2021 03:28:14 +1100 (AEDT)
Received: by mail-io1-xd30.google.com with SMTP id n21so18308234ioa.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Mar 2021 09:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=UZQuQN+Y/Ln5Rqog6y/XuFlmircqKTHpGhsY1hXDlr8=;
 b=eDO9wyI04ngUdU4BR8Y3W2FAnFEO5oflQNs09vAXNIZhoCh9dTx4aaHXdMIYBH0Oh8
 uc/UESMI/Z+g+irH6E40Htfp2p8zAswssVgTY6fSJo3mDj8fU9OdbaUBJajkHpAv1VIr
 3dGUVkhgqbtxibuLPOTmlW9L7Ec4Y9OwIWhIH5pFNXMMgxysZoai50ci/RYuIRIfNBtS
 TAgqEc0WmUE2Zmwtp3/lGCoYj2z/HFs38AGsHt5psvqvPIbAN93CiFdxwaegR+/PJtdN
 uXv4ZWjZC+PpK/0szjiZjPkQUcglOIgEo47FsdIuWcrK984a540b0CU+XIbS9e32YelC
 Ctqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UZQuQN+Y/Ln5Rqog6y/XuFlmircqKTHpGhsY1hXDlr8=;
 b=OPeW0PeLLWkno1nYlxPl19dZ7VZk+ufid9UQTRljKlqHFxFOURxD3VsjVOtpVJ/tOV
 HFRToDfwksgYitkohaGIVucQIlOYH6p8Vgw8GSUmXkPgcyA7wgyEMtMSqVKM/IExuHs1
 vApcDqUrpG/+q6MgYHPI6iXYR2P2vVG+yp3v/u1rTaFyl7u+UxN2DM+yxRJ8OoLHRxY5
 e2jn+tVaH1wTe/HwyJG8HZXDpLBV2sHugy9slzeJwsaaKspXdLt/bs41E+bADFywaFsr
 48sVFUb0RTly5DGza4dia+V/hXjjEQa9oxc55b9nQd/6Qu6GI337p4L4ngdw+wAwy29Q
 YzQQ==
X-Gm-Message-State: AOAM5311HgARLA5PKqmf/tBty2D5kZ3iijkIx2i0OySfhSX+kqClyfVp
 EwipyBtPlijWRFbCi7BzHqbmwTZ0ZTSddw==
X-Google-Smtp-Source: ABdhPJxIB+FYjEsQXrnfmY1mc2AaqL+WNmFYjgoU+OScb8vpa1uJVcFAs1RmgLZMnLfU5DBGClTs4w==
X-Received: by 2002:a5d:89d9:: with SMTP id a25mr5011258iot.69.1616516891090; 
 Tue, 23 Mar 2021 09:28:11 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id s18sm9827634ilt.9.2021.03.23.09.28.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Mar 2021 09:28:10 -0700 (PDT)
Subject: Re: [PATCH] xsysace: Remove SYSACE driver
To: Michal Simek <michal.simek@xilinx.com>, Davidlohr Bueso <dave@stgolabs.net>
References: <ee1fe969905f641f5f97d812ee0cac44c12fe0f6.1604919578.git.michal.simek@xilinx.com>
 <20210323000436.qm5rkiplwt5x5ttk@offworld>
 <6948510c-dc7e-d74a-62e3-e42be14cff16@kernel.dk>
 <9c4911e6-92dc-0a0f-2f81-7d23e268144f@xilinx.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <66a774e3-f068-984e-e69f-b55667a494cf@kernel.dk>
Date: Tue, 23 Mar 2021 10:28:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9c4911e6-92dc-0a0f-2f81-7d23e268144f@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: devicetree@vger.kernel.org, monstr@monstr.eu,
 YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-block@vger.kernel.org,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Paul Mackerras <paulus@samba.org>, git@xilinx.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 3/23/21 10:25 AM, Michal Simek wrote:
> 
> 
> On 3/23/21 5:23 PM, Jens Axboe wrote:
>> On 3/22/21 6:04 PM, Davidlohr Bueso wrote:
>>> Hi,
>>>
>>> On Mon, 09 Nov 2020, Michal Simek wrote:
>>>
>>>> Sysace IP is no longer used on Xilinx PowerPC 405/440 and Microblaze
>>>> systems. The driver is not regularly tested and very likely not working for
>>>> quite a long time that's why remove it.
>>>
>>> Is there a reason this patch was never merged? can the driver be
>>> removed? I ran into this as a potential tasklet user that can be
>>> replaced/removed.
>>
>> I'd be happy to merge it for 5.13.
>>
> 
> Can you just take this version? Or do you want me to send it again?

Minor edits needed for fuzz, but I've applied this version.

-- 
Jens Axboe

