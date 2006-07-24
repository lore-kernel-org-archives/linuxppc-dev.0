Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id BEF4A67B5B
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 24 Jul 2006 21:44:57 +1000 (EST)
Date: Mon, 24 Jul 2006 15:45:16 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Laurent Pinchart <laurent.pinchart@tbox.biz>
Subject: Re: Endless "Trying 100/HALF" messages using FCC ethernet on MPC8248
Message-ID: <20060724154516.43d16e50@vitb.ru.mvista.com>
In-Reply-To: <200607241139.02128.laurent.pinchart@tbox.biz>
References: <200607241139.02128.laurent.pinchart@tbox.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 24 Jul 2006 11:39:01 +0200
Laurent Pinchart <laurent.pinchart@tbox.biz> wrote:

> Hi everybody,
> 
> I'm not sure if this issue is ppc-specific, so forgive me if it should have 
> been reported to the drivers/net/phy maintainer.
> 
> When using the MPC8248 FCC ethernet ports, the following messages are printed 
> by the kernel on the console when a link is down (ethernet cable unplugged):
> 
> Trying 100/FULL
> Trying 100/HALF
> Trying 100/HALF
> Trying 100/HALF
> ...
> 
> This goes on forever, with a new message every 5 or 10 seconds. The message is 
> printed by drivers/net/phy/phy.c at line 463.
> 
> Those messages are pretty annoying. Commenting the pr_info() call gave me some 
> rest, but a proper fix is probably needed.
> 
> For the record, I'm using FCC1 and FCC2 with an LXT973 phy in bit-banging 
> mode.
> 

The thing you'll need is to make driver to trust autonegotiation...

IIRC that was addressed in my patches for fs-enet. what's happening: The PAL subsystem tries hard to be 
wise, an dif there are no link located, it starts to try forced mode, setting various stuff as link params and looking if link appeared or not. To keep consistency, I used the special flag passed via platform info, to just trust what ANEG had find out.

Prolly we need to limit the forced aneg as well somehow - say give up after it failed to get link going at 10/HALF or smth like that.

-- 
Sincerely, 
Vitaly
