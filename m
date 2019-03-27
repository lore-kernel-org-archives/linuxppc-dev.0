Return-Path: <SRS0=MnD0=R6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FF8C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 06:19:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 094E52075E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 06:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVpIwPgu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 094E52075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44TdBQ4Ry9zDqPM
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 17:19:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="PVpIwPgu"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Td8C24JpzDqQK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 17:17:31 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id g8so9466343pgf.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2019 23:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=axc9xNpyTRBrX7LQvA1WbHYImqcINzH7Eycv8MVMF/4=;
 b=PVpIwPgukE0ulDL4eMxd0AVT7NxyKepWyR5/kfGAyuxYrIyneZKWAyqs2MXg7Kuocz
 ZV1yM6vvG9TyDlTB/lYl+sgBPNnTQeCWixRc0WARv67XPxtciy871zgJ+StOHaN9n66t
 SAzVwBcXnl8IZHMXVoWPZ1ezgWNJzVFycz4E4AV5isbLSiI78kN58oW1fVaBhvc/ATxO
 k5j+O/+0wHM7ZVIuZml0uq28OJvDMy024uHQ4ZtDucjynD01t2kOdC+qdQvYdzCYOdt9
 ARTY5HQL3ivBSA4aQuha0SX8o04W34yrb6OSflCuRyDokO3r/x7p/1UHFIFleI9hKQEh
 KLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=axc9xNpyTRBrX7LQvA1WbHYImqcINzH7Eycv8MVMF/4=;
 b=KbkX5/DmA81/m9bjU77Ad6J4fuRVvnxJ23xULy9BkDUes4WJ+8DpxJoHg/zOT1qJpq
 RmGRg+Q6IR0x25jqRhVccpa04IgdKnCkns5sZ99agiHw1SAJ2AZkfGWSYeL88PFzVQld
 Q1q46Q9Uhy/iwHoCjYA7vn84iW9LbzMtg1uxAxKtnhBAwkckUAiK89NuWXiOhSVDG2G1
 bLoNdhzvBmKKzM1Yr4o67un3LNeTynRSDmqJ+HaC5Hz7ek5Pn4Xjf6p94/gmCEiwSOwx
 pxa9gqTJyDdBLeeGtLvJdaEZFZCRVVCQkAnCXmRBrGOWBUg7uo30wBYQdg0FeIx0YU0b
 ZdUA==
X-Gm-Message-State: APjAAAVyHy+mIK9lc2z+/8RJ77LokuMF601XCReAtPjV3tLYrMV1ehPN
 BzlDLOwt3c9YdmbIJqi0OMU=
X-Google-Smtp-Source: APXvYqyaM2rwJz7R/xglj9vUJq7GnjXoEg8UYqDL3bywMLrAs+rHV2dBjJBeEOEfOQQkAtWHMBlbOA==
X-Received: by 2002:a62:2046:: with SMTP id g67mr28278282pfg.121.1553667448718; 
 Tue, 26 Mar 2019 23:17:28 -0700 (PDT)
Received: from localhost (14-202-58-188.tpgi.com.au. [14.202.58.188])
 by smtp.gmail.com with ESMTPSA id d75sm48701697pga.66.2019.03.26.23.17.26
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 26 Mar 2019 23:17:27 -0700 (PDT)
Date: Wed, 27 Mar 2019 16:17:21 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2] kbuild: strip whitespace in cmd_record_mcount
 findstring
To: Joe Lawrence <joe.lawrence@redhat.com>, Masahiro Yamada
 <yamada.masahiro@socionext.com>
References: <20190325160438.8982-1-joe.lawrence@redhat.com>
 <CAK7LNARyD=tG0JhwN_mjdyDRSPAF8UoZKvqAT3Ah_v7GfymCPg@mail.gmail.com>
 <20190326173308.GA26546@redhat.com>
In-Reply-To: <20190326173308.GA26546@redhat.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1553667417.opxakvn5r6.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Joe Lawrence's on March 27, 2019 3:33 am:
> On Tue, Mar 26, 2019 at 02:29:47PM +0900, Masahiro Yamada wrote:
>> On Tue, Mar 26, 2019 at 1:05 AM Joe Lawrence <joe.lawrence@redhat.com> w=
rote:
>> >
>> > CC_FLAGS_FTRACE may contain trailing whitespace that interferes with
>> > findstring.
>> >
>> > For example, commit 6977f95e63b9 ("powerpc: avoid -mno-sched-epilog on
>> > GCC 4.9 and newer") introduced a change such that on my ppc64le box,
>> > CC_FLAGS_FTRACE=3D"-pg -mprofile-kernel ".  (Note the trailing space.)
>> > When cmd_record_mcount is now invoked, findstring fails as the ftrace
>> > flags were found at very end of _c_flags, without the trailing space.
>> >
>> >   _c_flags=3D" ... -pg -mprofile-kernel"
>> >   CC_FLAGS_FTRACE=3D"-pg -mprofile-kernel "
>> >                                        ^
>> >     findstring is looking for this extra space
>> >
>> > Remove the redundant whitespaces from CC_FLAGS_FTRACE in
>> > cmd_record_mcount to avoid this problem.
>> >
>> > Fixes: 6977f95e63b9 ("powerpc: avoid -mno-sched-epilog on GCC 4.9 and =
newer").
>> > Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
>> > ---
>> >
>> > Standard disclaimer: I'm not a kbuild expert, but this works around th=
e
>> > problem I reported where ftrace and livepatch self-tests were failing =
as
>> > specified object files were not run through the recordmcount.pl script=
:
>> >
>> > ppc64le: ftrace self-tests and $(CC_FLAGS_FTRACE) broken?
>> > https://lists.ozlabs.org/pipermail/linuxppc-dev/2019-March/187298.html
>> >
>> >  scripts/Makefile.build | 8 ++++----
>> >  1 file changed, 4 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
>> > index 2554a15ecf2b..74d402b5aa3c 100644
>> > --- a/scripts/Makefile.build
>> > +++ b/scripts/Makefile.build
>> > @@ -199,10 +199,10 @@ sub_cmd_record_mcount =3D perl $(srctree)/script=
s/recordmcount.pl "$(ARCH)" \
>> >         "$(if $(part-of-module),1,0)" "$(@)";
>> >  recordmcount_source :=3D $(srctree)/scripts/recordmcount.pl
>> >  endif # BUILD_C_RECORDMCOUNT
>> > -cmd_record_mcount =3D                                            \
>> > -       if [ "$(findstring $(CC_FLAGS_FTRACE),$(_c_flags))" =3D   \
>> > -            "$(CC_FLAGS_FTRACE)" ]; then                       \
>> > -               $(sub_cmd_record_mcount)                        \
>> > +cmd_record_mcount =3D                                                =
    \
>> > +       if [ "$(findstring $(strip $(CC_FLAGS_FTRACE)),$(_c_flags))" =
=3D  \
>> > +            "$(strip $(CC_FLAGS_FTRACE))" ]; then                    =
  \
>> > +               $(sub_cmd_record_mcount)                              =
  \
>> >         fi
>> >  endif # CC_USING_RECORD_MCOUNT
>> >  endif # CONFIG_FTRACE_MCOUNT_RECORD
>> > --
>> > 2.20.1
>> >
>>=20
>>=20
>>=20
>> I do not see a point in using the shell command here
>> in the first place.
>>=20
>> Instead of adding crappy workarounds,
>> I guess the following simple code should work:
>>=20
>>=20
>> index 2554a15..5f13021 100644
>> --- a/scripts/Makefile.build
>> +++ b/scripts/Makefile.build
>> @@ -199,11 +199,8 @@ sub_cmd_record_mcount =3D perl
>> $(srctree)/scripts/recordmcount.pl "$(ARCH)" \
>>         "$(if $(part-of-module),1,0)" "$(@)";
>>  recordmcount_source :=3D $(srctree)/scripts/recordmcount.pl
>>  endif # BUILD_C_RECORDMCOUNT
>> -cmd_record_mcount =3D                                            \
>> -       if [ "$(findstring $(CC_FLAGS_FTRACE),$(_c_flags))" =3D   \
>> -            "$(CC_FLAGS_FTRACE)" ]; then                       \
>> -               $(sub_cmd_record_mcount)                        \
>> -       fi
>> +cmd_record_mcount =3D $(if $(findstring $(CC_FLAGS_FTRACE),$(_c_flags))=
,\
>> +                 $(sub_cmd_record_mcount))
>>  endif # CC_USING_RECORD_MCOUNT
>>  endif # CONFIG_FTRACE_MCOUNT_RECORD
>>=20
>=20
> Hi Masahiro,
>=20
> Agreed on the shell command ugliness, however I still think we need to
> strip the search pattern here.  With your suggestion:
>=20
> % rm -f kernel/trace/trace_selftest_dynamic.o=20
> % make kernel/trace/trace_selftest_dynamic.o
>   CALL    scripts/checksyscalls.sh
>   CALL    scripts/atomic/check-atomics.sh
>   CC      kernel/trace/trace_selftest_dynamic.o
>=20
> % eu-readelf --sections kernel/trace/trace_selftest_dynamic.o | grep mcou=
nt
> (nothing)
>=20
> Adding it back as, as below, restores those sections and the self tests
> work again.

Thanks for finding and fixing this, nice work!

Thanks,
Nick

>=20
> Regards,
>=20
> -- Joe
>=20
> -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8--
>=20
> From 6a85e8ecf4179b3e80601a327ec43d8d49f0e3cd Mon Sep 17 00:00:00 2001
> From: Joe Lawrence <joe.lawrence@redhat.com>
> Date: Tue, 26 Mar 2019 10:50:28 -0400
> Subject: [PATCH v2] kbuild: strip whitespace in cmd_record_mcount findstr=
ing
>=20
> CC_FLAGS_FTRACE may contain trailing whitespace that interferes with
> findstring.
>=20
> For example, commit 6977f95e63b9 ("powerpc: avoid -mno-sched-epilog on
> GCC 4.9 and newer") introduced a change such that on my ppc64le box,
> CC_FLAGS_FTRACE=3D"-pg -mprofile-kernel ".  (Note the trailing space.)
> When cmd_record_mcount is now invoked, findstring fails as the ftrace
> flags were found at very end of _c_flags, without the trailing space.
>=20
>   _c_flags=3D" ... -pg -mprofile-kernel"
>   CC_FLAGS_FTRACE=3D"-pg -mprofile-kernel "
>                                        ^
>     findstring is looking for this extra space
>=20
> Remove the redundant whitespaces from CC_FLAGS_FTRACE in
> cmd_record_mcount to avoid this problem.
>=20
> Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com> (refactorin=
g)
> Fixes: 6977f95e63b9 ("powerpc: avoid -mno-sched-epilog on GCC 4.9 and new=
er").
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> ---
>  scripts/Makefile.build | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 2554a15ecf2b..76ca30cc4791 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -199,11 +199,8 @@ sub_cmd_record_mcount =3D perl $(srctree)/scripts/re=
cordmcount.pl "$(ARCH)" \
>  	"$(if $(part-of-module),1,0)" "$(@)";
>  recordmcount_source :=3D $(srctree)/scripts/recordmcount.pl
>  endif # BUILD_C_RECORDMCOUNT
> -cmd_record_mcount =3D						\
> -	if [ "$(findstring $(CC_FLAGS_FTRACE),$(_c_flags))" =3D	\
> -	     "$(CC_FLAGS_FTRACE)" ]; then			\
> -		$(sub_cmd_record_mcount)			\
> -	fi
> +cmd_record_mcount =3D $(if $(findstring $(strip $(CC_FLAGS_FTRACE)),$(_c=
_flags)),	\
> +	$(sub_cmd_record_mcount))
>  endif # CC_USING_RECORD_MCOUNT
>  endif # CONFIG_FTRACE_MCOUNT_RECORD
> =20
> --=20
> 2.20.1
>=20
>=20
=
