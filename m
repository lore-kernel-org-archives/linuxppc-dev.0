Return-Path: <SRS0=aJM7=ML=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10457C43143
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Sep 2018 05:18:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 089C12084D
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Sep 2018 05:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/MQ7phN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 089C12084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42McJw0831zF3Lc
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Sep 2018 15:18:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j/MQ7phN";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="j/MQ7phN"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42McGM6lHJzF3Lc
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Sep 2018 15:16:27 +1000 (AEST)
Received: by mail-pg1-x544.google.com with SMTP id v133-v6so5866984pgb.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 22:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FLhNRXDh++j3xMVcsZ+lpIk1M9DVtcaXoQMG1mxIhv4=;
 b=j/MQ7phN8hhnR9KtvkYrUR/8ETpON6H4C2/Cdl9+/qnrS56LdE44p0VE9ivF0WtScA
 cFED01Ny2j4Qt7nJB5+PVOubFcn97vDZuN3CSnZ4jfxl0uKIPBNp4zqG2Ek8IUD9c4/A
 8HeXNrijCgB4TToajOlHl6ACSPbikY4C3DO2WEFzlD+HOSXNm8DYIJZ5YRRrReYiE91j
 sC15DhvEpJ3WlFvaWatAjcFIrS2gwrAKzNbaLN68E8AEBccdEMaWBdjjXIm5D5d+ylXT
 zful8XViPfxB08uWElbrTjMyBpnLkkGmqGxtrnomFTW3z9V5UQsrFwOd0FacCrOW2rPj
 XmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FLhNRXDh++j3xMVcsZ+lpIk1M9DVtcaXoQMG1mxIhv4=;
 b=SbZlN1jvCleZyGWxdvlXqnpPJDi3vRAXTEHFpy0z3rtuTwMjlj+fabdgL2/nGBUVwl
 g83aDTJkQUm8toV9BDLZDybX0PjUAfmv+wHLIaXHRFwggB0sLTbzMTalm2FYBwL7qHG9
 g56vf5r4o+qAckkzXQe+pLPfAKrYNBj6HHHUp7GFyznvlj8zBfrFOAWZyMCPC98GurLJ
 xGHyduoKl0QrC7xNdMPlvNjaFdvYt9HkwcmCsnLnUNFkkiOHcfo0s5CyFUjLBYnUvXBA
 CeS/GXHvY2xoiRn8P9rlG0gdxdEdGdQbibv6D11Ul+UJa0HLabncvRYaWUU0sZ76JfAR
 pawA==
X-Gm-Message-State: ABuFfohQyinAMHK/Uzc+1pIDWjD+n3vlnfNyv0TsR/Rga0g3/1PL0flf
 paLH+IaCbahb7ZdXsqWsG6k=
X-Google-Smtp-Source: ACcGV62QByMlmBZrf7uA1UBXp7OrwogB5s0Pnj46jjwuOBrzmrpMCvVkTYiN/sB+cvilWusIqoxfuA==
X-Received: by 2002:a62:4799:: with SMTP id
 p25-v6mr1638137pfi.197.1538198185174; 
 Fri, 28 Sep 2018 22:16:25 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (59-102-83-213.tpgi.com.au. [59.102.83.213])
 by smtp.gmail.com with ESMTPSA id i186-v6sm8951034pge.80.2018.09.28.22.16.21
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 28 Sep 2018 22:16:24 -0700 (PDT)
Date: Sat, 29 Sep 2018 15:16:18 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Anton Blanchard <anton@ozlabs.org>
Subject: Re: [PATCH 2/2] powerpc/time: Only cap decrementer when watchdog is
 enabled
Message-ID: <20180929151618.1e15ca4c@roar.ozlabs.ibm.com>
In-Reply-To: <20180929012607.10204-2-anton@ozlabs.org>
References: <20180929012607.10204-1-anton@ozlabs.org>
 <20180929012607.10204-2-anton@ozlabs.org>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: mikey@neuling.org, paulus@samba.org, oohall@gmail.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 29 Sep 2018 11:26:07 +1000
Anton Blanchard <anton@ozlabs.org> wrote:

> If CONFIG_PPC_WATCHDOG is enabled, we always cap the decrementer to
> 0x7fffffff. As suggested by Nick, add a run time check of the watchdog
> cpumask, so if it is disabled we use the large decrementer.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---

Thanks for tracking this down. It's a fix for my breakage

a7cba02deced ("powerpc: allow soft-NMI watchdog to cover timer
interrupts with large decrementers")

Taking another look... what I had expected here is the timer subsystem
would have stopped the decrementer device after it processed the timer
and found nothing left. And we should have set DEC to max at that time.

The above patch was really intended to only cover the timer interrupt
itself locking up. I wonder if we need to add

    .set_state_oneshot_stopped = decrementer_shutdown

In our decremementer clockevent device?

Thanks,
Nick
