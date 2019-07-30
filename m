Return-Path: <SRS0=hRxk=V3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448A7C0650F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jul 2019 17:13:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEFF4206A2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jul 2019 17:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P7x6iRL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEFF4206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45yjnH49dzzDqNf
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Jul 2019 03:13:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=chromium.org
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=keescook@chromium.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="P7x6iRL+";
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45yjfz0HgVzDqWf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2019 03:07:54 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id i18so30384573pgl.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2019 10:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Ij5IHsIz5m1k/TZ9G+k0vjjrXKuI8zvs4XWvYMUv6xA=;
 b=P7x6iRL+potI/UXe2GL2bGfRW6KNMvSV5ppccdYt283WmoDUkRdzp4koQgOgunvvzl
 snnlVm7+LveboI+FEM9Sxiqv4tsYw40jcdadwsRQ4ypLgBK/XrqJnb9wZOPcxftcsBwJ
 DqurscVqXfKuZu8Sjv4SL2ydKIbof4EZcvndE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Ij5IHsIz5m1k/TZ9G+k0vjjrXKuI8zvs4XWvYMUv6xA=;
 b=iJz0M8rHnzqnrJNJTnLNGUX96p/w5Y3/DgSpvqwn1QRH2mzfhsFHP2sT7IJksteHk6
 lWHvlRHB6qgugzjBllOjn+kzX3ruGLI7Ef2PlobfaD4/f3J23c4x1z07lBUrbK6yLFS3
 UdepkCiq5BlAAC7u0W1sC/v8MQcNOoryzRxSymaygClf0NwTiNMa2zxoav9hR1+02B63
 4coMvbYYdE9QuvCrF2bFszoYKQ5HW+kQFQkTonO0r9WxfY++g1i6lpNFfOVKWrFvDBx1
 zrH+IQjZDs3ctnIYo/nrantWTR+Rq+7FZWaW4jyd+l/6L5HJGrMFI/DZyWTr9eEKoOpf
 pGRg==
X-Gm-Message-State: APjAAAW0UPwJDC/1dx0VwqonMMkiWMJfWrBdL2DqgArx9nfXuR8BBcVg
 GAfz21vmMPRP7mcD39ZRIs10sQ==
X-Google-Smtp-Source: APXvYqxJ+yRT5SoyqEcmrG5qDLkr0gEeD/gtdMxDd4IXybXkd0K5WhnE3L10kkcRHqj8qn91kuZIng==
X-Received: by 2002:aa7:9298:: with SMTP id j24mr41520880pfa.58.1564506470984; 
 Tue, 30 Jul 2019 10:07:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id f6sm67441648pga.50.2019.07.30.10.07.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 30 Jul 2019 10:07:50 -0700 (PDT)
Date: Tue, 30 Jul 2019 10:07:49 -0700
From: Kees Cook <keescook@chromium.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] drivers/macintosh/smu.c: Mark expected switch fall-through
Message-ID: <201907301005.0661E63CF@keescook>
References: <20190730143704.060a2606@canb.auug.org.au>
 <878ssfzjdk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878ssfzjdk.fsf@concordia.ellerman.id.au>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>,
 Linux kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Jul 31, 2019 at 12:28:55AM +1000, Michael Ellerman wrote:
> Stephen Rothwell <sfr@canb.auug.org.au> writes:
> > Mark switch cases where we are expecting to fall through.
> >
> > This patch fixes the following warning (Building: powerpc):
> >
> > drivers/macintosh/smu.c: In function 'smu_queue_i2c':
> > drivers/macintosh/smu.c:854:21: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >    cmd->info.devaddr &= 0xfe;
> >    ~~~~~~~~~~~~~~~~~~^~~~~~~
> > drivers/macintosh/smu.c:855:2: note: here
> >   case SMU_I2C_TRANSFER_STDSUB:
> >   ^~~~
> >
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  drivers/macintosh/smu.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/macintosh/smu.c b/drivers/macintosh/smu.c
> > index 276065c888bc..23f1f41c8602 100644
> > --- a/drivers/macintosh/smu.c
> > +++ b/drivers/macintosh/smu.c
> > @@ -852,6 +852,7 @@ int smu_queue_i2c(struct smu_i2c_cmd *cmd)
> >  		break;
> >  	case SMU_I2C_TRANSFER_COMBINED:
> >  		cmd->info.devaddr &= 0xfe;
> > +		/* fall through */
> >  	case SMU_I2C_TRANSFER_STDSUB:
> >  		if (cmd->info.sublen > 3)
> >  			return -EINVAL;
> 
> Why do we think it's an expected fall through? I can't really convince
> myself from the surrounding code that it's definitely intentional.

Yeah, good question. Just now when I went looking for who
used SMU_I2C_TRANSFER_COMBINED, I found the only caller in
arch/powerpc/platforms/powermac/low_i2c.c and it is clearly using a
fall-through for building the command for "stdsub" and "combined",
so I think that's justification enough:

        switch(bus->mode) {
        case pmac_i2c_mode_std:
                if (subsize != 0)
                        return -EINVAL;
                cmd->info.type = SMU_I2C_TRANSFER_SIMPLE;
                break;
        case pmac_i2c_mode_stdsub:
        case pmac_i2c_mode_combined:
                if (subsize > 3 || subsize < 1)
                        return -EINVAL;
                cmd->info.sublen = subsize;
                /* that's big-endian only but heh ! */
                memcpy(&cmd->info.subaddr, ((char *)&subaddr) + (4 - subsize),
                       subsize);
                if (bus->mode == pmac_i2c_mode_stdsub)
                        cmd->info.type = SMU_I2C_TRANSFER_STDSUB;
                else
                        cmd->info.type = SMU_I2C_TRANSFER_COMBINED;


Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
