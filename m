Return-Path: <SRS0=7Eaw=QE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F52FC282C8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 19:11:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C69AF20989
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 19:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbFy6eoo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C69AF20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43pK4T24NBzDqNL
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 06:11:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::241; helo=mail-lj1-x241.google.com;
 envelope-from=jrdr.linux@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="fbFy6eoo"; 
 dkim-atps=neutral
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com
 [IPv6:2a00:1450:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43pJwt1qy3zDqMv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 06:05:18 +1100 (AEDT)
Received: by mail-lj1-x241.google.com with SMTP id x85-v6so15266030ljb.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2019 11:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KLBtBGXi3hlTxbZLGrRdRNxgDb+OQSk2JyX0KtPuOm0=;
 b=fbFy6eooKBnPCjgoX3yEfus37O2C7wWdE7RkU3pSZF8JhIv6RWSANEdUvqIoX6DvjV
 Naua51jw5y0va2ez0qy6z1zhI/aeqLNqE83FrYBEsRzlsTbEt4qeGbJdN/VxTPLk7IfM
 9IJjyEK7MFHigbch5YF4Rv71dAV190/YbCYaXBQLTg4u8nOVMMRxILQX+yh2QOdzvwgs
 U/3OiRyRyFt6YWTpIyMn+xk9nEgpVkMjOrXdCIZwFoBITNm5QLwYayZF5sJam8G1RDF6
 0e74wbb27OQnulrXDdYV5nDu6lVFVh9xaomdulLqJl3lt6QyYx87pfRoi7Cw9qkGoChq
 om5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KLBtBGXi3hlTxbZLGrRdRNxgDb+OQSk2JyX0KtPuOm0=;
 b=a3jVd87B+42YZptihiLfpPy0ZWA42v6koXAIgJB0sn1azLhJYRVhZRvgsSnM1jDRqb
 Gv1a1pps9EPXac61L6I5WGCPsZrsVVQF/8qGd9Y9ksgHTtQW2PAh4btnuvmxASnSjkOR
 9ptpuN7ybk1djbBsC01RuJAXzXaLhbXwU0ysmhOievAOjiP1OH4+7iPBOKAEjPNu/A/Q
 SC7R8ejpmBg0bDUuIqR2jkP4kPeRutyP5I1tDl4GtfcC3L0GyD4EWhrPWWndBcAYfzbU
 yoNsGAxC55s0rA1eL9zFA5R9laBZzsmY8ehcCv8LQ3DT6RMyyzOrUYZMp6OjorUIUJV6
 m0JA==
X-Gm-Message-State: AJcUukcOUDEtL8obCR+DiNqa1IQr/W5F/kuLwi4rpQ417T7G6hioK6Il
 /eRdTM1d2CHXOod/9QKCsVHbjsl9mGT7QF5EcTc=
X-Google-Smtp-Source: ALg8bN5nuobWIeIPWqy+hB1cSR4Pu3LHtkKdP/LJevum907FwcbkIu/ncqDDOKeDHgeGGxamAg93g3QnVCoBjaitQtU=
X-Received: by 2002:a2e:8643:: with SMTP id
 i3-v6mr19612443ljj.43.1548702314824; 
 Mon, 28 Jan 2019 11:05:14 -0800 (PST)
MIME-Version: 1.0
References: <20190128161136.GA2266@hp-pavilion-15-notebook-pc-brajeswar>
In-Reply-To: <20190128161136.GA2266@hp-pavilion-15-notebook-pc-brajeswar>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Tue, 29 Jan 2019 00:35:01 +0530
Message-ID: <CAFqt6zbv-tMbv8JQdzHf7jjZPg3oGUk1H9gdnkbAvueBbemeow@mail.gmail.com>
Subject: Re: [PATCH] powerpc/kernel/time: Remove duplicate header
To: Brajeswar Ghosh <brajeswar.linux@gmail.com>
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
Cc: Arnd Bergmann <arnd@arndb.de>,
 Sabyasachi Gupta <sabyasachi.linux@gmail.com>, linux-kernel@vger.kernel.org,
 npiggin@gmail.com, paulus@samba.org, aneesh.kumar@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jan 28, 2019 at 9:41 PM Brajeswar Ghosh
<brajeswar.linux@gmail.com> wrote:
>
> Remove linux/rtc.h which is included more than once
>
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>

Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

> ---
>  arch/powerpc/kernel/time.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index 3646affae963..bc0503ef9c9c 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -57,7 +57,6 @@
>  #include <linux/irq_work.h>
>  #include <linux/clk-provider.h>
>  #include <linux/suspend.h>
> -#include <linux/rtc.h>
>  #include <linux/sched/cputime.h>
>  #include <linux/processor.h>
>  #include <asm/trace.h>
> --
> 2.17.1
>
