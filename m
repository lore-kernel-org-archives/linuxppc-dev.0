Return-Path: <SRS0=l0Nn=JE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD9EC433B4
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Apr 2021 19:59:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6126D6105A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Apr 2021 19:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6126D6105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FFwFb5qqxz3bvW
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Apr 2021 05:58:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=oF0cJJli;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::734;
 helo=mail-qk1-x734.google.com; envelope-from=leobras.c@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=oF0cJJli; dkim-atps=neutral
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FFwF74tX8z2xZp
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Apr 2021 05:58:35 +1000 (AEST)
Received: by mail-qk1-x734.google.com with SMTP id o5so20162656qkb.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Apr 2021 12:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :organization:user-agent:mime-version:content-transfer-encoding;
 bh=6fZ/ViiD+pHeXtQLFjb/Z7oHK2Q9bzwQJTyo6w74m6I=;
 b=oF0cJJlib378/ESJnMtKadOGiybdFVACJjzQfsNJalMkV4wHfu79umMG3ZsEGQ/zxw
 MSaGgy3Zmvj0ydbPI7/T3XsBqAP8y1etoI75nRNhBb5VL2TVNgbkhUusskyJ/BYql5lF
 xhVlI94jTfPARboVGM0L7+fdVxwXIR9L7ospIDPPdHFHIR3hLKlTwZRgACKqiake75YT
 B/xg/kS6qqkyvBhVxylHQOlr+5mu1WsttXrl0OdaNnIFTrlj6qV/kTrI7XaidLVcOUVc
 Xoy/jr7EWAIOkFmSib2A/ofJ1JQJ3XZ+BOGvfA2anjLQ/H+3+J8bfSuc1hWcVjmS2jdS
 EhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=6fZ/ViiD+pHeXtQLFjb/Z7oHK2Q9bzwQJTyo6w74m6I=;
 b=ecNEh0NrL+6kqHF/JXoiTnG6jpFGHWgN1gG+2drJAlhrpO+1XdVi0DckT1DNIqZybW
 bCfpHOtFH3KSuhQWZvAdDIt8mq8cGYWMv1KWEggTXpuyaDPieHZtzDkXBHr92zjxcCKQ
 aWMWp/moxNn7ZHuBKv/afhRF4BeuWGmbvbJnsFNN5TPljP/M5F7ntMi7gBucauelqMry
 wnQosYsNrHQHvxUsw+G9gGosrD7T1NNVXAO9BgculaujGyoPfvG0JMsoHWL9pcS36geF
 zvvisNj2mmTzSF7hgu/ZMQBxVr7zT6CMTksKORe9QQJqEYQPUaXBcHq+Mdl7T06UnGEu
 mVRg==
X-Gm-Message-State: AOAM530UmQW5QpY7BMN/GxcIUmATpHlbH1JHgHPMHSwEHIXCMr4b0j3b
 10SdTBjRTD38WYKsOblgYWw=
X-Google-Smtp-Source: ABdhPJyIv9lgQmEv8xFsxtKio+OVUdiYh2xUaxUzN9jf15s0SD4mozHeNa0kXvnguVRWV2ozvXVqtQ==
X-Received: by 2002:ae9:e518:: with SMTP id w24mr4878314qkf.78.1617825512109; 
 Wed, 07 Apr 2021 12:58:32 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com
 ([2804:14c:482:7b04::1000])
 by smtp.gmail.com with ESMTPSA id j10sm17781787qti.94.2021.04.07.12.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Apr 2021 12:58:31 -0700 (PDT)
Message-ID: <1af8c4ed38981332bcd8ffcf003d70c4a6f766ef.camel@gmail.com>
Subject: Re: [PATCH 1/1] powerpc/iommu: Enable remaining IOMMU Pagesizes
 present in LoPAR
From: Leonardo Bras <leobras.c@gmail.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Ellerman
 <mpe@ellerman.id.au>,  Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Christophe Leroy
 <christophe.leroy@c-s.fr>,  Joel Stanley <joel@jms.id.au>,
 brking@linux.vnet.ibm.com
Date: Wed, 07 Apr 2021 16:58:27 -0300
In-Reply-To: <2088f84c-08fb-fecc-f5d4-5735357dc296@ozlabs.ru>
References: <20210322190943.715368-1-leobras.c@gmail.com>
 <2088f84c-08fb-fecc-f5d4-5735357dc296@ozlabs.ru>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello Alexey,

On Tue, 2021-03-23 at 18:41 +1100, Alexey Kardashevskiy wrote:
[...]
> > +#define IOMMU_PAGE_SHIFT_16G	34
> > +#define IOMMU_PAGE_SHIFT_256M	28
> > +#define IOMMU_PAGE_SHIFT_128M	27
> > +#define IOMMU_PAGE_SHIFT_64M	26
> > +#define IOMMU_PAGE_SHIFT_32M	25
> > +#define IOMMU_PAGE_SHIFT_16M	24
> > +#define IOMMU_PAGE_SHIFT_64K	16
> 
> 
> These are not very descriptive, these are just normal shifts, could be 
> as simple as __builtin_ctz(SZ_4K) (gcc will optimize this) and so on.
> 
> OTOH the PAPR page sizes need macros as they are the ones which are 
> weird and screaming for macros.
> 
> I'd steal/rework spapr_page_mask_to_query_mask() from QEMU. Thanks,
> 

Thanks for this feedback!
I just sent a v2 applying your suggestions.

Best regards,
Leonardo Bras


