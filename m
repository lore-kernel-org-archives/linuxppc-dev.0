Return-Path: <SRS0=ejpM=RS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAD1C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 18:49:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8972521871
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 18:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8972521871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44LZNx6dg6zDqTn
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Mar 2019 05:49:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=212.227.126.135; helo=mout.kundenserver.de;
 envelope-from=lkml@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
X-Greylist: delayed 329 seconds by postgrey-1.36 at bilbo;
 Sat, 16 Mar 2019 05:47:21 AEDT
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44LZLx5XxKzDqSK
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Mar 2019 05:47:20 +1100 (AEDT)
Received: from [192.168.1.110] ([77.2.38.11]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MirfI-1gb17s0I5M-00exYF; Fri, 15 Mar 2019 19:41:20 +0100
Subject: Re: serial driver cleanups v2
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <1552602855-26086-1-git-send-email-info@metux.net>
 <CAHp75VeH9isvFkp+AECgsN8du__8tBBp_4zZEVXJ083BdFweeg@mail.gmail.com>
 <afc51d27-3312-cdf4-68a5-4486db1d006b@metux.net>
 <20190315181118.GF9224@smile.fi.intel.com>
From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <d9ac8446-c7ff-6e57-5eaa-f1a09d549081@metux.net>
Date: Fri, 15 Mar 2019 19:41:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190315181118.GF9224@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:SEhWkGTngchVaGOi1VLTckafsrasxjLcF1GzXHt0mnNThnYbRaw
 QfYHKt7uxK+IYwNNtICBankPHlIcLqxdx139j3YzHaskDIfe8r/jK8AyOQhUuNgUIe9tzTC
 WcG9jAOjUZpESxhSdjbcQMp3fY9dKCpffjGyz8EyYPzNQPcvVVBAHa337c3hpGqWvmrOJlm
 VXJ3TblaMwQXQ1Y+/esrw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cdx7YzeKHzo=:JKl5PhseLRl9MVeRXuGHaP
 sR1pqqUSfXMBszMHb45s6kUIw0StZd0j8eEKWtZVzPsAlZp+oJApFNSFijgUKxcHDt9nFNq/x
 mJnBWJGUy7TkBIpGieFC+47XpQYUJ1Gu1COP1Ah/uqx1NjUGkOFO0Y4H+4gmGDO4peI4QOJgJ
 O/ZGG+wRaO2hAe72osY7eNijNeaVQhiKQwHSgmPODNZPfvvWRypUJ4wqLcivFsvJt6wyoPCGf
 ryZ8ccUKbL9+p5SVLvbJBeaNAXr4SNtLPu7GctHfAcux9FInJ93jIbkFpW8ukshndqLEuZG3L
 IBuxJdG0KqyO41MvIT8EA8KWTcKOBzS6Lqh5bw93Z1zIIswK4+Y1+Bdf7iu+VhYEP2UXk73cM
 rJ3ZerA/kv3MimTylfdsXalZUAis5OdW7fUUu96XrurMBj1D5UZ0bhreWFGXqKexMwEdhNIcX
 k00D4NoHNcO8yopdRejjm8aMRN7kYUBWFVoOXrm1u8K+Y2+LtYuUDVjdYHlk6KgyiueSP0JtD
 w/DWJT7exvHcXXtcoyCmv9MkXBb9nESfDvcLvUK/ZCk7jeVwIC6C3gnswucN7CIWZ271/0x+e
 I5cHc1j4gpH5qAwlXltgcPQ5QnZmOAN/6ppkCxLaRnWwtCaNgv/r3n6q56jXw9kDebiYYbUHL
 Xijb0Wa5f4bUNIBACw53bZipOyWTGtO5g3mAPB3wSeQjhzwAwfr/vwaG89uFRBwYtwenqteJW
 u/yu2jKrw5UaXVFBFDLKo638n5YVTbtfI2BOfgBYJLa6e2bLCgvowuxmFj/1yO+oEhE4VJcB3
 0m8ambiNeej5pGwAT49lRP+K4dbjq3jZ1b0RhmCpTp7hlob9O5D0XqllSxo6iTuHN1IePp0
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
 Matthias Brugger <matthias.bgg@gmail.com>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>, baohua@kernel.org,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>,
 Richard Genoud <richard.genoud@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 15.03.19 19:11, Andy Shevchenko wrote:

>> The actual goal is generalizing the whole iomem handling, so individual
>> usually just need to call some helpers that do most of the things.
>> Finally, I also wanted to have all io region information consolidated
>> in struct resource.
> 
> That's should be a selling point, not just conversion per se.

hmm, I never was good at selling :o

but I'll try anyways: it shall make the code smaller and easier to
read/understand.

does that count ?

> You have to explain that in each commit message, that the change does bring a
> possible new error message printed.

Ok, I wasn't aware of that. Yes, I missed to read the code of that
function carefully and didn't expect that it does more than just a dumb
wrapper around dev_ioremap() that picks out the params from struct
resource.

OTOH, the name, IMHO, is a bit misleading. Any chance of ever changing
it to a more clear name (eg. devm_request_and_ioremap_resource()) ?

> The performance side of the deal, you are lucky here, is not significant
> because it's slow path.

okay :)


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
