Return-Path: <SRS0=8mZb=HF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633E9C433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 02:43:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE5EA64E41
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 02:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE5EA64E41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DVmFH0MWYzDwk4
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 13:42:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::e34;
 helo=mail-vs1-xe34.google.com; envelope-from=emil.l.velikov@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=P5+gYqPz; dkim-atps=neutral
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com
 [IPv6:2607:f8b0:4864:20::e34])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DVX9d1tSRzDqt3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2021 04:38:56 +1100 (AEDT)
Received: by mail-vs1-xe34.google.com with SMTP id u127so849103vsc.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Feb 2021 09:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eHAW1mrB7zvHhh97f0tcropb/e113NgWFEAjP6gLbCQ=;
 b=P5+gYqPz5l2mFlVKQREHmz6Kr0fA/RiH9maBRKb+UIPpLrmJCqO0uZtlprkvOcVC7R
 zfLNlUQD86NkP+ifjcEWmIBbuauC+qpY41TpCmhwHtmog0l7nn9JmHrn+u+THmtLIdRH
 0KnCTzdZzCy8vq0biUzKHV1wh4EBiZ9oAhpnAVrPJLt++k/V0XTB8bMDbd3Qdhisf4xn
 zldT4XKEDyVCBwD/nZj1eNAdMGt3Bg7tXjS8x0Jxcv2kvkr0eEq97P/HBzukApwh349g
 hMt5JK//cZJtHt8GTmxsjoMa4oHwEaTmQsEBjy8RLtIA7UYf87pdqgL7wYkBBpfw2voR
 5vXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eHAW1mrB7zvHhh97f0tcropb/e113NgWFEAjP6gLbCQ=;
 b=WgBfcs5oUG6jEzZNSHjjkhGHidmEyFxDe2CL21vTBA0RCNtcX+oihdkMaaUbzK0G7n
 Cr0e5074GDL6uRPJQEDHorugQ7ElR+eNqsh0a1FL/lZB1cyGymK+6c6oX8WXzvwMZ3n5
 vwt7sn9+oeQ4D8RNJij+8SF09AgExbihqmmbY7Hwzb1sP5+PVC0YdI3pp1O8B7PFOpGK
 23kaIJGvkGZEQB8jaQIVA/8HQIBgr8VPKnYLXV3e+uEkfBnM1w4lP85pvtP0ty9ySJd5
 lWWweX6lq0B0I+0JTxYX15777J4Tk2zNBWmyNl2h8n9+ybjSuBcujtN+WH86j0aLNEXU
 PDvw==
X-Gm-Message-State: AOAM533+p8vMF7+wb+rKgKlmFNV+c6UlkMat6b7hnDlVmWO8+gfhE/jA
 bQw8irxb25meRv5LDZ9jixgpH6N7NIiVDtSLNFc=
X-Google-Smtp-Source: ABdhPJxr6UuPLfiTQWU0PtI4KjGAd7lT5wP47Eg2A5ysqKhDWcwimMgCtP8JDHk8rXFO/C2SX4AsHulH76L2ZXyS3BI=
X-Received: by 2002:a05:6102:96:: with SMTP id
 t22mr13599418vsp.22.1612287530852; 
 Tue, 02 Feb 2021 09:38:50 -0800 (PST)
MIME-Version: 1.0
References: <20210202121334.1361503-1-hch@lst.de> <YBljkDgMFcqKcH8H@gunter>
In-Reply-To: <YBljkDgMFcqKcH8H@gunter>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Tue, 2 Feb 2021 17:38:39 +0000
Message-ID: <CACvgo50f0d9fYZ+n4nSBOCgaGpe=x6_tfXPPGB2FiDVwGgaAJA@mail.gmail.com>
Subject: Re: module loader dead code removal and cleanups v3
To: Jessica Yu <jeyu@kernel.org>
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
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Andrew Donnellan <ajd@linux.ibm.com>, linux-kbuild@vger.kernel.org,
 David Airlie <airlied@linux.ie>, Masahiro Yamada <masahiroy@kernel.org>,
 Jiri Kosina <jikos@kernel.org>,
 "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
 ML dri-devel <dri-devel@lists.freedesktop.org>,
 Michal Marek <michal.lkml@markovi.net>,
 Thomas Zimmermann <tzimmermann@suse.de>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Frederic Barrat <fbarrat@linux.ibm.com>, live-patching@vger.kernel.org,
 Miroslav Benes <mbenes@suse.cz>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Jessica,

On Tue, 2 Feb 2021 at 14:37, Jessica Yu <jeyu@kernel.org> wrote:
>
> +++ Christoph Hellwig [02/02/21 13:13 +0100]:
> >Hi all,
> >
> >this series removes support for long term unused export types and
> >cleans up various loose ends in the module loader.
> >
> >Changes since v2:
> > - clean up klp_find_object_symbol a bit
> > - remove the now unused module_assert_mutex helper
> >
> >Changes since v1:
> > - move struct symsearch to module.c
> > - rework drm to not call find_module at all
> > - allow RCU-sched locking for find_module
> > - keep find_module as a public API instead of module_loaded
> > - update a few comments and commit logs
>
> Thanks Christoph for cleaning up all that aged cruft, and thanks everyone
> for the reviews.
>
> I was curious about EXPORT_SYMBOL_GPL_FUTURE and EXPORT_UNUSED_SYMBOL
> variants, and found that most of that stuff was introduced between
> 2006 - 2008. All the of the unused symbols were removed and gpl future
> symbols were converted to gpl quite a long time ago, and I don't
> believe these export types have been used ever since. So I
> think it's safe to retire those export types now.
>
I believe you're spot on - based on reading through git log and
checking the ML archives.

Shame I didn't get to finish a similar series I had locally. Patches
11-13 match what I have here so:
Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>

HTH
-Emil
