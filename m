Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E20E5DDFD4
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jul 2008 08:14:42 +1000 (EST)
Subject: Re: 32-bit kernel on PPC64 supported?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Marvin <marvin24@gmx.de>
In-Reply-To: <200807182043.08991.marvin24@gmx.de>
References: <200807182043.08991.marvin24@gmx.de>
Content-Type: text/plain
Date: Sat, 19 Jul 2008 08:14:35 +1000
Message-Id: <1216419275.7740.459.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-07-18 at 20:43 +0200, Marvin wrote:
> Hi,
> 
> while trying to cleanup some configs/makefiles for ppc64 I noticed, that 
> CONFIG_POWER4 implies CONFIG_PPC64 and vice versa in all defconfigs.
> So I want to boldly replace CONFIG_POWER4 by CONFIG_PPC64 - ugh.

No, those are different.

CONFIG_PPC64 means a 64 bits kernel.

CONFIG_POWER4 means a 64 bits kernel that only runs on IBM POWER4 and
later (ie, processors conforming to, iirc, version 2.01 or later of
the architecture).

That is, it's legal to have CONFIG_PPC64 and !CONFIG_POWER4, and this
is even necessary if you want to boot on a POWER3 or an RS64 processor.

Now, there also used to be some 32 bits support for POWER4 and G5 but
that has been dropped a while ago.

Cheers,
Ben.
