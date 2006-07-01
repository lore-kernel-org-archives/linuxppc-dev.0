Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.76])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E8CCA679FC
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Jul 2006 09:46:29 +1000 (EST)
Date: Sat, 1 Jul 2006 18:46:25 -0500 (CDT)
Sender: Milton Miller <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
Subject: [0/5][POWERPC] boot: create zImage.kexec #2
To: <linuxppc-dev@ozlabs.org>
Message-id: <kexec-zImage-try2@bga.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
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


Status:  I changed more of the makefile to if_changed_dep.  I updated
the rules to not do if_changed and cmd when changing the same file.

Patches 4 and 5 have been rediffed and __ENTRY__ and __BASE__ are now
caps instead of lowercase in patch 5.

Unfornately I could not get my test and build machines talking due
to network problems, and thereefore was unable to regression test
the output.  Therefore the state is still 'it worked before I moved
code among the files' and 'display-character untested'.

Without [KBUILD] allow any PHONY in if_changed_dep it causes all
the files in boot to be built each time, unless we do some alternative,
either make COPYHEADERS a real dummy that we touch if it doesn't
exist, or just say rebuild all sources when any .h in the kernel
tree changes and collapse the dependency.

Its this fragment:

+$(obj-boot):  COPYHEADERS
+COPYHEADERS:	$(addprefix $(obj)/,$(linuxheader) $(zlibheader))
+PHONY	+= COPYHEADERS




 [1/5][POWERPC] boot: prepare for zImage.kexec
	I tried to keep the changes to main.c and prom.h minimal.  

 [2/5][POWERPC] boot: Add kexec callable zImage wrapper
	The actual code and crt0 for this method.

 [3/5][POWERPC] boot: use more Kbuild rules
	I had a bit of trouble with rebuilds.  This trys to get some
	rules more right.  

	It also renames zliblinuxheader to linuxheader as the next
	patch will add stringify.h to the list, and renames
	OBJCOPYFLAGS to allow usage of the $(objcopy) rule.

 [4/5][POWERPC] boot: Makefile and linker scripts for zImage.kexec
	Delta to above and inker scripts for the existing link.
	zImage.kexec is 32 bit, there is also altnernate link that
	pretends to be 64 bit which allows kexec-tools to load it
	without writing ompat code.

 [5/5][POWERPC] boot: generate lds file from lds.S
	An alterative file ploferations, generate the lds from .S using
	the Kbuild rule.  If you like this patch then I can avoid creating
	two files that are immediately removed.
milton
