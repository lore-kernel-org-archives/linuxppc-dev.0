Return-Path: <SRS0=JrXR=RT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506ADC43381
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Mar 2019 09:19:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E19D2087C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Mar 2019 09:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E19D2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44LxjG4DdJzDqVr
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Mar 2019 20:19:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=217.72.192.73; helo=mout.kundenserver.de;
 envelope-from=lkml@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44LxgW6XXGzDqM4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Mar 2019 20:17:57 +1100 (AEDT)
Received: from [192.168.1.110] ([95.117.13.126]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MMFdY-1hMCLq1ldW-00JGKe; Sat, 16 Mar 2019 10:17:16 +0100
Subject: Re: [PATCH v2 10/45] drivers: tty: serial: zs: use devm_* functions
To: Greg KH <gregkh@linuxfoundation.org>
References: <1552602855-26086-1-git-send-email-info@metux.net>
 <1552602855-26086-11-git-send-email-info@metux.net>
 <20190314225204.GB1795@kroah.com>
 <3734d588-6b9c-29e2-45b6-82e778f47602@metux.net>
 <20190315142628.GA30650@kroah.com>
 <d81364fc-c5da-c1b2-f38a-3a23c701c50d@metux.net>
 <20190316032630.GB2499@kroah.com>
From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <fd8d6a9b-3e85-9904-2195-1f1bbc42bd2d@metux.net>
Date: Sat, 16 Mar 2019 10:17:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190316032630.GB2499@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:EeDIdx/ZofCsDCjDCqDBdwJVn2vFx/eYFegD5Ya7VFYNybfet1J
 3wxuCJlxu9QfJi1PtUMeEtTgSfAdwo4QO+us5aMtiqM63gXLmhu7Y9FeqCw0/ZHUNjQmemp
 C+M1lQ4UgmbcYBlv1Ft+qZ1DiSjF0yDMNnl6HfdPyGE2GSeQvnFmC3+EH51ObeMhGujIb8v
 q2aiqoqoSmDh9MGiT+XQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P9NI7bTY56M=:R3xN1Mqy2RRkBDf8qpUd8m
 6/ilptxmqeSdfhOojd3Oahqhbhc6SzWzY+i5d/zfWYaHMc0zfdkJ7XCF7+V49T6NOtZt0BOmP
 DBYLB+kfLWYDq6RaMeQYMvpo6ZsMqCWb/dRz70YPAHQ4LdA26tPwF/2vWX+jUm/2QV4yihzU4
 M1nXjxZwuXO9RPRolDYhQARZzV8L5N4zj6ZFO+IjbAH5iR3K9eoXjRCF7PS+fK7rhyBpFuucq
 tA3wk6A7Ljl08ltvGopfnrVI20CbziAEybIxtH/yD/S6M6DhJB5KPKSbT8AS1yTcOGMcIxCdU
 HNh/bz2+K17NsPZVOf5wPXq52T26etgaXDr6KoXxdavqPWuPIgtwVmtRro6hF+9nfvpbrtvc2
 n/ICtcs7yzPa7/UwM4ZDrkKLtOdsjTluh6XrUOxvtZ9h2ZHXxtxg3BO7BigBSgKBBDQBRTOyN
 No9uFS95NCNrGnU0o/k7a0s9JTse+R+qlbXwUnCVSPGc25SiHjrVaGt7+X42Nlp3nBGbBpI5I
 mkfEfBoOQtY6EynGZ8qS9leCGqtmJHNDMHZG3cyMuaYiB13F7btHRSVXGhIexVpOap2ZJmxMr
 PMiCx/93wXhGGerfju0CVrSizsycdc0Hi9pL/dQxIX2HpIn0aaRnPjm1ZBAWLn6omBEbCYzqH
 Di/UUQpmP+VFA90CmDyBFGKVeXyclpBWmNtCOivhu8hLgPc/2f7x7bXINYrXZzgZXnuojlhcO
 B6Bu7sxkRzPEcQxerG1ThvTnKgVxBfmRL8DOzXh6volzOn88FG5DaEHFq5g=
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
 s.hauer@pengutronix.de, u.kleine-koenig@pengutronix.de,
 linuxppc-dev@lists.ozlabs.org, vz@mleia.com, matthias.bgg@gmail.com,
 andriy.shevchenko@linux.intel.com, baohua@kernel.org, sbranden@broadcom.com,
 eric@anholt.net, richard.genoud@gmail.com, "Enrico Weigelt,
 metux IT consult" <info@metux.net>, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de, shawnguo@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 16.03.19 04:26, Greg KH wrote:

> No, it's just that those systems do not allow those devices to be
> removed because they are probably not on a removable bus.

Ok, devices (hw) might not be removable - that also the case for uarts
builtin some SoCs, or the good old PC w/ 8250. But does that also mean
that the driver should not be removable ?

IMHO, even if that's the case, it's still inconsistent. The driver then
shouldn't support a remove at all (or even builtin only), not just
incomplete remove.

>> Okay, I was on a wrong track here - I had the silly idea that it would
>> make things easier if we'd do it the same way everywhere.
> 
> "Consistent" is good, and valid, but touching old drivers that have few
> users is always risky, and you need a solid reason to do so.

Understood.

By the way: do we have some people who have those old hw and could test?
Should we (try to) create some ? Perhaps some "tester" entry in
MAINTAINERS file ? (I could ask around several people who might have
lots of old / rare hardware.)

>> Understood. Assuming I've found some of these cases, shall I use devm
>> oder just add the missing release ?
> 
> If it actually makes the code "simpler" or "more obvious", sure, that's
> fine.  But churn for churns sake is not ok.

Ok.

> I put the review of new patch submissions on hold, yes.  Almost all
> maintainers do that as we can not add new patches to our trees at that
> point in time.

hmm, looks like a pipeline stall ;-)
why not collecting in a separate branch, which later gets rebased to
mainline when rc is out ?

> And I do have other things I do during that period so it's not like I'm
> just sitting around doing nothing :)

So it's also a fixed schedule for your other work. Understood.

It seems that this workflow can confuse people. Few days ago, somebody
became nervous about missing reactions on patches. Your autoresponder
worked for me, but maybe not for everybody.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
