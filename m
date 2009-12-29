Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A57ABB6EEB
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Dec 2009 20:37:16 +1100 (EST)
Subject: Re: xmon & SCSI ATA devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: gshan <gshan@alcatel-lucent.com>
In-Reply-To: <4B33197D.9000506@alcatel-lucent.com>
References: <4B33197D.9000506@alcatel-lucent.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 29 Dec 2009 20:37:08 +1100
Message-ID: <1262079428.2173.218.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-12-24 at 02:34 -0500, gshan wrote:
> Hello,
> 
> xmon and SCSI SATA device driver were installed on my system. When I invoked
> xmon explicitly for kernel debugging, there're probably pending SCSI 
> requests issued.
> So those SCSI requests complained timeout when I quited from xmon. I want to
> find a way to suspend SCSI device before invoking xmon and resume that 
> before
> quiting from xmon. Anybody knew there is a way to do this?

Well, it's non trivial. xmon is very low level and doesn't muck around
with drivers etc...

We could add hacks to avoid those timeouts or even do what you suggest
with suspending devices, but that would make entering xmon a -lot- more
fragile. The idea is that xmon relies on very little kernel services and
can be entered even when things are utterly wrong.

To be honest, I'm tempted to leave that as it is. Most of the time,
getting into xmon is a one way trip.... 

Cheers,
Ben.

> Thanks,
> Gavin
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
