Return-Path: <SRS0=lgwO=Q2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D74C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 03:48:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F8262075C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 03:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="AtQ4AQBZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F8262075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 443RYH6NW7zDqHw
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 14:48:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="AtQ4AQBZ"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 443RWM1r1tzDqHY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2019 14:47:10 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id k2so357046plt.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2019 19:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=tUz5JABWfgefOez+HboEAqWRpASZBI5PTo6PVfPcxkM=;
 b=AtQ4AQBZ2Rs72iQg21eVLhPCUlHDD2nd52ok0ZoaZuwrzF6SLa2Z3rjN3Adj0IEHx/
 kLwciEPdrRzkQM512RIV6QIh32UOnQnq4MNhzjJGJkdP4tmCPTVsrpf+L7xPpGT4/m7p
 CjvZtu15kGGCXRv9ZHBNWKFBBcvl/DjrLtZWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=tUz5JABWfgefOez+HboEAqWRpASZBI5PTo6PVfPcxkM=;
 b=Dapwx7oqtD3GhnIeigSB3SZvOHFw3i74zE9jzhRRUno9J1bKVsZXnYIDMrs6aafohK
 7qnuWCEV9hm8MUBsV4fgR7yQlBUh8HfI2PWCFNdyVhTVc+FT1C7Ihah80wzLFMDmsc/F
 JGKAqNmhYw6f1ppfn7+xYCXsexnBYH6v+0/QW8rD51IJcoT0I82J6f9r8l/Qx9+JhI/E
 TYWmcoIw3zS6P0lKtGOdG03sXkmGi7BoAQLw4akf6wrI/fNlobkYJ4fVKzAqwIu+nn6U
 RxH219oGaNPCD/kRs2HXA6aFBgxuqExomuCeb4hjLTnzVG3R4KiYGpvLZCyfbWW1WwbL
 GS8w==
X-Gm-Message-State: AHQUAuZy16CdYILn36SRg3TbH6shrwc6vJMbwxYEFkaqkSq9F0Ox6XF1
 WUuglkIOSJgKhvZ+t6/fvVNx5Q==
X-Google-Smtp-Source: AHgI3IazyC9x9/pPkfrXHrIGgcQZGn+Wj3upFeyiZPMMewsB4KKyc1LnVK7RYGbaB3hy66K9mFJJEQ==
X-Received: by 2002:a17:902:6686:: with SMTP id
 e6mr28695726plk.208.1550548028446; 
 Mon, 18 Feb 2019 19:47:08 -0800 (PST)
Received: from localhost (ppp121-45-196-25.bras1.cbr1.internode.on.net.
 [121.45.196.25])
 by smtp.gmail.com with ESMTPSA id z127sm24578596pfb.80.2019.02.18.19.47.06
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Feb 2019 19:47:07 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: YueHaibing <yuehaibing@huawei.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Aravinda Prasad <aravinda@linux.vnet.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [PATCH -next] powerpc/pseries: Drop pointless static qualifier in
 vpa_debugfs_init()
In-Reply-To: <20190218125644.87448-1-yuehaibing@huawei.com>
References: <20190218125644.87448-1-yuehaibing@huawei.com>
Date: Tue, 19 Feb 2019 14:47:02 +1100
Message-ID: <87ftska18p.fsf@linkitivity.dja.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
 YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi YueHaibing, <yuehaibing@huawei.com> writes:

> There is no need to have the 'struct dentry *vpa_dir' variable static
> since new value always be assigned before use it.
>

Much to my surprise this seems to be a correct change. I don't know why
the struct was ever static but it seems to have been this way since the
commit went in in October 2018. And yes, it is set every time when the
function is called (which is exactly once, it's an initcall). I wonder
if once upon a time in an earlier spin of the patch there was a method
to tear the debugfs down, so it was global, and in the revisions that
went away but the static qualifier remained.

Anyway, I think your commit message should have:

Fixes: c6c26fb55e8e ("powerpc/pseries: Export raw per-CPU VPA data via debugfs")

as this is the commit that introduced the issue.

With that change:
Reviewed-by: Daniel Axtens <dja@axtens.net>

Regards,
Daniel

> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  arch/powerpc/platforms/pseries/lpar.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
> index f2a9f0adc2d3..f649c1b652eb 100644
> --- a/arch/powerpc/platforms/pseries/lpar.c
> +++ b/arch/powerpc/platforms/pseries/lpar.c
> @@ -1263,7 +1263,7 @@ static int __init vpa_debugfs_init(void)
>  {
>  	char name[16];
>  	long i;
> -	static struct dentry *vpa_dir;
> +	struct dentry *vpa_dir;
>  
>  	if (!firmware_has_feature(FW_FEATURE_SPLPAR))
>  		return 0;
