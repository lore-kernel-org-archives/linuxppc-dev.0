Return-Path: <SRS0=Rs50=ZE=vger.kernel.org=linux-m68k-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14CAC43331
	for <linux-m68k@archiver.kernel.org>; Tue, 12 Nov 2019 23:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7593E20674
	for <linux-m68k@archiver.kernel.org>; Tue, 12 Nov 2019 23:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c4HijsXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfKLXBa (ORCPT <rfc822;linux-m68k@archiver.kernel.org>);
        Tue, 12 Nov 2019 18:01:30 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44076 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbfKLXB3 (ORCPT
        <rfc822;linux-m68k@lists.linux-m68k.org>);
        Tue, 12 Nov 2019 18:01:29 -0500
Received: by mail-pl1-f196.google.com with SMTP id az9so152870plb.11
        for <linux-m68k@lists.linux-m68k.org>; Tue, 12 Nov 2019 15:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nExhpa8NtyhyvUyh20F6httON+9jpHubOC8X4R1/1QI=;
        b=c4HijsXEjZGJqE7HF/OLTdBXGVnY9qLmNBULMzMpbSwMDUdlWMyYkBAj7Jv9KvJQq9
         uQ/fhhX6CbwBVqkc6vhI0J9bVR6S+eypweTAwvYsABomRnDDk1wGcU2hJ/fV4/K6uu+1
         c9+G8zkVxO8gfkNV8xNJ/wUCIdP5veO1BJPEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nExhpa8NtyhyvUyh20F6httON+9jpHubOC8X4R1/1QI=;
        b=RaQDUCo9Z3syPSPJVCm1cY0eFCo0kq49hh2MHakWJ13hOXSdvrQCj7WWRtazT/bexX
         /GVgMr4Okm5ngEOA9hmCS9UAhJGybXYj7qTRlebS3gcGHBH4T4OkytHEjFagVKprRKTr
         5SQUnqbv0hqagQUzAxuaR3iwCmmX0Hcs5l3CCw+KSGNI/Rc8/+hp7Sd35AW9/EN5ZMf6
         G1GKUVZynVbt1M6PhI7FpscwRdlp3yoc8fKjftkuviyf+KRv6lkbbig9NHr2598wbLSh
         Pw+E8dSFoi30UHDmdxg533VBg/th0uT6cgDQB47OEAV3wQqh09XQ6tQnlqwmF+n5Tu2t
         XQMQ==
X-Gm-Message-State: APjAAAUtLq3i8ieVzPXKJ0Rkbec2zkmRoYffIZnPYoH5FTmC5A7pU4qY
        oD+n6ri5/z8nO8+y5PRLZ4HfJg==
X-Google-Smtp-Source: APXvYqy/dNw+1S0sgv4o54+xgQ9m/sDAbXJguDm6De1m1sF3Ucjez84Z50LDqlIQCV97XGMiY2eUjw==
X-Received: by 2002:a17:902:b282:: with SMTP id u2mr266015plr.301.1573599688858;
        Tue, 12 Nov 2019 15:01:28 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id em16sm159840pjb.21.2019.11.12.15.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 15:01:27 -0800 (PST)
Date:   Tue, 12 Nov 2019 15:01:26 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v15 0/9] open: introduce openat2(2) syscall
Message-ID: <201911121457.7D02692@keescook>
References: <20191105090553.6350-1-cyphar@cyphar.com>
 <20191111132404.y523iqicbn6fivx5@yavin.dot.cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111132404.y523iqicbn6fivx5@yavin.dot.cyphar.com>
Sender: linux-m68k-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-m68k.vger.kernel.org>
X-Mailing-List: linux-m68k@vger.kernel.org
Message-ID: <20191112230126.fB6tgZWuPfytE2mByhRZoPC7CCs14ObIOeCrnAjR5yo@z>

On Tue, Nov 12, 2019 at 12:24:04AM +1100, Aleksa Sarai wrote:
> On 2019-11-05, Aleksa Sarai <cyphar@cyphar.com> wrote:
> > This patchset is being developed here:
> >   <https://github.com/cyphar/linux/tree/openat2/master>
> > 
> > Patch changelog:
> >  v15:
> >   * Fix code style for LOOKUP_IN_ROOT handling in path_init(). [Linus Torvalds]
> >   * Split out patches for each individual LOOKUP flag.
> >   * Reword commit messages to give more background information about the
> >     series, as well as mention the semantics of each flag in more detail.
> > [...]
> 
> Ping -- this patch hasn't been touched for a week. Thanks.

If I've been following correctly, everyone is happy with this series.
(i.e. Linus's comment appear to have been addressed.)

Perhaps the next question is should this go via a pull request by you to
Linus directly during the v5.5 merge window, via akpm, via akpm, via
Christian, or some other path? Besides Linus, it's not been clear who
should "claim" this series. :)

-- 
Kees Cook
