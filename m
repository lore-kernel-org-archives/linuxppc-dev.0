Return-Path: <SRS0=fKfC=FW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AF3C4361B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Dec 2020 00:58:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D2D5238A0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Dec 2020 00:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D2D5238A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cxr7w34M4zDqXr
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Dec 2020 11:58:04 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cxr6950LLzDqWQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Dec 2020 11:56:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=ldVsLC9O; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Cxr686Gvkz9sVq;
 Fri, 18 Dec 2020 11:56:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1608252993;
 bh=RIVFcTOuMTXKuat3V+u6VnXKuyOKwXzAo6QsS3OttQY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=ldVsLC9O5QSNtT/7ep8yC6lrTP34/0mLobwb4U0eSjEe6BfFHrZUN2i8QK9vRdR/1
 af6WnEI9IaII70hhWbnfWZ2x87B3ItK9HMkMIFXNuUwEnsz3J9A1/t0JX+2rTl6bi4
 WqLdh7lISANQpoyKly6onvO39sIvtVj2cdjgow+g+vor51+NkHlGLZJBEMgBI4ebQp
 QOKYuPR9C9YKRsin00Xyanb8sc+yOlalEVZmxsQQpb188l3a+7Td1q0EOiX9pxTyKq
 kWT14yyHAKK3VWJJn+a68XfFLJ/jbmSbeBxDjY+kCk9WJhnD+bAnEdBIh26pSTMYKB
 sMRlQuMLB38Jw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kajol Jain <kjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/perf/hv-24x7: Dont create sysfs event files for
 dummy events
In-Reply-To: <20201217113230.1069882-1-kjain@linux.ibm.com>
References: <20201217113230.1069882-1-kjain@linux.ibm.com>
Date: Fri, 18 Dec 2020 11:56:21 +1100
Message-ID: <87o8isx77u.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: kjain@linux.ibm.com, suka@us.ibm.com, maddy@linux.vnet.ibm.com,
 atrajeev@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Kajol Jain <kjain@linux.ibm.com> writes:
> hv_24x7 performance monitoring unit creates list of supported events
> from the event catalog obtained via HCALL. hv_24x7 catalog could also
> contain invalid or dummy events (with names like FREE_  or CPM_FREE_ so
> on). These events does not have any hardware counters backing them.
> So patch adds a check to string compare the event names to filter
> out them.
>
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> ---
>  arch/powerpc/perf/hv-24x7.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
> index 6e7e820508df..c3252d8a7818 100644
> --- a/arch/powerpc/perf/hv-24x7.c
> +++ b/arch/powerpc/perf/hv-24x7.c
> @@ -894,6 +894,11 @@ static int create_events_from_catalog(struct attribute ***events_,
>  
>  		name = event_name(event, &nl);
>  
> +		if (strstr(name, "FREE_")) {
> +			pr_info("invalid event %zu (%.*s)\n", event_idx, nl, name);
> +			junk_events++;
> +			continue;

I don't think we want a print for each event, just one at the end saying
"Dropped %d invalid events" would be preferable I think.


> +		}
>  		if (event->event_group_record_len == 0) {
>  			pr_devel("invalid event %zu (%.*s): group_record_len == 0, skipping\n",
>  					event_idx, nl, name);
> @@ -955,6 +960,9 @@ static int create_events_from_catalog(struct attribute ***events_,
>  			continue;
>  
>  		name  = event_name(event, &nl);
> +		if (strstr(name, "FREE_"))
> +			continue;

Would be nice if the string comparison was in a single place, ie. in a
helper function.

cheers
