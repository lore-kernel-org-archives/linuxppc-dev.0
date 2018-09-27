Return-Path: <SRS0=O7I3=MJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACD9C43382
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Sep 2018 19:34:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49ABF21710
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Sep 2018 19:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49ABF21710
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42LlPQ0k24zF37t
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 05:34:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.194; helo=mail-oi1-f194.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
 [209.85.167.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42LlMJ4J9gzF37p
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 05:32:43 +1000 (AEST)
Received: by mail-oi1-f194.google.com with SMTP id 13-v6so3259393ois.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 12:32:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=tnSYaK0DUOE5vwk8CXbgIKk4JjzqMvOiW++MdLQZSJ0=;
 b=DCnsTrVpgwoVTD2KbBLlcLwuiZhVpO9FBrdVH65vQYZ1zYO3ZRF01nINGE9twSLuAV
 QEnvBZ0kx/Nj6l2gDx9WAl9CaYZNKI1EzdZPNytIpHiGzEOOFxtWbHKZM0GkLQExwxb0
 xNSzw4+qlhwzLH7r5GXeu0+mBcjcEoQCHPPMEUetDbw6NVG3PlM04rPTtyWr0WYVjuBB
 8EZrI/p+zge/KKa74q/MGIWryA+W/IavRVWNwIG988wEcNsE8SX1W+L3+BO/8JBF7twh
 pZCGzye35OhkWOurvuDm+gwRNxwsVKh/8imjJp95ys8ezAHJTBcwciS+X4vcbmOJN3LB
 7mcQ==
X-Gm-Message-State: ABuFfogjJN0TRDljsbctrn6fzxPDrdVJvyKdlx9yNkEL4oUF/GXNHQX5
 nwDsXNCoe5o5cZYA0mtfCQ==
X-Google-Smtp-Source: ACcGV60TmkVwBvyfbPHx9Z793dhCXq0b3Vp8Jkc/cxewLDo4IcxfS1BazWHaS0g8+C4aXg8fqpt/zg==
X-Received: by 2002:aca:dad7:: with SMTP id
 r206-v6mr4054236oig.271.1538076761491; 
 Thu, 27 Sep 2018 12:32:41 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id s25-v6sm1130411ote.35.2018.09.27.12.32.40
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 27 Sep 2018 12:32:40 -0700 (PDT)
Date: Thu, 27 Sep 2018 14:32:40 -0500
From: Rob Herring <robh@kernel.org>
To: Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: arm64: add compatible for LX2160A
Message-ID: <20180927193240.GA29253@bogus>
References: <1537747741-6245-1-git-send-email-vabhav.sharma@nxp.com>
 <1537747741-6245-2-git-send-email-vabhav.sharma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537747741-6245-2-git-send-email-vabhav.sharma@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: mark.rutland@arm.com, kstewart@linuxfoundation.org,
 linux-kernel-owner@vger.kernel.org, catalin.marinas@arm.com,
 mturquette@baylibre.com, will.deacon@arm.com, yamada.masahiro@socionext.com,
 linux-clk@vger.kernel.org, udit.kumar@nxp.com, linux@armlinux.org.uk,
 viresh.kumar@linaro.org, devicetree@vger.kernel.org, arnd@arndb.de,
 linux-pm@vger.kernel.org, oss@buserror.net, robh+dt@kernel.org,
 V.Sethi@nxp.com, Vabhav Sharma <vabhav.sharma@nxp.com>,
 linux-arm-kernel@lists.infradead.org, sboyd@kernel.org,
 gregkh@linuxfoundation.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 sudeep.holla@arm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
Message-ID: <20180927193240.ZlcDS1SSPgopcc8_ZZkBBha5zO_MbVLiZuUqO1P6ipo@z>

On Mon, 24 Sep 2018 05:38:56 +0530, Vabhav Sharma wrote:
> Add compatible for LX2160A SoC,QDS and RDB board
> 
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.txt | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
