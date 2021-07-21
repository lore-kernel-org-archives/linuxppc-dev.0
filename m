Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935FDC07E9B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Jul 2021 06:53:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA3A061001
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Jul 2021 06:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA3A061001
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GV5rW70g3z3bh5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Jul 2021 16:53:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=TaTMVqhl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1;
 helo=casper.infradead.org;
 envelope-from=batv+75be22767c7c0793244e+6541+infradead.org+hch@casper.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=TaTMVqhl; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GV5r02Fgjz2yLS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jul 2021 16:52:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=+skYpVFx7D26gZP3u4sFvQmDQJ66kJNmYAf8MY+5yFI=; b=TaTMVqhlAYzzaMNEl9YC7dzmxn
 1CXjRkMdMpvsxrcDsiWSN+C7YsUcSGcnzfszUyULbfcS4ooEOY9tYgSTcSDi8G0+oWilUGS6sOcPf
 nLp4xhpCmloqX13mk1sMDi5gtqkhduaQ+k6J7vhS99Z+ty7iwqeV+TAF87tjbFtL39SRWdu7qwI4I
 Vgt4l+1YRSeRmJMUI+A2kV6QVzaS/HZMFW/RSB+q0xG3mDki08KQH4msQrqT0KjcXd87usNNUZ9Ch
 ufmPwWhMwnf8G0/afdBOJAMzOP2q4EjptdlCBBhK1vzXw/mz7U7siUAfM4yKdONCURjyTTfLtOm62
 Wn3DySvA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1m665B-008tgP-6t; Wed, 21 Jul 2021 06:51:56 +0000
Date: Wed, 21 Jul 2021 07:51:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Christian K??nig <christian.koenig@amd.com>
Subject: Re: [RFC v2 2/2] drm/amd/display: Use PPC FPU functions
Message-ID: <YPfECUtD0SRCjrSm@infradead.org>
References: <20210721044801.840501-1-Anson.Jacob@amd.com>
 <20210721044801.840501-3-Anson.Jacob@amd.com>
 <9094cea1-602e-6e71-4ff7-c06fd04af6c5@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9094cea1-602e-6e71-4ff7-c06fd04af6c5@amd.com>
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
Cc: Bhawanpreet.Lakha@amd.com, Harry.Wentland@amd.com,
 Anson Jacob <Anson.Jacob@amd.com>, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, linux-kernel@vger.kernel.org, roman.li@amd.com,
 Christoph Hellwig <hch@infradead.org>, Sunpeng.Li@amd.com,
 Aurabindo.Pillai@amd.com, paulus@samba.org, amd-gfx@lists.freedesktop.org,
 linuxppc-dev@lists.ozlabs.org, bindu.r@amd.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Jul 21, 2021 at 08:29:43AM +0200, Christian K??nig wrote:
> Looks good in general, but question is what about other architectures like
> ARM?

DRM_AMD_DC_DCN currently requires X86 || PPC64.

Maybe a good think would be to add a new KERNEL_FPU_API Kconfig symbol,
selected by x86 and powerpc (I think ppc32 should be fine too now) so
that we get these arch dependencies out of the driver.
