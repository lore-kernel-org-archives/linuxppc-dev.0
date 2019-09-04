Return-Path: <SRS0=Ib4m=W7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAF0C3A5A7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Sep 2019 06:25:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 209DD23401
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Sep 2019 06:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="klSroD0q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 209DD23401
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46NYhj6m6FzDqkP
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Sep 2019 16:25:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.83; helo=conssluserg-04.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="klSroD0q"; 
 dkim-atps=neutral
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com
 [210.131.2.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46NYfH3dvZzDqjX
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Sep 2019 16:23:02 +1000 (AEST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com
 [209.85.222.43]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id x846MjDJ001317
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Sep 2019 15:22:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x846MjDJ001317
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1567578166;
 bh=f/Vt6AfJ/h0GmLP4nlGQ6fG5Sb31T5I6KrbEB4uL3XQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=klSroD0qCQpZ5U6pxi2/qRowXcLbgDr38bNgsFdq09oA5xRagfY68AYymJmL2UKlZ
 AdN3EX+pOaZXFigtquwmXFnvIz3YR5SyvpELIcqwh15t9FojM4OT3w//5DNBllrIS6
 8jcWank4fplhHLSRIv52JaVQuXE5k/O5ezpgG5ovUix9gr7t72Y2U85WCK6zchNNJI
 IGep9b/kvtqmmEuB+oOySx5SD5G4+ClVDvd1oagm+uuBhiKUFk40Yrf9WaJNoy0z1a
 NNwxMd4a2bXNJgvA3NvxjGlIrwB+ZlBl4kmYV1maLKxeec0WoF6e/8B3E0jIXdQNVi
 GUbzyrXAys9UQ==
X-Nifty-SrcIP: [209.85.222.43]
Received: by mail-ua1-f43.google.com with SMTP id i17so3049350ual.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Sep 2019 23:22:46 -0700 (PDT)
X-Gm-Message-State: APjAAAXm0CjZ7HW/1JWq2xKkZBWWXeah8ikz4G+tAkbbAmfpYeCopr5n
 Dywxpz6/ddnjXZIMCxCIsV3mKy143iz4yexQNpI=
X-Google-Smtp-Source: APXvYqwXqIiEkpz8t5zX3CwWA0I7b3aQl9vXC5xpQV6eLWDVUn+QwNnliorr9pE1hNc0I8hJVRq/h0Tg+eKQL9tTnI0=
X-Received: by 2002:a9f:2213:: with SMTP id 19mr6836107uad.25.1567578165238;
 Tue, 03 Sep 2019 23:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190904101259.2687cea4@canb.auug.org.au>
 <CAK7LNAT=qUi76cF776GcT=UYce5QBo+_24gLwXH7ra15=1xLvQ@mail.gmail.com>
In-Reply-To: <CAK7LNAT=qUi76cF776GcT=UYce5QBo+_24gLwXH7ra15=1xLvQ@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 4 Sep 2019 15:22:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ8VJz8fxecnEWmbFCpD0rgt4tjoipOX0g3oY0xU8xt5w@mail.gmail.com>
Message-ID: <CAK7LNAQ8VJz8fxecnEWmbFCpD0rgt4tjoipOX0g3oY0xU8xt5w@mail.gmail.com>
Subject: Re: linux-next: build warnings after merge of the kbuild tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
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
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Sep 4, 2019 at 10:00 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi Stephen,
>
> On Wed, Sep 4, 2019 at 9:13 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >

For today's linux-next, please squash the following too.

(This is my fault, since scripts/mkuboot.sh is a bash script)


diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 41c50f9461e5..2d72327417a9 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -374,7 +374,7 @@ UIMAGE_ENTRYADDR ?= $(UIMAGE_LOADADDR)
 UIMAGE_NAME ?= 'Linux-$(KERNELRELEASE)'

 quiet_cmd_uimage = UIMAGE  $@
-      cmd_uimage = $(CONFIG_SHELL) $(MKIMAGE) -A $(UIMAGE_ARCH) -O linux \
+      cmd_uimage = $(BASE) $(MKIMAGE) -A $(UIMAGE_ARCH) -O linux \
                        -C $(UIMAGE_COMPRESSION) $(UIMAGE_OPTS-y) \
                        -T $(UIMAGE_TYPE) \
                        -a $(UIMAGE_LOADADDR) -e $(UIMAGE_ENTRYADDR) \





-- 
Best Regards
Masahiro Yamada
