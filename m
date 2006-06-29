Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.76])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7A9DB67AC7
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jun 2006 23:44:57 +1000 (EST)
Date: Thu, 29 Jun 2006 08:24:14 -0500 (CDT)
Message-Id: <200606291324.k5TDOEwV098163@sullivan.realtime.net>
From: Milton Miller <miltonm@bga.com>
Subject: [0/5][POWERPC] boot: create zImage.kexec 
To: <linuxppc-dev@ozlabs.org>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

What follows is a series of 5 patches that take the existing zImge code
from the arch/powerpc/boot directory and add an alternative image that
will boot with a device tree struct but not with a prom interface
callback.

It searches the flat device tree (read-only) to find the
memory size, reserved ranges, and  rtas.  Messages are sent through
rtas to eiher the new for cell put-term-char or display-character
interfaces.



 [1/5][POWERPC] boot: prepare for zImage.kexec
	I tried to keep the changes to main.c and prom.h minimal.  

 [2/5][POWERPC] boot: Add kexec callable zImage wrapper
	The actual code and crt0 for this method.

 [3/5][POWERPC] boot: use more Kbuild rules
	I had a bit of trouble with rebuilds.  This trys to get some
	rules more right.  However, the final target changes to cmd
	should go to if_changed and add FORCE to the dependency
	(rebuild gets make[2]: arch/powerpc/boot/zImage is up to date..

	It also renames linuxheader to be more generic and renames
	OBJCOPYFLAGS to allow usage of the $(objcopy) rule.

 [4/5][POWERPC] boot: Makefile and linker scripts for zImage.kexec
	delta to above and inker scripts for the existing link.
	zImage.kexec is 32 biz, there is also altnernate link that
	pretends to be 64 bit which allows kexec-tools to load it
	without writing ompat code.

 [5/5][POWERPC] boot: generate lds file from lds.S
	An alterative file ploferations, generate the lds from .S using
	the Kbuild rule.  If you like this patch then I can avoid creating
	two files that are immediately removed.

Status:  The patch survived 3 kexec reboots with a large initramfs yesterday.
Since then I reworked the Makefile and rearranged include files.  It compiles
clean, and if it passes a regression then I think its mergable.  The 
is up to date regression in patch 3 and taking the update in 5, as well as
actually trying to use this version are my any hesitations.  The rtas
display-character has not been tested and is commented out

milton
