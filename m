Return-Path: <SRS0=3PPi=MM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C97C07E95
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Jul 2021 06:07:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 979AD6113A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Jul 2021 06:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 979AD6113A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GTStc1lZPz3bfD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Jul 2021 16:07:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Ihy/jz+o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1;
 helo=casper.infradead.org;
 envelope-from=batv+d721ffb997130df132c6+6540+infradead.org+hch@casper.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=Ihy/jz+o; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GTSt90RP5z2xbB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jul 2021 16:07:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=zY/bA1mmo80mAzxM6Dqf7zbj0hsJZEwAfFA84ALlcz8=; b=Ihy/jz+o+4KAUoA6iHjBE2hAIk
 1KVtU50DJksORf+Jgi5tF72tnslR5cy7hHwFbg9m7p15Ox9epP3q7P1aAIqa8EqnS0VDizf62TOX8
 yTS1k/oalIUSYym8s3k8gJyn8NPkVn0yVB3AKiCbxd3CA9TTXjsmChIWKQOFj0RetzQG31RxSqktC
 gIqCg8mhmOKnxxrckhaLumo0Tn0rzbL6d/AiBBKnkftU2JBJOWUgEtF9UsqXrmmjhT0EJOSSFqTbU
 cEPJOh95bDAyO13/oCQR4yM+1i36dMG7CETXN1DMt/PiE2YB04CURN5mvt/KZGh1m5QyBxbe9Wqqv
 Kc4ETxvg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1m5iu3-007oH6-Lz; Tue, 20 Jul 2021 06:06:56 +0000
Date: Tue, 20 Jul 2021 07:06:51 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Anson Jacob <Anson.Jacob@amd.com>
Subject: Re: [RFC 2/2] drm/amd/display: Use PPC FPU functions
Message-ID: <YPZn+wqulTHSR+h2@infradead.org>
References: <20210719195211.520428-1-Anson.Jacob@amd.com>
 <20210719195211.520428-3-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719195211.520428-3-Anson.Jacob@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Harry.Wentland@amd.com, Sunpeng.Li@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, amd-gfx@lists.freedesktop.org,
 Bhawanpreet.Lakha@amd.com, Aurabindo.Pillai@amd.com, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org, bindu.r@amd.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

>  #define DC_FP_END() kernel_fpu_end()
>  #elif defined(CONFIG_PPC64)
>  #include <asm/switch_to.h>
> +#define DC_FP_START() kernel_fpu_begin()
> +#define DC_FP_END() kernel_fpu_end()
>  #endif

Please use the same header as x86 in your first patch and then kill
this ifdefered and the DC_FP_START/DC_FP_END definitions entirely.
