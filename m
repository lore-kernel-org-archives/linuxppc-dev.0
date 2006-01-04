Return-Path: <nathael.pajani@cpe.fr>
Received: from smtp-out.completel.net (smtp-out.completel.net [83.145.110.36])
	by ozlabs.org (Postfix) with ESMTP id 37E3E689AA
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Jan 2006 00:40:56 +1100 (EST)
Received: from linuxdev.ECRIN-CROLLES (unknown [83.145.98.3])
	by smtp-out.completel.net (Postfix) with ESMTP id D1ABC280031
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 Jan 2006 14:40:54 +0100 (CET)
Date: Wed, 4 Jan 2006 14:44:40 +0100
From: Nathael Pajani <nathael.pajani@cpe.fr>
To: linuxppc-embedded@ozlabs.org
Message-Id: <20060104144440.5af3d88d.nathael.pajani@cpe.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: Cross Compiling driver for PPC
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

> We are trying to port a newly developed device driver for powerPC .
> We are unable to compile it for powerpc driver on Host platform.
> Please give us the way to compile the device driver
=20
You need to cross compile, which means having a ggc for powerpc in addition=
 to the gcc you have for your developpement machine.
I do not know whether you will find it on the net, usualy you have to recom=
pile gcc (and "ld" and "ar" and so on, the whole gcc toolchain I think) wit=
h specific options

Then you will have a powerpc-linux-gcc (for example) which will be able to =
compile for powerpc
then, you will have some modifications to do in the makefiles: look for thi=
s string: "CROSS_COMPILE" and set it to "powerpc-linux-" (or whatever is th=
e prefix for you gcc).
I also created a ".arch" file at the base of the source tree, containing "p=
pc" and some other modifications in makefiles, but I cannot tell you wich..=
. and wether they are usefull. You'll have to try.

Then add "ARCH=3Dppc" option to the make command when you want to compile y=
our kernel for powerpc.

Have fun.
+++

----=20
Nathael PAJANI
Ing=E9nieur CPE Lyon
nathael.pajani@cpe.fr
