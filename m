Return-Path: <SRS0=EtvQ=7Z=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01976C433DF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2020 08:04:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 373B020578
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2020 08:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpLD6GPa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 373B020578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49jtXl0jQZzDqwv
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2020 18:04:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::442;
 helo=mail-pf1-x442.google.com; envelope-from=nicoleotsuka@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=KpLD6GPa; dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49jtT33kk0zDqyZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2020 18:00:54 +1000 (AEST)
Received: by mail-pf1-x442.google.com with SMTP id x22so3942378pfn.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2020 01:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=tf6ndzUcORoBXdwJ742om4LN/SmZ3Qj0kiAjVJpLMKc=;
 b=KpLD6GPa1LiJdiGXWZtlAf3FCCQaL2P+jEHXZXpY0DK6/JwqBCfMEUa6SycwKn36pV
 fIU7NQzgMPjlZDT6/IgfHOy47FlKgE318Lpks/2XmKxd5ssYI/JhxLhUQ75NrwSA+FgI
 WwR9W/Kd/eb/WW1vtpNmQ9luP94CdVn8iknLZhGVcTLxXCE6AOHNN7mJqKJ9Lc/iCNKJ
 AmEDtdeCOQrtGcSJIcVAUggLVeknItOjsof4ZZKoN+u8vQ8mGV1UW+HWOCH9ZqIxe4wq
 8t6k+b6hVLXOTtMTvWBax2XusbsF8sNZOXOOhxUDzzwcEiUU8r0WY8sevY40vdjtQHLE
 pVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=tf6ndzUcORoBXdwJ742om4LN/SmZ3Qj0kiAjVJpLMKc=;
 b=iRp552YpaQtb6BYo+j3mRe2buA+1A5zAPXTatEdjyL0eSP1j7SttOuGQnPzANODoLB
 OUxM60hS3N03upqTd5XIh3VsI8antMxvSOu7wlNPJwiZbGCPMGYTZSHbFQVUGSEUVXA0
 rE0P+o2fmN8ST2nYBxn4V2MJ9DZg/qGIQn5DYc65zIztO2MJDB/MraeGlv5/eEC2Bmos
 g/LC3ixnhUxpCEihaPVnNk/px82exKP/GXzjx+T9pRn2JNlSyxUKBedRw52J5z7ObKUa
 QI52AmVnt+MQe3wZtxT2CSWn8TSq9s2E/in41xrmu3luYl4bYUdrinzgXmcvkhgIDjGE
 hmSA==
X-Gm-Message-State: AOAM530PxgWbThMvdfiMZqXQTcuOG2LB5dyrXaFIUQGdS2vWfNFrd9dU
 6XIuCUtrS0NE/LIl/L7Kp0U=
X-Google-Smtp-Source: ABdhPJw376HozhA54nKnNRb/izTEe/+VX9TjxpQMNrnO9HjCzAoOeOAkAY3whh0s2i+FcSh4Kp67PA==
X-Received: by 2002:a63:4f1b:: with SMTP id d27mr9654512pgb.389.1591948851063; 
 Fri, 12 Jun 2020 01:00:51 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
 by smtp.gmail.com with ESMTPSA id ca6sm4579180pjb.46.2020.06.12.01.00.50
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 12 Jun 2020 01:00:50 -0700 (PDT)
Date: Fri, 12 Jun 2020 01:00:38 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [RFC PATCH v3 1/4] ASoC: soc-card: export
 snd_soc_lookup_component_nolocked
Message-ID: <20200612080037.GA22422@Asurada-Nvidia>
References: <cover.1591947428.git.shengjiu.wang@nxp.com>
 <55f6e0d76f67a517b9a44136d790ff2a06b5caa8.1591947428.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55f6e0d76f67a517b9a44136d790ff2a06b5caa8.1591947428.git.shengjiu.wang@nxp.com>
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, timur@kernel.org,
 Xiubo.Lee@gmail.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, lgirdwood@gmail.com, tiwai@suse.com,
 broonie@kernel.org, perex@perex.cz, festevam@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Jun 12, 2020 at 03:37:48PM +0800, Shengjiu Wang wrote:
> snd_soc_lookup_component_nolocked can be used for the DPCM case
> that Front-End needs to get the unused platform component but
> added by Back-End cpu dai driver.
> 
> If the component is gotten, then we can get the dma chan created
> by Back-End component and reused it in Front-End.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>
