Return-Path: <SRS0=pcIm=NN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3D4C32789
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 16:40:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9C5020657
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 16:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fmHmgWsk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C5020657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42mnqX5hjBzF37b
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Nov 2018 03:40:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fmHmgWsk";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=2a00:1450:4864:20::144; helo=mail-lf1-x144.google.com;
 envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org
 header.b="fmHmgWsk"; dkim-atps=neutral
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com
 [IPv6:2a00:1450:4864:20::144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42mnn122fSzF35j
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Nov 2018 03:37:57 +1100 (AEDT)
Received: by mail-lf1-x144.google.com with SMTP id h192so1760030lfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Nov 2018 09:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YMtQVwW5HLRJnJy+IgvXD+FW8D0Noi+dI/SWfC0ibEk=;
 b=fmHmgWskuZcMw1lEzD3UvRrQDeleRHT8o+fUqDmA3QHCwvjMD2kwfOpygzeVkdSH39
 halRBw43KzA6uvxxELLh6nE9pRiHlT4EY07kdFtmsY7Kxrrp5pZ51SR9erkRAM0wWaii
 D13Yg1kHWhdWCUoKh/E8wxCURpjOOCs5EsXe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YMtQVwW5HLRJnJy+IgvXD+FW8D0Noi+dI/SWfC0ibEk=;
 b=FLfn8tc3ihnT0JwUNAYjfs1AXfXVVExZAlZtgQuG9NVTY4sqFaWouxH7myL2icM4Vs
 +NicrgMlLiDsBRdatrdjDptnP5/h/l54FXOZI4IH5W2m9K9OcnaNYpCzNn9V2GeQFi+I
 c0HhXuKT2pAHfoCqI+FsT547E2F1IHbr/skDGwhYNSTfGzlcXYn1kyf9X2VskYF3t2JE
 XEh8cbPZXikFot7d4OkRymI/6sozNJUBmbU6bETakiPHot6FkH1bK3o6Il1cqF4kkYjJ
 LxX+iXVD4Rl/A/t3BiVRtVVeZqnRLErI+ZzerpQycNyHQ9vWAh72GhNTmJrLnfm270xn
 jBdA==
X-Gm-Message-State: AGRZ1gLHQXouXVCIKM9iabm4+xKmDnl07kEvHAOM1ec1bMhSmIwBwS8z
 m0bkBc4ze/eD6MeW7wnP4wXjcULt5YK0iQ==
X-Google-Smtp-Source: AJdET5eCXEgSBuoEHgulzWBD44Znca6raL0w4QngdCIWtT94cJ424PQHvSSmeLluA+rDI7F8N+iCvw==
X-Received: by 2002:a19:4e59:: with SMTP id c86mr7629665lfb.132.1541176673190; 
 Fri, 02 Nov 2018 09:37:53 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com.
 [209.85.167.53])
 by smtp.gmail.com with ESMTPSA id m62-v6sm1319091lfg.56.2018.11.02.09.37.50
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 02 Nov 2018 09:37:51 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id d7-v6so1770340lfi.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Nov 2018 09:37:50 -0700 (PDT)
X-Received: by 2002:a19:982:: with SMTP id 124mr1705724lfj.138.1541176669963; 
 Fri, 02 Nov 2018 09:37:49 -0700 (PDT)
MIME-Version: 1.0
References: <874lczemmh.fsf@concordia.ellerman.id.au>
In-Reply-To: <874lczemmh.fsf@concordia.ellerman.id.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 2 Nov 2018 09:37:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiAtG1mQ0usihPbAgvo=R_z8fpkePsZfE8ozg=H2VME_g@mail.gmail.com>
Message-ID: <CAHk-=wiAtG1mQ0usihPbAgvo=R_z8fpkePsZfE8ozg=H2VME_g@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-4.20-2 tag
To: mpe@ellerman.id.au
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, oss@buserror.net,
 tyreld@linux.vnet.ibm.com, joel@jms.id.au, felipe.rechia@datacom.com.br,
 leitao@debian.org, aravinda@linux.vnet.ibm.com,
 naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 camelia.groza@nxp.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Nov 2, 2018 at 4:37 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> powerpc fixes for 4.20 #2

Pulled,

                    Linus
