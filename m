Return-Path: <SRS0=O7I3=MJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28816C43382
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Sep 2018 21:13:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF1F621571
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Sep 2018 21:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF1F621571
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Lnbb4QKSzDrWN
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 07:13:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.160.195; helo=mail-qt1-f195.google.com;
 envelope-from=breno.debian@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com
 [209.85.160.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Ln7R2Jv0zF38X
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 06:52:35 +1000 (AEST)
Received: by mail-qt1-f195.google.com with SMTP id l2-v6so4304186qtr.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 13:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cF5KSpSrk1jLJyiIcMdd3rjocddR4wgsvoY6Jt4mR0Y=;
 b=eBsotfuk1JlnXdH5rXFnJHBFT4VNChZyVElDTVBceJGwxrR20rzfEAL0t65sD6i3G9
 TDiadkurhSAnSSXNLZdGYHSPmNCzlqX7smF0OqAAtQtx3jWW1Y7O9on5gHAeoqeKCKEa
 YCvKndinoq2mVk/XtO0+D8chqng1u3e01H0v8J0GLUZiSdon0wqKvwTkeH3JHMlDUaJO
 yhneZENP/NbW6K800Yv00GgBywtXuoXjK58jBnV2TBRCK5EMj7L+bpx76nFMdO7JOkKx
 MOvJ7VGxtFjM5cdMGmm0UNmJoJ6XF1ED9JTgxiGa10mhT6cYry6dhLSi5lZ07W/ljHzX
 StTw==
X-Gm-Message-State: ABuFfojUHnSGAi233w4ho/PobUzJAQI9buH27UttOTI5tsAk/sND7Unq
 9Lu5IbBuJp2JPiKsieyLEL8=
X-Google-Smtp-Source: ACcGV60Bg3UVfybY40GHizFqcbCJ6lZW2aUhlcKqwCgtf5/PXGtPBcLZ4AoXW8GHHH/yWCFkxF1dpw==
X-Received: by 2002:aed:2601:: with SMTP id
 z1-v6mr9911308qtc.123.1538081553200; 
 Thu, 27 Sep 2018 13:52:33 -0700 (PDT)
Received: from [10.0.0.9] ([177.83.210.7])
 by smtp.gmail.com with ESMTPSA id n41-v6sm2016005qtn.73.2018.09.27.13.52.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Sep 2018 13:52:32 -0700 (PDT)
Subject: Re: [RFC PATCH 10/11] powerpc/tm: Set failure summary
To: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
References: <1536781219-13938-1-git-send-email-leitao@debian.org>
 <1536781219-13938-11-git-send-email-leitao@debian.org>
 <7647a2d788ceb979e6de8bb8bb988f4d37fb1877.camel@neuling.org>
From: Breno Leitao <leitao@debian.org>
Message-ID: <85a2de6d-6cb5-6052-252e-858e61eb00ab@debian.org>
Date: Thu, 27 Sep 2018 17:52:29 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7647a2d788ceb979e6de8bb8bb988f4d37fb1877.camel@neuling.org>
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
Cc: ldufour@linux.vnet.ibm.com, gromero@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Mikey,

On 09/18/2018 02:50 AM, Michael Neuling wrote:
> On Wed, 2018-09-12 at 16:40 -0300, Breno Leitao wrote:
>> Since the transaction will be doomed with treckpt., the TEXASR[FS]
>> should be set, to reflect that the transaction is a failure. This patch
>> ensures it before recheckpointing, and remove changes from other places
>> that were calling recheckpoint.
> 
> TEXASR[FS] should be set by the reclaim. 

Do you mean that the CPU should set TEXASR[FS] when treclaim is called, or,
that the tm_reclaim?

Looking at the ISA, I didn't see TEXASR[FS] being set automatically when a
reclaim happens, although, I see it needs TEXASR[FS] to be set when executing
a trecheckpoint, otherwise it will cause a TM Bad Thing.

That is why I am forcing TEXASR[FS]=1 to doom the transaction so we can
recheckpoint it, but it seems I understood this wrongly.

> I don't know why you'd need to set this
> explicitly in process.c. The only case is when the user supplies a bad signal
> context, but we should check that in the signals code, not process.c
> 
> Hence I think this patch is wrong.
> 
> Also, according to the architecture, TEXASR[FS] HAS TO BE SET on trecheckpoint
> otherwise you'll get a TM Bad Thing. You should say that rather than suggesting
> it's because the transaction is doomed. It's ilqlegal to not do it. That's why we
> have this check in arch/powerpc/kernel/tm.S.

When you say "HAS TO BE SET", do you mean that the hardware will set it and
we shouldn't care about this flag? Thus, if I am hitting EMIT_BUG_ENTRY, it
means my TEXASR was messed somehow?

Thank you
