Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Received: from imagateway.smiths-aerospace.com (host241-chi.smiths-group.com
	[65.216.75.241]) by ozlabs.org (Postfix) with ESMTP id 9E14967A7F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Jan 2005 01:16:33 +1100 (EST)
Message-ID: <41FA4938.90605@smiths-aerospace.com>
Date: Fri, 28 Jan 2005 09:16:24 -0500
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
To: LinuxPPC Support <linuxppc-embedded@ozlabs.org>
References: <BAY1-DAV565FDDF51898BE3F6E73D8B790@phx.gbl>
In-Reply-To: <BAY1-DAV565FDDF51898BE3F6E73D8B790@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: problem executing simple app on ppc target running linux
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Vijay Padiyar wrote:
> Hi
> 
> I have a doubt regarding execution of applications on Linux.
> 
> I am developing applications to execute on an MPC8260 (PowerPC) target. I
> started off by building a toolchain for the target (using Kegel's
> crosstool).
> 
> The compiler created for my target bears the name
> 'powerpc-603e-linux-gnu-gcc.'
> 
> Then I built the Linux 2.6.10 kernel with this cross-compiler and got the
> executable image. I downloaded this image on the target and executed it
> successfully. I have now obtained the Linux command prompt.
> 
> I am using U-Boot 1.1.1 as the bootloader and am loading the JFFS2 partition
> on my Flash directly as the root drive, using the boot argument
> 'root=/dev/mtdblock3.'
> 
> The directory structure on my JFFS2 partition is as follows:
> 
> /bin (with Busybox)
> /dev
> /etc
> /home (for my programs)
> /lib (currently empty)
> /proc (empty)
> /sbin
> /tmp
> /usr - bin, sbin
> /var
> 
> Now, I built a simple "Hello, World!" application with my cross-compiler
> with the following command:
> 
> $ powerpc-603e-linux-gnu-gcc -o hello hello.c
> 
> When I try to execute the resulting file on my target from the Linux kernel
> prompt, I get a message saying:
> 
> /home # ./hello
> /bin/sh: hello: No such file or directory

It didn't find your hello program.  You didn't copy it over, it isn't 
executable, it is in the wrong directory, _______ (fill in the blank).

> When I compile the above file with my native gcc and execute on the target,
> I get a message saying:
> 
> /home # ./hello
> /bin/sh: hello: Line 1: Unexpected '(' in file (or something to that effect)

Running silly things give silly results.

> I know I can't execute apps built with gcc on the target. But why does it
> not work even when built with the cross-compiler?
> 
> Another thing is, how do I compile applications with shared libraries? And
> how do I know which specific shared library files I need to put in the /lib
> and /usr/lib folders on my target JFFS2 partition for the program to execute
> successfully?
> 
> Please give me some guidance. I'm a bit new to Linux.
> 
> Regards
> 
> Vijay Padiyar
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

Wolfgang Denk <http://denx.de> has an Embedded Linux Development Toolkit 
(ELDK) that is a pre-packaged solution for cross compiling, target 
system ramdisks, etc. for 82xx (and 8xx and lots of others) targets.  He 
also has a " The DENX U-Boot and Linux Guide (DULG)" manual that tells 
you lots (perhaps even all :-) of what you need to know.

I have found ELDK and DULG are necessary and sufficient :-).  If you 
understand ELDK and DULG, you will probably be able to answer your own 
questions.

References:
<http://denx.de/e/index1.php?head=docs-head&main=docs&subnav=docs-subnav&logo=logo-se&mainnav=docsnav&bottom=bottom-se>
<http://www.denx.de/twiki/bin/view/DULG/Manual>

gvb
