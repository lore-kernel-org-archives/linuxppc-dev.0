Return-Path: <SRS0=AYvg=P2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA55C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 06:42:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EBE420652
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 06:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="a2dm8hcx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EBE420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43grwD0jnbzDqsK
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 17:42:20 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43grtc591WzDqkJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 17:40:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="a2dm8hcx"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43grtc4Hxrz8sX5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 17:40:56 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43grtc3mh2z9sML; Fri, 18 Jan 2019 17:40:56 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::d42; helo=mail-io1-xd42.google.com;
 envelope-from=firoz.khan@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="a2dm8hcx"; 
 dkim-atps=neutral
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com
 [IPv6:2607:f8b0:4864:20::d42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43grtb4Y0sz9sLt
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2019 17:40:54 +1100 (AEDT)
Received: by mail-io1-xd42.google.com with SMTP id b23so9871476ios.10
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2019 22:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DivQhHVEK17txxqL8dBhADceyH1FHxo8gm6BaEKlYpg=;
 b=a2dm8hcxEUTIlZYOq5qkP+BCsKZiYHrT3Cvs/OCDOT2bTj++FJnJ44tQs/a7S5mB/t
 ezvhe1rY79vzUGB3DRZ7dBmRLYshO/6pevDBxOMhaWk/Owz57XSmVEY5/2GKUs6jM1zm
 /duiAgIohkuXjCGDnozBHbAHPV0GeLJjqC+FU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DivQhHVEK17txxqL8dBhADceyH1FHxo8gm6BaEKlYpg=;
 b=L8Ro4kb4A+hlj6QdZ0XGg4l3sCIegB58HYRdPzM5mw+63PXuoA8/JCq0n4lhY2hDXF
 D24EQ0zhR+wm2NJl5nolGpx5oG6EngsI4FtSH1A4Y81zgO1eoL84JEsHVyTbRd21kslq
 75q6YBw9v+oeLwVeoD7OJGeKyBT9tOipja4K5f6E2YrlsK6YTRUO9RWYAP9B20YOWfcB
 WVyKJG6SoTJAyTPyhkhpzH2w3B+uycTaD5a//CdFijTeuIPuNVAI0LQBpGY70u0v3Xz2
 OgTeUgmclX3bTq8OXjoUUxOUoeuhZRpWGQh9wvciuSOMCvya1ALluuYJ6ortk1GwSEQE
 cfXQ==
X-Gm-Message-State: AJcUukeXy9WFGvPMJFbWxsfxJdbnuFahd+eyYVatt0cVYtBSA7ZPH/ou
 zd+6epCZsQjbk4LBomdTlE0M4fmjj682eJ3rREL9Gg==
X-Google-Smtp-Source: ALg8bN6oVd/C2b+ihS782voX8q9CS85GOxQdLSAd+a3Ni/gsypF/libUzlFm8l9pY3GOxmyTAbG9mYGdyfpHZ9qEU10=
X-Received: by 2002:a6b:4106:: with SMTP id n6mr9549458ioa.171.1547793652874; 
 Thu, 17 Jan 2019 22:40:52 -0800 (PST)
MIME-Version: 1.0
References: <20190116132714.20094-1-mpe@ellerman.id.au>
 <20190116132714.20094-5-mpe@ellerman.id.au>
 <CAK8P3a2EmiT+hEmj40i1ihZM1ecK2Q42zknWNLRbgYeuOyJgrg@mail.gmail.com>
In-Reply-To: <CAK8P3a2EmiT+hEmj40i1ihZM1ecK2Q42zknWNLRbgYeuOyJgrg@mail.gmail.com>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Fri, 18 Jan 2019 12:10:41 +0530
Message-ID: <CALxhOniuaifL+y03AcTsOKkgUe_45JZXbTiMipOOXEM5yqV8dA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/5] powerpc/syscalls: Allow none instead of
 sys_ni_syscall
To: Arnd Bergmann <arnd@arndb.de>
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
Cc: linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Arnd,

On Wed, 16 Jan 2019 at 19:23, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Jan 16, 2019 at 2:27 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
> > @@ -24,28 +24,28 @@
> >  14     common  mknod                           sys_mknod
> >  15     common  chmod                           sys_chmod
> >  16     common  lchown                          sys_lchown
> > -17     common  break                           sys_ni_syscall
> > -18     32      oldstat                         sys_stat                        sys_ni_syscall
> > -18     64      oldstat                         sys_ni_syscall
> > +17     common  break                           none
> > +18     32      oldstat                         sys_stat                        none
> > +18     64      oldstat                         none
>
> The '64 oldstat' line can simply get dropped here, it has no value
> (I failed to notice this earlier).

The initial requirement is to replace uapi and syscalltbl file with
the script as it is.
If I'm right, for oldstat has uapi header and syscalltbl entry is
sys_ni_syscall. So
the above change will replace uapi and syscalltbl as it is.

We'll do a cleanup for all 10 architectures, so that time we can
remove this (and similer)
entries.

Thanks
Firoz
