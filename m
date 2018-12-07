Return-Path: <SRS0=Xegb=OQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFF9C07E85
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 06:31:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B44E620838
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 06:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ae2OOy9X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B44E620838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43B2gZ5CF4zDqyh
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 17:31:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ae2OOy9X";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::143; helo=mail-it1-x143.google.com;
 envelope-from=firoz.khan@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ae2OOy9X"; 
 dkim-atps=neutral
Received: from mail-it1-x143.google.com (mail-it1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43B2L44FfQzDrfb
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 17:16:44 +1100 (AEDT)
Received: by mail-it1-x143.google.com with SMTP id c9so5512528itj.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Dec 2018 22:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=998y8pHq+kRnZsu/gJjJwmjSGRxH1Yh1ButahyP6q18=;
 b=Ae2OOy9X9FFuQB1eDZsoI1QniElK5oK8FpFiO+UbB6HkzU0sSIQJLlVCMtO0gqn3I0
 YmR6Coi+LqbN0lZmULOH0rVHI17CulqxScSn+VP9MqkmWr2g1D2Gbatewkq9FAKkswVu
 aMt5DQmzKkK3I8N0sX6S+lfR0rPwKZRu/jhVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=998y8pHq+kRnZsu/gJjJwmjSGRxH1Yh1ButahyP6q18=;
 b=TkvXNBZxtSfdDdofezcMudqoxzMBa9ZAoFzdHyye2s2XMqfTiR2MzMzeJCRxUeLvht
 HwRZhciRJsQNhn8FQTPZHH69oxxDTQuspf7ccrlQv1Lz3VtwXVzS2V27su8xccHW1P2p
 7WfDU37H23KPdFrC6313+N8AdO1dc0ZLl1se1Mo2afjlHNxLxx8LLgOmSSvQ42FPvmtA
 EamQe2dO+19JNUyU/wVyTszupThG3dKozcs4ke+1I+cPjha0SiBFEoCfVEVZJwlTZOP2
 rspa1vYxrED+mHoRtly+7SZxWNEJBW52eOiWBAi3pfGPZdA0y5cUx3NVkDxCk2qFqalS
 Uc4w==
X-Gm-Message-State: AA+aEWZROeggAFzyPTX0StnE0f5z3drTUR4kInXBj9m6Uze6XWRseiEK
 cCAnfJetIHJLCCl3538FN77K2lxnmIUoz6RApbyc0B45pWc=
X-Google-Smtp-Source: AFSGD/U3+GgbDTRzz1OZtRERgH0dFuTzHXMWawglO6JkGEH+J6GdvUuc5VzR68E6FWURnkzhHDqKckh1X8wBgdres7k=
X-Received: by 2002:a05:660c:12c7:: with SMTP id
 k7mr1060805itd.148.1544163402432; 
 Thu, 06 Dec 2018 22:16:42 -0800 (PST)
MIME-Version: 1.0
References: <1544163100-15510-1-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1544163100-15510-1-git-send-email-firoz.khan@linaro.org>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Fri, 7 Dec 2018 11:46:30 +0530
Message-ID: <CALxhOnij8xO1yyZ87HX_jE8YdE-PbEe9a=yu50wvORnn-0_UvQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] powerpc: system call table generation support
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, 
 Michael Ellerman <mpe@ellerman.id.au>, Ram Pai <linuxram@us.ibm.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Breno Leitao <leitao@debian.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>, 
 Thomas Gleixner <tglx@linutronix.de>,
 Kate Stewart <kstewart@linuxfoundation.org>
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
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Deepa Dinamani <deepa.kernel@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

++ sathnaga@linux.vnet.ibm.com,

Hi Satheesh,

On Fri, 7 Dec 2018 at 11:42, Firoz Khan <firoz.khan@linaro.org> wrote:
>
>
> Changes since v3:
>  - split compat syscall table out from native table.
>  - modified the script to add new line in the generated
>    file.

I have fixed few major issue. Could you perform boot test with v4
on the platform.

Thanks
Firoz
