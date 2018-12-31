Return-Path: <SRS0=LDiU=PI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA129C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Dec 2018 17:22:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5AE320652
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Dec 2018 17:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cQxxOZCH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5AE320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43T3zX3wdMzDqDC
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Jan 2019 04:22:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cQxxOZCH";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.dk
 (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com;
 envelope-from=axboe@kernel.dk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel-dk.20150623.gappssmtp.com
 header.i=@kernel-dk.20150623.gappssmtp.com header.b="cQxxOZCH"; 
 dkim-atps=neutral
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43T3wg267vzDqJ1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Jan 2019 04:20:15 +1100 (AEDT)
Received: by mail-pg1-x531.google.com with SMTP id w6so12881348pgl.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Dec 2018 09:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CrRXlUXUMQ3PiwDJSYk8y5FlbmGKwKsCyEHZvxkLc2o=;
 b=cQxxOZCHgV6rA6r995YMSNVHFsSdK+D4CBfYvTCmqGXZuWPByTqbyyeeT1xMG+pDrS
 dWTNWFHkMu3BTl32bv08/pk3uiDi7Svu4l3Sme52SEQRjAuJZtKrzGslbtZj64cwXsnu
 yWYRSnmw9f+isme7NvdbBvyw9MonmDt/bRM8RpFOURNCVH2scRdd5Ce0U1LBUy0aFfNJ
 3l7HgeG/2l4TPFc+inWocHe3YwdtEzb+dKJPyFsfcUZ88tSOTeSTd4RNvccE9omimiOw
 DJU3cP3hDZ+XvlWkrNrc9xvbtfz1zS+VEp3IctIqyLiIN86KJo2q/UXpPsPswYx2Rc05
 l3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CrRXlUXUMQ3PiwDJSYk8y5FlbmGKwKsCyEHZvxkLc2o=;
 b=X5Nm9wkDzEo7WLjo6K6zAd11mO05IgB7OZupOB5aRMgW5RAE+Tfo7K/OhjRq0+p/Ht
 m87lx4Aqhcb94mWfaZ1+aHJ9Dg6fTeUZjE9YoROBPZeEDlM6acFSRmZdwgbnbddRe16N
 C3ocps5WFCO9sWpVze2PXmECq7hT0us1a8LUNAOqg4i2UNZdfqf524iFirDkMYw17Uxu
 1A012PN829zKzGgFOgkky3BpaWDeLtCLhTfXUqjx64evcjNM8sqwnRpxHlRRO8B1oZt8
 uL5/mt3TiVPjzJGqAQuPNBgwryoNwZuWzeb/8yw87zsXQY5TATrzsR+pF5QX8QDKCuu9
 BgXQ==
X-Gm-Message-State: AJcUukfUIHihIJalf2TQQYcVJ1AeujRnRQviiAs0Cg3TUkJElZi/HyvM
 YmONG+JLPLtoC/RJj0YEB4gC3A==
X-Google-Smtp-Source: ALg8bN48Oa3BqrebUL5lsXlr98IU7W7wUFwX4ylU3AMxbf7hDbUhCy3fa9njgk8XKsvJPgJDkHLmoQ==
X-Received: by 2002:a63:9e19:: with SMTP id s25mr8190242pgd.203.1546276813251; 
 Mon, 31 Dec 2018 09:20:13 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
 by smtp.gmail.com with ESMTPSA id p6sm66153028pfn.53.2018.12.31.09.20.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 31 Dec 2018 09:20:12 -0800 (PST)
Subject: Re: [PATCH] block/swim3: Remove dead return statement
To: Finn Thain <fthain@telegraphics.com.au>
References: <f84a43669647c55b91c2a46e7876d8dd2a713c8a.1546235049.git.fthain@telegraphics.com.au>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7846fc4b-2cb4-bc07-4dc0-cc8c9ce2d00a@kernel.dk>
Date: Mon, 31 Dec 2018 10:20:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <f84a43669647c55b91c2a46e7876d8dd2a713c8a.1546235049.git.fthain@telegraphics.com.au>
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
Cc: linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 12/30/18 10:44 PM, Finn Thain wrote:
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Applied, thanks.

-- 
Jens Axboe

