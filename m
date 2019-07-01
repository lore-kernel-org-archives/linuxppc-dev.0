Return-Path: <SRS0=ROWL=U6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20179C5B578
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Jul 2019 23:53:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8371620B7C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Jul 2019 23:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEEn9+dr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8371620B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45d42N0LBJzDqZH
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jul 2019 09:53:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux-foundation.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=akpm@linux-foundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="tEEn9+dr"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45d40X16VtzDqJW
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jul 2019 09:51:55 +1000 (AEST)
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net
 [73.223.200.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9CACB21473;
 Mon,  1 Jul 2019 23:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1562025112;
 bh=m49J8QUAIUGzLQ10Pk7MDlm3F9FEcvjOwjEaylX3Yg0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=tEEn9+drzZeoB0fZ7R/AqFp9Wzc7N8ww7Vx902mD+h3w9UbMjzy9+UZPaIV+7VP8V
 NDsRCIHliWNtovAnQoKH8EnUvaYKwMZYlGBgh1p6MTymacyx+u8OdvNZ2Wd/9kx4jf
 Qr+rVz9DGogNzkjQgju1/GWOVyi6riVhx3LtcqkM=
Date: Mon, 1 Jul 2019 16:51:52 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] mm/nvdimm: Add is_ioremap_addr and use that to check
 ioremap address
Message-Id: <20190701165152.7a55299eb670b0ca326f24dd@linux-foundation.org>
In-Reply-To: <20190701134038.14165-1-aneesh.kumar@linux.ibm.com>
References: <20190701134038.14165-1-aneesh.kumar@linux.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: linux-mm@kvack.org, dan.j.williams@intel.com, linuxppc-dev@lists.ozlabs.org,
 linux-nvdimm@lists.01.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon,  1 Jul 2019 19:10:38 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:

> Architectures like powerpc use different address range to map ioremap
> and vmalloc range. The memunmap() check used by the nvdimm layer was
> wrongly using is_vmalloc_addr() to check for ioremap range which fails for
> ppc64. This result in ppc64 not freeing the ioremap mapping. The side effect
> of this is an unbind failure during module unload with papr_scm nvdimm driver

The patch applies to 5.1.  Does it need a Fixes: and a Cc:stable?

