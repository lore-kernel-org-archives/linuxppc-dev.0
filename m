Return-Path: <SRS0=kNGO=H7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3ECDC433DB
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Mar 2021 22:20:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED96560231
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Mar 2021 22:20:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED96560231
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DqF8F6Qgcz3clr
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Mar 2021 09:20:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256 header.s=google header.b=clAXYSbt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=axtens.net (client-ip=2607:f8b0:4864:20::636;
 helo=mail-pl1-x636.google.com; envelope-from=dja@axtens.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256
 header.s=google header.b=clAXYSbt; dkim-atps=neutral
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DqF7n3Qnjz30Qm
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Mar 2021 09:20:19 +1100 (AEDT)
Received: by mail-pl1-x636.google.com with SMTP id z7so10800597plk.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Mar 2021 14:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=wMX3q2NCKCdQkZCDujwqGQ31ThPGso7OFWe+UfWY/6c=;
 b=clAXYSbtvOkDRyzlGaVMsPGkEIIDxpuKC4vSpzkBkrXxfrZNkqUH6iLVhqgK0cFuND
 jbjQUX4UeFLo8ebPWr6I4kAVOEocI5D4Ne5gk+EbongbqBFT8cFRtT/H1UD785n+fRmq
 ssFJukq6wVJoPcTrPTBfCDwRG2zjwnJmSQ4VU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=wMX3q2NCKCdQkZCDujwqGQ31ThPGso7OFWe+UfWY/6c=;
 b=e9wg5YjscdWUuEwWabrU2doBz8Q4wKuwbI5hkOf6pDYb1QXmD7eLYtKYnhW9lYu4G8
 UO2PjE+UWf8zcyy9SUgzALiW1kuQJh3p9FWRYL5IJVCdQ18y61ifwmosdYZl5ptsvfsE
 1Rhicld+ppqmrF+p6lbOxBN9vZd7h/6dJOZssMCEVLcpTyte4KSPr1rIUX0f3tUC7Kkw
 HRBoFQYu4/cpkf2xp9GsZn2dUHi3Bh+bQZXiwPgMPz4HTHkskFCQEH51B2trtFsWgJPR
 QNLE/JM9+PRG7oNgwKvh7XJkP6g3HBvaVTy6tA+0niT+LAhTGEWbgUc5+pldCV/WD5pS
 ZEhQ==
X-Gm-Message-State: AOAM530BQlLuMdE3hA1KSOo3pxI6Ngx3HeeYMVLqC40mGP3xBtPZBnIJ
 CzpGGxPS8slk4k1Mt5MNc1+sjg==
X-Google-Smtp-Source: ABdhPJyIlALZqCEKL0o+XkvYRSX2xp62dBh4C3DvJ5pbvPlKNXlXkGE1tNH5kl71wgPmoS/BlnN+Aw==
X-Received: by 2002:a17:90b:253:: with SMTP id
 fz19mr1050336pjb.160.1614637215570; 
 Mon, 01 Mar 2021 14:20:15 -0800 (PST)
Received: from localhost
 (2001-44b8-1113-6700-b18e-89be-e1b2-4959.static.ipv6.internode.on.net.
 [2001:44b8:1113:6700:b18e:89be:e1b2:4959])
 by smtp.gmail.com with ESMTPSA id mp19sm1041301pjb.2.2021.03.01.14.20.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Mar 2021 14:20:15 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v1 02/15] powerpc/uaccess: Define ___get_user_instr() for
 ppc32
In-Reply-To: <03d1f57f73c74748829994f8026cb274065c1d8d.1614275314.git.christophe.leroy@csgroup.eu>
References: <cover.1614275314.git.christophe.leroy@csgroup.eu>
 <03d1f57f73c74748829994f8026cb274065c1d8d.1614275314.git.christophe.leroy@csgroup.eu>
Date: Tue, 02 Mar 2021 09:20:11 +1100
Message-ID: <87ft1eo6sk.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Christophe,

> +#else /* !CONFIG_PPC64 */
> +#define ___get_user_instr(gu_op, dest, ptr)				\
> +	gu_op((dest).val, (u32 __user *)(ptr))
> +#endif /* CONFIG_PPC64 */
>  
>  #define get_user_instr(x, ptr) \
>  	___get_user_instr(get_user, x, ptr)
> @@ -91,18 +95,6 @@ static inline bool __access_ok(unsigned long addr, unsigned long size)
>  #define __get_user_instr_inatomic(x, ptr) \
>  	___get_user_instr(__get_user_inatomic, x, ptr)
>  
> -#else /* !CONFIG_PPC64 */
> -#define get_user_instr(x, ptr) \
> -	get_user((x).val, (u32 __user *)(ptr))
> -
> -#define __get_user_instr(x, ptr) \
> -	__get_user_nocheck((x).val, (u32 __user *)(ptr), sizeof(u32), true)
> -
> -#define __get_user_instr_inatomic(x, ptr) \
> -	__get_user_nosleep((x).val, (u32 __user *)(ptr), sizeof(u32))
> -
> -#endif /* CONFIG_PPC64 */

The previous version of __get_user_instr called __get_user_nocheck,
this version calls __get_user. Likewise __get_user_instr_inatomic called
__get_user_nosleep and now it calls __get_user_inatomic. I was confused
by this until I chased the macro definitions and realised that both
names refer to the same thing:

#define __get_user(x, ptr) \
	__get_user_nocheck((x), (ptr), sizeof(*(ptr)), true)

#define __get_user_inatomic(x, ptr) \
	__get_user_nosleep((x), (ptr), sizeof(*(ptr)))

(I don't think you need to do anything here, I'm just documenting what I
considered while reviewing your patch.)

As such:
Reviewed-by: Daniel Axtens <dja@axtens.net>

Kind regards,
Daniel


> -
>  extern long __put_user_bad(void);
>  
>  #define __put_user_size(x, ptr, size, retval)			\
> -- 
> 2.25.0
