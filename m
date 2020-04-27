Return-Path: <SRS0=vPFq=6L=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A88BC4CECD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2020 20:52:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5155E2070B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2020 20:52:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5155E2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 499xmY0tNNzDqgV
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2020 06:52:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=ftp.linux.org.uk (client-ip=2002:c35c:fd02::1;
 helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=zeniv.linux.org.uk
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 499xjy5PzmzDqKJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2020 06:50:14 +1000 (AEST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1jTAhN-00D2oe-Sy; Mon, 27 Apr 2020 20:49:54 +0000
Date: Mon, 27 Apr 2020 21:49:53 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/5] powerpc/spufs: simplify spufs core dumping
Message-ID: <20200427204953.GY23230@ZenIV.linux.org.uk>
References: <20200427200626.1622060-1-hch@lst.de>
 <20200427200626.1622060-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427200626.1622060-2-hch@lst.de>
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
Cc: Arnd Bergmann <arnd@arndb.de>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Jeremy Kerr <jk@ozlabs.org>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "Eric W . Biederman" <ebiederm@xmission.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Apr 27, 2020 at 10:06:21PM +0200, Christoph Hellwig wrote:

> @@ -1988,7 +1984,12 @@ static ssize_t spufs_mbox_info_read(struct file *file, char __user *buf,
>  	if (ret)
>  		return ret;
>  	spin_lock(&ctx->csa.register_lock);
> -	ret = __spufs_mbox_info_read(ctx, buf, len, pos);
> +	/* EOF if there's no entry in the mbox */
> +	if (ctx->csa.prob.mb_stat_R & 0x0000ff) {
> +		ret = simple_read_from_buffer(buf, len, pos,
> +				&ctx->csa.prob.pu_mb_R,
> +				sizeof(ctx->csa.prob.pu_mb_R));
> +	}
>  	spin_unlock(&ctx->csa.register_lock);
>  	spu_release_saved(ctx);

Again, this really needs fixing.  Preferably - as a separate commit preceding
this series, so that it could be backported.  simple_read_from_buffer() is
a blocking operation.  Yes, I understand that mainline has the same bug;
it really does need to be fixed and having to backport this series is not
a good idea, for obvious reasons.
