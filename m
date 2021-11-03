Return-Path: <SRS0=iwfG=PW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDE2C433F5
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Nov 2021 01:16:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D544760E73
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Nov 2021 01:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D544760E73
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HkTPk2J7Xz2ypV
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Nov 2021 12:16:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=paul-moore-com.20210112.gappssmtp.com header.i=@paul-moore-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=uykTM8Hx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=paul-moore.com
 (client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=paul@paul-moore.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=paul-moore-com.20210112.gappssmtp.com
 header.i=@paul-moore-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=uykTM8Hx; dkim-atps=neutral
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HkTNv73N5z2xDV
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Nov 2021 12:15:59 +1100 (AEDT)
Received: by mail-ed1-x52f.google.com with SMTP id m14so3717728edd.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Nov 2021 18:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2zvCgkl8b/Wk2WXewhtHuS7jVQtKJSDpG2z1kWhZOdM=;
 b=uykTM8HxpyxLVkotdRmBgm/2SOtdLqJVMmow3Brimq1l+k1IpMMBYMQDTKbf9Uqopa
 cglMT2z4t9An9rn1HEulyGcudPudiWgrcquv4K043IbjUE4kFIWDCA18NzyXZYh5RqK1
 XHBWl+rE8w276wo6+oOmuhiIYH1ask4vFt3ZCVqyc0JDT14mCcxaXhBDTaYJwm93N2br
 /wAdiZpw3UMWJyBiDEDSe95V3IBRQrIh+Ocz+3RfJo/+Og1FiOQqwQ7dTHuGqznDFBUG
 8pxaSW0+NDWjkm2NdqKgaIxE+5XMhDfwLsyK0eIiNYyVwCHLRyROLsRmi3Fyg8Rg/D5b
 hB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2zvCgkl8b/Wk2WXewhtHuS7jVQtKJSDpG2z1kWhZOdM=;
 b=hc29+r4DpOQLZtDJyzmk+2oE8upRp/Lo4V/rgFZVG1wboaBC+aVI/FuG+f19nHH8FP
 wizAH51fGi15J2BuhMKXehmJkGJsv5D7JAZDdJ2jFP1GhXg7aBB2WWhuSsO3bpF4P6Gi
 tO+OTN2POK2yqxvsdRNDqT6DNTkv1KECecy0F/6IHtPmce2WpdUkDBkXUW7KnnLT78TP
 TEUBCeUOmiHsUK8YqLVUHuvdAt5zWUMCVZmpqZMftOvXVW1xGGHPffiKwr8U9PLlUAlE
 3+d7JFUy/YwgpBlvtk/ciwUHG+i2vv78Dzl7TUlHyRSSj6o9YQzaBbZcxyCYGmH+IqiJ
 7bcw==
X-Gm-Message-State: AOAM530uQCc7KfITi5uF0Cbi1grIaqyjivgaBa9v5LQJd1wdNAZaKBxp
 xJmGsxDTyPX6snnJatpuycCjt+zPtBJt5Q6oKM0i
X-Google-Smtp-Source: ABdhPJw2IoBOCByQEbw64BV12T8gdoTquNYioInlmW8yGRuMELWdpjO3NsBKnoAwGpJD+HKDnG8w7r4XDNEc9GMsbLQ=
X-Received: by 2002:a17:907:629b:: with SMTP id
 nd27mr49347316ejc.24.1635902149830; 
 Tue, 02 Nov 2021 18:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <a4b3951d1191d4183d92a07a6097566bde60d00a.1629812058.git.christophe.leroy@csgroup.eu>
 <163584790624.1845480.1785827913484538939.b4-ty@ellerman.id.au>
 <CAHC9VhROvSQHVQ6Wo8zHND1rGm+r6dGJur69B65sJ9JwNvMDpQ@mail.gmail.com>
 <87a6im87tq.fsf@mpe.ellerman.id.au>
In-Reply-To: <87a6im87tq.fsf@mpe.ellerman.id.au>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 2 Nov 2021 21:15:38 -0400
Message-ID: <CAHC9VhSXVc534jzZ9bSD5fbuJpaGY=mswv4crOW28y7AjhG7Tg@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] powerpc/audit: Convert powerpc to
 AUDIT_ARCH_COMPAT_GENERIC
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
Cc: patch-notifications@ellerman.id.au, linux-kernel@vger.kernel.org,
 linux-audit@redhat.com, Paul Mackerras <paulus@samba.org>,
 Eric Paris <eparis@redhat.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Nov 2, 2021 at 7:19 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
> Paul Moore <paul@paul-moore.com> writes:
> > On Tue, Nov 2, 2021 at 7:38 AM Michael Ellerman
> > <patch-notifications@ellerman.id.au> wrote:
> >>
> >> On Tue, 24 Aug 2021 13:36:13 +0000 (UTC), Christophe Leroy wrote:
> >> > Commit e65e1fc2d24b ("[PATCH] syscall class hookup for all normal
> >> > targets") added generic support for AUDIT but that didn't include
> >> > support for bi-arch like powerpc.
> >> >
> >> > Commit 4b58841149dc ("audit: Add generic compat syscall support")
> >> > added generic support for bi-arch.
> >> >
> >> > [...]
> >>
> >> Applied to powerpc/next.
> >>
> >> [1/1] powerpc/audit: Convert powerpc to AUDIT_ARCH_COMPAT_GENERIC
> >>       https://git.kernel.org/powerpc/c/566af8cda399c088763d07464463dc871c943b54
> >
> > Did the test failure discussed earlier in this thread ever get
> > resolved?  If not, this really shouldn't be in linux-next IMO.
>
> It's not in next, that notification is from the b4 thanks script, which
> didn't notice that the commit has since been reverted.

Okay, thanks for the clarification.  I know we had already talked
about this so I was a little caught off guard when I saw this mail :)

-- 
paul moore
www.paul-moore.com
