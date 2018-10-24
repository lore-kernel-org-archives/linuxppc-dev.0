Return-Path: <SRS0=Hff1=NE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D12AECDE46
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 22:12:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 345FA2075D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 22:12:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 345FA2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42gPdg6nX8zDrPx
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 09:12:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.68; helo=mail-ot1-f68.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42gPb20dcJzDrPm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 09:10:37 +1100 (AEDT)
Received: by mail-ot1-f68.google.com with SMTP id w18so3722274otk.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 15:10:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=LhIr8hbjHvuQQvBGJVoJ8v9oFEk0k6Yf7Hyh/pi1Euk=;
 b=uRKO7k2BNg32ExVmrjzwHQ9OAxSXvovzGcsxJSF8h/Mb3jk7THM412F+vJJcHAfzm4
 cxqmXk4EOyPNXghMHOTE7HGZHMLeh4QC6H4BFOyUvs2l7RlAtlvzcCNoz44Bi1q5jqad
 w1KGPzxPv1ykVyJJTyga5p57wN9InrOpmAsWv+LXZywfIyL8wK2iIIfUc0fg9Fy37MNy
 XLQ0N9OonBevkBYJiulyzEUB6TzeYkoiEJc3/LGJn2bBSb4Zmsiqh3DG/qd+GCzCQGrp
 W6X4fT05529Lx3VomYTIAbGIoXInzj+fdBbsrLTjlSNuz+bLIAHLdubzDzg6BTsHlgjj
 rjfg==
X-Gm-Message-State: AGRZ1gIjFtpZmK7kSRDyUUS0ObMdliYIzvlZsZPyuMTct8VeCOMQVGwo
 kAgRmwQkkUKRhk4tPwAooA==
X-Google-Smtp-Source: AJdET5cPOuuI8mxnir+fEmVpzrHl9aA3YyIjzAfVOKp6JTxQ2n+3RtBGnErADhDg4ZmXBW64acWNXw==
X-Received: by 2002:a9d:8ea:: with SMTP id 97mr2995500otf.10.1540419035249;
 Wed, 24 Oct 2018 15:10:35 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id m63-v6sm1867421oia.30.2018.10.24.15.10.34
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 24 Oct 2018 15:10:34 -0700 (PDT)
Date: Wed, 24 Oct 2018 17:10:33 -0500
From: Rob Herring <robh@kernel.org>
To: andy.tang@nxp.com
Subject: Re: [PATCH 2/3 v2] clk: qoriq: remove legacy bindings and add more
 compatibles
Message-ID: <20181024221033.GA5876@bogus>
References: <20181024021122.3942-1-andy.tang@nxp.com>
 <20181024021122.3942-2-andy.tang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024021122.3942-2-andy.tang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, sboyd@kernel.org,
 mturquette@baylibre.com, linux-kernel@vger.kernel.org, oss@buserror.net,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org, linux-clk@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Oct 24, 2018 at 10:11:21AM +0800, andy.tang@nxp.com wrote:
> From: Yuantian Tang <andy.tang@nxp.com>
> 
> The new bindings will be used, so delete the old bindings.
> Add more SOC compatibles as needed as well.

I'm a bit confused by this series. Normally you want to update the dts 
files first and wait some period of time before removing driver support 
(and bindings).

Rob

> 
> Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
> ---
> v2:
>   - involve more chips
> 
>  .../devicetree/bindings/clock/qoriq-clock.txt      |  112 +------------------
>  1 files changed, 6 insertions(+), 106 deletions(-)
