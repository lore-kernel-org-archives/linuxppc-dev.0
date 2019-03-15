Return-Path: <SRS0=ejpM=RS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CCAC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 10:38:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E86421872
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 10:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E86421872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44LMVg5JYFzDqSv
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 21:38:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=217.72.192.74; helo=mout.kundenserver.de;
 envelope-from=lkml@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44LMT34PSlzDqRj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 21:36:53 +1100 (AEDT)
Received: from [192.168.1.110] ([77.2.38.11]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MJmCV-1hJwlE0Za5-00KAx2; Fri, 15 Mar 2019 11:36:09 +0100
Subject: Re: serial driver cleanups v2
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
 "Enrico Weigelt, metux IT consult" <info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
 <CAHp75VeH9isvFkp+AECgsN8du__8tBBp_4zZEVXJ083BdFweeg@mail.gmail.com>
From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <afc51d27-3312-cdf4-68a5-4486db1d006b@metux.net>
Date: Fri, 15 Mar 2019 11:36:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VeH9isvFkp+AECgsN8du__8tBBp_4zZEVXJ083BdFweeg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:KM4NkyrC0BtJXbtB/FaU127xam16aUiyiPVIgxJxFT7tWcR+oZW
 XGh7IJUhgJv+eo0D3ftF9P5QE6bhrj2VYLI1BQRmTyrkhECuJ7tqsw52KfXxpz7tcp9zrSU
 GJY4s+gsSge9406QsaC/OC345jBCHUdMZEur89Us2eN8rRsZLiQHwfKxA7HLEqry9oNu5cn
 JTbDaq3Kd5tD1sCcqTTWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3eokONbwW5Q=:4c+53yi6qdmDtEvyPvangv
 pVai4FdNpGIWm7REjtzOotiOrB6TPmSzvyRrVc8ylgHdOjQnKZLqofHtK1UcOrsX0+FmLE22O
 tA5duOs7PHgMraKTTenoPbr4XyBSBndLOnmHOfbLLIawrPgS47JA86u5ghEDYUCcdZBeuO4pB
 FgEitoVG4DEFJBlXICeTObjRCJSJAmnTwGUmfMwaVCW0ig0633c5z9dlrjlxQNYiJSHEzZYxC
 nzS/mq5FsncNwgy+jFy5G00NOPSLugEaVU/gsfwgDHa/7c/8lmq5160WS6u8HLA7CYFw+rSgg
 /LFRk5iKfg3gLjxMGsmdtUlss/UTxuXQzrAJF3rbWhIfdSBsHTYgDv3bwL1rHBhJ196aHai3+
 5ncqNDYGDjpNbq52MzeO0loIJi3Np3TRlQE8bDyoy63YlMidEqxzUUNqsWdjpjBtU4kQ1mcED
 OTSn5dI8BwxBKOR3jxDRjEw/f7tKmRnZVbyZXLBPtWWdECsEGAHb2hF1fPPygpSj4hmBo4Dtd
 oMKVQd6WJDC5jdrjbttmJeO1mXoSfqg0xAbBz8wN/QoUWNxS9JqfW1RLMw15dFInk2dy+OYD5
 cA6KWxtuEbCytOjCQ5fTVcUTx00yAdYnvRs7F2LpCzpcOhLotHbPFG09W8cDL9/U2w2tAYuX7
 rRUDAtrNpTcEjuOOQ2hr3lP8l9NG5jawTV6YPxjGN7NjSeCeiMXHCirPSOoWOfQiYtp5DLjx7
 1sE5Ngb5Uacblm6r9pHLl5ULWJ8fAZTR6uHgmWCL6KiwiUHMTTliwxxfkBA=
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
Cc: linux-arm-msm@vger.kernel.org,
 Masahiro Yamada <yamada.masahiro@socionext.com>, macro@linux-mips.org,
 Peter Korsgaard <jacmet@sunsite.dk>, Fabio Estevam <festevam@gmail.com>,
 Stefan Wahren <stefan.wahren@i2se.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 Andy Gross <andy.gross@linaro.org>, Tobias Klauser <tklauser@distanz.ch>,
 David Brown <david.brown@linaro.org>, Ray Jui <rjui@broadcom.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, slemieux.tyco@gmail.com,
 "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
 <linuxppc-dev@lists.ozlabs.org>, Vladimir Zapolskiy <vz@mleia.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, baohua@kernel.org,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>,
 Richard Genoud <richard.genoud@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 15.03.19 10:12, Andy Shevchenko wrote:

>> Part II will be about moving the mmio range from mapbase and
>> mapsize (which are used quite inconsistently) to a struct resource
>> and using helpers for that. But this one isn't finished yet.
>> (if somebody likes to have a look at it, I can send it, too)
> 
> Let's do that way you are preparing a branch somewhere and anounce
> here as an RFC, since this was neither tested nor correct.

Okay, here it is:

I. https://github.com/metux/linux/tree/submit/serial-clean-v3
   --> general cleanups, as basis for II

II. https://github.com/metux/linux/tree/wip/serial-res
   --> moving towards using struct resource consistently

III. https://github.com/metux/linux/tree/hack/serial
    --> the final steps, which are yet completely broken
    (more a notepad for things still to do :o)

The actual goal is generalizing the whole iomem handling, so individual
usually just need to call some helpers that do most of the things.
Finally, I also wanted to have all io region information consolidated
in struct resource.

Meanwhile I've learned that I probably was a bit too eager w/ that.
Guess I'll have to rethink my strategy.

> And selling point for many of them is not true: it doesn't make any
> difference in the size in code, but increases a time to run
> (devm_ioremap_resource() does more than plain devm_iomap() call).

Okay, just seen it. Does the the runtime overhead cause any problems ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
