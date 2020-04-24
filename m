Return-Path: <SRS0=4/q6=6I=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F254CC2BA1A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2020 09:17:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6559420724
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2020 09:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLqeK807"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6559420724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 497pV264sqzDqRX
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2020 19:17:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1044;
 helo=mail-pj1-x1044.google.com; envelope-from=nicoleotsuka@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=hLqeK807; dkim-atps=neutral
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20::1044])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 497pSB6HnKzDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2020 19:15:54 +1000 (AEST)
Received: by mail-pj1-x1044.google.com with SMTP id a7so3696190pju.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2020 02:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=GiWyPt7yzmACBp+FM5CBU27WrasEL3zEd6YMjPXRRYw=;
 b=hLqeK807AIl6oploSr0Ba6ECKM0p7TJKe7Ek3q2RmBD0GalqEqtMmRgxnkTlqcmdzV
 ImxmiB17WCsKRZzUUwf15tdxBIvx8kVfKqvsamdbhlDfruuX1a/rIrojrXzb7AmzvZnw
 L/qkKYRqVsQM5Y6gA907HSjwfpLGR5zddHhtKDXluMyl6xz5DNoWeedHM8EwIj+zJRct
 YGRYb5B6VaHlc00x4WiOwUXXe0lfY6iZ6Zs2FtKP23Al/RAc2TlBD5WToZDRaVsNd0VF
 8JosDlT9ZgqC9CyuqWcb0/7Dh8Wv8VY7VpWPMCNx0aa4cmIudmY0/WbW+98c0jYN39hH
 APeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=GiWyPt7yzmACBp+FM5CBU27WrasEL3zEd6YMjPXRRYw=;
 b=Q3UyYtGsKFp0FVixJqL5cBiUa5lewBbvO3Z7U9nKjyWbPRvzbh1kC43Axq+nPFNd1q
 llPJZiwTo68L09ec+XbwnuA/ZiK6Ahw5oJWzjhYXWaehTyU7tu2ULhY9P9SlHU2mUEc/
 lgAPuy6vnfwUdlQCF+e7kAGoOOjBXaZs2xtYaw1sXHcl9f/9tglr35Hxixv/00qfsMdO
 LifwqCf/odNZDWwPCkkF0olgfFpzFRqckzWBfCV8OTr0gDpj+/wNs2mOF/BknFd+lSa1
 B3m5CJJ7GvhAXguiEyyb9qtxKtMR9MMGJ5UqvqcPDyAtIUthiRBg8hrCI4/TKI9bxA0M
 gaeQ==
X-Gm-Message-State: AGi0Pub1HUm1PKnUBEg44njaAEqd5H9p5hAyhVxDywuDmjq7rnnP+Tp7
 oJ7GLPNL1JpQPJ2j8t1RxuY=
X-Google-Smtp-Source: APiQypJMf2vN0y0/aXmoENydAS7xfN3ytEgap8oA8faei9WM71d4PxRiV+783Qla1nkRQ/PT8Su4cw==
X-Received: by 2002:a17:902:8218:: with SMTP id
 x24mr8335621pln.192.1587719748506; 
 Fri, 24 Apr 2020 02:15:48 -0700 (PDT)
Received: from Asurada (c-73-162-191-63.hsd1.ca.comcast.net. [73.162.191.63])
 by smtp.gmail.com with ESMTPSA id
 u13sm4301584pjb.45.2020.04.24.02.15.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 24 Apr 2020 02:15:48 -0700 (PDT)
Date: Fri, 24 Apr 2020 02:15:33 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_esai: Remove the tasklet
Message-ID: <20200424091533.GA8856@Asurada>
References: <1587711246-27226-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587711246-27226-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
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
Cc: alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 linuxppc-dev@lists.ozlabs.org, tiwai@suse.com, lgirdwood@gmail.com,
 perex@perex.cz, broonie@kernel.org, festevam@gmail.com,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Apr 24, 2020 at 02:54:06PM +0800, Shengjiu Wang wrote:
> Remove tasklet for it may cause the reset operation
> can't be handled immediately, then there will be
> endless xrun interrupt.

The reset routine is really long and expensive, so not sure
if it'd be good to do it completely inside HW ISR. Have you
tried to clear xEIE bits to disable xrun interrupts, before
scheduling the tasklet? If that does not solve the problem,
we may go for this change.
