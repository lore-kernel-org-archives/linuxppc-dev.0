Return-Path: <SRS0=IbMY=PZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19DFC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 11:51:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DA5420657
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 11:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA5420657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43gMq52FPTzDqpv
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 22:51:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.222.194; helo=mail-qk1-f194.google.com;
 envelope-from=breno.debian@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com
 [209.85.222.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43gMmn2lwMzDqdb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 22:49:12 +1100 (AEDT)
Received: by mail-qk1-f194.google.com with SMTP id y16so5783878qki.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 03:49:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VrkXYLFOreGPO2PvicgsOzrSETWH+R5V7cE6kyE8Wqg=;
 b=amb28rP+x+3OFzNZnWT+mnoCa3Irts48BhvBoD/gfd+yxR8MVXYriwrlfcccHHuRoJ
 tor+FY+hUzv1Df7UE8mbGu4GNRAAqVc9k8gd4mqelbQbchV3VGDiVvxmA5VNvWRJO1wV
 SD2ZB9/yvigVP12NBRwOZCyA3kfSdELn3GNB/6h2WSA+2FQD8nhkdO1VCVCeiGd4kapk
 ZBCISekrhyliAvteorc0cUjAQ4+fTiRXR641KZLI0OJN4CaT+6XSkrYfYghQ0YgEQvfp
 tvIduTQOUyuCTF/0Wg1uk39XnNrOSc/9Cj9b9wdmjVik9Q7cHryMqVo9UCEyseTLmafI
 WICA==
X-Gm-Message-State: AJcUukdO7g6lgV9eToMMzJScfwcl0riKZ/upPQpBw9gIWE7IajImAJie
 lD5DFCJZAGmIJ5oZtqEV5Lk=
X-Google-Smtp-Source: ALg8bN730DE2pd1omadwvvTI3LhgwRuKyKx88jiLOgM2pYbb8MsRCI/ubht6WXReE55cgy4u/Bd2ng==
X-Received: by 2002:a37:4f4e:: with SMTP id d75mr10436430qkb.257.1547725750893; 
 Thu, 17 Jan 2019 03:49:10 -0800 (PST)
Received: from [10.0.0.8] ([189.29.25.55])
 by smtp.gmail.com with ESMTPSA id d193sm66043110qka.91.2019.01.17.03.49.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Jan 2019 03:49:10 -0800 (PST)
Subject: Re: [PATCH] powerpc/tm: Limit TM code inside PPC_TRANSACTIONAL_MEM
To: Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
References: <1547039805-7979-1-git-send-email-leitao@debian.org>
 <20190116133600.BA78B2086D@mail.kernel.org>
From: Breno Leitao <leitao@debian.org>
Message-ID: <bc20e375-09a0-1672-f61c-f90375c31a61@debian.org>
Date: Thu, 17 Jan 2019 09:49:05 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190116133600.BA78B2086D@mail.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: mikey@neuling.org, stable@vger.kernel.org, gregkh@linuxfoundation.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

hi Sasha,

On 1/16/19 11:35 AM, Sasha Levin wrote:
> Hi,
> 
> [This is an automated email]
> 
> This commit has been processed because it contains a "Fixes:" tag,
> fixing commit: e1c3743e1a20 powerpc/tm: Set MSR[TS] just prior to recheckpoint.
> 
> The bot has tested the following trees: v4.20.2, v4.19.15, v4.14.93, v4.9.150.
> 
> v4.20.2: Failed to apply! Possible dependencies:
>     Unable to calculate
> 
> v4.19.15: Failed to apply! Possible dependencies:
>     Unable to calculate
> 
> v4.14.93: Failed to apply! Possible dependencies:
>     0d60619e1c0c ("powerpc: Add missing prototype for sys_debug_setcontext()")
>     67b464a89c21 ("powerpc/32: Mark both tmp variables as unused")
>     6f5b9f018f4c ("powerpc/tm: Unset MSR[TS] if not recheckpointing")
>     b53875c4b4f2 ("powerpc: Add missing prototypes for sys_sigreturn() & sys_rt_sigreturn()")
>     bf7fb32dd5fc ("powerpc: Add missing prototypes for ppc_select() & ppc_fadvise64_64()")
>     f3675644e172 ("powerpc/syscalls: signal_{32, 64} - switch to SYSCALL_DEFINE")
> 
> v4.9.150: Failed to apply! Possible dependencies:
>     0d60619e1c0c ("powerpc: Add missing prototype for sys_debug_setcontext()")
>     67b464a89c21 ("powerpc/32: Mark both tmp variables as unused")
>     6f5b9f018f4c ("powerpc/tm: Unset MSR[TS] if not recheckpointing")
>     b53875c4b4f2 ("powerpc: Add missing prototypes for sys_sigreturn() & sys_rt_sigreturn()")
>     bf7fb32dd5fc ("powerpc: Add missing prototypes for ppc_select() & ppc_fadvise64_64()")
>     f3675644e172 ("powerpc/syscalls: signal_{32, 64} - switch to SYSCALL_DEFINE")
> 
> 
> How should we proceed with this patch?

I understand that the commit that this patch fixes is not integrated into
stable tree.

I think it does not need to make stable at this moment, thus.

Thanks,
Breno
