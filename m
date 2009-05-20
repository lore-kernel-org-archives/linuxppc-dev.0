Return-Path: <tmorrison@empirix.com>
Received: from empbedexfe.empirix.com (empbedexfe.empirix.com [12.38.203.54])
	by ozlabs.org (Postfix) with ESMTP id D2AB4DE1D7
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 09:15:51 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: How to debug a hung multi-core system....
Date: Wed, 20 May 2009 19:17:00 -0400
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D90110EFACB2@EMPBEDEX.empirix.com>
From: "Morrison, Tom" <tmorrison@empirix.com>
To: <linuxppc-dev@ozlabs.org>
Cc: "Young, Andrew" <andrew.young@windriver.com>, "Brown,
	Jeff" <jbrown@empirix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

All,

First off, we turned SPE off completely in our build - so we=20
could debug a much deeper problem that seems to be occurring=20
in our application (before we try to find a potential test=20
case for corruption of GPR registers).

We have had this problem for 3 weeks, and just recently have=20
come down to a single test case that makes it fail (although=20
extremely complicated test case)...

Setup:  =20
   Master Blade (8548E) with Linux 2.6.23 (and custom BSP)
   Slave Blade (8572E) with Linux 2.6.23 (and similar custom BSP).

The Master Blade works flawlessly (and also works in a slave=20
capacity too flawlessly). The single 'slave' 8572E blades=20
communicates with the 'master' blade over TCP/IP & PCI Express
(and is running a similar application)...

Running Single Core on slave 8572E (nosmp option on command line)=20
the application works in all conditions (from modestly loaded to=20
well oversubscribed/pegged CPU).

In Multi-core option, the application also works flawlessly. The=20
problem comes when we oversubscribe our application and push=20
this 'slave' blade to the extreme edge of processing (falling=20
behind in our processing...etc).=20

Eventually, sometime between 5-15 minutes, this board becomes=20
hung (where the console becomes completely unresponsive and=20
you cannot 'ping' the box).

I have a JTAG WindRiver ICE and connect to this blade after it=20
is hung, and it appears that both cores are running to some=20
extent:

   Core 1 seems to be Idle loop - happily doing nothing=20
		(and not servicing TCP and/or the console)...

   Core 0 seems to be 'stuck' at the "InstructionStorage"=20
		Exception. And it seems to be going 'nowhere' fast

	SRR0 seems to point to this same spot (0xc00006C0)
	SRR1 value is 0x00021200=20

I am at a loss to see how the kernel (and/or our kernel BSP)=20
cause this exception, and I am even more of a loss on figuring=20
out an application could cause this exception...

Anybody have any ideas - and/or ways to re-configure our=20
setup to obtain more data? Or does this sound familiar to=20
a bug somebody has already found in the kernel?

We are even having trouble defining a test program that can
cause (on purpose) the 'InstructionStorage' Exception (does=20
anybody have an simple 'c' (or ppc assembly) program that=20
causes this exception (so we can run in user application land
and see if the symptoms are similar))?

Thank you in advance for any / all help you can provide....
because I am completely stumped on even how to proceed!

Sincerely,

Tom Morrison
Principal Software Engineer


EMPIRIX=20
20 Crosby Drive - Bedford, MA  01730
p: 781.266.3567 f: 781.266.3670=20
email: tmorrison@empirix.com=20
www.empirix.com
