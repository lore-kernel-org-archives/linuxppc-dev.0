Return-Path: <SRS0=U6gC=R7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADBDC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 13:00:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72D87206B6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 13:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="0HS/QlZp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72D87206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44VQ2T1Dd1zDq9S
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 00:00:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.83; helo=conssluserg-04.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="0HS/QlZp"; 
 dkim-atps=neutral
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com
 [210.131.2.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44VQ0T5g0MzDq6J
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2019 23:58:32 +1100 (AEDT)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com
 [209.85.221.181]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id x2SCw76L019682
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2019 21:58:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x2SCw76L019682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1553777888;
 bh=iNmNHPxummQG0NGAnAG9Kb2w/4+4tPoyHR3WrxALJPQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=0HS/QlZprPavqjj2dwJ/CgToYMLqCJd6WpcoYVoSwLzQZd3+QhtbYDqwtqSIvki11
 /B12xMVuZJ6Kif2dEw+HroNHhlkk3p9dEnRGAcn0eL0orqPZ+lZFOfJo+0G+a4ciLD
 svkdc39eEHeXBUJX+dOPIs/AVfp4hgTlaqL0qCrcHuUImpW8Ko/IUAEI4d3stHR4B7
 esIhK6Gxf3wOjh3ESeKChiQeUQgZvABTMSt7iayuslkVrp8af9wNG5/27tXrefgrBr
 ujQwquaOnMd2IehEyjcdV7wChtb3fKKyfqvekkxQaTMFibxfYD2Uo4xJXfDQh0lZYG
 Xy8T8N6qkeNig==
X-Nifty-SrcIP: [209.85.221.181]
Received: by mail-vk1-f181.google.com with SMTP id 195so31932vkx.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2019 05:58:08 -0700 (PDT)
X-Gm-Message-State: APjAAAX9lqKBP21f3ROaMK55ziqbZHDUR9ZTZRUtJgdmrcfNVVg2bY6I
 H4f6btsyeiye90oanE805Da4DFj6r+gau9Y34vI=
X-Google-Smtp-Source: APXvYqzsjz8BW750T3mIR6MJZvSdPNs07X6W7SlnlVlDoyNhEdxrxPhM5BRccjybZgDCFh+ClPBz5cEdCHLESIa+x18=
X-Received: by 2002:a1f:9350:: with SMTP id v77mr24780964vkd.84.1553777886929; 
 Thu, 28 Mar 2019 05:58:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190325160438.8982-1-joe.lawrence@redhat.com>
 <CAK7LNARyD=tG0JhwN_mjdyDRSPAF8UoZKvqAT3Ah_v7GfymCPg@mail.gmail.com>
 <20190326173308.GA26546@redhat.com>
In-Reply-To: <20190326173308.GA26546@redhat.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 28 Mar 2019 21:57:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT4VTUOtjEvJfe9+7yNemkodUnDo6bMoKxSgqGq7H4mOQ@mail.gmail.com>
Message-ID: <CAK7LNAT4VTUOtjEvJfe9+7yNemkodUnDo6bMoKxSgqGq7H4mOQ@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: strip whitespace in cmd_record_mcount
 findstring
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

Hi Joe,


On Wed, Mar 27, 2019 at 2:33 AM Joe Lawrence <joe.lawrence@redhat.com> wrote:
>
> On Tue, Mar 26, 2019 at 02:29:47PM +0900, Masahiro Yamada wrote:
> > On Tue, Mar 26, 2019 at 1:05 AM Joe Lawrence <joe.lawrence@redhat.com> wrote:
> > >
> > > CC_FLAGS_FTRACE may contain trailing whitespace that interferes with
> > > findstring.
> > >
> > > For example, commit 6977f95e63b9 ("powerpc: avoid -mno-sched-epilog on
> > > GCC 4.9 and newer") introduced a change such that on my ppc64le box,
> > > CC_FLAGS_FTRACE="-pg -mprofile-kernel ".  (Note the trailing space.)
> > > When cmd_record_mcount is now invoked, findstring fails as the ftrace
> > > flags were found at very end of _c_flags, without the trailing space.
> > >
> > >   _c_flags=" ... -pg -mprofile-kernel"
> > >   CC_FLAGS_FTRACE="-pg -mprofile-kernel "
> > >                                        ^
> > >     findstring is looking for this extra space
> > >
> > > Remove the redundant whitespaces from CC_FLAGS_FTRACE in
> > > cmd_record_mcount to avoid this problem.
> > >
> > > Fixes: 6977f95e63b9 ("powerpc: avoid -mno-sched-epilog on GCC 4.9 and newer").
> > > Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> > > ---
> > >
> > > Standard disclaimer: I'm not a kbuild expert, but this works around the
> > > problem I reported where ftrace and livepatch self-tests were failing as
> > > specified object files were not run through the recordmcount.pl script:
> > >
> > > ppc64le: ftrace self-tests and $(CC_FLAGS_FTRACE) broken?
> > > https://lists.ozlabs.org/pipermail/linuxppc-dev/2019-March/187298.html
> > >
> > >  scripts/Makefile.build | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > > index 2554a15ecf2b..74d402b5aa3c 100644
> > > --- a/scripts/Makefile.build
> > > +++ b/scripts/Makefile.build
> > > @@ -199,10 +199,10 @@ sub_cmd_record_mcount = perl $(srctree)/scripts/recordmcount.pl "$(ARCH)" \
> > >         "$(if $(part-of-module),1,0)" "$(@)";
> > >  recordmcount_source := $(srctree)/scripts/recordmcount.pl
> > >  endif # BUILD_C_RECORDMCOUNT
> > > -cmd_record_mcount =                                            \
> > > -       if [ "$(findstring $(CC_FLAGS_FTRACE),$(_c_flags))" =   \
> > > -            "$(CC_FLAGS_FTRACE)" ]; then                       \
> > > -               $(sub_cmd_record_mcount)                        \
> > > +cmd_record_mcount =                                                    \
> > > +       if [ "$(findstring $(strip $(CC_FLAGS_FTRACE)),$(_c_flags))" =  \
> > > +            "$(strip $(CC_FLAGS_FTRACE))" ]; then                      \
> > > +               $(sub_cmd_record_mcount)                                \
> > >         fi
> > >  endif # CC_USING_RECORD_MCOUNT
> > >  endif # CONFIG_FTRACE_MCOUNT_RECORD
> > > --
> > > 2.20.1
> > >
> >
> >
> >
> > I do not see a point in using the shell command here
> > in the first place.
> >
> > Instead of adding crappy workarounds,
> > I guess the following simple code should work:
> >
> >
> > index 2554a15..5f13021 100644
> > --- a/scripts/Makefile.build
> > +++ b/scripts/Makefile.build
> > @@ -199,11 +199,8 @@ sub_cmd_record_mcount = perl
> > $(srctree)/scripts/recordmcount.pl "$(ARCH)" \
> >         "$(if $(part-of-module),1,0)" "$(@)";
> >  recordmcount_source := $(srctree)/scripts/recordmcount.pl
> >  endif # BUILD_C_RECORDMCOUNT
> > -cmd_record_mcount =                                            \
> > -       if [ "$(findstring $(CC_FLAGS_FTRACE),$(_c_flags))" =   \
> > -            "$(CC_FLAGS_FTRACE)" ]; then                       \
> > -               $(sub_cmd_record_mcount)                        \
> > -       fi
> > +cmd_record_mcount = $(if $(findstring $(CC_FLAGS_FTRACE),$(_c_flags)),\
> > +                 $(sub_cmd_record_mcount))
> >  endif # CC_USING_RECORD_MCOUNT
> >  endif # CONFIG_FTRACE_MCOUNT_RECORD
> >
>
> Hi Masahiro,
>
> Agreed on the shell command ugliness, however I still think we need to
> strip the search pattern here.  With your suggestion:
>
> % rm -f kernel/trace/trace_selftest_dynamic.o
> % make kernel/trace/trace_selftest_dynamic.o
>   CALL    scripts/checksyscalls.sh
>   CALL    scripts/atomic/check-atomics.sh
>   CC      kernel/trace/trace_selftest_dynamic.o
>
> % eu-readelf --sections kernel/trace/trace_selftest_dynamic.o | grep mcount
> (nothing)
>
> Adding it back as, as below, restores those sections and the self tests
> work again.


OK, confirmed.

First, I was wondering why I could not reproduce this issue.
Then, I found the reason was I was using the latest GNU Make
compiled from the git source tree.

I found the following commit:

commit b90fabc8d6f34fb37d428dc0fb1b8b1951a9fbed
Author: Paul Smith <psmith@gnu.org>
Date:   Sat May 27 20:07:30 2017 -0400

    * NEWS: Do not insert a space during '+=' if the value is empty.

    * doc/make.texi (Appending): Document this behavior.
    * variable.c (do_variable_definition): Only add a space if the variable
    value is not empty.
    * tests/scripts/variables/flavors: Test this behavior.

diff --git a/NEWS b/NEWS
index e60644a..6e2c5c6 100644
--- a/NEWS
+++ b/NEWS
@@ -29,6 +29,12 @@
http://sv.gnu.org/bugs/index.php?group=make&report_id=111&fix_release_id=108&set
   This was claimed to be fixed in 3.81, but wasn't, for some reason.
   To detect this change search for 'nocomment' in the .FEATURES variable.

+* WARNING: Backward-incompatibility!
+  Previously appending using '+=' to an empty variable would result in a value
+  starting with a space.  Now the initial space is only added if the variable
+  already contains some value.  Similarly, appending an empty string does not
+  add a trailing space.
+
 * The previous limit of 63 jobs under -jN on MS-Windows is now
   increased to 4095.  That limit includes the subprocess started by
   the $(shell) function.




Applied to linux-kbuild/fixes with additional comments.

[Additional info by masahiro.yamada:
This issue only happens in the released versions of GNU Make.
CC_FLAGS_FTRACE will not contain the trailing space if you use
the latest GNU Make, which contains commit b90fabc8d6f3
("* NEWS: Do not insert a space during '+=' if the value is empty.")
]




> Regards,
>
> -- Joe
>
> -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8--
>
> From 6a85e8ecf4179b3e80601a327ec43d8d49f0e3cd Mon Sep 17 00:00:00 2001
> From: Joe Lawrence <joe.lawrence@redhat.com>
> Date: Tue, 26 Mar 2019 10:50:28 -0400
> Subject: [PATCH v2] kbuild: strip whitespace in cmd_record_mcount findstring
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
> Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com> (refactoring)
> Fixes: 6977f95e63b9 ("powerpc: avoid -mno-sched-epilog on GCC 4.9 and newer").
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> ---
>  scripts/Makefile.build | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 2554a15ecf2b..76ca30cc4791 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -199,11 +199,8 @@ sub_cmd_record_mcount = perl $(srctree)/scripts/recordmcount.pl "$(ARCH)" \
>         "$(if $(part-of-module),1,0)" "$(@)";
>  recordmcount_source := $(srctree)/scripts/recordmcount.pl
>  endif # BUILD_C_RECORDMCOUNT
> -cmd_record_mcount =                                            \
> -       if [ "$(findstring $(CC_FLAGS_FTRACE),$(_c_flags))" =   \
> -            "$(CC_FLAGS_FTRACE)" ]; then                       \
> -               $(sub_cmd_record_mcount)                        \
> -       fi
> +cmd_record_mcount = $(if $(findstring $(strip $(CC_FLAGS_FTRACE)),$(_c_flags)),        \
> +       $(sub_cmd_record_mcount))
>  endif # CC_USING_RECORD_MCOUNT
>  endif # CONFIG_FTRACE_MCOUNT_RECORD
>
> --
> 2.20.1
>


-- 
Best Regards
Masahiro Yamada
