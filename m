Return-Path: <petermendham@computing.dundee.ac.uk>
Received: from uncle.computing.dundee.ac.uk (unknown [134.36.36.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DA71BDE23B
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Jul 2008 18:49:58 +1000 (EST)
Received: from mailex.computing.dundee.ac.uk (mailex.computing.dundee.ac.uk
	[134.36.36.15])
	by uncle.computing.dundee.ac.uk (8.13.1/8.13.1) with ESMTP id
	m628ndVn004811
	for <linuxppc-embedded@ozlabs.org>; Wed, 2 Jul 2008 09:49:50 +0100
Message-ID: <486B4122.90909@computing.dundee.ac.uk>
Date: Wed, 02 Jul 2008 09:49:38 +0100
From: Peter Mendham <petermendham@computing.dundee.ac.uk>
MIME-Version: 1.0
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: Linux on Virtex board with ARCH=powerpc
References: <4860B81F.6070205@computing.dundee.ac.uk>	<20080624140532.E77E333006C@mail5-sin.bigfish.com>	<48614927.8020406@computing.dundee.ac.uk>	<20080624195027.01963640077@mail214-sin.bigfish.com>	<48626FAC.2070904@computing.dundee.ac.uk>	<20080625203435.D3C46778055@mail212-sin.bigfish.com>	<48639871.9020204@computing.dundee.ac.uk>	<20080626132905.2779E1F007F@mail24-dub.bigfish.com>	<4864DD66.5040909@computing.dundee.ac.uk>
	<874p7eeodw.fsf@macbook.be.48ers.dk>
In-Reply-To: <874p7eeodw.fsf@macbook.be.48ers.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: John Linn <John.Linn@xilinx.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

Peter Korsgaard wrote:
> Hi,
>
>  Peter> I now have a new and rather bizarre problem, which maybe you
>  Peter> or someone else has met before.  I have a simple FPGA design
>  Peter> with memory, a sysace and a uart16550 on an ML405 (I've put my
>  Peter> hardware to one side for the moment).  It works just fine.  If
>  Peter> I swap the uart16550 for a uartlite (remaking the kernel with
>  Peter> the correct device tree) I see all the boot messages and the
>  Peter> kernel seems to start OK, the root partition is mounted but
>  Peter> then I see nothing from /sbin/init.  This is the same root fs
>  Peter> that I was using with the uart16550 example I just mentioned.
>
> Did you remember to change your inittab to use /dev/ttyUL0?
>   
Yes, I'm using a buildroot/busybox system and have changed inittab and 
securetty for ttyUL0.  From what I understand, initialisation lines in a 
busybox inittab that do not specify a tty at the beginning go out on 
/dev/console.  To collaborate this, if I set my hardware up for a 
uart16550 and leave the inittab specifying ttyUL0, I see the messages 
from the init scripts (which must be going to console) but then I 
messages (again on console I guess) saying that ttyUL0 doesn't exist.  
When I try things the other way round, I don't see anything at all (none 
of the stuff that I think is going to console) and it doesn't moan at 
me.  Which I guess means something is wrong with /dev/console?

-- Peter

The University of Dundee is a Scottish Registered Charity, No. SC015096.
