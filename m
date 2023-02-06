Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC378C05027
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Feb 2023 22:38:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4P9h4L2D2zz3f6V
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Feb 2023 09:38:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=KU85o3Mb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::82e; helo=mail-qt1-x82e.google.com; envelope-from=f.fainelli@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=KU85o3Mb;
	dkim-atps=neutral
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4P9h2p6bB8z3cdZ
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2023 09:37:06 +1100 (AEDT)
Received: by mail-qt1-x82e.google.com with SMTP id x10so7785513qtr.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Feb 2023 14:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GOsvo1Wy7rEBzdeEtnpUfAafl2KXxjzL9FtW2ispnjA=;
        b=KU85o3MbVzoHlkVJzhppe87qpv+MKx9lyyDdf3URpIiYW2Zidjluq5+t4NqrkTLUBv
         BRl/cCx5UTdh3aUIwMxRLKf3K19OUGtgV5HFrKptL15UYJmmTGvHZi6n1tGBM6Vf7Qec
         Fv2CPnc+/XIvJmWxKMyYwgaTKiV0NvjpGqskadXDL55OTeZQWVisLyUct3nRPo0Kq+cz
         3t+AtT7cMBjD/SfOlG/cCwpZ41t9OHqLYe3AnL8skDCedkkVLY3cSzbQ/y1Nym/wuNGd
         /htZGYXMc15GtuW+cC7bkrX2Xh3bzxXSEw5FuC89ogwPJcdKxuVchUBDZKlyGTgv95hH
         uqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GOsvo1Wy7rEBzdeEtnpUfAafl2KXxjzL9FtW2ispnjA=;
        b=t9GcpEhjpUo+6bWtQOw8lIJqxXJE18YIAN6prcH8DT/dek/ZMkSo+I5y4cbmNh7Gl7
         iwvRL2tG/33b10ICuR3WqjaHbaxbYGcx0WNq3c3hdP3xCleG0IKqm++jqNATWx72TWh9
         fENTwsKjuwWpcZDGr1CIoRCaNRv/UMOEBM4p+3PYp/Ii464UhdEZYf+Md8oREwcWXagF
         QLhirtCqkexFVVBDVM73BgmRHxFMHlpvMG1Q10w99LKGYxIF2ejiFvJKkNb3GJQLc3KY
         tD9n/JFUy5sY1xtYXsUYUObXzMg4E8MUZrPkEgLPz5HRF7CSg19laWWQanKCeTbWHqA9
         CA0g==
X-Gm-Message-State: AO0yUKXOf7MxOaAQ2amb+Nt9OtJy96tfvAUrtF2eOrrU7ASxDa3HIZr/
	FvWnymoTsvXZEOU5sRMQVrI=
X-Google-Smtp-Source: AK7set9txcfpHUlXwqrs8TNPgMT1nzGtwN0jT40D3fyWqV4erahgPF9QgZAv8Qf/7l444RGWli3bLw==
X-Received: by 2002:a05:622a:1101:b0:3a7:e9a2:4f4a with SMTP id e1-20020a05622a110100b003a7e9a24f4amr2153637qty.8.1675723024034;
        Mon, 06 Feb 2023 14:37:04 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 136-20020a370c8e000000b00706aeebe71csm8301291qkm.108.2023.02.06.14.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 14:37:02 -0800 (PST)
Message-ID: <177ee7b1-9954-be71-a1c0-024bed9902db@gmail.com>
Date: Mon, 6 Feb 2023 14:36:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 10/22] mips/cpu: Make sure play_dead() doesn't return
Content-Language: en-US
To: Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org
References: <cover.1675461757.git.jpoimboe@kernel.org>
 <b131d3e00967034d86692b894a66c6a656e7de3f.1675461757.git.jpoimboe@kernel.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <b131d3e00967034d86692b894a66c6a656e7de3f.1675461757.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: juri.lelli@redhat.com, dalias@libc.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, peterz@infradead.org, catalin.marinas@arm.com, dave.hansen@linux.intel.com, x86@kernel.org, jiaxun.yang@flygoat.com, bsegall@google.com, jcmvbkbc@gmail.com, guoren@kernel.org, hpa@zytor.com, sparclinux@vger.kernel.org, kernel@xen0n.name, will@kernel.org, vschneid@redhat.com, f.fainelli@gmail.com, vincent.guittot@linaro.org, ysato@users.sourceforge.jp, chenhuacai@kernel.org, linux@armlinux.org.uk, linux-csky@vger.kernel.org, mingo@redhat.com, bcm-kernel-feedback-list@broadcom.com, mgorman@suse.de, mattst88@gmail.com, linux-xtensa@linux-xtensa.org, paulmck@kernel.org, richard.henderson@linaro.org, npiggin@gmail.com, ink@jurassic.park.msu.ru, rostedt@goodmis.org, loongarch@lists.linux.dev, tglx@linutronix.de, dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org, jgross@suse.com, chris@zankel.net, tsbogend@alpha.franken.de, bristot@redhat.com, linux-mips@vger.kernel.org, linux-alph
 a@vger.kernel.org, bp@alien8.de, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 2/3/23 14:05, Josh Poimboeuf wrote:
> play_dead() doesn't return.  Make that more explicit with a BUG().
> 
> BUG() is preferable to unreachable() because BUG() is a more explicit
> failure mode and avoids undefined behavior like falling off the edge of
> the function into whatever code happens to be next.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

