Return-Path: <SRS0=+Gyc=SY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED46C10F14
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 03:00:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 921C920833
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 03:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMipgTXX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 921C920833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nWXx2H31zDqQd
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 13:00:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="WMipgTXX"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nWWF0rmhzDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 12:59:04 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id z5so5027474pfn.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Apr 2019 19:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=bLTCqZP0EkEe5cTjpvrGXCdlUzTPZuSYTCe6QDTNd9Q=;
 b=WMipgTXX23x09PQjGeptEst4JHIS05wIXfC9NKFO/azh/ELjjw7eRT1JP2Xnl51o42
 F7Ew4z7pbyWDOLspFgzi79/5QSpm0C+OmtsIYtqg4EryaTngcEvHHTTHjf1jTqHmZKxf
 LYScnE8+ZmjWvHMeJUJwEKIuZjwlDn4d0hEX1dKSaigOshR1j8Wh0YUy+kt8s1ZFNNVM
 jgtnV9G3Zze+c3TlclbBRhZYvTLAsWw1dxrT8SyI5tSrgY2nD+Rm1lWlOi8QI5om60bY
 6SiMCEZJX7hsHryQt4x2dj4CcGyjO88/plKhfgKYA/0VI7e3fHq2bRC9xLdf9mtN5R+/
 Ibtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=bLTCqZP0EkEe5cTjpvrGXCdlUzTPZuSYTCe6QDTNd9Q=;
 b=ekIBl+RNurvbBwcOsAcyqqIR53+S3+Gmb3f24lW4nJv4hflEOR+jKfzQqef5Ugyr/k
 u0pdeX0nDbzHiZSRHfCBBjygdNuVSmLBD6KWitkCnvE58L7Yg9AE4k9AUHoZKBZZCJ2z
 sOOKP3L8fP6jvBzMTRgJyjMEBTpMFUWYNLFHuRnHTBiSxXnHrAzVA9l6pvTYdsOJvuDJ
 gVkyn8KhmBMe3MCORKnsLGHIWpdyyNfgbrpC6bEn+KWobYIDt38QrE0O0Sf+G1rl5qGV
 mWX8UeEWDuaATJx+6moslSuphUAXhUohToGOz5GEESVgh1qzbVtWtElSHhebtQFt9oC2
 2eVg==
X-Gm-Message-State: APjAAAVwRVA/qmRvpuIWZTci0FB6bm/nWEGe9VeM2yKPQs5FEKkaTYUd
 /BpLQUU4d9K1WHAgJg2JNSo=
X-Google-Smtp-Source: APXvYqx/X7l9wCZA8zKnCu4okFTzhlOhU2FcDFA2JwYv8oCTRTXnlBX2TyBzxH6e/EpmwhE73FZOig==
X-Received: by 2002:a62:5206:: with SMTP id g6mr17639111pfb.227.1555901942422; 
 Sun, 21 Apr 2019 19:59:02 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
 by smtp.gmail.com with ESMTPSA id
 b63sm30188611pfj.54.2019.04.21.19.59.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 21 Apr 2019 19:59:01 -0700 (PDT)
Date: Sun, 21 Apr 2019 19:58:55 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V5 3/3] ASoC: fsl_asrc: Unify the supported input and
 output rate
Message-ID: <20190422025854.GA8476@Asurada>
References: <cover.1555900078.git.shengjiu.wang@nxp.com>
 <841aa2c4256e418759422affe6c138fa55cd1785.1555900078.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <841aa2c4256e418759422affe6c138fa55cd1785.1555900078.git.shengjiu.wang@nxp.com>
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

On Mon, Apr 22, 2019 at 02:32:38AM +0000, S.j. Wang wrote:
> Unify the supported input and output rate, add the
> 12kHz/24kHz/128kHz to the support list
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thank you
