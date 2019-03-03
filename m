Return-Path: <SRS0=weZV=RG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A43C4360F
	for <linuxppc-dev@archiver.kernel.org>; Sun,  3 Mar 2019 20:06:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F6CC20863
	for <linuxppc-dev@archiver.kernel.org>; Sun,  3 Mar 2019 20:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ks2Y60mC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F6CC20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44CDh25VFWzDqHv
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 07:06:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=bsingharora@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ks2Y60mC"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44CDfG5zLgzDqHj
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Mar 2019 07:05:08 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id n74so1408112pfi.9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 03 Mar 2019 12:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XUb2aMj/8sMp7lRQBT/pAJ867w+b2Pb5FwqRoatohMY=;
 b=Ks2Y60mCjonMxa4QL8qr12F7xlYJhu14WLjp09CGzKQRBZ6cx44SF6WO+bsXAcw1E4
 EAZqliycWqekDl4lWKaS5a+J9pUGdRM6yJuylEOSNQI1o3bP5C4ak440Qp5+pokl2Dxj
 B5mYbOqj39C0PQagZfAjlY2SzE7r7uYvwBTM+el41YALMgc0G8byKgAyua3N9Tb3NwJU
 vB4LluvKUdvUQ0lsJ11phArBtg1Rwl3ytvwx3j3CnlkyUk0OhoXjMHYuGWqtM7Y9bzQ8
 3bCQUO9nn3jYQrXUm5Qj+2gH5NyIV2PpHbaU8zRZ/I8JP6K3px09Fs6KwsVYG5lW79BH
 KvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XUb2aMj/8sMp7lRQBT/pAJ867w+b2Pb5FwqRoatohMY=;
 b=eMHNxYEN1M/uzYEYQgyvE6gWzG/5K2WmYMCf/dJnAbt0ec+pEp9/XE3sUStQiH06tL
 9/Dc2bf8zBhYVup6VRUhE5a4MA9ekX46btV8Hc1B9tlviL8FG5VJPtu4oZLi3tczgwei
 2ScX4wXmounlLdh+PnDAdivp26aemDAA95BQch5vgSneVsfgt9ZJ23hxcLfZThJSEcQs
 1QgON9svWsnN6OQJGkta5yZBlCeAQX0vVrwGz136FNRlg9EeOsp/MNtAebeWE5wSUef6
 23gbhUOtIGVPsjmNFcwWGSm+yo7nIaMo85yoDWnfQIReuoL70CgIaIiEdEVGP1psErqZ
 qCcA==
X-Gm-Message-State: APjAAAXU8x+EVWqcMYDhpPHNJOun0ciD5C+1Njr7U1nC3pJ6nkHBG5wK
 0waNZpQ4ewYoIyqRl5SbuYA=
X-Google-Smtp-Source: APXvYqyZZVDyDksDoMwzAvjYU28IinoqSDa83/BDmz3YB0Cf+AY39OicBmYoEOp7T5CK+YYMj8iO7A==
X-Received: by 2002:a63:f453:: with SMTP id p19mr14487091pgk.232.1551643504663; 
 Sun, 03 Mar 2019 12:05:04 -0800 (PST)
Received: from 8c8590bceeee.ant.amazon.com ([205.251.233.179])
 by smtp.gmail.com with ESMTPSA id k125sm9582922pgc.51.2019.03.03.12.05.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 03 Mar 2019 12:05:03 -0800 (PST)
Subject: Re: [PATCH] powerpc: remote save_stack_trace_tsk_reliable export
To: Joe Lawrence <joe.lawrence@redhat.com>, live-patching@vger.kernel.org,
 x86@kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20190301191721.4010-1-joe.lawrence@redhat.com>
From: "Singh, Balbir" <bsingharora@gmail.com>
Message-ID: <72e1368e-8444-7c06-5c35-f75ab4ecb1de@gmail.com>
Date: Sun, 3 Mar 2019 12:05:02 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190301191721.4010-1-joe.lawrence@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
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
Cc: Thomas Gleixner <tglx@linutronix.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 3/1/19 11:17 AM, Joe Lawrence wrote:
> As tglx points out, there are no in-tree module users of
> save_stack_trace_tsk_reliable() and its x86 counterpart is not exported,
> so remove the powerpc symbol export.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> ---
>  arch/powerpc/kernel/stacktrace.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
> index e2c50b55138f..42c587de21a9 100644
> --- a/arch/powerpc/kernel/stacktrace.c
> +++ b/arch/powerpc/kernel/stacktrace.c
> @@ -193,7 +193,6 @@ save_stack_trace_tsk_reliable(struct task_struct *tsk,
>  	}
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(save_stack_trace_tsk_reliable);
>  #endif /* CONFIG_HAVE_RELIABLE_STACKTRACE */
>  
>  #if defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_NMI_IPI)
> 


Acked-by: Balbir Singh <bsingharora@gmail.com>

Balbir Singh
