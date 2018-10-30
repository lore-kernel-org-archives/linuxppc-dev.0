Return-Path: <SRS0=S6eX=NK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAF2C2BC61
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 12:45:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB51F20827
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 12:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="OZQbAhtA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB51F20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42krm91HGlzDsDx
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 23:45:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="OZQbAhtA";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.91; helo=conssluserg-06.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="OZQbAhtA"; 
 dkim-atps=neutral
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com
 [210.131.2.91])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42krgX0Hk7zDrYZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 23:41:27 +1100 (AEDT)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com
 [209.85.221.177]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id w9UCf5Qo010212
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 21:41:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w9UCf5Qo010212
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1540903266;
 bh=YairTKVKKa5Ofh3V0oC7nmntUB8w6vB+j3hvWIgrl34=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=OZQbAhtA0wZkrwpuuALWS+7IH/UDVnc+/8vIoV3/mpWAIOtMu5Hj7IkhDv+NKfxp/
 nEmAVFbywRBWKuFMLp66sKHLys1lyqhsTYPXElJ5AJ9t9gEWPmfpde+RHnoZqnmYPQ
 fheQ87JkY8odiyttli3jRscTD/HCdCK/8o6DYGaMYJVJkyzYloMWtiC+czQ7eDIkdw
 UduuFBb4xrCfvhtbWiV2P5vAKctX3YqFu0R3MdEp+0HH2X9pYvnYNJXl7miZUbNHm0
 iaCknZszfCqEJBzjt0Vgp9dUCs035ygGwG+Q+bOOFduODsiEBzrYxUAmrWasPzrIgJ
 OwSNNgLS+F1bA==
X-Nifty-SrcIP: [209.85.221.177]
Received: by mail-vk1-f177.google.com with SMTP id o10-v6so2942412vki.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 05:41:05 -0700 (PDT)
X-Gm-Message-State: AGRZ1gJCNr2nKgrWCuJu0mc26HwECvQUHDV7cN3a1zfySH+/hfn+nhzo
 7aRVN3RVz2SIzj9pLT7GSnHPUV2BGQMfzuQK+zU=
X-Google-Smtp-Source: AJdET5eEUF99L4FtC2VlzofrvfFd1ZV/6/+V52Td1Afdq8arw8wITWqX1xauzd2VFT59Ji2hh1utOYimeSPgwecHJyM=
X-Received: by 2002:a1f:c08e:: with SMTP id q136mr7771310vkf.84.1540903264092; 
 Tue, 30 Oct 2018 05:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <1540873293-29817-1-git-send-email-yamada.masahiro@socionext.com>
 <877ehzk3we.fsf@concordia.ellerman.id.au>
In-Reply-To: <877ehzk3we.fsf@concordia.ellerman.id.au>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 30 Oct 2018 21:40:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNASrdToqTrffe5XD+_LuK9+0=Bv8L_7ZWeN6iSivYe8Gmg@mail.gmail.com>
Message-ID: <CAK7LNASrdToqTrffe5XD+_LuK9+0=Bv8L_7ZWeN6iSivYe8Gmg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: replace cc-name test with CONFIG_CC_IS_CLANG
To: Michael Ellerman <mpe@ellerman.id.au>
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
Cc: Linux-MIPS <linux-mips@linux-mips.org>,
 Michal Marek <michal.lkml@markovi.net>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 James Hogan <jhogan@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Oct 30, 2018 at 9:36 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Masahiro Yamada <yamada.masahiro@socionext.com> writes:
> > diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> > index 17be664..338e827 100644
> > --- a/arch/powerpc/Makefile
> > +++ b/arch/powerpc/Makefile
> > @@ -96,7 +96,7 @@ aflags-$(CONFIG_CPU_BIG_ENDIAN)             += $(call cc-option,-mabi=elfv1)
> >  aflags-$(CONFIG_CPU_LITTLE_ENDIAN)   += -mabi=elfv2
> >  endif
> >
> > -ifneq ($(cc-name),clang)
> > +ifneq ($(CONFIG_CC_IS_CLANG),y)
> >    cflags-$(CONFIG_CPU_LITTLE_ENDIAN) += -mno-strict-align
> >  endif
> >
> > @@ -175,7 +175,7 @@ endif
> >  # Work around gcc code-gen bugs with -pg / -fno-omit-frame-pointer in gcc <= 4.8
> >  # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=44199
> >  # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=52828
> > -ifneq ($(cc-name),clang)
> > +ifneq ($(CONFIG_CC_IS_CLANG),y)
> >  CC_FLAGS_FTRACE      += $(call cc-ifversion, -lt, 0409, -mno-sched-epilog)
> >  endif
> >  endif
>
> Does this behave like other CONFIG variables, ie. it will not be defined
> when it's false?

Right.


> And if so can't we use ifdef/ifndef? eg:
>
> ifndef CONFIG_CC_IS_CLANG
>   CC_FLAGS_FTRACE       += $(call cc-ifversion, -lt, 0409, -mno-sched-epilog)
>
> That reads cleaner to me.


OK, will do respin if you prefer ifdef/ifndef style.




> Still this patch is fine as is:
>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
>
> cheers



-- 
Best Regards
Masahiro Yamada
