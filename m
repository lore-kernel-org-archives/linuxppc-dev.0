Return-Path: <SRS0=wNeI=O2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5DFC43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 10:59:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 024D0206A2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 10:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hcqPXBJN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 024D0206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43JJ840dlwzDqW0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 21:59:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hcqPXBJN";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::d43; helo=mail-io1-xd43.google.com;
 envelope-from=firoz.khan@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="hcqPXBJN"; 
 dkim-atps=neutral
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com
 [IPv6:2607:f8b0:4864:20::d43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43JHmV3v7hzDqhm
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Dec 2018 21:42:50 +1100 (AEDT)
Received: by mail-io1-xd43.google.com with SMTP id w21so9645635ioc.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Dec 2018 02:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Da/nKj92LiTLzN6gmOjFat553E3Faps1ywC2IU+ZEuY=;
 b=hcqPXBJNPp0cw3G3qIdDYDrTqI5e33m0PsPlNlh59Rx4G5v3B9zffIJDNXtYgMWKgd
 eCDWB8nm1GIsRU61ArryN3fk4V59JXAu8GxEmscEG9ziLpJfFL9Qah3SmQNBNdeqIP7p
 Si4mF0GCHe+ME8cg9bIrF0tDWc4wmOFvlS34w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Da/nKj92LiTLzN6gmOjFat553E3Faps1ywC2IU+ZEuY=;
 b=Y8xya+CIOk/R3FkqoDRhWB/egbHQbSdW0gsBGRLrs0DiAAs6lUWnQzqB4/sZVjXn56
 5npTpUSQF0TrBmo+TRsdEI819KW5p4o12hpo+SqkPA4T92NnQH7IyQXMCGwncsjrDN5B
 SevwTbQGIzbz6f6YDyP/9GBsQgAtdpGvlh05dS+3c4P0V395Y/+d+hMo1oePQLAqKhxx
 KGSWexG1Uk868Z6xZF6/3I3B1zRsxtOq08oljXzrOnRHI82bHE2/lJMJjtQNKSwzve4x
 3+d4rWbHMNzLZypgljkJbodlO5tCjwfuGWnqLFLwEAsVkoOgG8niSelN7tJWEcTJbDr5
 GJsw==
X-Gm-Message-State: AA+aEWaIQxCb7VaJsRoxPews0mCy5k1LuT694Mghvh5i1ceRObpTWIHr
 YiqjOZ1z2vRH5mXHu87+I+Q4fxoEd+BkK5ANt8naTOBy
X-Google-Smtp-Source: AFSGD/W/CyGsIm3JnHJ8Dm/5ZX0mKF10fQWtRwEhQJPJkvan2c0DCuxa2C9sboIoz9FjOr9wQ2SB4txgIsaZYRbvjNA=
X-Received: by 2002:a6b:6919:: with SMTP id e25mr10270672ioc.119.1545043368209; 
 Mon, 17 Dec 2018 02:42:48 -0800 (PST)
MIME-Version: 1.0
References: <1544691770-8938-1-git-send-email-firoz.khan@linaro.org>
 <20181217080846.GA28424@sathnaga86.in.ibm.com>
 <877eg8v40t.fsf@concordia.ellerman.id.au>
In-Reply-To: <877eg8v40t.fsf@concordia.ellerman.id.au>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Mon, 17 Dec 2018 16:12:37 +0530
Message-ID: <CALxhOnh5a86pBi4rD1YzhVGq7KPs56du9+G8vkt7zVAqbGkLEw@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] powerpc: system call table generation support
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
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
 Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 y2038 Mailman List <y2038@lists.linaro.org>, Boqun Feng <boqun.feng@gmail.com>,
 Philippe Ombredanne <pombredanne@nexb.com>, Ram Pai <linuxram@us.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Breno Leitao <leitao@debian.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Deepa Dinamani <deepa.kernel@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Michael,

On Mon, 17 Dec 2018 at 16:01, Michael Ellerman <mpe@ellerman.id.au> wrote:
> No it's fine if it applies on next.
>
> I can also fix up minor merge conflicts if there are any.

Ohh. I already rebased and sent v6.

Thanks
Firoz
