Return-Path: <kenneth@southpole.se>
Received: from mail.southpole.se (mail.southpole.se [193.12.106.18])
	by ozlabs.org (Postfix) with ESMTP id 88CC0B7B96
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 13 Oct 2009 23:41:05 +1100 (EST)
Subject: Re: [U-Boot] Linux seamless booting
From: Kenneth Johansson <kenneth@southpole.se>
To: Fortini Matteo <matteo.fortini@mta.it>
In-Reply-To: <4AD33533.5030900@mta.it>
References: <4AD30DF0.1000901@mta.it>
	<7c4144600910120623k2c9aea89ia0f255164f03ff89@mail.gmail.com>
	<4AD33533.5030900@mta.it>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 13 Oct 2009 14:22:25 +0200
Message-Id: <1255436545.4918.70.camel@kenjo-laptop>
Mime-Version: 1.0
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
	Roberto Guerra <roberto.j.guerra@gmail.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-10-12 at 15:54 +0200, Fortini Matteo wrote:
> Yes, that's what we're currently using, but the problem is a little 
> broader: I should answer to CAN messages in at most 100-200ms from 
> powerup, and that can be done in u-boot.

if you are in that interval you definitely need to go to a more exotic
start sequence than usual. 

one solution would be to do as you suggest and do a special driver that
is living outside of the kernel during startup. you still need to hack
into the interrupt code to let your "external" driver handle the CAN.
then you need to hack up the ordinary driver to take over from yours.

I have not seen this solution on any project I worked on but should be
doable. 

optimizing the boot time of linux so it starts up in 200ms is probably
going to be quite hard. I did 2 seconds to /sbin/init started from ide
driver without to much trouble. removing the IDE and going to a root on
NOR would probably get closer to 1.5 but to get down to 200ms would
probably mean removing most of u-boot and only keep the dram setup then
you probably need to remove most of the drivers from the kernel and load
them later as modules. I have never really tried to do a insane fast
boot like this so I'm not sure what problems you will run up against.
but maybe it's possible. but 200ms feels a bit to optimistic.


> However, handing CAN transmission control over to Linux is quite 
> complicated nowadays, since it would involve passing structures in 
> memory and hacking through device init.
> It'd be nice to have a framework with which u-boot could hand-over 
> devices to Linux in a clean and defined way.
not likely to happen as a generic solution. Much better to just remove
the boat loader then and work on optimizing the linux startup code. 
