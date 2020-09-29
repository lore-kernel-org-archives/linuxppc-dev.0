Return-Path: <SRS0=xLud=DG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E22EC4727F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2020 20:57:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93CDD20774
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2020 20:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Az63m3dK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93CDD20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C1BXB5qrSzDqYS
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2020 06:56:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::844;
 helo=mail-qt1-x844.google.com; envelope-from=leobras.c@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Az63m3dK; dkim-atps=neutral
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C1BTb1T7kzDqWP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2020 06:54:43 +1000 (AEST)
Received: by mail-qt1-x844.google.com with SMTP id c18so4842877qtw.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2020 13:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :organization:user-agent:mime-version:content-transfer-encoding;
 bh=b0bTMiquRskxnI+oNlBKE2v3cxIISXfUCYjgsD4f8oU=;
 b=Az63m3dKxYZtSiV3F3oqfFwSDDtk+9cMxa7OxX1ThBJqHU/DHe6CrfbfXF3w8nmkFm
 4IWB9m04VUmXTf4hMS7csRxdhFbft7Tke0m3o6pkd6ipeGv4GO91AF3LWxCIOyzVx6Rw
 mN9qfFH580W/n0Djcf5/e1nTmd6VyasSXCkaKNrcuxSd/q6DAUw6e3fjtUv7cibcmaUP
 J/IdRgDI3jpNju5QrHrtCrkKOPpsdH23F7wbvhkM/CznJNsm6ZixnpLXDcVr8vOgkNme
 pMJ+YvuvsC7So28Jinfn5Brk+B/K/f1bpbFhMKlNpviM/V845Ucats2sDoTWalkBgAW2
 qXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=b0bTMiquRskxnI+oNlBKE2v3cxIISXfUCYjgsD4f8oU=;
 b=JDDCjlUvfXjxgmToul68MJvvBy8KaS2JGtoiwBMoFmU1a5QT2cIx7/4ChB2trxXyra
 80QK+FzFRKsQfSGrY474ETfKiqwy1yN2idovbDhBHLRS9KacXxxS2P/20qeAkwaM2sUv
 0mgtEt8a9Vmpx/UIUu8ulgVH+m3wG/uNyqjWlU7AlsY+N1wiKeArzZ77fb9wd1zrJ57d
 hra7l40RLx6KGcX9UpMEu4ihGfnA05wi4f5TdKwk1pbY6epg0FiAX3Q5ZgNXzs+tPA2n
 JC/K9Mzi31T+boc90+X7pDRYH47VaB/EGEh3uzhpVnIIxtUzUBUiH4K1kKThdhnmcejh
 TnZQ==
X-Gm-Message-State: AOAM532wJKAXsWE8m6sf/YMimrGNlwrqTLlUd+5jGSDQP1xDAP2mPG8s
 vmdAw7jNDNEFg3o4ofDal2U=
X-Google-Smtp-Source: ABdhPJwnZXHxWKELPhXkgV1kQxcec5gFQ+QS0cvaneXppH15kK+X7saRtfc86a3lDPkmaZrMbbJYSA==
X-Received: by 2002:ac8:6e89:: with SMTP id c9mr5298466qtv.3.1601412879254;
 Tue, 29 Sep 2020 13:54:39 -0700 (PDT)
Received: from LeoBras (179-125-141-251.dynamic.desktop.com.br.
 [179.125.141.251])
 by smtp.gmail.com with ESMTPSA id f12sm6881702qti.70.2020.09.29.13.54.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 13:54:38 -0700 (PDT)
Message-ID: <1b813ab38869e2e6770ed09487a3fba7befaca86.camel@gmail.com>
Subject: Re: [PATCH v2 14/14] powerpc/pseries/iommu: Rename "direct window"
 to "dma window"
From: Leonardo Bras <leobras.c@gmail.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Ellerman
 <mpe@ellerman.id.au>,  Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Joel Stanley <joel@jms.id.au>, 
 Christophe Leroy <christophe.leroy@c-s.fr>, Thiago Jung Bauermann
 <bauerman@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>, Brian King
 <brking@linux.vnet.ibm.com>, Murilo Fossa Vicentini <muvic@linux.ibm.com>,
 David Dai <zdai@linux.vnet.ibm.com>
Date: Tue, 29 Sep 2020 17:54:31 -0300
In-Reply-To: <2ba89065-4e9c-57c2-3825-aed9a7d8451a@ozlabs.ru>
References: <20200911170738.82818-1-leobras.c@gmail.com>
 <20200911170738.82818-15-leobras.c@gmail.com>
 <2ba89065-4e9c-57c2-3825-aed9a7d8451a@ozlabs.ru>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2020-09-29 at 13:55 +1000, Alexey Kardashevskiy wrote:
> 
> On 12/09/2020 03:07, Leonardo Bras wrote:
> > Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
> > 
> > A previous change introduced the usage of DDW as a bigger indirect DMA
> > mapping when the DDW available size does not map the whole partition.
> > 
> > As most of the code that manipulates direct mappings was reused for
> > indirect mappings, it's necessary to rename all names and debug/info
> > messages to reflect that it can be used for both kinds of mapping.
> > 
> > Also, defines DEFAULT_DMA_WIN as "ibm,dma-window" to document that
> > it's the name of the default DMA window.
> 
> "ibm,dma-window" is so old so it does not need a macro (which btw would 
> be DMA_WIN_PROPNAME to match the other names) :)

Thanks for bringing that to my attention!
In fact, DMA_WIN_PROPNAME makes more sense, but it's still generic and
doesn't look to point to a generic one.

Would that be ok to call it DEFAULT_WIN_PROPNAME ?


> 
> 
> > Those changes are not supposed to change how the code works in any
> > way, just adjust naming.
> 
> I simply have this in my .vimrc for the cases like this one:
> 
> ===
> This should cause no behavioural change.
> ===

Great tip! I will make sure to have this saved here :)

Thank you!

