Return-Path: <SRS0=CkO+=VG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5E8C73C46
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jul 2019 16:36:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F69D205ED
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jul 2019 16:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtV9AEGZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F69D205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45jnyN1gm6zDqWS
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jul 2019 02:36:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=natechancellor@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="TtV9AEGZ"; 
 dkim-atps=neutral
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45jnw46zlCzDqQ6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2019 02:34:28 +1000 (AEST)
Received: by mail-wm1-x330.google.com with SMTP id x15so3744458wmj.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jul 2019 09:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=dmI53Fe6ja6YvtBlOYuS2C3Quf7woGdreNXKMWpwq/Y=;
 b=TtV9AEGZZZvxyteeYkcQf9GHSSzWpvppVjkkrE1hTNQ8SKZD2a7U8c7y/9ccK1uCFj
 gjlSEdZgbju2PcUVdlPKP2P+IwHarrxZ+dFcPqkQB9LM0weOehmsO3l2o3OWY+aX2Gh6
 LEzRrtynKUcYfZu5sx+w/sg6vn/xR/QiONYy8H7ubeI0CKukiWyxssB3DUX8qLPHTXuP
 H2KTxa74WfPgZktrhNdbjYr2/B48rMGpZ8+9171y6KhUdSZoQo3bnRuKi3qiCpfg2zsJ
 Leyp4TsR3MM3Bhsy3Q64sj+pZM5rVzaap32rGpWcCoabwD0csHUIp4wOFP0/7pEDCIQp
 J4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=dmI53Fe6ja6YvtBlOYuS2C3Quf7woGdreNXKMWpwq/Y=;
 b=B91OiJOhw/ywRCbll5h4zDp37P7TE7rotHCssijPSBlnJThqdCdVeDUJ+EejcR1Qcp
 pQMlsegPRYLafqGOaYwS9RFZDd+M9RJ5UPxM7PB9tSDYtJ1FfsoQ51H0SqpapduvnwPx
 oIGll66joOkbbm9z6lGFa/Rafz3nKz7tyOHL+bKEF0tF9oreV1KnrvWh6FBH/VZXM4CW
 h/ND+mb6XF7Jo1gZSX78lV4BWNu2EeRZnM9R6n0g/Hl6tJCghqnWfMA+AYxN2JaHgFrc
 F8k7Ikif3vOQX+KNSpw8aMsUm9Bv3x/L3e7INmJZzZkAw5sgWdBA7huFS4tJNVzRTnJR
 0ojA==
X-Gm-Message-State: APjAAAUjUfjxcX6H8E2wXxTDaDNdysoLqjNsBwkPYOA83OOZ2pm3Iqhh
 AVHCUJ+fnk+8LM4lwkovo6Q=
X-Google-Smtp-Source: APXvYqxGtMKm4ZllrIQdJW5DabmzGQ6c9JVgIl91CqdgTkS5K1OiFPQBEQlbQD3GfGIkbaKEDj8kMg==
X-Received: by 2002:a1c:a019:: with SMTP id j25mr704612wme.95.1562690063636;
 Tue, 09 Jul 2019 09:34:23 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
 by smtp.gmail.com with ESMTPSA id u186sm5323219wmu.26.2019.07.09.09.34.22
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 09 Jul 2019 09:34:23 -0700 (PDT)
Date: Tue, 9 Jul 2019 09:34:21 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Subject: Re: [linux-next][P9]Build error at
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h:69 error: field mirror has incomplete
 type
Message-ID: <20190709163421.GA87363@archlinux-threadripper>
References: <1562689597.26515.7.camel@abdul>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1562689597.26515.7.camel@abdul>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: sachinp <sachinp@linux.vnet.ibm.com>, Philip.Yang@amd.com,
 Felix.Kuehling@amd.com, linux-kernel <linux-kernel@vger.kernel.org>,
 linux-next <linux-next@vger.kernel.org>, alexander.deucher@amd.com,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jul 09, 2019 at 09:56:37PM +0530, Abdul Haleem wrote:
> Greeting's
> 
> linux-next failed to build on Power 9 Box with below error
> 
> In file included from drivers/gpu/drm/amd/amdgpu/amdgpu.h:72:0,
>                  from drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:39:
> drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h:69:20: error: field â€˜mirrorâ€™
> has incomplete type
>   struct hmm_mirror mirror;
>                     ^
> make[5]: *** [drivers/gpu/drm/amd/amdgpu/amdgpu_drv.o] Error 1
> make[4]: *** [drivers/gpu/drm/amd/amdgpu] Error 2
> make[3]: *** [drivers/gpu/drm] Error 2
> make[2]: *** [drivers/gpu] Error 2
> 
> Kernel version: 5.2.0-next-20190708
> Machine: Power 9 
> Kernel config attached
> 
> -- 
> Regard's
> 
> Abdul Haleem
> IBM Linux Technology Centre
> 

This should be fixed on next-20190709:

https://git.kernel.org/next/linux-next/c/e5eaa7cc0c0359cfe17b0027a6ac5eda7a9635db

Cheers,
Nathan
