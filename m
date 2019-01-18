Return-Path: <SRS0=AYvg=P2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7165FC43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 10:07:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 966A020855
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 10:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9KOX/kp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 966A020855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43gxSr2qCkzDqyH
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 21:07:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::244; helo=mail-lj1-x244.google.com;
 envelope-from=jrdr.linux@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="A9KOX/kp"; 
 dkim-atps=neutral
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com
 [IPv6:2a00:1450:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43gxQ60lSBzDqsK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 21:05:01 +1100 (AEDT)
Received: by mail-lj1-x244.google.com with SMTP id k15-v6so11119306ljc.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 02:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kJ205dDi2ixFxpwP81y40GqDgkPxHnuU8GfUzsPelD8=;
 b=A9KOX/kpqZbpPIy0I6Di6wJ5o+OX4oKK7d0Vv9Sc2FtnKpKWKdia/iphS6MQ+N15Ht
 PisSwgt/8rbBNw7EXqtoWWFEfRHjGVjHiQE3F1ff1g1IB8jUp7C2GXFOhX0xnEYfk4lG
 OSWOHdZREl+zBkxAyUR+8Wcy7du0FvXsmAfx3a0ExjaKu3TI4T0cXoleykd2jZXQnyTC
 EUfjn1MG6rebWXnqfqozD80vjQLNqR5XMYR+SHqRtbRHRrZvilcmZKv6aCBYN6BYi/0h
 jUwKQMX2aPPimsgX5pan9ga9+88ffj+KeTz9jja9dC7X/vYF6BQc1mgdOxtjFE3olvNC
 M9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kJ205dDi2ixFxpwP81y40GqDgkPxHnuU8GfUzsPelD8=;
 b=WoQgCB4nrcZGZ5RNRFjiGmSVZCzZ5PU0hTEfeekz5yMYHbpvfs0/wSYd1bajOHaYDd
 SpUQXuxiMEtlURJv2PmqPH9QwFgXj2/OWNd93Jhje6x3wnjBmbq1v+lTknspWwUiihks
 03rkr0TpbQT6XmOODy1o6MJmn61ns/AR2s6GbOVWGbL9hm2NljS7gjidAdgCUilEXgNV
 OzY1//WFKd8OHQk8DK05gckc/+7Pi3aYCSEiKedxoTjeApo9HcuAXKz7OrkpO+Ps4YNs
 PHyFSUOm3HTeDfeSVO7tor63L9BqVWz1tkhn64Eol9Z1wxPJUlkJ1KkjSZKwbBs3tRMz
 dKvw==
X-Gm-Message-State: AJcUukdwIkPb6EfZMhwzSLbw6PUySEAICOSjLSNHeNP+dGvDXEFcgzja
 R/WiXx4B7FZfvDwCu7EzokShzQ1QjoTa4C04OjA=
X-Google-Smtp-Source: ALg8bN44e0Tjf3vXDjWe2aMD8Rf88ITASC4bEdArFLMOYmy9qUKgA33sXrtBVKA0hIRH8WNf9S58QEquyYgPgD8HaMI=
X-Received: by 2002:a2e:3012:: with SMTP id
 w18-v6mr11289731ljw.75.1547805898424; 
 Fri, 18 Jan 2019 02:04:58 -0800 (PST)
MIME-Version: 1.0
References: <5c40a8fd.1c69fb81.e4b1b.8f85@mx.google.com>
In-Reply-To: <5c40a8fd.1c69fb81.e4b1b.8f85@mx.google.com>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Fri, 18 Jan 2019 15:34:45 +0530
Message-ID: <CAFqt6zbyZnk3vAnRHV0JsXpVF=HxoC-WA9x434R+k36b0vtKzA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/powernv: Remove duplicate header
To: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
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
Cc: Brajeswar Ghosh <brajeswar.linux@gmail.com>, linux-kernel@vger.kernel.org,
 npiggin@gmail.com, paulus@samba.org, oohall@gmail.com, msuchanek@suse.de,
 linuxppc-dev@lists.ozlabs.org, haren@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jan 17, 2019 at 9:40 PM Sabyasachi Gupta
<sabyasachi.linux@gmail.com> wrote:
>
> Remove linux/printk.h which is included more than once.
>
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>

Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

> ---
>  arch/powerpc/platforms/powernv/opal.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index beed86f..802de0d 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -26,7 +26,6 @@
>  #include <linux/memblock.h>
>  #include <linux/kthread.h>
>  #include <linux/freezer.h>
> -#include <linux/printk.h>
>  #include <linux/kmsg_dump.h>
>  #include <linux/console.h>
>  #include <linux/sched/debug.h>
> --
> 2.7.4
>
