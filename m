Return-Path: <SRS0=JA7W=R5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2A7C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 05:32:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FA8D20828
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 05:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="tq5a2XQJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA8D20828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44T0BY3mFNzDqKf
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 16:32:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.90; helo=conssluserg-05.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="tq5a2XQJ"; 
 dkim-atps=neutral
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com
 [210.131.2.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44T08r3yytzDqBv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2019 16:30:51 +1100 (AEDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com
 [209.85.217.45]) (authenticated)
 by conssluserg-05.nifty.com with ESMTP id x2Q5UO59018363
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2019 14:30:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x2Q5UO59018363
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1553578225;
 bh=2V8oJ4SOZOoa9r88dWoDFuRZe2fco3wf/520gsHE4Y0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=tq5a2XQJYg5mJXLOOo7OEqmCWD5Uck6dPci0qDI4HwNwBK1bRhyLyj/VPet0jspyJ
 LXFrfFGkb+S2qnb1ujQgoJK8s5+D0Al54EyANQ8zFYkYB0QrC6WFvHa42qhhCC6XR9
 j5bVL3WtozNQhGyvBxbUHfnGBTqc58cWv7TLTQDH79fcrvDqn6bhm6uQ8lpjaO9SQN
 ASc9lkXs0meixZWEvoZqG2qLE/1RxpF43nYkYNB/x12yL5hVmakpwM36kw0RkdCqxU
 AALlKTLF1O3Pa5oc+HVaJL39jqN7e0Ljo8RE7dEYYOOMpCN4+xCW+1aw25/uml1QUs
 TWKF7mQ9fdN1w==
X-Nifty-SrcIP: [209.85.217.45]
Received: by mail-vs1-f45.google.com with SMTP id f15so6892262vsk.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 22:30:24 -0700 (PDT)
X-Gm-Message-State: APjAAAW8TKTLSJuviUdfv2f+PuMELVd9mEoMgtumvWeToxRV9MfodVWF
 yBJFs3KYVJorMFpiLBzRaDQ1JyWbSV21urHziDE=
X-Google-Smtp-Source: APXvYqzkcmSuUYgRYqfOq756473wcaYDiCn793dCs9KhRBidCZ+kZmCBeeBa8ii2AD+i5Qtyl3RzzVHtzcxlkhw6TnQ=
X-Received: by 2002:a67:f105:: with SMTP id n5mr17676008vsk.181.1553578223556; 
 Mon, 25 Mar 2019 22:30:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190325160438.8982-1-joe.lawrence@redhat.com>
In-Reply-To: <20190325160438.8982-1-joe.lawrence@redhat.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 26 Mar 2019 14:29:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNARyD=tG0JhwN_mjdyDRSPAF8UoZKvqAT3Ah_v7GfymCPg@mail.gmail.com>
Message-ID: <CAK7LNARyD=tG0JhwN_mjdyDRSPAF8UoZKvqAT3Ah_v7GfymCPg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: strip whitespace in cmd_record_mcount findstring
To: Joe Lawrence <joe.lawrence@redhat.com>
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
Cc: Michal Marek <michal.lkml@markovi.net>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Mar 26, 2019 at 1:05 AM Joe Lawrence <joe.lawrence@redhat.com> wrote:
>
> CC_FLAGS_FTRACE may contain trailing whitespace that interferes with
> findstring.
>
> For example, commit 6977f95e63b9 ("powerpc: avoid -mno-sched-epilog on
> GCC 4.9 and newer") introduced a change such that on my ppc64le box,
> CC_FLAGS_FTRACE="-pg -mprofile-kernel ".  (Note the trailing space.)
> When cmd_record_mcount is now invoked, findstring fails as the ftrace
> flags were found at very end of _c_flags, without the trailing space.
>
>   _c_flags=" ... -pg -mprofile-kernel"
>   CC_FLAGS_FTRACE="-pg -mprofile-kernel "
>                                        ^
>     findstring is looking for this extra space
>
> Remove the redundant whitespaces from CC_FLAGS_FTRACE in
> cmd_record_mcount to avoid this problem.
>
> Fixes: 6977f95e63b9 ("powerpc: avoid -mno-sched-epilog on GCC 4.9 and newer").
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> ---
>
> Standard disclaimer: I'm not a kbuild expert, but this works around the
> problem I reported where ftrace and livepatch self-tests were failing as
> specified object files were not run through the recordmcount.pl script:
>
> ppc64le: ftrace self-tests and $(CC_FLAGS_FTRACE) broken?
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2019-March/187298.html
>
>  scripts/Makefile.build | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 2554a15ecf2b..74d402b5aa3c 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -199,10 +199,10 @@ sub_cmd_record_mcount = perl $(srctree)/scripts/recordmcount.pl "$(ARCH)" \
>         "$(if $(part-of-module),1,0)" "$(@)";
>  recordmcount_source := $(srctree)/scripts/recordmcount.pl
>  endif # BUILD_C_RECORDMCOUNT
> -cmd_record_mcount =                                            \
> -       if [ "$(findstring $(CC_FLAGS_FTRACE),$(_c_flags))" =   \
> -            "$(CC_FLAGS_FTRACE)" ]; then                       \
> -               $(sub_cmd_record_mcount)                        \
> +cmd_record_mcount =                                                    \
> +       if [ "$(findstring $(strip $(CC_FLAGS_FTRACE)),$(_c_flags))" =  \
> +            "$(strip $(CC_FLAGS_FTRACE))" ]; then                      \
> +               $(sub_cmd_record_mcount)                                \
>         fi
>  endif # CC_USING_RECORD_MCOUNT
>  endif # CONFIG_FTRACE_MCOUNT_RECORD
> --
> 2.20.1
>



I do not see a point in using the shell command here
in the first place.

Instead of adding crappy workarounds,
I guess the following simple code should work:


index 2554a15..5f13021 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -199,11 +199,8 @@ sub_cmd_record_mcount = perl
$(srctree)/scripts/recordmcount.pl "$(ARCH)" \
        "$(if $(part-of-module),1,0)" "$(@)";
 recordmcount_source := $(srctree)/scripts/recordmcount.pl
 endif # BUILD_C_RECORDMCOUNT
-cmd_record_mcount =                                            \
-       if [ "$(findstring $(CC_FLAGS_FTRACE),$(_c_flags))" =   \
-            "$(CC_FLAGS_FTRACE)" ]; then                       \
-               $(sub_cmd_record_mcount)                        \
-       fi
+cmd_record_mcount = $(if $(findstring $(CC_FLAGS_FTRACE),$(_c_flags)),\
+                 $(sub_cmd_record_mcount))
 endif # CC_USING_RECORD_MCOUNT
 endif # CONFIG_FTRACE_MCOUNT_RECORD



-- 
Best Regards
Masahiro Yamada
