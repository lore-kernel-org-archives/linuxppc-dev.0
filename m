Return-Path: <SRS0=MfaX=RW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A095DC4360F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 10:23:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D592820828
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 10:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="dyTOgN2g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D592820828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Npzl6XTCzDqLC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 21:23:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=lca.pw
 (client-ip=2607:f8b0:4864:20::742; helo=mail-qk1-x742.google.com;
 envelope-from=cai@lca.pw; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=lca.pw header.i=@lca.pw header.b="dyTOgN2g"; 
 dkim-atps=neutral
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Npxp6kZRzDqJB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 21:21:49 +1100 (AEDT)
Received: by mail-qk1-x742.google.com with SMTP id k189so6210418qkc.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 03:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rEpkfPsDj23CwxfUKV9E2hJWjwLh0d9UFa4vQefOAfg=;
 b=dyTOgN2gVc6jqEdIB9qe2fmz8nLewsCTPtDg8S3oq8dbL6rqacVYro+uDi5LyrQ1Xd
 fY3vlkYP6YghXiWHK0MQhJjQ6+xfTqLEiAGwSl7EV6BxlNDRF0u8vx+NwldqTBn2FyAr
 jXwt597etXhnABb17P2lH0C096XfUleFWoq5tMFA6VRPvvu+aIUZLiS+DrpDXVRavsvF
 /lPGq1/KrUPAsygBu64pN2pPS7B0L17ijKU/1tUFddle1GxBHey6axyADRo17LaHucD8
 Z7z4ogPuuXgR8bJB72t9S2SPoJadvDXGb4QABdWGbNvXJhPvxqY9Mr3NVABkYuwAMmtR
 lw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rEpkfPsDj23CwxfUKV9E2hJWjwLh0d9UFa4vQefOAfg=;
 b=hGffXpppJLaTHB9SWFbO6UCLPUDx16BU6ewLGi1UObtyoA7lmwu2yIf7MtXLEAI/vx
 s/LLHdVzfJrwgl5Mgq9FXNlZP/SdzacDISg+BXr9+0X+VvVLwplsmSKeoq5B/tyxIPPp
 8r4Jyijd3KAOQ3R0HnWhruYX7xVEynk2XKRjV4C3dAcaen4cviymBBTJQx7SYxzUfApP
 Am31DvPVdBw0pPOptIU8KfLw/kdYmDtz5z5ICcLR6YQK4JMuo3r5mG0Smf0nsvINg4c8
 CZ0l9ngvGTlaMJXShoV9nMZbFwe5PnVQYVLMF51dOSTDo8CotqQS/kyVhy1vGE4Ofdav
 qoog==
X-Gm-Message-State: APjAAAVi+IA8F6BUtyhthFsvEEl1QNLxVJgMtcNpeGBFVdD5yExb3Ei9
 OSXYCau2t6QxkrT9FF6L9RONIA==
X-Google-Smtp-Source: APXvYqy598D9NuNFngcL/ofJCThxLNW9mD8tMUsgeOO4NgPewZtExABDQT0MJlLcUSaC3PptIIW9sw==
X-Received: by 2002:a05:620a:1352:: with SMTP id
 c18mr1110704qkl.303.1552990905802; 
 Tue, 19 Mar 2019 03:21:45 -0700 (PDT)
Received: from ovpn-120-94.rdu2.redhat.com
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id x29sm7970832qtm.74.2019.03.19.03.21.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Mar 2019 03:21:45 -0700 (PDT)
Subject: Re: [RESEND PATCH v2] powerpc: mute unused-but-set-variable warnings
To: Christophe Leroy <christophe.leroy@c-s.fr>, mpe@ellerman.id.au,
 benh@kernel.crashing.org, paulus@samba.org
References: <20190317220516.92654-1-cai@lca.pw>
 <1ffdc5ae-2d5f-6c81-3997-0e6c81c67516@c-s.fr>
From: Qian Cai <cai@lca.pw>
Message-ID: <b3e7d016-74ca-aaaa-02e7-39fbc2200013@lca.pw>
Date: Tue, 19 Mar 2019 06:21:43 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <1ffdc5ae-2d5f-6c81-3997-0e6c81c67516@c-s.fr>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 3/19/19 5:21 AM, Christophe Leroy wrote:
> Is there a reason for resending ? AFAICS, both are identical and still marked
> new in patchwork:
> https://patchwork.ozlabs.org/project/linuxppc-dev/list/?submitter=76055
> 

"RESEND" because of no maintainer response for more than one week.

> Indeed, the resend has an issue in the commit log and fails the checkpatch (a ::
> in Reviewed-by::)

Yes, my bad for a copy-and-paste error.
