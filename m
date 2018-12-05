Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8C2C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 18:34:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3384920645
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 18:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HODZEPsJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3384920645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4396pF3LrGzDqqD
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 05:34:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HODZEPsJ";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=andy.gross@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="HODZEPsJ"; 
 dkim-atps=neutral
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4396ks1B3WzDqq3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2018 05:31:29 +1100 (AEDT)
Received: by mail-ot1-x342.google.com with SMTP id e12so19589519otl.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Dec 2018 10:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=KjQ36aVOOBWevKPNYjYvYEZ3HkAGFCzYyc8+nitudjg=;
 b=HODZEPsJ2mBlftE+QcwCw0nZvVzc51kOFVZBWsGKgvVZM/Wf37V4EEWJvwO9JktX5v
 tMNAF+vO3otnGV/CwrK71a2M1bGHDgviX97ple1P2LaZ10h007uY8X3vgG+3RQ5Sh6NU
 jV+09eLwY2HYYcxQm8coOal9AmpKqbciK/inM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=KjQ36aVOOBWevKPNYjYvYEZ3HkAGFCzYyc8+nitudjg=;
 b=fBFu+deFsV/+ussa6NIU6AbmXNn7hnGeFeqqEp12FOcqor18opEx2zA4BDGzE7xjaS
 nEkhqDo2sxa6BU+ArSIzZAgXEnl0sAmvZYTq9Bhch0X+2ugV97EGvJE1mEQNzZzd6y86
 gUCX8VSiykqak7eWGBwu/JDNv8R6QkRihBSReYPgXjGBWkD/JS71gGazZNwS/2GCcNnl
 FHnJpAUq4RF4pzCEZ8TgklkG/V+WyKevzNWEo0RM356fby3+5hmlE1+9tHd3sRtEi5rI
 TOkxBxcBHQ0fkFV0ekTzsl4u+hvLESEGXjhUZx5yanLDu78a6mtBNLby2x+daNJgh00g
 dT1A==
X-Gm-Message-State: AA+aEWak9ypqcJ7QUCv27NfalyqJLYxNhmJbLo1+hZCjn4Ro+/tlFN3l
 YUczjver89VRMnYYDhrMD0Z34Q==
X-Google-Smtp-Source: AFSGD/W0PEg+UScYa9ARunJVtqWLgGPe7FMOhDRUMPVP/U6OOSGnXTHRUvDUF0xRvQvjMrPLh1SROg==
X-Received: by 2002:a9d:63cd:: with SMTP id e13mr17155795otl.319.1544034687190; 
 Wed, 05 Dec 2018 10:31:27 -0800 (PST)
Received: from localhost ([2600:1700:141:4960:545d:d91f:9ae0:9fd8])
 by smtp.gmail.com with ESMTPSA id l108sm8155569otc.23.2018.12.05.10.31.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 10:31:26 -0800 (PST)
Date: Wed, 5 Dec 2018 12:31:25 -0600
From: Andy Gross <andy.gross@linaro.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 22/34] dt-bindings: arm: Convert QCom board/soc
 bindings to json-schema
Message-ID: <20181205183125.GA5497@hector.attlocal.net>
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-23-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203213223.16986-23-robh@kernel.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Kumar Gala <kumar.gala@linaro.org>, Grant Likely <grant.likely@arm.com>,
 Sean Hudson <darknighte@darknighte.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, David Brown <david.brown@linaro.org>,
 arm@kernel.org, Frank Rowand <frowand.list@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Dec 03, 2018 at 03:32:11PM -0600, Rob Herring wrote:
> Convert QCom SoC bindings to DT schema format using json-schema.
> 
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: David Brown <david.brown@linaro.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Andy Gross <andy.gross@linaro.org>
