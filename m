Return-Path: <SRS0=INWp=NY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD8CC432BE
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Sep 2021 06:52:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E43260FC0
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Sep 2021 06:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5E43260FC0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H0Wn96g3sz2ypM
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Sep 2021 16:51:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=GSYRQRH3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1;
 helo=casper.infradead.org;
 envelope-from=batv+1fe5bfb7fcaf9fee4071+6584+infradead.org+hch@casper.srs.infradead.org;
 receiver=<UNKNOWN>)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H0WmM2vsSz2xY8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Sep 2021 16:51:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=iKiCgpE2RAx5gME3v9KQAcvDRUxt2sz+SQ5l2zSQS2Y=; b=GSYRQRH3hvmSCEXfuYL6oM6SN2
 WwXMxon0LE1dleknLZ37cDxjrlj5tIXIQ0y5a0TuQiTe3BBlou/zaUEsClrBSakAf4IKP+dr0hTv1
 4bcZK01UlYAL+IrHPSJenMR1D7xIZj8iRDiZjFHYDfLmy3Xhbje6zNFWHPtJ7FOotT3/x6K64qkrg
 xWgI85GvDXYnk0KqoTii7gftrem40pFOjj4/JFVGynYv5LAnoOiPp75Yh6a3hOdPmFcZx2WM9h/2U
 w6bXO+MkBl6TJQF4gP2nAtWTVn41x4lvLkJVmkF3iNqsjEULtGXpBuxqQBdYYBiG41RRdOvUAGtYg
 ZMaM7NVQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1mLgXu-003Bjy-DR; Thu, 02 Sep 2021 06:50:08 +0000
Date: Thu, 2 Sep 2021 07:49:58 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2 1/5] powerpc/signal64: Access function descriptor with
 user access block
Message-ID: <YTB0Fhlvg2kHV6hi@infradead.org>
References: <fd7938d94008711d441551c06b25a033669a0618.1629732940.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd7938d94008711d441551c06b25a033669a0618.1629732940.git.christophe.leroy@csgroup.eu>
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Aug 23, 2021 at 03:35:51PM +0000, Christophe Leroy wrote:
> Access the function descriptor of the handler within a
> user access block.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/kernel/signal_64.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
> index 1831bba0582e..790c450c2de8 100644
> --- a/arch/powerpc/kernel/signal_64.c
> +++ b/arch/powerpc/kernel/signal_64.c
> @@ -936,8 +936,18 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
>  		func_descr_t __user *funct_desc_ptr =
>  			(func_descr_t __user *) ksig->ka.sa.sa_handler;
>  
> -		err |= get_user(regs->ctr, &funct_desc_ptr->entry);
> -		err |= get_user(regs->gpr[2], &funct_desc_ptr->toc);
> +		if (user_read_access_begin(funct_desc_ptr, sizeof(func_descr_t))) {
> +			unsafe_get_user(regs->ctr, &funct_desc_ptr->entry, bad_funct_desc_block);
> +			unsafe_get_user(regs->gpr[2], &funct_desc_ptr->toc, bad_funct_desc_block);
> +		} else {
> +			goto bad_funct_desc;
> +bad_funct_desc_block:
> +			user_read_access_end();
> +bad_funct_desc:
> +			signal_fault(current, regs, __func__, funct_desc_ptr);
> +			return 1;
> +		}
> +		user_read_access_end();

Having a goto after an ele block, an then labels jumping into it is just
weird.

To make this somewhat readable just split it into a helper function:

static inline bool put_func_descr(func_descr_t __user *funct_desc_ptr,
		struct pt_regs *regs)
{
	if (!user_read_access_begin(funct_desc_ptr, sizeof(func_descr_t)))
		goto fault;
	unsafe_get_user(regs->ctr, &funct_desc_ptr->entry, uaccess_end);
	unsafe_get_user(regs->gpr[2], &funct_desc_ptr->toc, uaccess_end);
	user_read_access_end();
	return false;

uaccess_end:
	user_read_access_end();
fault:
	signal_fault(current, regs, __func__, funct_desc_ptr);
	return true;
}
