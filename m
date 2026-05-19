Return-Path: <linuxppc-dev+bounces-21140-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327A6CD343F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 02:32:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKJcK4QKbz2yCM;
	Tue, 19 May 2026 12:32:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779157969;
	cv=none; b=L3Ed2qi/S46MfWMp/z4MM9q4KViP4zcwe1SDNrYo3mddd7ngmndHWAfaA7edNBHowvZnLQXDsSjCl71rQkslA87nZpINjHxqUHU7oh3yym3Z2QpZiUeHBdKzlmWdFdXxKcjdCXGybfbJ9avVnSEdBhI6OXZmze8ib8qw9WdfN27n9FVAeII15KXQESSKkM75ve97dF21Zok194puvs10FDkWQBPDQH0Uis9wQKSBwd4xY3Ekrw30O/4JYtzUgi/i9EWnrbjKf83IHRVTdGnPqdr9evgPh7UEEKzBWBdmAk+bunicf+8qOUKUqzXBQdeCZULsRp8HS710hT3Kt9kJ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779157969; c=relaxed/relaxed;
	bh=+1Rq+XpE/2iXe/JnSZqTkyDn6Xdj3FVk9xULcGkYY4s=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=fzRJ0uTyVLNaSn813KSKZuZhGjzyZk4dkE/wS9pa/kc2Mb89/hwifl7nO9F1hANzuzOI/DdrXPVdjJSMrAd35Ak5OVhvwwAurboRbEXmffOY27VrUHstANPFwJMRP/O6OtN2vLO4QcdNKB3CQmhpCyTONjQVEIY4Fes3M+gJCvn6rDU+7XCUhTPj77u/txTE1sIFT1hTQm3VBfgmouFWPgQwDDZz8E6OsbK86y+5eVCwb3x8CQYOLQ8kVpA02SmpC3bXAtmJirL/rptIWpY/Zo61ivTX6nvoKCo/10ESBPSMOLMRSsZ2ERt72buiul1lr5MICJsBmMWKn2CxxQi5qA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FoWibNjf; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FoWibNjf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKJcJ74GMz2xwH
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 12:32:48 +1000 (AEST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-36643b96b99so2814699a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 19:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779157967; x=1779762767; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+1Rq+XpE/2iXe/JnSZqTkyDn6Xdj3FVk9xULcGkYY4s=;
        b=FoWibNjfCVidJNoQK13hcio8yTaaoX8x3JkHXLeuIkev9xisPi5srRwMTq6tn109hL
         ZL4PcwRFjHB+Geko9O86r6CTNFouqqN1NADC3iWktKEwgULiJzzEeFLLcIU3Rii0p8oC
         nCDrQ69axgJmkSlbGdn73T6Y9ur8noYYe5jPsZhpXknV6rqQWRhsirUQ1FMqtBYf0hyC
         6OTi7dDIIaMkM3k8nt3WnUJoqQTWznmfW0Q5kwyN8gScxCLf3lbgyDpVXL/gWfoykgTW
         s+qZtcZYLZNtrD3UWqZo9ObxpNTFPZDhf9wDPbbPgaur9yWkN8/xUJyTMnnvW7OEWmru
         s+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779157967; x=1779762767;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+1Rq+XpE/2iXe/JnSZqTkyDn6Xdj3FVk9xULcGkYY4s=;
        b=EvVa4SsGqUrnhmUn5hVWWFTxgHWU75f5fggELM5IQvrpKym3cyRIUe7Ho3VqZkKvDw
         MiW+DtF54CfXh6lzwnG/C7kp+n5tlY8WrR1mVn9RWohK+LmNXe8FemkLjoFpNY8S+oVP
         lZMUruDmLgED78z/N5zXNi0NsyxVtx7fwW+rdk8onDdWPrH8iYeW0gYPDUu4BCCOt+0B
         9HUjIfdHUCy7+JlGOonvO/jeglQ4shQYsBFUYkH+92dhQxp1qriCYZ8xniTT/r+LzAbY
         saURMzxlGlD/UZQ20FA/BhDjN51TjtgNerpxhp7w1nORWI1knKNTGpUZCFc152Xb94qs
         vhjw==
X-Forwarded-Encrypted: i=1; AFNElJ8+QBvLkIkLW2aFePWx5Z+WRxGFsqH1Mo40XnEbcdxMCvwtBFLDv8X2o5d4rpVgfMStreq4L6D0Vjobm70=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyb2C+sjC1oh2T/EDoLPugNpNUARuJ+jPOCaZO6Tln5VY0eOoIl
	JEkoY8eHEDZ+ER/SM5NU+DuxZKEs4uGmzDMm3Yu/js5+MF8Dby0dS/BE
X-Gm-Gg: Acq92OHPnvkBx9Sp7n8I6yHLQJn0+Gsy/00vyxfATYuzmIUTWccGLMRPKQ/oX9wUpW0
	ow77HRPEAvZSbNc6tFaiwxCOTZmuMyU5JKJAtGZrhnSyj1/AyZInY2LD0Ita/XTDj+TCGxDDpMA
	fqUatM6ab8mRg5yUsm/IuvWlq9ry276nRUJC3Vce0KcqCOjdXfJCfqmmydydy+ym+w9uZGhvM+I
	yr32PTb20GXncbjENzB5QyREvRvu6GSIr7CSprMRU2x5kTjUCk9kgiJCR9PWny8p/DjAq6TIJkZ
	QaXX2FABFWDRt4Y3EXECfVvCJvLhct2D4HPeSnZxOsc8igtC8OqWOy4cocWOTBFUMME2WotvpSF
	3CDJ0pZp7pVQ1kCkvByIY+J3DMMtVq7ysL66b+rP2f8T4N5FFLmHpXyfunfV02XBdpSTa2TZ/fy
	DMCuBHkZz1wsYYGrFWQVcZO8F0M3jk9tBU
X-Received: by 2002:a17:90b:58cb:b0:368:ea0c:1b75 with SMTP id 98e67ed59e1d1-369519cdf58mr17063511a91.6.1779157966847;
        Mon, 18 May 2026 19:32:46 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369517a8612sm12662487a91.12.2026.05.18.19.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 19:32:46 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sayali Patil <sayalip@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, Mahesh Salgaonkar <mahesh@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] lkdtm/powerpc: add isync after slbmte to enforce SLB update ordering
In-Reply-To: <2f8d430962a96a7498903b994f081deee4a4d97a.1778975974.git.sayalip@linux.ibm.com>
Date: Tue, 19 May 2026 07:54:38 +0530
Message-ID: <mrxwqgpl.ritesh.list@gmail.com>
References: <cover.1778975974.git.sayalip@linux.ibm.com> <2f8d430962a96a7498903b994f081deee4a4d97a.1778975974.git.sayalip@linux.ibm.com>
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

Sayali Patil <sayalip@linux.ibm.com> writes:

> The slbmte instruction modifies the Segment Lookaside Buffer, but without
> a context synchronizing operation the CPU is not guaranteed to observe
> the updated SLB state for subsequent instructions. This can result in
> use of stale translation state when memory is accessed immediately after
> SLB modifications.
>
> Add isync after each slbmte in the PPC_SLB_MULTIHIT test to ensure proper
> ordering of SLB updates before subsequent memory accesses.
>
> This aligns with Power ISA context synchronization requirements for changes
> in address translation state and improves the reliability of SLB multihit
> injection tests in hash MMU mode.
>

Yup, CSI is required for before & after a slbmte. Given we are trying to
add duplicate slb entries, I think the isync()s added in this patch is
sufficient.

LGTM. Feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


As Mpe added - This needs to be cc'd to Kees.

-> ./scripts/get_maintainer.pl -f drivers/misc/lkdtm/powerpc.c
Kees Cook <kees@kernel.org> (maintainer:LINUX KERNEL DUMP TEST MODULE (LKDTM))
Arnd Bergmann <arnd@arndb.de> (maintainer:CHAR and MISC DRIVERS)
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (maintainer:CHAR and MISC DRIVERS)
linux-kernel@vger.kernel.org (open list)
CHAR and MISC DRIVERS status: Supported

-ritesh

