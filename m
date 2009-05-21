Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ABE3CDE186
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 23:13:05 +1000 (EST)
Message-Id: <C966FFF1-23FD-4581-A001-79F6961F8E49@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: "Morrison, Tom" <tmorrison@empirix.com>
In-Reply-To: <BD261180E6D35F4D9D32F3E44FD3D90110EFACB2@EMPBEDEX.empirix.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: How to debug a hung multi-core system....
Date: Thu, 21 May 2009 08:12:42 -0500
References: <BD261180E6D35F4D9D32F3E44FD3D90110EFACB2@EMPBEDEX.empirix.com>
Cc: linuxppc-dev@ozlabs.org, "Young, Andrew" <andrew.young@windriver.com>,
	"Brown, Jeff" <jbrown@empirix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 20, 2009, at 6:17 PM, Morrison, Tom wrote:

> All,
>
> First off, we turned SPE off completely in our build - so we
> could debug a much deeper problem that seems to be occurring
> in our application (before we try to find a potential test
> case for corruption of GPR registers).
>
> We have had this problem for 3 weeks, and just recently have
> come down to a single test case that makes it fail (although
> extremely complicated test case)...
>
> Setup:
>   Master Blade (8548E) with Linux 2.6.23 (and custom BSP)
>   Slave Blade (8572E) with Linux 2.6.23 (and similar custom BSP).
>
> The Master Blade works flawlessly (and also works in a slave
> capacity too flawlessly). The single 'slave' 8572E blades
> communicates with the 'master' blade over TCP/IP & PCI Express
> (and is running a similar application)...
>
> Running Single Core on slave 8572E (nosmp option on command line)
> the application works in all conditions (from modestly loaded to
> well oversubscribed/pegged CPU).
>
> In Multi-core option, the application also works flawlessly. The
> problem comes when we oversubscribe our application and push
> this 'slave' blade to the extreme edge of processing (falling
> behind in our processing...etc).
>
> Eventually, sometime between 5-15 minutes, this board becomes
> hung (where the console becomes completely unresponsive and
> you cannot 'ping' the box).
>
> I have a JTAG WindRiver ICE and connect to this blade after it
> is hung, and it appears that both cores are running to some
> extent:
>
>   Core 1 seems to be Idle loop - happily doing nothing
> 		(and not servicing TCP and/or the console)...
>
>   Core 0 seems to be 'stuck' at the "InstructionStorage"
> 		Exception. And it seems to be going 'nowhere' fast
>
> 	SRR0 seems to point to this same spot (0xc00006C0)
> 	SRR1 value is 0x00021200
>
> I am at a loss to see how the kernel (and/or our kernel BSP)
> cause this exception, and I am even more of a loss on figuring
> out an application could cause this exception...

This is a bit odd as we shouldn't see an ISI from 0xc00006C0.

Are you able to single step Core0?  Can you dump the contents of the  
TLBs on Core0

> Anybody have any ideas - and/or ways to re-configure our
> setup to obtain more data? Or does this sound familiar to
> a bug somebody has already found in the kernel?
>
> We are even having trouble defining a test program that can
> cause (on purpose) the 'InstructionStorage' Exception (does
> anybody have an simple 'c' (or ppc assembly) program that
> causes this exception (so we can run in user application land
> and see if the symptoms are similar))?
>
> Thank you in advance for any / all help you can provide....
> because I am completely stumped on even how to proceed!


Is your application generating a lot of processes or have a lot of  
concurrent processes on the 8572?

- k
