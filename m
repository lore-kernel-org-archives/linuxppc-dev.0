Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6EFC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 19:50:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0002220643
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 19:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnGy8nV+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0002220643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lV896JCSzDqTJ
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 05:50:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="XnGy8nV+"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lV6T52JdzDqLl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2019 05:49:05 +1000 (AEST)
Received: by mail-pf1-x444.google.com with SMTP id h5so1579195pfo.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 12:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Nv1osdKMnyQhFpXAYzfTc/y8P4eQhfnwJ3z9VJHumRs=;
 b=XnGy8nV+vrlbZLrGOz/2ITivLC4FD5nuOPNiQP39Nwi2Gff+bcupMcExivueyD+z4q
 Go4gLOQzKLBdAhlU1UFvA6mJ/k2mQAsY0MiA6Fj/0c2Uks1VRkL5eMVDgdeSFuqqHknh
 gFqVhfzZEtWCIJZzGTm9argq1WxEObOFJLsFmk181hFJUQ/4Rwa9wmOHbhQWBXSzvrLX
 ZDf/iLZrVTMrUuPGKKCkPG3jc3FJVXRUsRCwB7fIUkgz9zul3803EgfjxsaVzR27tsqi
 yia0T6ibseVHWa1l1bBeAXTCpcCG1vnuUKn6pY00thLmzsPgbupuGk6nwMDrLlgyL8nS
 PbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Nv1osdKMnyQhFpXAYzfTc/y8P4eQhfnwJ3z9VJHumRs=;
 b=H1eRKPTZeg7VNxANSKR5Zg95sOEryuzLuG13AWnZ2TxO6EQu8j0bSfCN/1chv3uidS
 EnHY9ZO6kQhVaFztet78w0hARhRVLAkdsWWWffAWYopmcuDmSskdCUsw90m3ezxSE9TG
 jiDK/P/MzjCIQBXKMWdtlioE7L0I1zcu9FEsyAnoorW8dZLeH3pvFWKoTxcTKhc7gHDt
 PwrXIAtwTFUfwc9ITogpn39YZOiTdwFvtZDVEhTYSBG8VqeKhtVxVl45xiC/oMCkV5vg
 hdbWpkDJVLU9KaZ+9xB5lQGCjOYbYgG92zcqcqLG8qUCU3ia0yDXHPfJ71566K5KRUod
 ZBFQ==
X-Gm-Message-State: APjAAAWGCAuVYxGnkeAMstlaPZuV9ebUOS8MW9snjrhrlkTwzBqmJEpu
 Hlla1GgDaAtn1ufOm38Zyn0=
X-Google-Smtp-Source: APXvYqws8l3BHlRoJ8O3n8PyNUaV9SDlmTRmQ2aAZP27lA4t4fOhIUvpl8zDughhtClhkxUHkgXcWw==
X-Received: by 2002:a65:4bce:: with SMTP id p14mr92784659pgr.376.1555616941584; 
 Thu, 18 Apr 2019 12:49:01 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id m23sm3924311pfa.117.2019.04.18.12.49.00
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 18 Apr 2019 12:49:01 -0700 (PDT)
Date: Thu, 18 Apr 2019 12:48:58 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V2] ASoC: fsl_esai: Add pm runtime function
Message-ID: <20190418194857.GB14885@Asurada-Nvidia.nvidia.com>
References: <8c78be27ef3795e9b870de7789c25454bd3774b3.1555586023.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c78be27ef3795e9b870de7789c25454bd3774b3.1555586023.git.shengjiu.wang@nxp.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Apr 18, 2019 at 11:34:15AM +0000, S.j. Wang wrote:
> Add pm runtime support and move clock handling there.
> fsl_esai_suspend is replaced by pm_runtime_force_suspend.
> fsl_esai_resume is replaced by pm_runtime_force_resume.

The change looks fine, yet I'd prefer to have a good justification
in the commit message. It could be simply some benefit of doing so
like what you have discussed with Mark.

> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Please add it in next version upon commit message update:

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks
