Return-Path: <linuxppc-dev+bounces-22689-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413CBCD98DA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2026 06:27:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfcTf6p9Bz3bqh;
	Tue, 16 Jun 2026 16:27:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781591222;
	cv=none; b=GQZypn5mNEEQK0YpR+7AVKy5FD6+XWT9tZl6+7yTM7LPptV7Dod3w1HSvbisAoFAcFePK24DI/rqBvxF/49Bf/V4rILToEKyCRY7z8hiVCS8yq7tbAFuDj3K9bYTC3aQUQmMZbUFVTDfdxJS8BmpIPmDBq3YVdMvf/v1qSS3VmapbbJaNSavRv44RmlVRyKv1gBHxG6WeZIhM/oHAI5Qd8h4ysaU8ysvB3qDwbanj30yLy/HG9G40cgnx4aeK3kJbStxWGrAEDuWp4SWbf6LC5eBvyNXNrqsxJONPjV1xTgYiSXzTtOiLl8PW0Eo0CPZS7uNxbo88rsMJLhleEf/aA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781591222; c=relaxed/relaxed;
	bh=rI93y5seViHg5YidVC1YNQsLofTGTFtrXXZXnF5WUWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WuzKUW+Zf4F5CqSOH8XeSwCnOaZkcYz+iNKO0N4wVu7kaEZTWy3AEAeCysGvX3E697xeu99tyDU1q2aOvxa00o2OEVBpx49Knj96DGcGNML8uPM1MV3t4rgb/tyfFaQzmFMO0Ydf5nE6WVZeKNAxluDxr+/eAH3YB0CHdOQXTTqXsrDuEzHWChydkFHdaEC1+lGYXaVAV3RjK4F3ufO2L0yfo1Gi88zg+mwScNWXUruKoG7sBrK7HM7aeRP0PmxBnaMAG0AdCIFS6iOeTbcUns8FMUWg6ETGl8le9+8Fw1fMQwxzoHMKfBwCbE7ZPw793CvxspysaDZxuK/scD79vw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iRx2H0ox; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iRx2H0ox;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfcTd1w82z2yv0
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 16:27:00 +1000 (AEST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-8423f626a65so1977454b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 23:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781591218; x=1782196018; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rI93y5seViHg5YidVC1YNQsLofTGTFtrXXZXnF5WUWU=;
        b=iRx2H0oxJ/3Cy6Ai1oxKrDAFDfr1RgCCMC9UpeU8oOxoEPL0byLAps9x7FQ1DfreM0
         LRtFMSPpMS7QzYor1FnBEY9AxrA1GAjUg+KdM3OgAQJF+jZE8yivyEQWRX2Cec7T5/Tm
         OK9sTDPqlHl2BwlFWHm/kKwqdCOxLB9Uf63SIQE5YmE/RvhDIK5LfYlLQ4LUBFjrNoqx
         90z8wy7BDXR3IlG4OZl93ROda5zR3FSvsZ63/+TFp8M9xxA43hmHvqdjatPK1OBzoLSW
         yK9ODdJlhMur9RCux0HNWr4mCnRBPCXfjP2tv8KdK1ERiOYx1t+9AhnTWAEkqz433Tph
         NHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781591218; x=1782196018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rI93y5seViHg5YidVC1YNQsLofTGTFtrXXZXnF5WUWU=;
        b=W9HZt1M0I+35GL1OwcU+cbOyBZqny8N8d48nl6AfSC37hNXK+TnxrbEO6H0KKBgKRf
         L27JQT06hdTlinGH5JxvA2BrwPuaGq+UaST4ixXiLqOMO0gOOPpxaMqbpgkg1DUYk+fd
         0/aN9QDi+CXqSE0TTzhm0vCL0rx71Rt9d+f77agPlGzhCxvtx3VUfEgm659wR0X5cSZS
         7CY+WT/wOM9z1yzAbQzL1E89TXHA9d3iVteAAoPPmr+kHDFcS82OTpxml62mNH/YZgei
         ddICeyfR8f/CFHxpdU1/x1ha9/mQEaVd51cSAmklWGYjo8MCkOXH7buhJCkeM/drzE/7
         nHUg==
X-Forwarded-Encrypted: i=1; AFNElJ/ZpaoXfWVGTlpP7y/PZbIRw8ha53pIQmHJq53wX40UStgwawKNhBmRsjmGTE9Rj8w2Pi/tj8xGwkeRO6I=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyftG94u4PujYjV1Ig4RrJP2wqWGkjjb39IGdJoIqjpHzEVilZK
	visI4QuOA9y3/vO01M80U1Q/FM8wnu0LPhbXBchXkBjB+T3Yt1+S1iB/
X-Gm-Gg: Acq92OHt5Oq3LVStJQ/g5ZnCN1vM3YVbNq4dpR1c+lylf8MiVYKjM70NYc1vfw+R1XN
	5YepQxDOKS4mqpUvCOy4JqKfD1oAo0HKr7HmI6py8zfdvYb17+wuA336Q/+aSLDW3aHIYN8Amt8
	iFbo8dsEQRsJOQkYIDgfTmJttvU1DvxRQTsTqskAxTH43m7hpiMyJ0ok8L6odAqyUwYnSq+lpW8
	GoxifFOSvU9o7wDiOesat8FMJEUAjDptX1QI4BuFAUyKlczpI0J+Wmw/8KFRTMiZ3Qy6AiHgVbD
	Qg0fBg1atnRE5qHjJ4by6Na7u/RhjiJ4fe3czM6FGZ4/WENf4kTY51dvNAL2BpUwkzrnlkMvcR4
	fk4iXTMI5ho+kTrDuwVNssVRWo25vmxCCETw3YLQHIbb4dIcmCwam+vFA/dJWfepVWqo+tUaT71
	fC5Y/S9OkrMcrZ1bx9IuZYjZT7AZIEqvkTHf8yssdEtFzBYz2Y4XITkilAFlDwegNSxQuOmkQ=
X-Received: by 2002:a05:6a00:4485:b0:842:2f3d:dff2 with SMTP id d2e1a72fcca58-84515521648mr2243020b3a.34.1781591218063;
        Mon, 15 Jun 2026 23:26:58 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b009e67sm14154810b3a.42.2026.06.15.23.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 23:26:57 -0700 (PDT)
Date: Tue, 16 Jun 2026 11:56:52 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Yeswanth Krishna <yeswanth@linux.ibm.com>
Cc: netdev@vger.kernel.org, venkat88@linux.ibm.com, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [BUG] kernel BUG in team driver: buffer overflow in
 team_add_slave()
Message-ID: <ajDshKtFNpQAtHQ0@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <3ad19e86-234c-408f-896e-0d6c774fea49@linux.ibm.com>
 <a08b0a7f-089f-4428-9360-9edbec3a5453@linux.ibm.com>
 <ad80ee33-400b-4c63-8197-838c3cf85cef@linux.ibm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad80ee33-400b-4c63-8197-838c3cf85cef@linux.ibm.com>

On Tue, Jun 16, 2026 at 11:38:37AM +0530, Yeswanth Krishna wrote:
> 
> > Please add below reported-by tag:
> > Reported-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>\
> > 
> > 
I am also not able to reproduce it.
Can you paste the full report of the crash?

Regards,
Mukesh

