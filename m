Return-Path: <SRS0=bUW7=VN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA3AC76188
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jul 2019 09:03:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0024D20880
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jul 2019 09:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iE9qoOLo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0024D20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45nvZ53HWyzDqbs
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jul 2019 19:03:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=viresh.kumar@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="iE9qoOLo"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45nvVk6GzRzDqQf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jul 2019 19:00:14 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id l21so9113023pgm.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jul 2019 02:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=lkUFnw3tfRAr3e/K9WKPjwIamFFWJ4GH53aBPdA3SN4=;
 b=iE9qoOLowk11gGQyNUKy6hX3dzsZULEYSEE9OPgqI7mSLLicdUlU32aTXLzaosOv7o
 Ps4O6zFWL2zCMd3qvOz+NPOOvxudpA4ZoNz1iW7Kfm742WMhzcJgBCItjvxhdXUFEpyJ
 q1nV6IR/pVSafAW3UgifsGzWyaCK13P0JoqyXGZf1ENQ7sW90oBo9k5SJQtD9weyR/nM
 F6NcPidmAxKSquh6UC12UiEPXBGITyV41xeCRd0q7nCLS66gdldBCos0dPIjm88xzghm
 mu0cB9pSTFbkVmGX1VOZzW3LHyZtMnr/kUgpnQ82ctfG0dTDhC3nwPBAwZiAkRnO8wZh
 OCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=lkUFnw3tfRAr3e/K9WKPjwIamFFWJ4GH53aBPdA3SN4=;
 b=d22eRiFP777ZZuIa9UNgk3TslftaBVu27UBTZtiNFGHIiS907iYo/I28sZw/qTl1FB
 mNkfGu5NJeTqkGNgRhWCI3fqdX7XsCSMXUizZA+mzRoHPJP12wZE2h9mhSnUY8ZckDzA
 h4RUVJA1YLAa+XSOq7xDGz/BDpBSBR+tbVXrvCGsH6YxetczqvLN6WcurHz30wF/AFYJ
 tTwSxPhAHeyqyR25O4pI1CrQXKiLXVzVYOrTNO7abeuXb1gJnvM6k+bHfdoCWGat90nU
 6vrJvZc5r1HBoQYTw0ARJnISkjn2Vh85wjrqO1yhuvg1qjPqDzSX/aiDLZtAlwYjvYj0
 VdwA==
X-Gm-Message-State: APjAAAWPFyqdI0QLP5bLJEfthjDkA1oCywoTzqbkE9ZnoloVeO4slkWP
 TluiaRadyUjpdMAeE4OQ01gMOA==
X-Google-Smtp-Source: APXvYqyRYVnjwsmXfuDGrvTUNw/8KnmANGhR7WhUa8xiZz7T5T2fm77xuJxrapWCLvklzQ79FgDmQw==
X-Received: by 2002:a63:6c46:: with SMTP id h67mr22406939pgc.248.1563267611013; 
 Tue, 16 Jul 2019 02:00:11 -0700 (PDT)
Received: from localhost ([122.172.28.117])
 by smtp.gmail.com with ESMTPSA id r6sm12769971pgl.74.2019.07.16.02.00.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 02:00:10 -0700 (PDT)
Date: Tue, 16 Jul 2019 14:30:08 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: wen.yang99@zte.com.cn
Subject: Re: [PATCH v6] cpufreq/pasemi: fix an use-after-free
 inpas_cpufreq_cpu_init()
Message-ID: <20190716090008.pgddadjzribgbaxw@vireshk-i7>
References: <20190712034409.zyl6sskrr6ra5nd3@vireshk-i7>
 <201907161626465333445@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201907161626465333445@zte.com.cn>
User-Agent: NeoMutt/20180716-391-311a52
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
Cc: wang.yi59@zte.com.cn, linux-pm@vger.kernel.org, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn, cheng.shengyu@zte.com.cn,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 16-07-19, 16:26, wen.yang99@zte.com.cn wrote:
> Okay thank you.
> Now this patch
> (https://lore.kernel.org/lkml/ee8cf5fb4b4a01fdf9199037ff6d835b935cfd13.1562902877.git.viresh.kumar@linaro.org/) 
> seems to have not been merged into the linux-next.
> 
> In order to avoid code conflicts, we will wait until this patch is merged in and then send v7.

Please rebase on PM tree's linux-next branch instead and resend your
patch.

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git

-- 
viresh
