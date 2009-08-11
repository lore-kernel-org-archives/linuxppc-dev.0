Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9BC71B6F20
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 Aug 2009 01:24:51 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 293F5DDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2009 01:24:50 +1000 (EST)
Date: Tue, 11 Aug 2009 19:24:48 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Felix Radensky <felix@embedded-sol.com>
Subject: Re: [PATCH] powerpc/85xx: Workaround MPC8536 GPIO 1 errata.
Message-ID: <20090811152448.GA21956@oksana.dev.rtsoft.ru>
References: <> <1249981458-16102-1-git-send-email-felix@embedded-sol.com>
	<20090811134450.GA9820@oksana.dev.rtsoft.ru>
	<4A818A4C.8060502@embedded-sol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4A818A4C.8060502@embedded-sol.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 11, 2009 at 06:12:12PM +0300, Felix Radensky wrote:
[...]
> >Plus, this are two reads instead of just one. I think it'll be better
> >to implement mpc8536_gpio_get(), and then do
> >
> >if (of_device_is_compatible(np, ... 8536-gpio-bank ...))
> >	gc->get = mpc8536_gpio_get;
> >else
> >	gc->get = mpc8xxx_gpio_get;
> 
> The reads are from 2 different registers, how do you propose to replace
> them by a single read ?

I didn't propose that, I proposed to not do 2 reads for CPUs that
don't have the errata. ;-)

> I'll implement mpc8572_gpio_get(), suitable for both 8572 and 8536.

Great, thanks!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
