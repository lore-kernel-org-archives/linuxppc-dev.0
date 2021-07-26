Return-Path: <SRS0=wZlq=MS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDFEC4338F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Jul 2021 17:11:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF4486056B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Jul 2021 17:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BF4486056B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iram.es
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GYRKn3Vx5z3bXD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Jul 2021 03:11:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=iram.es header.i=@iram.es header.a=rsa-sha256 header.s=DKIM header.b=n6Jq1zVz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=iram.es
 (client-ip=130.206.19.150; helo=mx01.puc.rediris.es;
 envelope-from=prvs=1837463adb=paubert@iram.es; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=iram.es header.i=@iram.es header.a=rsa-sha256
 header.s=DKIM header.b=n6Jq1zVz; dkim-atps=neutral
X-Greylist: delayed 919 seconds by postgrey-1.36 at boromir;
 Tue, 27 Jul 2021 03:11:14 AEST
Received: from mx01.puc.rediris.es (outbound6mad.lav.puc.rediris.es
 [130.206.19.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GYRKG2fb3z2yZB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jul 2021 03:11:12 +1000 (AEST)
Received: from mta-out02.sim.rediris.es (mta-out02.sim.rediris.es
 [130.206.24.44])
 by mx01.puc.rediris.es  with ESMTP id 16QGth9n021301-16QGth9p021301
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 26 Jul 2021 18:55:43 +0200
Received: from mta-out02.sim.rediris.es (localhost.localdomain [127.0.0.1])
 by mta-out02.sim.rediris.es (Postfix) with ESMTPS id 0E9F5C7A3F3;
 Mon, 26 Jul 2021 18:55:43 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mta-out02.sim.rediris.es (Postfix) with ESMTP id F2972C7A48C;
 Mon, 26 Jul 2021 18:55:42 +0200 (CEST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
 mta-out02.sim.rediris.es
Received: from mta-out02.sim.rediris.es ([127.0.0.1])
 by localhost (mta-out02.sim.rediris.es [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id jzjTcSwQkz2F; Mon, 26 Jul 2021 18:55:42 +0200 (CEST)
Received: from lt-gp.iram.es (haproxy02.sim.rediris.es [130.206.24.70])
 by mta-out02.sim.rediris.es (Postfix) with ESMTPA id 2F887C7A3F3;
 Mon, 26 Jul 2021 18:55:40 +0200 (CEST)
Date: Mon, 26 Jul 2021 18:55:33 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Michal Suchanek <msuchanek@suse.de>
Subject: Re: [PATCH] powerpc/stacktrace: Include linux/delay.h
Message-ID: <20210726165533.GA6643@lt-gp.iram.es>
References: <20210726154243.29025-1-msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726154243.29025-1-msuchanek@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: mx01.puc.rediris.es;
 spf=pass (rediris.es: domain of paubert@iram.es designates 130.206.24.44 as
 permitted sender) smtp.mailfrom=paubert@iram.es
X-FE-Policy-ID: 2:8:0:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=iram.es; s=DKIM;
 c=relaxed/relaxed; 
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=WX5am9mZ2qXQ90+KT5G4LIHyaObghAjkzPCF6LmWvEo=;
 b=n6Jq1zVzqZWbVm2kCdfMVWnEZJAvai0TzAXXm/NzK72u+ub9/nNByh/xjNiNruvfcbnfeNs5ZMTa
 pshOu+lVfLHrTOKuq42yA2pincW3yNTw/JqUQJWtif3eLd4B5TDMk2ZKQfN+sdWMeHyXG5KZ3dy7
 zfS6d9wGaN3ST2HP30A+HWQtPXNIMMxLEt/fnelnS59gYOv6Jc2dlVIUZHi7XkdG1ArJ5xtmNlZT
 Dx1wVYreqGnWajbct4dCqweUgYSpnmnv/I6szN9UKGpUZhSVe8RS1LL8Iylk4FQWoBRFDZW8V9/D
 pUZBoNOhvuSmOV4ZQq3Y9AW9/6T6ENZfAWHN/Q==
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jul 26, 2021 at 05:42:43PM +0200, Michal Suchanek wrote:
> commit 7c6986ade69e ("powerpc/stacktrace: Fix spurious "stale" traces in raise_backtrace_ipi()")
> introduces udelay() call without including the linux/delay.h header.
> This may happen to work on master but the header that declares the
> functionshould be included nonetheless.
> 
> Fixes: 7c6986ade69e ("powerpc/stacktrace: Fix spurious "stale" traces in raise_backtrace_ipi()")
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  arch/powerpc/kernel/stacktrace.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
> index 2b0d04a1b7d2..a17ac10f86b1 100644
> --- a/arch/powerpc/kernel/stacktrace.c
> +++ b/arch/powerpc/kernel/stacktrace.c
> @@ -12,6 +12,7 @@
>  #include <linux/kallsyms.h>
>  #include <linux/module.h>
>  #include <linux/nmi.h>
> +#include <linux/delay.h>
>  #include <linux/sched.h>
>  #include <linux/sched/debug.h>
>  #include <linux/sched/task_stack.h>

Hmm, I believe we try to keep the list of includes sorted in
alphabetical order.

	Gabriel
 

