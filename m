Return-Path: <linuxppc-dev+bounces-24633-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4678AC44533
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2026 07:55:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4mlW5VW0z2y1F;
	Wed, 22 Jul 2026 17:55:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::430"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784706951;
	cv=none; b=iQ9CjSKyrvgY8+NhzLvwJ2PqN9F00lqHnJSSac5kNMW7HnvxAIscRmbFMjGrv1jw/Ta8MwLrSrMAsNn3rYwXnDWSOlrufyhrnZu1IEXoVVDbEpEzAHzr0d1W4i7WP2ftT3uvhhPThIqWoL9+CJ5giT0BJC0oMMQMLepoQEfnT3nyTEgEnjAJlm2ru0rLtRDWx3JBn1R7c3G2TcHuctrFzyTdX+ME8WgejUOks8TxayIdeh87iZxmFskhpoltA3wGTwer1wnwSJDoY5hTtTvF6o0os1XhiCQ1ZpuRcnm2f19lzS4kLBs8r5DLyD+td9GGzMbXZGUXTNLgXMAfsWGBLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784706951; c=relaxed/relaxed;
	bh=ylc8TXlNP8HCp9xOR7j/KXR/abtqHgmLUYlJxvcNlVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXtlXLJYxXVoTDSDXHHn6pkLbrsRm2cvETqGh6PxRVX6YSHVQVn5UyC96mlJ4yThapq93iLm3A1VNmn+QFfz5wLe++ib7mPcfwrgLzyvbxKLEptdt+LFK49WmX6kQrsb0e5DkpWKGNa1UcKx34vKsNB4yoawV1LSl+u+YWIplig2hpi1s+a4YTROs4eyf8ZAWu6nAxNzO925lTkHjFttSfNugA2nSFMq5KbCjUwip9DjZ2z3lzeXi/SdxiizbnO41iPErMPQnGXqNqlXCLjlH1XeEutJMW2deTEb8ABp93J/ekkq/3BtrOo+k4YWAABgIKQ1Kj7sYcH6Xj/6RV6l2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ChEJHVQu; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com; envelope-from=olteanv@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ChEJHVQu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com; envelope-from=olteanv@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4mlV0DBxz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2026 17:55:49 +1000 (AEST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-47f706438c3so193008f8f.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2026 00:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784706946; x=1785311746; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ylc8TXlNP8HCp9xOR7j/KXR/abtqHgmLUYlJxvcNlVU=;
        b=ChEJHVQu1V9yVqIY+rx5KHO6u1aXvoO9O1wneb7EMJ4+XTUIWmi8gcBXdiVPd7CW2h
         M1p2G4AwIvVArxEDXuW2Uyc6+GlRrmn/CYgKej3p3927p4cz0Mip7fAPdZuS9H3Tn/yQ
         5nHdnh3z6d1TPsqpyrb5LZDiL1vPMjQLpufWRCVEoNk4LlSBpVyvkYyqJvI/N054bFOu
         4yQiAeYfsJcpM1ipdJAhgdtAoJR21FPEnyZcqPOnwmXfktPY3cO6fVbMErHycir0QvqS
         7DUroyMMOrBxBFO2qKVOxCZYtBsf462TnY93T5asHEjv/DIAFg0C2kdHQYiH9jqPgGG+
         f3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784706946; x=1785311746;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ylc8TXlNP8HCp9xOR7j/KXR/abtqHgmLUYlJxvcNlVU=;
        b=YpHxfzjMo5EStOX+QYhIOr7vjyEgJgQGrUUwiiSl4sTBpZXTPWY7BExig6MpQ4VehA
         yCW0WVw3UXZgUwyG2iXvdW0gqrzRiYEwuxekkP3E4WhrV7gD+7bHjqH+Un/Odl9VtrKz
         SxJ/bU3f6Tl0+y6R0rhD1boDDGLk4m7pKnVeYOKpUGJ+5WRhHrvQKbWVICHTS8t5L2KQ
         8UNanWzr4w3UV0OrAjEeMpPvt+9M6FbabsCTe7gYXRRbzmtmDSdAzIUG5+luW9BOvVer
         Qih8FNaHnltzyq/DuBVNbMSNfY8ohbAtRcFa2LUprglFrCikg2LYll6NnDqa+8070kEI
         gsmw==
X-Forwarded-Encrypted: i=1; AHgh+RpwaTN6iWzJHEV6yZn/UPZYxvq6YXwRGN/ebxQCK7jg1cjF1A6FCLlOcnI6A0sOnvU2SWb07fKwKDkUleI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxtR0JtTKA9YrN8h7+gAG5+gL5Ee8SxIsdJ+W4gNmPAXa9w58bz
	LYmQtvN6bCtuhYkYCiuYDvlVrUqqQXc3MYdROyLAycn0nOhlhPb5LlLR
X-Gm-Gg: AR+sD12PIgCNEIUViv8MQeq86M9h6WPjG7Euwsv/34TQPip/E5JY/sodaJ3qV8dUyRv
	BYRAMy23VTlUAo4R5PfQZ0tEHk1ErvAHMy4TnliFFttihY7prl6ytK8JD2lPh/cILmpGvkPMOQ0
	w7yoeYvuGAKBG4HwJWgYtSLLAOFx9P2L9KPX3MxtlRTZqenocyLcKfFyperilX1ZeJb7lecqHEZ
	i1QO2rPFmg/mr8YorOUbtT9fEPrp44ZJ7ZHAQE4ECLVOsbaNy+Wep+ghl4OGnju7guXWx7x08x2
	SGWXT8s2VDiSDKtvW8yniV66uoHlqCueVyuwpQEUBVZr5WGVHfihoZKVfSnD4lGKT+n5yQr1JZ2
	Ygl1uFaeBNNyp86a9Y31HQXsqR/wAzo4QSi5NFBeUwp6Gscz7f+/WYrW4Ot3Kinb7h23G
X-Received: by 2002:a05:6000:4687:b0:47f:8136:e7f5 with SMTP id ffacd0b85a97d-47f8136e9edmr2516706f8f.2.1784706946354;
        Wed, 22 Jul 2026 00:55:46 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d801:b100:1a7a:c7e7:fc27:12d8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a64dsm3759581f8f.1.2026.07.22.00.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 00:55:45 -0700 (PDT)
Date: Wed, 22 Jul 2026 10:55:42 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Michael Walle <mwalle@kernel.org>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Tanjeff Moos <tanjeff.moos@westermo.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 phy-next 1/9] soc: fsl: guts: perform fsl_guts_init()
 error teardown in reverse order of setup
Message-ID: <20260722075542.p3uissyqzcvfsdri@skbuf>
References: <20260721231603.67865-1-vladimir.oltean@nxp.com>
 <20260721231603.67865-2-vladimir.oltean@nxp.com>
 <DK4X0XV6ZM1E.2L9G007WXO2J6@kernel.org>
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
In-Reply-To: <DK4X0XV6ZM1E.2L9G007WXO2J6@kernel.org>

On Wed, Jul 22, 2026 at 09:18:48AM +0200, Michael Walle wrote:
> Hi,
> 
> On Wed Jul 22, 2026 at 1:15 AM CEST, Vladimir Oltean wrote:
> > Michael Walle has confirmed that ignoring the error was intentional,
> > and we preserve that:
> > https://lore.kernel.org/linux-phy/DK44809N7Y8I.J2Z3U4N32H0Q@kernel.org/
> 
> I thought you wanted to check if kasprintf() fails and return an
> error? Just to be clear, I'm fine with either way.

I did, but then I considered I don't have a strong justification, and it
isn't a change I need to make to make progress with this series, rather
more of a distraction.

