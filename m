Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E0C4EDDE37
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jan 2007 14:33:50 +1100 (EST)
Subject: Re: kernel 2.6.18: Confusion about Macintosh backlight configuration
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matthias Grimm <matthiasgrimm@users.sourceforge.net>
In-Reply-To: <20070120150614.0b62a3ef.matthiasgrimm@users.sourceforge.net>
References: <20070120150614.0b62a3ef.matthiasgrimm@users.sourceforge.net>
Content-Type: text/plain
Date: Mon, 22 Jan 2007 14:33:35 +1100
Message-Id: <1169436815.31479.4.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, 407671@bugs.debian.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> This will allow modern systems to be compiled only with
> CONFIG_PMAC_BACKLIGHT and a user space daemon does the rest. I hope my
> point could be seen. I would really appreciate if the configuration
> could be cleaned up.
> 
> Other solutions could be:
> 
> 2. If the sysfs backlight driver is opened switch kernel backlight keys
>    handling off by calling PMU_IOC_GRAB_BACKLIGHT for machines that
>    support the sysfs backlight interface.
> 
> 3. Remove the kernel backlight keys control code from the kernel.
> 
> Which solution you prefer is up to you but I would be glad if at least
> solution #1 could be realised.

For now, at least, what prevents you from having all enabled and have
pbbuttonsd still call PMU_IOC_GRAB_BACKLIGHT ?

In the long run, we might want something smarter indeed, not sure what
the best solution is... I like having the kernel control work always
when no daemon is there.

Among others, because we have this never solved problem where
occasionally, the internal flat panel doesn't sync properly and the only
way to get it back is to turn the backlight all the way down and back up
a few times until it "kicks in".

Ben.
