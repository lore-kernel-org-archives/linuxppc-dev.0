Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9780606EE8D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 15:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kZIdU5Uo
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLjcQ2by8z2xJR;
	Sat, 07 Nov 2026 02:23:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793978598;
	cv=none; b=Ty4JPdVdKRCj6DDGmcn5+xSxnPaPlsA7BXuhmLb1hNKvo2+wUx37261xkjlnHvvzfASrU6/PwZpUUHr5tIKPjvL+9I2DZ1hsnR6B4QzOPlQbYQcYBVEL75dPz5y+UTprXh09zCDJedQFZTY0s0TSBGBydoDKDvYFD4czJFomyJyYzezHH7lOOeVqUFFd1QrUOdxr3+b4QMd/6fPW7G+iC5e2x1ynSHuV0COU9Ql/Sm6bU+UxqG9nA9b2zPGncdlK5E+97aEJVsiVauhUDlUDztM2NZNkCk8jqtxy6/Vr9XFkqBuwf0d8oPPdDJwk3PrUTpYlrLhO22yjgTqemf9nvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793978598; c=relaxed/relaxed;
	bh=wEP4JuQU0P2yq8X2XSLRKG5Pf8+rQ+Lx8gGdmvn7s3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkMhv7HR0gd2/tCYTKtFDoKrCjX/WDvqCe6jcnyg1iAj0prSQ2jHXwUlXrWpDjjuMSoYJKEB3RwtO7lLb7fftC639jT8qQ2V6k6xl4fKtgIgECJkFXkDrVKOTjeS7q8TAMdRlQaWMfnVJvNjEXfLFENCjn4TdOP7TZ3AzOi3azxCsFb9yIyvgH0dNYlkxTKSUforU+3Uu2ZztK3r7cPjWlIHOus6v/UAi4G4trijCok5XZso6TL1XLslbC5xMBlNUExeJaaLUfpa5OujealrX8Tq9Bl1Yc1BAFKtp8qXVBie2R7CtUpOngZCiBupwBd4ngt8oGYlWrsvz5isFSFI4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kZIdU5Uo; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jarkko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kZIdU5Uo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jarkko@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4jLjcP5kzTz2xDD
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2026 02:23:17 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id 9AB5C43BF6;
	Fri,  6 Nov 2026 15:23:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 036431F0089F;
	Fri,  6 Nov 2026 15:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793978595;
	bh=wEP4JuQU0P2yq8X2XSLRKG5Pf8+rQ+Lx8gGdmvn7s3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kZIdU5UoqQ0HkYNhJaloKpEHYfN92rDvF8TCDhkQ2ScGfiXlADW1/Ok08uDEpWAHn
	 q+GPUyE6kl4jwHnKZD7DW/pcq5sx10uMY/Ycx1FT1Og/yieL4BW6jLi1Zt9bUlBLqE
	 EFKBePbhVa1zBY5pohaMb3X3KAAt60u8qgkKceZM30FMWI7fnDDS6mqBhwm2d5XzCP
	 FHncPtPwT8cJQHZHe6/3ruQvgcUA2SFAxt/7Nwibzs9LVbc7XdQXQA1zr2D/h/tpGR
	 c9ZGIBs0OIqBu2pouY4Fa0KcqH4gO5QNHfERxGkr18dqXoPas1kUo7nm4qhu97x3Et
	 0G2XhYh++unnw==
Date: Fri, 6 Nov 2026 17:23:12 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Guo Zihao <guozh23@xiaopeng.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Ashley Lai <adlai@linux.vnet.ibm.com>,
	Kent Yoder <key@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] tpm: ibmvtpm: check the response size against the buffer
 size
Message-ID: <au3w4NDX1Uqz-iqd@kernel.org>
References: <20261106014946.4128696-1-guozh23@xiaopeng.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106014946.4128696-1-guozh23@xiaopeng.com>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 09:49:46AM +0800, Guo Zihao wrote:
> The send path validates the transfer size against the size of the
> RTCE buffer:
> 
> 	if (count > ibmvtpm->rtce_size) {
> 		dev_err(ibmvtpm->dev,
> 			"Invalid size in send: count=%zd, rtce_size=%d\n",
> 			count, ibmvtpm->rtce_size);
> 		return -EIO;
> 	}
> 
> The receive path has no such check: the response length is whatever
> the hypervisor reported in the completion CRQ, and it is only
> compared against the size the caller asked for before being used to
> copy and clear the RTCE buffer:
> 
> 	len = ibmvtpm->res_len;
> 
> 	if (count < len) {
> 		...
> 		return -EIO;
> 	}
> 
> 	spin_lock(&ibmvtpm->rtce_lock);
> 	memcpy((void *)buf, (void *)ibmvtpm->rtce_buf, len);
> 	memset(ibmvtpm->rtce_buf, 0, len);
> 
> A response length larger than the RTCE buffer makes the memcpy read
> past the buffer and the memset clear past it.
> 
> Reject a response that does not fit in the RTCE buffer, mirroring
> the check the send path already performs.
> 
> Fixes: 132f76294744 ("drivers/char/tpm: Add new device driver to support IBM vTPM")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guo Zihao <guozh23@xiaopeng.com>
> ---

Ditto. I.e, I'm not sure if this is a bug fix or just better validation
for failing components.

Br, Jarkko

