Return-Path: <SRS0=Lr1k=PM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162DFC43387
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 23:07:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA2C0218D8
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 23:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA2C0218D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43WgRq3VPSzDqRK
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Jan 2019 10:07:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.85.208.193; helo=mail-lj1-f193.google.com;
 envelope-from=mcroce@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
 [209.85.208.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Wdp83K8nzDqCk
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Jan 2019 08:53:36 +1100 (AEDT)
Received: by mail-lj1-f193.google.com with SMTP id t18-v6so33572321ljd.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Jan 2019 13:53:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rqrEaa2IDhOyDSyvJII217LpaLn9TnknhPAbYP5ID8Q=;
 b=fV83fAdzZTE7LoCM+nax0U76NnhSH5VQku66u7+Alxt4oXihZkUB76j+q9NnjHpzOQ
 g0tsJo18HfOXL2uybMOzuMkZVeROusA6vtPS3GgAyWJMdkZpFYsHEbEBLIS7G1fyIreG
 b7N8LNOAwdCXcgrlAGE5zT0g7ia+ZEAa8p1QCLs/zuGvoWBy8WX7bDXz76sDZ9mhFzgJ
 hsLxwr2PItSZPaU/ftABw1HsFHVnRwWOUp62cL4i4w36L1qPrYgpPVKfaHpzHW3UHxl/
 Elt0Qgz9OlEe9ITc769PUS70snuwmuQ0aU4wbR2yHNxgdhlHyu8Zkc90QaGa4xhnwKNH
 W2ZA==
X-Gm-Message-State: AJcUukdHRA8VBopCrl9pOPrteAUPGMkf2gkxW4rUOX06Iwr/WQmmxQMe
 kaH98egtjDLPP6ABzB+LzuVzTTD/Ax6Vj9z+0/JsfuVfqHzGuw==
X-Google-Smtp-Source: ALg8bN6G6scIJQLISSFs1snIq0Z2SFn8ttMhaFi1ApqAgZmGvKRVCLtw3JijjmmVXklvB3/2VKeTkPOWCXQfdpNtqkA=
X-Received: by 2002:a2e:9017:: with SMTP id
 h23-v6mr25239566ljg.71.1546638813103; 
 Fri, 04 Jan 2019 13:53:33 -0800 (PST)
MIME-Version: 1.0
References: <20190104213152.28602-1-mcroce@redhat.com>
In-Reply-To: <20190104213152.28602-1-mcroce@redhat.com>
From: Matteo Croce <mcroce@redhat.com>
Date: Fri, 4 Jan 2019 22:52:57 +0100
Message-ID: <CAGnkfhygD+7MJL-a6ba3VGb27_Z1Y-p3M1Dyymbt_CjKoo4Fcw@mail.gmail.com>
Subject: Re: [PATCH 02/12] powerpc/hvsi: fix typo
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 05 Jan 2019 10:00:31 +1100
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Jan 4, 2019 at 10:31 PM Matteo Croce <mcroce@redhat.com> wrote:
>
> Fix spelling mistake: "lenght" -> "length"
>
> Signed-off-by: Matteo Croce <mcroce@redhat.com>
> ---
>  arch/powerpc/include/asm/hvsi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Hi,

this patch was pulled from a 12 patches series and sent alone, please
discard the "02/12" in the subject

-- 
Matteo Croce
per aspera ad upstream
