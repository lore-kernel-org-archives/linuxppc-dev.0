Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E008C43143
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 23:01:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60700206B2
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 23:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="Um7HmHPL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60700206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PHpk2rkczF3Cf
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 09:01:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="Um7HmHPL";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PHkB0xw8zF3D6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 08:57:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="Um7HmHPL"; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42PHk90b5Dz9s3l;
 Tue,  2 Oct 2018 08:57:53 +1000 (AEST)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538434673; bh=VzMmh9hqTajqe6+n2bmegkVk55anULfwfRAg5jNJt1U=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Um7HmHPLZ/LJ1L/s9jBF4w6xdHnmM2E4RkaZL08P67+mF7erIULRtXJMtcs+m4xLq
 rcT5Sr3zzHIPBJuPnHB6gBSIOxYt7t/KO37Ah3B0n5IsKq1uFgIyMIXdHHYjXj36eK
 z0g5rbV7EEdX5MW2HfE5P2lEdHXAKil5ZboGRCv/jFzr4GdZpSfPeFZguxN32VogMt
 f+x6qum8XnlffTSRwnnzGcPQ8BYoHyIUuYmhsKeZwrCmNJV1PstAmfcwHbvCGT+8+I
 DvKibEQpYom2DoOBVV5T9P3LN2WL3lUrR7qHn3WbMQQbcYheliXQtxn35WqJKZNc5i
 yNJi2O7cJPRmg==
Date: Tue, 2 Oct 2018 08:57:51 +1000
From: Anton Blanchard <anton@ozlabs.org>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/2] powerpc/time: Only cap decrementer when watchdog is
 enabled
Message-ID: <20181002085751.0dc17ff2@kryten>
In-Reply-To: <20180929151618.1e15ca4c@roar.ozlabs.ibm.com>
References: <20180929012607.10204-1-anton@ozlabs.org>
 <20180929012607.10204-2-anton@ozlabs.org>
 <20180929151618.1e15ca4c@roar.ozlabs.ibm.com>
X-Mailer: Mutt/1.8.0 (2017-02-23)
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

Hi Nick,

> Thanks for tracking this down. It's a fix for my breakage
> 
> a7cba02deced ("powerpc: allow soft-NMI watchdog to cover timer
> interrupts with large decrementers")
> 
> Taking another look... what I had expected here is the timer subsystem
> would have stopped the decrementer device after it processed the timer
> and found nothing left. And we should have set DEC to max at that
> time.
> 
> The above patch was really intended to only cover the timer interrupt
> itself locking up. I wonder if we need to add
> 
>     .set_state_oneshot_stopped = decrementer_shutdown
> 
> In our decremementer clockevent device?

Thanks Nick, that looks much nicer, and passes my tests.

Anton
