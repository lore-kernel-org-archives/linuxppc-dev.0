Return-Path: <SRS0=ejpM=RS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED299C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 19:15:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D3CE218A1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 19:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D3CE218A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44LZyz6yNgzDqVx
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Mar 2019 06:15:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=212.227.126.187; helo=mout.kundenserver.de;
 envelope-from=lkml@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44LZxH4p5nzDqKN
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Mar 2019 06:13:37 +1100 (AEDT)
Received: from [192.168.1.110] ([77.2.38.11]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MAwsT-1hB9eE3ZNZ-00BIzf; Fri, 15 Mar 2019 20:12:52 +0100
Subject: Re: [PATCH v2 10/45] drivers: tty: serial: zs: use devm_* functions
To: Greg KH <gregkh@linuxfoundation.org>
References: <1552602855-26086-1-git-send-email-info@metux.net>
 <1552602855-26086-11-git-send-email-info@metux.net>
 <20190314225204.GB1795@kroah.com>
 <3734d588-6b9c-29e2-45b6-82e778f47602@metux.net>
 <20190315142628.GA30650@kroah.com>
From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <d81364fc-c5da-c1b2-f38a-3a23c701c50d@metux.net>
Date: Fri, 15 Mar 2019 20:12:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190315142628.GA30650@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:SXEacaD/ABSnz5SC+KZNJR8X78uU/ZHYhiWG9+GZ6gQCPTRGGY6
 oMVfqetSpylUX++ls1E5S5HMu7R8JrQbuqlXNK9GlVbbb2YxtlIIR6Sf1yP6eTo7EfFHl/Z
 Maw2+uQShcxCe04Q9AyUvT6oRLqxbx0eJetBsxpHX2vZK0Gl31iXmsQWqVvjXcebaOsL/m0
 UpjmXfWKzQcDwYagaNBUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U0SKPNSdJuY=:oH4Oh2WL/2UXvNa1xcttEc
 JapvfqqU5eJSH+zxCk1UXoC9CpcPzzmyn8dM5c9MYzhMXx07BypNuqhrITXcExIs9egcWb5xU
 qs8bOQ4nsK5Ccib7fl/aZDNONmEiA9YO2wbKp+3nnu7A/n42004mxMiPLiX++31wJUL6S7mK2
 g+6eQWnpLA7gGb4fg4ukKY9Afc1X3dtj0pOjhwxXivv4ruLJNt1e6tbrxsIynHTX+wvkOknAL
 Rx/rKTJYjuSWCQVI5cGiztn/H4ddH17G9yZb68A2LjkUVrC+RkgqmekunC/y7hNFw4FhRzOUQ
 UWAAD0r6FJazA9Rk2f/Y3MgPTiMu3uJ/vEFVXXuaLjuYor3ALPdapzAusG/112kc9xL7lIPiN
 LNLDxa1dSXA2D96FOVQteqAwb2DDvx9ctHgc/TD/UjH9BjqzXkDjGzeBzk1soXOx9AlUnbEyv
 GwyheLkj8ic1hJY2lD/Jfvp5dRziz25+6QEOgprLVy25JD/LfeJvYfZJCnVsv7gJh4Ycu4RXQ
 R3pfWebRRndXb3qNThL4ulCN+gdrVBoSLE0SAiAWkAzbGTAJEF6EfPYAxzzsSfrSDA8aWcQsO
 EB0Jcvb9XVisrzk+XgnQc7jhhQmBMonJ9/tgBYjwrv7lGNWJATn+zD4qmIlobtmNnMa6lzlZt
 QeRSwymnrQw/VgB3fK2+g/YWTG+uB6QDyrDrK7Nu2RhOz4d3qMIiB7MZ238EnjwajX9ljbHZG
 unFgbBFSu3XxyC2q9RZE6HifJNhAR/R+m4Sjb0snrvb/gUGvpsm7IQWMhk8=
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

On 15.03.19 15:26, Greg KH wrote:
> On Fri, Mar 15, 2019 at 10:06:16AM +0100, Enrico Weigelt, metux IT consult wrote:
>> On 14.03.19 23:52, Greg KH wrote:
>>> On Thu, Mar 14, 2019 at 11:33:40PM +0100, Enrico Weigelt, metux IT consult wrote:
>>>> Use the safer devm versions of memory mapping functions.
>>>
>>> What is "safer" about them?
>>
>> Garbage collection :)
> 
> At times, but not when you do not use the api correctly :)

Okay, my fault that I didn't read the code careful enough :o

But still, I think the name is a bit misleading as it *sounds* as just
a wrapper around devm_ioremap() that just picks the params from a
struct resource. I guess we can't change the name easily ?

> Yes, there are lots of drivers for devices that are never unloaded or
> removed from the system.  The fact that no one has reported any problems
> with them means that they are never used in situations like this.

So, never touch a running system ?

> No, you need to have a good reason why it needs to be changed, when you
> can not verify that this actually resolves a problem.  As this patch
> shows, you just replaced one api call with another, so nothing changed
> at all, except you actually took up more memory and logic to do the same
> thing :(

Okay, I was on a wrong track here - I had the silly idea that it would
make things easier if we'd do it the same way everywhere.

>> IMHO, we should have a closer look at those and check whether that's
>> really okay (just adding request/release blindly could cause trouble)
> 
> I agree, please feel free to audit these to verify they are all correct.
> But that's not what you did here, so that's not a valid justification
> for these patches to be accepted.

Understood. Assuming I've found some of these cases, shall I use devm
oder just add the missing release ?

>> In this consolidation process, I'm trying to move everything to
>> devm_*, to have it more generic (for now, I still need two versions
>> of the request/release/ioremap/iounmap helpers - one w/ and one
>> w/o devm).
> 
> Move everything in what part of the kernel?  The whole kernel or just
> one subsystem?

Just talking about the serial drivers.

>> My idea was moving to devm first, so it can be reviewed/tested
>> independently, before moving forward. Smaller, easily digestable
>> pieces should minimize the risk of breaking anything. But if you
>> prefer having this things squashed together, just let me know.
> 
> Small pieces are required, that's fine, but those pieces need to have a
> justification for why they should be accepted at all points along the
> way.

Hmm, okay, in these cases, I agree there's no real justification if
we're not seeing it as an intermediate step to the upcoming stuff.
Having thought a bit more about this, my underlying dumbness was
setting everything on the devm horse when converting introducing the
helpers, and then splitted out the change to devm in even more patches
... Silly me, I better should have catched some sleep instead :o

>> In the queue are also other minor cleanups like using dev_err()
>> instead of printk(), etc. Should I send these separately ?
> 
> Of course.

Ok. I'll collect those things in a separate branch and send out the
queue from time to time:

https://github.com/metux/linux/tree/wip/serial/charlady

>> By the way: do you have some public branch where you're collecting
>> accepted patches, which I could base mine on ? (tty.git/tty-next ?)
> 
> Yes, that is the tree and branch, but remember that none of my trees can
> open up until after -rc1 is out.

So, within a merge window, you put everything else on hold ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
