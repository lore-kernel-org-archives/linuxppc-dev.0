Return-Path: <SRS0=Hff1=NE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FD2C004D3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 08:00:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25D86206B5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 08:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="lSTuWwRw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D86206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42g2jq3brRzDrNP
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 19:00:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="lSTuWwRw";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=cogentembedded.com
 (client-ip=2a00:1450:4864:20::143; helo=mail-lf1-x143.google.com;
 envelope-from=sergei.shtylyov@cogentembedded.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=cogentembedded.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=cogentembedded-com.20150623.gappssmtp.com
 header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="lSTuWwRw"; 
 dkim-atps=neutral
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com
 [IPv6:2a00:1450:4864:20::143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42g2gG53xPzDqfB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 18:57:59 +1100 (AEDT)
Received: by mail-lf1-x143.google.com with SMTP id w16-v6so1090735lfc.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 00:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:references:cc:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding;
 bh=V2JxQ9bo1qI+nhXdlK58QIW5s19i3I6plF2Wm8La7tg=;
 b=lSTuWwRw+w4s0c6dnCFrgC2Ld3jUFS30Z4N8hxaNUmj1aVbNWQGhyYVwm05Fznzvv0
 vDt/786ivZubvxT5fZoiumDQ4+rF5Qy1Ev/nIx+KZxXkwrU9gEi/mdjIAIT/K1WhsjjS
 AyWbrNUUSjkTmTnsrHkYdX+kKeEgczFRp2W56nbOS0Ik/4AXjO7EZ+bwRSravPjIJW7j
 kaTEyiX+w6uWoW2WNZ+tdTBCKwJYbYgEDIwf/yqqNC3D9aulvvGwXeTkP6wuACOFt6jw
 uCGCSYmAzZc+Z6TQsNDfc6J6SX6aJERYzTdGQpdlp4hFSyA7bbbT5Ve15FYI+4jQIk6Q
 ZPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:cc:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding;
 bh=V2JxQ9bo1qI+nhXdlK58QIW5s19i3I6plF2Wm8La7tg=;
 b=Cj2Osg4LRiAo+agNdhz+Pr27aF4ktag4GYKUIavtieiWqwjH5zfJQYluNyxU7f7Xv2
 w0zSyUREHIUx+c+vyPUhukCNPH6PO5H16KW5ppueH0UB3QXZOoB1l96K8z0IXPwEWVH7
 RuZkeXvC0rd7r7kVD/v3hHfT1+/aUogpLS6+opYA9oM66qAK9rR2vgZcpu1jquC0V92m
 1CvKX23a30eZY/1NWAAwYsc8vQHLckYCN+ceSV8LdBLTs3/eiyTTNCSeKzp/fZTivVtq
 877/MpQr8JMKUIuko88qg44YjuQSPvaSUIoDMgvV44QlyIqV1rwebi3qAxUVd8CcQb0F
 Mngw==
X-Gm-Message-State: ABuFfoj3h0Z+R6+m1R88rQy5ORF9DuKhvWvbSpHoHsqWPyc1xwhOQ0pC
 31CTHI+nDu1Al+pBOwfxApyuLg==
X-Google-Smtp-Source: ACcGV62uYJH8DMiyK5GKYiczfyqB98ujW+uN85c+acc8oigvD5Qj6uIm52nRHcmBCYDFjU2bnn5Y5A==
X-Received: by 2002:a19:5510:: with SMTP id n16mr8139579lfe.68.1540367875507; 
 Wed, 24 Oct 2018 00:57:55 -0700 (PDT)
Received: from [192.168.0.200] ([31.173.82.66])
 by smtp.gmail.com with ESMTPSA id u20-v6sm586980lfk.55.2018.10.24.00.57.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Oct 2018 00:57:54 -0700 (PDT)
Subject: Re: [PATCH v3 4/7] ata: ahci_sunxi: use xxxsetbitsi_le32 functions
To: Corentin Labbe <clabbe@baylibre.com>, Gilles.Muller@lip6.fr,
 Julia.Lawall@lip6.fr, agust@denx.de, airlied@linux.ie,
 alexandre.torgue@st.com, alistair@popple.id.au, benh@kernel.crashing.org,
 carlo@caione.org, davem@davemloft.net, galak@kernel.crashing.org,
 joabreu@synopsys.com, khilman@baylibre.com, matthias.bgg@gmail.com,
 maxime.ripard@bootlin.com, michal.lkml@markovi.net, mpe@ellerman.id.au,
 mporter@kernel.crashing.org, narmstrong@baylibre.com, nicolas.palix@imag.fr,
 oss@buserror.net, paulus@samba.org, peppe.cavallaro@st.com, tj@kernel.org,
 vitb@kernel.crashing.org, wens@csie.org
References: <1540366553-18541-1-git-send-email-clabbe@baylibre.com>
 <1540366553-18541-5-git-send-email-clabbe@baylibre.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <83472722-c7e7-820f-b97f-37016ff32893@cogentembedded.com>
Date: Wed, 24 Oct 2018 10:57:49 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1540366553-18541-5-git-send-email-clabbe@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-ide@vger.kernel.org,
 linux-sunxi@googlegroups.com, linux-mediatek@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 cocci@systeme.lip6.fr, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello!

    Typo in the subject: s/xxxsetbitsi/xxxsetbits/.

On 24.10.2018 10:35, Corentin Labbe wrote:

> This patch converts ahci_sunxi to use xxxsetbits_le32 functions
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
[...]

MBR, Sergei

