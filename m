Return-Path: <linuxppc-dev+bounces-20821-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8079ECD37B6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 04:02:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFftv1JKgz2xlV;
	Wed, 13 May 2026 14:02:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778644967;
	cv=none; b=G33j/+XgsW3MFcKSAEHF2fYwtCtwSADj+ZcAVqfOCO5/i9yg5uwKan5w2IRzR07QnCrACn/J4SLJKRVOcm5D94QzOZrou63LAIAahX/FO/5O2UbUvQsjTzTS8t7R1AvRFGKNjxWjMhWN0WmAf6RXhapFiFUr95H8k4ZbHgFbeAEMhn9EUdNB6vyGQxG3/4GAJM3RFZB2QMkEQZArlCEeFh11IsyPDzw+DrxBKZ2VP0VDT4KgNtTS4d8tLNB7pgCxlmaLH8zKlzD6vVdgwBYAbBwAxzbaL8cIS4mS0iyJbg/KySxP7B5tozmmtKr18/UKMdFvkLHilQLMfa5NH4HVQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778644967; c=relaxed/relaxed;
	bh=0BV+1540KgleJJ+gKBgYH2coBbWbcBBVwsCU6knOwuU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=RbfPaxrWzAJv7hvNPb2oMTu3Q3rnP0yrZBw3qTO9cdqxUtM/6/d6BsAN8eDrixqhf6D8IvOUqHO8f3qJQsg10oWu/Q278AXYFxGBP1C7A5PCfjZNdAqaIBCackxiXzQljXq0Lh7ahkHe6V/2JyzGYvoCYszPOW14TCSZWXl7xSsxEZKTlC2tMdvZyXm8OGzr4gMtsPQVpACZvb2x0PyGkqMD7KXN+j9c5XeDY9Xywsil5TuW3Ezktf0r4Y5Jz9iU4GU0gLtkDSh3lPn8kKYCoc/xRb6v7JJnhoxzPrdCtGR5nSvRGuTnoCeFNTrTiVOmf2fTq8RxXaxTH0SUY3Va4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=W0B551b7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=W0B551b7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFftt35xSz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 14:02:46 +1000 (AEST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso2546652a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 21:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778644964; x=1779249764; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0BV+1540KgleJJ+gKBgYH2coBbWbcBBVwsCU6knOwuU=;
        b=W0B551b74v1KyBSwUNSzderOatAfHByKmaz3KsBuaaokry+RnWVcaMkrfsDF4X0yvD
         mqcqpPnaGZ0NTzHCaXWee0dpU2bw0/ZVxN3uJ86yU6/LG74m7M8PLXAyE1jIiIuR9FOt
         AkMi/eXn78LY3rh8t/ZC2mp0pyAXKRHQU8tiQ5g8Bhq2rBZCTOzLQcBZ+nlbsDhzEfcT
         1Ag20grBugjjAzJ9xq1ih9a6JWWBMKYp/hODC84gmfZ9dpIT4iZifa8JLn0q1e++/R0P
         htw5aQoBKYOZWnEiDLCBd75gfyxOw1pfGvAeFQSGRUgdw5Ev5nWuW32h+aeydILfnuxh
         4MiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778644964; x=1779249764;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0BV+1540KgleJJ+gKBgYH2coBbWbcBBVwsCU6knOwuU=;
        b=YPaPlHEALALpzoxY5i/MXWXTbClg8Hzo6Kll3IWoJtbtANcAk5icBU64heu9pM8EZ3
         tStp8Xz37aXCU+PtBSFwkc5e4ZU0yaE4IS9W3G7lTfY8DDeVBkpK1TayGhhy5Dro+znC
         9XI6Dz9RnJJWs3iC3jLbgcFBsN3C7VWDsobE02MCh/OqbXePbl0RIjbkTwJvkxaJtRiv
         /5Z7hbHtaOduAxWiNgMq5TmsTYoez3RpzZp7v09q5ZIZ5FRgrZwKptdo9xhz3T7+k597
         jdmCnVjxPzaYJE1BWQqnVfMtoLUXycsSk+FUD6yAN/7lxwplSQ0c76G30p5oixtauOSw
         G4yQ==
X-Forwarded-Encrypted: i=1; AFNElJ8raGBYA82EL4yjWuJfjxkQkuMbA8e1PzLEgBSCU5deUPKsdg+3D19yV3P5HDeWvxwPu0/jzie2P7Fqcl8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw2ePQV3asH910KeeunvFwRKfBz3x3Zbq8ZVC44fr8XOkoWi1Sn
	N9SUo7T9onXhvBmpS77SqktRV9CRBTbOp/qI2FVlmP8lCeaTBKrQqxJR
X-Gm-Gg: Acq92OExxnwmR9kj94DDN9Tmlp88pmVktoEWaG/mcNXFoe1LObcmcNsbCfSMZWF5ucu
	W3WJBSC7PRakQtC5XysHy0g41VZFJRfs/7zjiC8j+W3VpQWCr/Ke5Oms5SlI40JB+2uL9TxkbOu
	p33+TJPK2WDfcYHBzoFOS8XziKiNIiHfFTfhHFPBFPsDOcm0Nen4QnQqY0aSfcvfUDP/5UFoCeW
	JriZ3nf2X3/oC5+0BXM5mESESSukrCCs6I25mZJI6Snvo9qI/wHxmxOCRuLBYqfpTxRkkxcjPI5
	oXtvaAKWnMxOuqTvwmj0ZD42jKcgt9rwOJ1dFYzUfrg22mT5YuSJRcgMLLoj8cvfPnAi+fzukSv
	kvTaRrrUcsz6MuM9TQ431yASBdrFyamXdN4F7NUbSIufjZ7Ntf8UKNz5WJ1HI2VhOhtVZtRHTYl
	zGmqaLGruIaY7RbgdU9D7xhg==
X-Received: by 2002:a17:903:1b67:b0:2b2:5042:dd18 with SMTP id d9443c01a7336-2bd271455ecmr18135495ad.3.1778644963976;
        Tue, 12 May 2026 21:02:43 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd3414b8b6sm4472385ad.30.2026.05.12.21.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 21:02:43 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gautam Menghani <Gautam.Menghani@ibm.com>, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org
Cc: Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/64s: Fix the vector number in comments for h_facility_unavailable
In-Reply-To: <20260511080412.50722-1-Gautam.Menghani@ibm.com>
Date: Wed, 13 May 2026 09:30:31 +0530
Message-ID: <se7wq7q8.ritesh.list@gmail.com>
References: <20260511080412.50722-1-Gautam.Menghani@ibm.com>
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

Gautam Menghani <Gautam.Menghani@ibm.com> writes:

> From: Gautam Menghani <gautam@linux.ibm.com>
>
> The comments explaining the h_facility_unavailable interrupt have mentioned
> the vector number as 0xf60 instead of 0xf80. Fix this typo.
>

Yup, looks like it got copied over from the above definition of Facility
Unavailable Interrupt. Nice catch!

LGTM. Please feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

