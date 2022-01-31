Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BAA7C433F5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Jan 2022 12:27:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JnS443hbqz3bZT
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Jan 2022 23:27:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dZZojRSx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+c8a487c16eeb054acd37+6735+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=bombadil.20210309 header.b=dZZojRSx; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JnS3M5yX8z2x9G
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jan 2022 23:26:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=hBha+4ZQjalDLD6xPvVHvMBCdVa7nDcSg1bYsYjsECY=; b=dZZojRSxt2WA3XFgSMkkhmm99W
 DKsfcim8XFhS7PPpIU54jNrfklMqQCQ3kh0B05DBTfmBSbUcoc+vaP6TvxOzJPczr1r0721w0pujn
 owwK8/bOJ6fP/eCyLRLK12xJcyFUTZbOmylV8pOnBqZsg6jzFRvX4zV2LuBZEml1UfsG5nnQl8xEu
 IoTxbUAkPCme+p6q+KC5jvSWxu7wp6L1eXPoGkrt+O5jmc1uPlCWK3k+SqAJzynzwnzWddqdGT7Pt
 lhLLnTuEGVwtibDNS6yEcRCRcd4/Lhe9ZeTHLHpWBfDe5ih1e/VgN0q4Bj4T323Ka5zqXDyRE7HWS
 8DvFpD/A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nEVl7-009L0d-Lx; Mon, 31 Jan 2022 12:26:13 +0000
Date: Mon, 31 Jan 2022 04:26:13 -0800
From: Christoph Hellwig <hch@infradead.org>
To: guoren@kernel.org
Subject: Re: [PATCH V4 16/17] riscv: compat: Add COMPAT Kbuild skeletal support
Message-ID: <YffVZZg9GNcjgVdm@infradead.org>
References: <20220129121728.1079364-1-guoren@kernel.org>
 <20220129121728.1079364-17-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129121728.1079364-17-guoren@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Guo Ren <guoren@linux.alibaba.com>, linux-mips@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, hch@lst.de,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, anup@brainfault.org,
 x86@kernel.org, linux-csky@vger.kernel.org, hch@infradead.org, arnd@arndb.de,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 drew@beagleboard.org, gregkh@linuxfoundation.org, wangjunqiang@iscas.ac.cn,
 linux-kernel@vger.kernel.org, palmer@dabbelt.com, liush@allwinnertech.com,
 linuxppc-dev@lists.ozlabs.org, wefu@redhat.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Given that most rv64 implementations can't run in rv32 mode, what is the
failure mode if someone tries it with the compat mode enabled?
