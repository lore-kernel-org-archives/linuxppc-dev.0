Return-Path: <SRS0=qVND=NW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC16C432BE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Aug 2021 13:50:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED7346056B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Aug 2021 13:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ED7346056B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GzT9Q0zWsz2yNp
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Aug 2021 23:50:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.a=rsa-sha256 header.s=20150623 header.b=1dVdeB6E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=paul-moore.com
 (client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=paul@paul-moore.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=paul-moore-com.20150623.gappssmtp.com
 header.i=@paul-moore-com.20150623.gappssmtp.com header.a=rsa-sha256
 header.s=20150623 header.b=1dVdeB6E; dkim-atps=neutral
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GzT8d5QVnz2xZs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Aug 2021 23:50:09 +1000 (AEST)
Received: by mail-ed1-x534.google.com with SMTP id r7so10918190edd.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Aug 2021 06:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zPX1Cx6i1wGAaNv/FyWRibhoHk490fta5weo1iPmB0Q=;
 b=1dVdeB6E9D4+m134wRVReiHxIto9X5gCIKMBqQuRf87ES60DlT5paBnu3uA0Wer4x2
 ny9wiMkfWtxR/Jww/CTgv66he1SAsLUUk4ZAaPnUDD7UQXXtjtzbdc+HxNbFcOEoioPZ
 sWNnXfuuI79IjoTQAcbKSmuJHP3Pa07T+UStcaM7PpYUDsRZ3uWHw5aadzlmR7mU2GZH
 bnWGy6bUdTewhMMNj8Hj6SXb1IQeqDl6BCCCD4dcaRuCou3iF3gxiKz6qIn1+GeXI9aR
 espETnz/DEToQCnl5tcSCsCNxkJSLAEYfd4DKxlRK25cwk2hHeKRLRS2xX8IbcrVxPCv
 7M6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zPX1Cx6i1wGAaNv/FyWRibhoHk490fta5weo1iPmB0Q=;
 b=cKuu2E/wFXIAKdz2coUMAQToX+8zaTUHCXp80ajo0T9OwTotIjotvLmbAFSpvZPiii
 KrHUld0P5xFz3C4pyz4Bp7dkpjMSTWQmp9VUxtbKK9Ul/oWzG9/9Bvbv2s0i9kumvd+W
 lscbdCEtIFS/mBQGCzdtgr853LFFrDYpe7yeQmPfgK3wTvzgKqm8Lg5vWJuwp68dxdvm
 ATAR3zax3mveOvQdPUc4T2EfNfiSDfseXxhy7TZgd3MaFE3OUpLwFU/pGcWExMqMbfNe
 xTdxngtxM9X6TjAATubKLtSLq4I4wP8AB4uydzpTi+pgTjzDDVI8pNTRsRWpWqjoxSm8
 DGlw==
X-Gm-Message-State: AOAM531Uk016hq6lt+7I2N9F6m4GPjJ5g1OBzkCWogzzB6ScuvLXet8i
 zoh3eX2Pj0V0RuEPNI8hLoAv+Y5btr7cJJ5MesjM
X-Google-Smtp-Source: ABdhPJyGDT7sjKnvAaslCh6VU3oeZudwS5qG9rubETPaZxPkqNoONMqbRw1AEONbP0PiecvVT5WPlpdCnWvYhqaPj8Q=
X-Received: by 2002:a05:6402:4cf:: with SMTP id
 n15mr30404106edw.269.1630417801745; 
 Tue, 31 Aug 2021 06:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210616085118.1141101-1-omosnace@redhat.com>
 <CAHC9VhSr2KpeBXuyoHR3_hs+qczFUaBx0oCSMfBBA5UNYU+0KA@mail.gmail.com>
 <CAFqZXNvJtMOfLk-SLt2S2qt=+-x8fm9jS3NKxFoT0_5d2=8Ckg@mail.gmail.com>
In-Reply-To: <CAFqZXNvJtMOfLk-SLt2S2qt=+-x8fm9jS3NKxFoT0_5d2=8Ckg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 31 Aug 2021 09:49:50 -0400
Message-ID: <CAHC9VhRdh0uTBur8PHOR4bL38rQozatO7J2fwEzZiLwRXLL7fg@mail.gmail.com>
Subject: Re: [PATCH v3] lockdown,selinux: fix wrong subject in some SELinux
 lockdown checks
To: Ondrej Mosnacek <omosnace@redhat.com>
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
Cc: linux-efi@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-cxl@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, x86@kernel.org,
 James Morris <jmorris@namei.org>, linux-acpi@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, linux-serial@vger.kernel.org,
 linux-pm@vger.kernel.org, SElinux list <selinux@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Casey Schaufler <casey@schaufler-ca.com>,
 network dev <netdev@vger.kernel.org>,
 Stephen Smalley <stephen.smalley.work@gmail.com>, kexec@lists.infradead.org,
 Linux kernel mailing list <linux-kernel@vger.kernel.org>,
 Linux Security Module list <linux-security-module@vger.kernel.org>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, "David S . Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Aug 31, 2021 at 5:08 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> Can we move this forward somehow, please?

As mentioned previously, I can merge this via the SELinux tree but I
need to see some ACKs from the other subsystems first, not to mention
some resolution to the outstanding questions.

-- 
paul moore
www.paul-moore.com
