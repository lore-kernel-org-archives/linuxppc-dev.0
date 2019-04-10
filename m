Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFF3C10F14
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 03:54:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24CFB217D6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 03:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ply8VgFd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24CFB217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44f9JR28GfzDqKq
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 13:54:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ply8VgFd"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44f9Gg0LBGzDqK1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 13:52:42 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id y3so651284pgk.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Apr 2019 20:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=JaYiiQSD6kJfG0/TWSs3FdKQzJwxb7e3bje3y4fv9sQ=;
 b=ply8VgFd+x/AEmf7puJN6OqvSXLKVGTq9FNT5obmAFnas4a0aG6WMD1s1W9Rqafh5/
 5JaZBD1NZZI51zhqfFcvJpN98Wr8hE/edkB3sX3amLQJgllZLmnpKalWmqIu8mQeFZe3
 M4kexUq8n+eeUlTUP9O68UIklm4pTkNV/zNfALK8freZFcNTAez5YaWWZ00ydZY9T2sm
 tn296JEvG6BLAXtYbkF0lDaEhou8bAENb7L65JbEh94eDRz+ZINjSMscGgln0rGeJw5G
 M5tMeWBcD0d10bxkvv0nba/hmaQ+FeQGcYteYjo6asQOeIYCtDNKiKo7GOmLtMD1OsIg
 +f1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=JaYiiQSD6kJfG0/TWSs3FdKQzJwxb7e3bje3y4fv9sQ=;
 b=crx6ql7/yC5Hml0/ZBYeZTGZ0gw8xCIwWS4kCBejCKam+NrW/eUSeO25ceXJBtbj4X
 YcCPw52LLc+03b4oTz04DHT3WE0YxgqDzk7L65UKvWO79ZStUSBUvNgiwZWjIMqJ2/VV
 hGkVBFfYRu1AGcakTRuKjBy35GrYW7qjpzmWjTCLU2GC5EZnoxZqf3Ww8si9mYP+HTFZ
 LmTKp6gCcC2h/icW/8Ow5DLaaXDBShjKT3Dxx2sxrylr7WPL40nuhnRIlibzYwXE36f0
 0wryPDVtCFyB2eoNL812cf/JzFEDVlDqPwLMXpNpNte9Pd5lJTxQr5iTJxnAzfl+OuUH
 A06g==
X-Gm-Message-State: APjAAAVAbyornaY++Hvn5iOJ61XV6YxYK2ae+Qp2A4apHeE/Pnd+Z8ed
 ULwweItd4kbhwWlQai6WuEM=
X-Google-Smtp-Source: APXvYqx3VVTzqJCOrKSXLQUxJd9lFxXwA3MbfReN7nOgv0juOKrS2VfsYCX7CLsEDhYrmxHlXbmVYQ==
X-Received: by 2002:a63:6988:: with SMTP id
 e130mr22290258pgc.150.1554868359200; 
 Tue, 09 Apr 2019 20:52:39 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
 by smtp.gmail.com with ESMTPSA id
 w11sm21733536pfi.37.2019.04.09.20.52.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Apr 2019 20:52:38 -0700 (PDT)
Date: Tue, 9 Apr 2019 20:52:36 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V1] ASoC: fsl_esai: replace fall-through with break
Message-ID: <20190410035235.GB8844@Asurada>
References: <66c117128f300b0ec5f278f538412789c78b60a6.1554715589.git.shengjiu.wang@nxp.com>
 <20190410035059.GA8844@Asurada>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410035059.GA8844@Asurada>
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
 "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "festevam@gmail.com" <festevam@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Apr 09, 2019 at 08:50:59PM -0700, Nicolin Chen wrote:
> On Mon, Apr 08, 2019 at 09:28:06AM +0000, S.j. Wang wrote:
> > case ESAI_HCKT_EXTAL and case ESAI_HCKR_EXTAL should be independent of
> > each other, so replace fall-through with break.
> > 
> > Fixes: 16bbeb2b43c3 ("ASoC: fsl_esai: Mark expected switch fall-through")
> > 
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> 
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
> 
> Thanks

Oops. Acked the older version...should have gong for v2.

Please ignore it.
