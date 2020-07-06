Return-Path: <SRS0=jlj5=AR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AF5C433E0
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2020 18:17:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A224206E2
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2020 18:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Go6ByYbk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A224206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B0v1k4hqYzDqYn
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2020 04:17:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (domain owner discourages use of this
 host) smtp.mailfrom=kernel.org (client-ip=210.131.2.83;
 helo=conssluserg-04.nifty.com; envelope-from=masahiroy@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.a=rsa-sha256
 header.s=dec2015msa header.b=Go6ByYbk; 
 dkim-atps=neutral
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com
 [210.131.2.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B0tzc1Q8WzDqYJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jul 2020 04:15:55 +1000 (AEST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com
 [209.85.222.43]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id 066IFHo7005118
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Jul 2020 03:15:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 066IFHo7005118
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1594059318;
 bh=Q+48gTKGnNNAyaZpkSljO3/+f87VrYhlKUVJ5FKjmdQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Go6ByYbk3w6ZqfzY+bcPEPfdQfjSDMmaa6f7z4KGrPRgiJJhVvFX0zG/wdRmgZlNg
 fJTpHeNu8RVg7HoRCqN2GZxiXEZp2S76ErzL9nr07q+JH7oEhnOp3qzCLAiRsYRgzW
 4sXuqhEX3EHJGIPC2K90ZNZVGxta6AAY3nLwwqnKU5AiXTqseg+g4DmWdA+ju4NdX/
 u3rtdKZRVojNvHpJbD5nmIHE4eTRwzZPmoVxbN7MZ3KlsszTCjUdjsMIZlEJR5waRC
 kQvyoW3byTZEbBTB0DnuSKMXAvEpdAs1vEuIS1owDD0UyqTFxLJqTS0J5glaKV+nk/
 UG3FkSjjPkTqQ==
X-Nifty-SrcIP: [209.85.222.43]
Received: by mail-ua1-f43.google.com with SMTP id l18so5122996uad.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2020 11:15:17 -0700 (PDT)
X-Gm-Message-State: AOAM531PBUOvgR+oDV+ZBJ81PJ7Q+NoM2/69rAl8oQ1VpzD1ZXCdTu3N
 w/NjZquovl9no99EjOJDK7WeCtjp0Zo9vMFHe5g=
X-Google-Smtp-Source: ABdhPJzoaiAwOpILAwYbp3vbz8/vfjd18YvPHG7eMlv5+34w/dyjTF009kfyXsQdMimrRPhduooTnxiTT2c1jqAYb+8=
X-Received: by 2002:ab0:21c6:: with SMTP id u6mr18691153uan.109.1594059316651; 
 Mon, 06 Jul 2020 11:15:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200628015041.1000002-1-masahiroy@kernel.org>
 <87imfa8le0.fsf@mpe.ellerman.id.au>
 <CAK7LNATusciypBJ4dYZcyrugdi_rXEV_s=zxAehDxsX+Sd5z4g@mail.gmail.com>
 <CADYN=9JnzPC6Ja9s3_01k-CDTSuxKBMRdrqU5rqp0xw1r9XpRw@mail.gmail.com>
In-Reply-To: <CADYN=9JnzPC6Ja9s3_01k-CDTSuxKBMRdrqU5rqp0xw1r9XpRw@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 7 Jul 2020 03:14:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNARg_B+tcbduBzrh2_Q3dwk_XxDcaw+sMTwsMOxNYM7hnQ@mail.gmail.com>
Message-ID: <CAK7LNARg_B+tcbduBzrh2_Q3dwk_XxDcaw+sMTwsMOxNYM7hnQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: introduce ccflags-remove-y and asflags-remove-y
To: Anders Roxell <anders.roxell@linaro.org>
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
Cc: Michal Marek <michal.lkml@markovi.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Russell King <linux@armlinux.org.uk>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Sami Tolvanen <samitolvanen@google.com>,
 Rich Felker <dalias@libc.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Anders,

On Mon, Jul 6, 2020 at 8:24 PM Anders Roxell <anders.roxell@linaro.org> wrote:
>

> The full log can be found here [1].
>
> Without this patch for  'trace_selftest_dynamic' for instance, CC_FLAGS_FTRACE
> was removed from kernel/trace/*, and then added back to
> kernel/trace/trace_selftest_dynamic.
> While with this patch it looks like we add the flag (even though it is
> already there), and then
> removes the flag for all files in kernel/trace/* .


You are right.

I will drop this patch,
and send v2.


Thank you.




-- 
Best Regards
Masahiro Yamada
