Return-Path: <SRS0=VpUd=ZH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07085C432C3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Nov 2019 07:47:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73B552072A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Nov 2019 07:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="cimPOY7g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73B552072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47Dr5s14NBzF1bv
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Nov 2019 18:46:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=rasmusvillemoes.dk (client-ip=2a00:1450:4864:20::244;
 helo=mail-lj1-x244.google.com; envelope-from=linux@rasmusvillemoes.dk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.b="cimPOY7g"; dkim-atps=neutral
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com
 [IPv6:2a00:1450:4864:20::244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47Dr2v3Ds0zF5yW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Nov 2019 18:44:22 +1100 (AEDT)
Received: by mail-lj1-x244.google.com with SMTP id r7so9633266ljg.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Nov 2019 23:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MerzeYQd7mMrWj7xug82ip0Zzuk57QC86rO5mCSsEzs=;
 b=cimPOY7g4EAlwVyfr4cwpdgRJdBwRgLjtx/sUwL01IBFA4qPtm6hLBgyIKILrFzJM9
 xiOtbLJf0y4FyFS5wuHNxaB4q8sFK2F7P67/5/RQWCsQ9oGFBnDTdc4D+B26iZzap9Qa
 gTUwq1Rz9t3IIvqDWNeazaS9zPcEWsGD6g1ZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MerzeYQd7mMrWj7xug82ip0Zzuk57QC86rO5mCSsEzs=;
 b=VsXZkpBzVW7pb/efdjAunVlABMHEb85fIh1CA02PVjyqU+VfihwaYrWJniz9kT//OX
 ldF6WWmKsK+DJWo9m4yp7/vsY6Vv5PvlgQAAuBYYkrcyqv6JUxiuFkcOEkElm0/xq+1z
 vz8LXYm1wzeqt83YcOAgW0SJTzdNdpAi92HdCnrOGf0YZwRB7+scoGx3Dubs7zZpdagH
 r7dupABZYFyPsFRZdVSG8aXgPyYQIhc/e+FmFOLI9dHYKvyOEhzekPirGqmnClwbpljE
 VhNEqNrWkvBA85f1rsDBo/XF9m3GgS7AyTCpNjrWCy18EDUIG+hUJeUkrLTFgxfc2Y5l
 rPPQ==
X-Gm-Message-State: APjAAAUk6cz6WROsJmI8uPWmgEteHtrCDa4EHNXkCjZTsAY4DH3wb/Ku
 JPYQCociNU/p3Kfb4Ikmv73xcg==
X-Google-Smtp-Source: APXvYqw8OAiLBu508szXHtSnz3QQioa3U2uijYFbTHFzEtm/A+7bHMI6CgvxmnwrGknlwyb2z4HUYw==
X-Received: by 2002:a2e:9784:: with SMTP id y4mr10091304lji.77.1573803854082; 
 Thu, 14 Nov 2019 23:44:14 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
 by smtp.gmail.com with ESMTPSA id p19sm3689755lji.65.2019.11.14.23.44.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Nov 2019 23:44:13 -0800 (PST)
Subject: Re: [PATCH v4 45/47] net/wan/fsl_ucc_hdlc: reject muram offsets above
 64K
To: Timur Tabi <timur@kernel.org>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
 <20191108130123.6839-46-linux@rasmusvillemoes.dk>
 <CAOZdJXUibQ6RM8O4CfkYBdGsg+LMcE2ZoZEQ4txn2yvquUWwCA@mail.gmail.com>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <79101f00-e3ff-9dd0-7a05-760f8be1ff69@rasmusvillemoes.dk>
Date: Fri, 15 Nov 2019 08:44:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAOZdJXUibQ6RM8O4CfkYBdGsg+LMcE2ZoZEQ4txn2yvquUWwCA@mail.gmail.com>
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
Cc: netdev <netdev@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
 Li Yang <leoyang.li@nxp.com>, Scott Wood <oss@buserror.net>,
 linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Qiang Zhao <qiang.zhao@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 15/11/2019 05.41, Timur Tabi wrote:
> On Fri, Nov 8, 2019 at 7:04 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
> 
>> diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
>> index 8d13586bb774..f029eaa7cfc0 100644
>> --- a/drivers/net/wan/fsl_ucc_hdlc.c
>> +++ b/drivers/net/wan/fsl_ucc_hdlc.c
>> @@ -245,6 +245,11 @@ static int uhdlc_init(struct ucc_hdlc_private *priv)
>>                 ret = -ENOMEM;
>>                 goto free_riptr;
>>         }
>> +       if (riptr != (u16)riptr || tiptr != (u16)tiptr) {
> 
> "riptr/tiptr > U16_MAX" is clearer.
> 

I can change it, sure, but it's a matter of taste. To me the above asks
"does the value change when it is truncated to a u16" which makes
perfect sense when the value is next used with iowrite16be(). Using a
comparison to U16_MAX takes more brain cycles for me, because I have to
think whether it should be > or >=, and are there some
signedness/integer promotion business interfering with that test.

Rasmus
