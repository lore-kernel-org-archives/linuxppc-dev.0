Return-Path: <SRS0=D6Rn=6F=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3371FC54FCC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2020 18:52:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9D6A2068F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2020 18:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9D6A2068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 496CNR1RGXzDqxc
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2020 04:52:07 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 496CL25TM2zDqvW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2020 04:50:02 +1000 (AEST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1jQxxl-007lIL-Bu; Tue, 21 Apr 2020 18:49:41 +0000
Date: Tue, 21 Apr 2020 19:49:41 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/7] powerpc/spufs: simplify spufs core dumping
Message-ID: <20200421184941.GD23230@ZenIV.linux.org.uk>
References: <20200421154204.252921-1-hch@lst.de>
 <20200421154204.252921-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421154204.252921-2-hch@lst.de>
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
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 Jeremy Kerr <jk@ozlabs.org>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "Eric W . Biederman" <ebiederm@xmission.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Apr 21, 2020 at 05:41:58PM +0200, Christoph Hellwig wrote:

>  static ssize_t spufs_proxydma_info_read(struct file *file, char __user *buf,
>  				   size_t len, loff_t *pos)
>  {
>  	struct spu_context *ctx = file->private_data;
> +	struct spu_proxydma_info info;
>  	int ret;
>  
> +	if (len < sizeof(info))
> +		return -EINVAL;
> +	if (!access_ok(buf, len))
> +		return -EFAULT;
> +
>  	ret = spu_acquire_saved(ctx);
>  	if (ret)
>  		return ret;
>  	spin_lock(&ctx->csa.register_lock);
> -	ret = __spufs_proxydma_info_read(ctx, buf, len, pos);
> +	__spufs_proxydma_info_read(ctx, &info);
> +	ret = simple_read_from_buffer(buf, len, pos, &info, sizeof(info));

IDGI...  What's that access_ok() for?  If you are using simple_read_from_buffer(),
the damn thing goes through copy_to_user().  Why bother with separate access_ok()
here?
