Return-Path: <SRS0=qVND=NW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB305C432BE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Aug 2021 01:32:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC5E060F3A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Aug 2021 01:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EC5E060F3A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gz8nT1NRsz2yMM
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Aug 2021 11:32:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=AzDcWKGt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::633;
 helo=mail-pl1-x633.google.com; envelope-from=senozhatsky@chromium.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=AzDcWKGt; dkim-atps=neutral
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gz7Tx3d4Gz2xh1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Aug 2021 10:33:55 +1000 (AEST)
Received: by mail-pl1-x633.google.com with SMTP id bg1so4279149plb.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Aug 2021 17:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=TjFdVibCziMMV625QJ8En+pQePJGwxqOLzHHo+cR/2g=;
 b=AzDcWKGtdHyMnoIEjzFPFQjRSRfN6cZcyUfqyg+1RFft/sQblgaz4y7UB0acXhUsAk
 aYq77Xwd7EMjSfEApWR3a558fJLQOEbjXYD1SI5rTv8NJMwK07Xba20kndQ9K5z7nQNv
 VqF6GPhvubvT3lLK/TsJYcG7uj5cuYcL5eVI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TjFdVibCziMMV625QJ8En+pQePJGwxqOLzHHo+cR/2g=;
 b=GAjPKBjAYqGiSR4RvufJo2jWBJmnfFZHwAd1n6aFdNiYj2cBsDUBVD7f+7yb6TGMXG
 pdVOQhjmFeKYJXeSUjAuGS8jbexI+RmdmvS58K1F0+d95Q+xuBmc/Q0UjO/JN2BxJr26
 2eHpreZhOn1UCRGXg5VeTPcaIxRthCOzQfbedYT0bxECanvX1kaYawG2FdMEcy8pOkGV
 SLWwXzg46H49UWpGmbPNNiqdGFW/vH59mCTt7ejc88wBDWKAwMDctV0vVZrBt+siq73i
 b/uCS9LZxJYoNJ5f1HTxXSOZgt3unBveOrx4nNrkgYQzTwFeQzp7X42aMyi9tckTPFEI
 wH9Q==
X-Gm-Message-State: AOAM532i/Brbb0ggc80NGWkohTcrz2FZy4//oz+wApVQ2qlkDaMaDjaB
 44arbYrlF6NZf+hdcM+aGVOrqQ==
X-Google-Smtp-Source: ABdhPJxdbxW4ryHv5bhuf8dsnrqkWswjsDidSV0lyn6xogTwXPWUAw0uITGdywWoWH5lbvCpqEzDjw==
X-Received: by 2002:a17:90a:bc47:: with SMTP id
 t7mr2025742pjv.19.1630370030908; 
 Mon, 30 Aug 2021 17:33:50 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:69ed:b45b:ceb5:e18b])
 by smtp.gmail.com with ESMTPSA id q12sm15915318pfj.153.2021.08.30.17.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Aug 2021 17:33:50 -0700 (PDT)
Date: Tue, 31 Aug 2021 09:33:36 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH printk v1 00/10] printk: introduce atomic consoles and
 sync mode
Message-ID: <YS144PMiCJnmoKE4@google.com>
References: <20210803131301.5588-1-john.ogness@linutronix.de>
 <YQwHwT2wYM1dJfVk@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQwHwT2wYM1dJfVk@alley>
X-Mailman-Approved-At: Tue, 31 Aug 2021 11:31:52 +1000
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
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Jiri Slaby <jirislaby@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Al Cooper <alcooperx@gmail.com>, Douglas Anderson <dianders@chromium.org>,
 Paul Cercueil <paul@crapouillou.net>,
 Matthias Brugger <matthias.bgg@gmail.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Cengiz Can <cengiz@kernel.wtf>,
 Chengyang Fan <cy.fan@huawei.com>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Eddie Huang <eddie.huang@mediatek.com>,
 Bhaskar Chowdhury <unixbhaskar@gmail.com>,
 John Ogness <john.ogness@linutronix.de>, Changbin Du <changbin.du@intel.com>,
 Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
 linux-mediatek@lists.infradead.org,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Ingo Molnar <mingo@redhat.com>, linux-serial@vger.kernel.org,
 kgdb-bugreport@lists.sourceforge.net, linux-mips@vger.kernel.org,
 Wang Qing <wangqing@vivo.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, Johan Hovold <johan@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Borislav Petkov <bp@alien8.de>,
 Nicholas Piggin <npiggin@gmail.com>, Hsin-Yi Wang <hsinyi@chromium.org>,
 Sedat Dilek <sedat.dilek@gmail.com>, Claire Chang <tientzu@chromium.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Andrij Abyzov <aabyzov@slb.com>, linux-arm-kernel@lists.infradead.org,
 Sumit Garg <sumit.garg@linaro.org>,
 kuldip dwivedi <kuldip.dwivedi@puresoftware.com>,
 Andrew Jeffery <andrew@aj.id.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Zhang Qilong <zhangqilong3@huawei.com>,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Guenter Roeck <linux@roeck-us.net>, Jason Wessel <jason.wessel@windriver.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>, linuxppc-dev@lists.ozlabs.org,
 Vitor Massaru Iha <vitor@massaru.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On (21/08/05 17:47), Petr Mladek wrote:
[..]
> 3. After introducing console kthread(s):
> 
> 	int printk(...)
> 	{
> 		vprintk_store();
> 		wake_consoles_via_irqwork();
> 	}
> 
> 	+ in panic:
> 
> 	    + with atomic console like after this patchset?
> 	    + without atomic consoles?
> 
> 	+ during early boot?

I guess I'd also add netconsole to the list.
