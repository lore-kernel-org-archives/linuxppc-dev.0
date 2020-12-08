Return-Path: <SRS0=iKYh=FM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9997BC433FE
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Dec 2020 01:30:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD39F221FD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Dec 2020 01:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD39F221FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CqjKh0Q3TzDqc6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Dec 2020 12:30:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::644;
 helo=mail-pl1-x644.google.com; envelope-from=nicoleotsuka@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=c+bi86iX; dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CqjHT6BgLzDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Dec 2020 12:28:20 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id t6so561331plq.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Dec 2020 17:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=g6R21sa3bkOjEnwqhAVxyM+kWVKk9KN5CJ8WQiyRzKg=;
 b=c+bi86iXy/pSBac/0D9EHuYLqSgzndqvSEaxFibcNpweMKyQygRkZzQDEMO+Qw0UxT
 /33sCLHGIDMYobzNYwvDSi74tyY8ITvbbDU0Sk258GTxreVez+owDIlHjtcFzsZa3xix
 ndvhJ1d6ZErYf3EfuNA0LAXY706OqaLr54H27c48TPfhCf0qaS4L6PqOmMCtN1HN3dO1
 QEJZ6vbRb6gjEs93MG4zMFETc25vJntRNgVRpY1n02Py/AK4BmQHWQK+H8sSTwpOHpWn
 XXq5k8unAN/YWq7bTwYRW4BFivBs+VzBJ60omZmbh14WbOjmjjO7/mdsrXwe3+w0Qdr2
 OW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=g6R21sa3bkOjEnwqhAVxyM+kWVKk9KN5CJ8WQiyRzKg=;
 b=YLYy1OrysCG92etsmvqJWqTmr2UujZjN+LCoq9EwI5CKgqI9HTaV6Kor+ufsdvu46+
 2l22oQRmsYmWbRCbRNIRM7Krfbpozve+8b1R51SECS3Q5qVw38RGDnEUswnzFPWFiwir
 tsr3ZSH3JVI2qcVodfZO0wKZ/Rcj6ppl5vq+5Ds5o+LKzFlPdD89ue7i68xL5N7K6iZM
 EJqLkHXVs7VbQo8YZUa30ZY5or6IvXNs++iTgfgZRmbaFctAZnLcxVPIykGde/JfCyK0
 ssqVMmzd9I6h2Ws4eqlV82jUjuYE9oNRSQ50Kqu03v6Dn2zUMzxqp0oMUyQfzDZlVuyD
 yqaQ==
X-Gm-Message-State: AOAM530qeJZN/vJV5rNrJkZKldZCCeSz8ZOX2VuWdrTa0JNmhmtYe4KM
 VEJpIkqBPXnNaELgjF5y7rc=
X-Google-Smtp-Source: ABdhPJxpxLxNICfqOJ5BiNFYHNzVKl0q1JwFffvvXbpF0tW9FuLkpPPBA+bELyA/XOq2JtoKBTRo5w==
X-Received: by 2002:a17:902:6ac8:b029:da:d645:ab58 with SMTP id
 i8-20020a1709026ac8b02900dad645ab58mr16864544plt.25.1607390896709; 
 Mon, 07 Dec 2020 17:28:16 -0800 (PST)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id a22sm12495382pfa.215.2020.12.07.17.28.15
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 07 Dec 2020 17:28:16 -0800 (PST)
Date: Mon, 7 Dec 2020 17:25:26 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2 2/2] ASoC: fsl: Add imx-hdmi machine driver
Message-ID: <20201208012526.GA21510@Asurada-Nvidia>
References: <1607251319-5821-1-git-send-email-shengjiu.wang@nxp.com>
 <1607251319-5821-2-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607251319-5821-2-git-send-email-shengjiu.wang@nxp.com>
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, timur@kernel.org,
 Xiubo.Lee@gmail.com, linuxppc-dev@lists.ozlabs.org, tiwai@suse.com,
 lgirdwood@gmail.com, robh+dt@kernel.org, perex@perex.cz, broonie@kernel.org,
 festevam@gmail.com, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Dec 06, 2020 at 06:41:59PM +0800, Shengjiu Wang wrote:
> The driver is initially designed for sound card using HDMI
> interface on i.MX platform. There is internal HDMI IP or
> external HDMI modules connect with SAI or AUD2HTX interface.
> It supports both transmitter and receiver devices.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
