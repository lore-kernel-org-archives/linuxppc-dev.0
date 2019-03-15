Return-Path: <SRS0=ejpM=RS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB38C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 09:34:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C7CB21872
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 09:34:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C7CB21872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44LL4Z235LzDqRm
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 20:34:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=217.72.192.74; helo=mout.kundenserver.de;
 envelope-from=lkml@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
X-Greylist: delayed 836 seconds by postgrey-1.36 at bilbo;
 Fri, 15 Mar 2019 20:20:55 AEDT
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44LKnM26T5zDqRm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 20:20:53 +1100 (AEDT)
Received: from [192.168.1.110] ([77.2.38.11]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MSbp1-1hSX4w3pNZ-00SysH; Fri, 15 Mar 2019 10:06:24 +0100
Subject: Re: [PATCH v2 10/45] drivers: tty: serial: zs: use devm_* functions
To: Greg KH <gregkh@linuxfoundation.org>,
 "Enrico Weigelt, metux IT consult" <info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
 <1552602855-26086-11-git-send-email-info@metux.net>
 <20190314225204.GB1795@kroah.com>
From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <3734d588-6b9c-29e2-45b6-82e778f47602@metux.net>
Date: Fri, 15 Mar 2019 10:06:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190314225204.GB1795@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:+o4SIs6v4ZgDwZgql/OoA36fyA5G9I82AbwrYGDAzoeoS1enF0W
 myQ8zfS75+8ASgxjq0d5DBvrKJXe012Kjnl4UNewqmKx2LYfC7Ag5hPi6O8nfxMsAMkWjFs
 OfNiATKNg8ZCymNpvy0E5YWmHXC0+reP8JaW0EQyXRhFG7Xorw1ASJ7hkyr8/TRfF0zMcT9
 0w59Z53qCG3X/FJmUEY9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZchXE+uDw/I=:0P5rdGdfB6t4QqGqwSM+6+
 lSWyz8zzC2xUbSpwPjrpi8GileNy2XxU7UmlCEng85H/w6xwjymFYZL/NHQAjMd7CnhtY4DBt
 ODbkdUg/WRAQRvlPdEZxpzaiyuZ8fJd8cZzgNX1mFIG7j1/og637KeWl+w1opT9Z2HPE17UDN
 G5jfmbuIylz4vRFztYZ8jjrqDOK6t+jVgLWAikPY9oUVOjbLPFl7jEm6++Lz2sV40Jzjp40L+
 fin/J9GwL81OgZnNUb+LZWOqEGsk0uYVvu8ZRrkMvgsX3oeH+AWK3pz0dPt+fucy5FWKBk99U
 Y99kx4t7UCu1cyyZK3q2ByvQ1bSeSwtmAC5FnmIJDeEE1EJI0a4KfakX5ZZRsPkklD8uyVjZC
 fayGtv8oEjdMIu+7EeIcj9XfDdeWN3KWgpr+q122Q8omcgDBNWjvPBH/Pxsqffyk3oNSTIwWB
 KFDklpgt5aaYTCG7xairWaKCq5DRh0xh7M9IUka+zNUU0HgqSKFbc8mCvNgJXzeLoMP6R2/ek
 bxUijWoCCtec6/+hgd4/+vrx2aGN7zuwRhsTqmuFIp04WNeZ+EL8TmIn4vBZpFrGARTMJXbfF
 ddVERTbSy5skzWgpHHndNEeos9ovZ9rFjZFF9FMp9r2fyOumEC1L5PrOgGnTEcDeUc7zPxC/m
 u7Z8c0uv4P3Y5jNjdAdeoVlKI69cr8A03bRONC/Edz5iRFZxTeUAOZU8bpG9F97sY7fs90Cqb
 g1woL6G5iT+JDO1R6NMrRogry3lEGdcXq6MPuCdk24ts84n2S6STPK35Zfc=
X-Mailman-Approved-At: Fri, 15 Mar 2019 20:32:42 +1100
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
Cc: linux-arm-msm@vger.kernel.org, yamada.masahiro@socionext.com,
 macro@linux-mips.org, jacmet@sunsite.dk, festevam@gmail.com,
 stefan.wahren@i2se.com, f.fainelli@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, linux-imx@nxp.com,
 linux-serial@vger.kernel.org, slemieux.tyco@gmail.com, andy.gross@linaro.org,
 tklauser@distanz.ch, david.brown@linaro.org, rjui@broadcom.com,
 s.hauer@pengutronix.de, u.kleine-koenig@pengutronix.de, vz@mleia.com,
 matthias.bgg@gmail.com, andriy.shevchenko@linux.intel.com, baohua@kernel.org,
 sbranden@broadcom.com, eric@anholt.net, richard.genoud@gmail.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de, shawnguo@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 14.03.19 23:52, Greg KH wrote:
> On Thu, Mar 14, 2019 at 11:33:40PM +0100, Enrico Weigelt, metux IT consult wrote:
>> Use the safer devm versions of memory mapping functions.
> 
> What is "safer" about them?

Garbage collection :)

Several drivers didn't seem to clean up properly (maybe these're just
used compiled-in, so nobody noticed yet).

In general, I think devm_* should be the standard case, unless there's
a really good reason to do otherwise.

<snip>

> Isn't the whole goal of the devm* functions such that you are not
> required to call "release" on them?

Looks that one slipped through, when I was doing that big bulk change
in the middle of the night and not enough coffe ;-)

One problem here is that many drivers do this stuff in request/release
port, instead of probe/remove. I'm not sure yet, whether we should
rewrite that. There're also cases which do request/release, but no
ioremap (doing hardcoded register accesses), others do ioremap w/o
request/release.

IMHO, we should have a closer look at those and check whether that's
really okay (just adding request/release blindly could cause trouble)

> And also, why make the change, you aren't changing any functionality for
> these old drivers at all from what I can tell (for the devm calls).
> What am I missing here?

Okay, there's a bigger story behind, you can't know yet. Finally, I'd
like to move everything to using struct resource and corresponding
helpers consistently, so most of the drivers would be pretty simple
at that point. (there're of course special cases, like devices w/
multiple register spaces, etc)

Here's my wip branch:

https://github.com/metux/linux/commits/wip/serial-res

In this consolidation process, I'm trying to move everything to
devm_*, to have it more generic (for now, I still need two versions
of the request/release/ioremap/iounmap helpers - one w/ and one
w/o devm).

My idea was moving to devm first, so it can be reviewed/tested
independently, before moving forward. Smaller, easily digestable
pieces should minimize the risk of breaking anything. But if you
prefer having this things squashed together, just let me know.

In the queue are also other minor cleanups like using dev_err()
instead of printk(), etc. Should I send these separately ?

By the way: do you have some public branch where you're collecting
accepted patches, which I could base mine on ? (tty.git/tty-next ?)


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
