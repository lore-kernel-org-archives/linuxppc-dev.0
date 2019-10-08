Return-Path: <SRS0=I7zA=YB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E641CC4360C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Oct 2019 16:00:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F6A0206C0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Oct 2019 16:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F6A0206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46nhrG3QYZzDqRR
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Oct 2019 02:59:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.208.196; helo=mail-lj1-f196.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
 [209.85.208.196])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46nhpG4YWJzDqFJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Oct 2019 02:58:12 +1100 (AEDT)
Received: by mail-lj1-f196.google.com with SMTP id l21so18142378lje.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Oct 2019 08:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ab5F2pwpqc92h3f3ztS+IDWHOoh9/XiB514cOnglgi0=;
 b=svNwT+Tb188cZaer+Sx8vwgWEpJmW4+1Te2xzSYqoDB0mazAnohkKXoVmyy1GHEkEi
 ABBJQi00kVVpTItTIWyihj/eTEZPx4F9OXw6WXuoFPazgtmStp2Jz37yID49qLcdWsWk
 YwZPIiDWeRLuwQc/jo8fAZzPHhRr+jKadOP8tRN6obNa5QCn4LbRCHaDYG1NTXnXbmS1
 cRHWGRpL7nJeld5AfvZZGTq3ah8BKCGcuw3p8+UwtzPxICoLNkry9Hg5BhBpq5+B0lRz
 A1jMpErn1swROc/kHSaaVbFKmky4pZxbuB/YqGSS78PcAEeYdvBH1fsHU4kYEn/0p92C
 zO/g==
X-Gm-Message-State: APjAAAXl+GM18wjoJJ//LdoQfdifKiZj4LHa+LHOpmNhWbKNZPAFTkiD
 5mcE1Qr3yJg6l9LhIzQKk9UOAVaBevczJBUTrRM=
X-Google-Smtp-Source: APXvYqwxV2LEz1UdCa3FMvPOFSbvTv7gdUYe9fG/J+gzm1FEJsUueqZ16mbvgHnpFXX7AY7SBWqGM2Z3KF20ATOLDcQ=
X-Received: by 2002:a05:651c:1032:: with SMTP id
 w18mr20289889ljm.256.1570550288646; 
 Tue, 08 Oct 2019 08:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <20191008141342.GA266797@gmail.com>
In-Reply-To: <20191008141342.GA266797@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 8 Oct 2019 17:57:52 +0200
Message-ID: <CAK8P3a1Ed7Lt-W4gVDVo+atxFNgNhOrLtipJEaOXgWYp6OAnjQ@mail.gmail.com>
Subject: Re: [PATCH] spufs: fix a crash in spufs_create_root()
To: Emmanuel Nicolet <emmanuel.nicolet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: David Howells <dhowells@redhat.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Jeremy Kerr <jk@ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Oct 8, 2019 at 4:13 PM Emmanuel Nicolet
<emmanuel.nicolet@gmail.com> wrote:
>
> The spu_fs_context was not set in fc->fs_private, this caused a crash
> when accessing ctx->mode in spufs_create_root().
>
> Signed-off-by: Emmanuel Nicolet <emmanuel.nicolet@gmail.com>

Fixes: d2e0981c3b9a ("vfs: Convert spufs to use the new mount API")
Acked-by: Arnd Bergmann <arnd@arndb.de>

>  arch/powerpc/platforms/cell/spufs/inode.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
> index 1d93e55a2de1..2dd452a047cd 100644
> --- a/arch/powerpc/platforms/cell/spufs/inode.c
> +++ b/arch/powerpc/platforms/cell/spufs/inode.c
> @@ -761,6 +761,7 @@ static int spufs_init_fs_context(struct fs_context *fc)
>         ctx->gid = current_gid();
>         ctx->mode = 0755;
>
> +       fc->fs_private = ctx;
>         fc->s_fs_info = sbi;
>         fc->ops = &spufs_context_ops;
>         return 0;
> --
> 2.23.0
>
