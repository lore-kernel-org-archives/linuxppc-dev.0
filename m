Return-Path: <dhlii@dlasys.net>
Received: from xm.dlasys.net (unknown [24.152.213.223])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1FAEB68A2C
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 Jan 2006 21:18:58 +1100 (EST)
Message-ID: <43BF65F2.3030705@dlasys.net>
Date: Sat, 07 Jan 2006 01:55:46 -0500
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
References: <11359385991901-git-send-email-grant.likely@secretlab.ca>	<43B5E37A.4020008@dlasys.net>	<43B601CC.1000102@secretlab.ca>
	<43B6B32A.5060606@dlasys.net> <43B95448.3040407@secretlab.ca>
	<43BC57C1.6010807@comcast.net> <43BF0736.4050703@secretlab.ca>
In-Reply-To: <43BF0736.4050703@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: RESEND:[RFC] Pico E12 (Xilinx V4) patches to 2.6.15
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

	I have cut out most of the patch and embedded my responses to your
comments. I appreciate your input and will try to get things cleaned up.

	I solved what I believe was my last critical porting issue, and now
have Linux on the E12 booting into sash.

	Pico has what they need for the moment, and I have two other projects
to get to. But I would like to submit what I have that might be useful
to others.
	As I see this it breaks into several major items:

	Xilinx UartLite support compliant with the 2.6 serial driver model. I
can break that into a separate patch. I can disable the debugging -
though I would prefer not to remove the code yet.
	Should I divide out the early boot part - uartlite_dbg.c and
uartlite_tty.c from the final serial driver ? I see them as belonging
together. There are very few serial devices that have boot to bash
serial support. As soon as I can figure out how to create a selective
patch I can do that. Does the UartLite stuff get submitted here or is
the a preferred place for Serial drivers ? The Uartlite is exclusively a
Xilinx item, and almost exclusively a ppc item (you can put one on a
MicroBlaze).

	Minimal Virtex-IV support. I see this as less important, you as well as
other seem to be doing it. Pico has what they need and I will conform it
to whatever makes its way into the kernel later. I would be happy to
submit it, but there probably should be only one set of V4 code, and due
to the constraints of the E12 I have an extremely minimal V4
implimentation. Also this is my first Linux port. The rest of you know
more about what you are doing.

	E12 support. Both I an Pico are glad to hear that there is even minimal
interest in including the E12 in the distribution kernel. But at the
moment Pico's clients will likely get support directly. Aside from the
benefits to my ego, the immediate value is to people doing other ports.
Benefits to Pico are long term not short term. The E12 is the first (and
smallest) of a family of devices. Right now this port is E12 specific,
but it is my expectation that it will become a generic Pico port - they
all have keyhole ports, they all use Virtex IV's.



Grant Likely wrote:
> David H. Lynch Jr. wrote:

> Your right; git uses unified by default.  You'll need to start reading
> them.  If found *lots* of stuff in this patch that shouldn't be there.

	I sort of expected that. I am used to other version controll systems,
such as cvs, subversion, sourcesafe, vault, ... where you can commit
what you want when you want, add in lots of personal or temporary
debugging changes, and then clean the out and still eaisly go back and
get them when you want.

	The model for git and I suspect bitkeeper, and kernel development in
general is completely different. I think I understand basically how git
works, but that is not the same as completely trusting that I understand
how it works.

 >>There are basically 5 parts, and I have no idea how to easily separate
>>the pieces:
> 
> Commit to your git tree frequently and commit related files at the same
> time.  Then you can bring up a list of all your commits and coalate
> related changes into a single patch.

	I appreciate the need to separate the functionality into discrete
patches. The issue - besides learning how to do that is that it does not
correspond to the way things have developed. As an example, I have been
tracing down a problem executing /init (or any initial shell).
At first I thought it was a console output problem - attempting to
isolate that resulted in the addition of an enormous amount of debugging
to the serial driver(2). hen I decided the problem had to be elsewhere
so I started adding debugging into various sys_calls - more to figure
out where I was going than anything else. Then I found I could turn on
SHOW_SYSCALLS, that lead to more debugging in the functions closet to
the actual failure, The problem turned out to be overwriting the
temporary debug IO TLB entry, and not switching to using the virtual
address created by ioremap. So now I have all this debugging all over
the place - mostly turned off. I understand that nobody wants all that
in the kernel, but although I do not need it right now,  until I am
comfortable enough with git to know I can save it, blow it away and
retreive it again later, I am not ready to part with it.

	Regardless, the bottom line is that I need to get more proficient with
git - I think I learn fairly fast, but there is alot to digest.

	My apologies for having to digest that massive diff.

> 
> BTW, many of the long lines were word wrapped (making an unusable
> patch).  You should attach the diff instead of pasting it into thunderbird.
	I thought I did. But I have computer issues at the moment. My primary
development laptop died. My backup laptop started dying, and I am now
working on a desktop that I just built a week ago. I have re-installed
thunderbird and firefox, and linux, and windows (I have paying windows
clients) too many times over the past month. I thought I migrated my
thunderbird profile correctly, but I keep noticing that attachements end
up either inline or separate seemingly at random.
	It would be really nice if I could spend alot less time working on
equipemnt and more on programming. I have to get back to a laptop anyway
- or get bifocals, but I am trying to pretend I am not old enough to
need them yet.

>> 	prompt "Processor Type"
>>-	default 6xx
>>+	default 4xx
> 
> You don't want to do this... Your defconfig file should set it instead.

	I only just recently saw some info on utilizing defconfig files - I
beleive in another of your posts. One of the problems with not knowing
how others do things is that you re-invent the wheel.
	
	Regardles, I do understand.
		Figure out how to break the patches up into logical peices.
		Figure out how to exclude what are essentially private convenience or
debugging changes from submitted patches.




>>+#ifdef CONFIG_XILINX_UARTLITE_CONSOLE
>>+#LIBS				+= $(TOPDIR)/drivers/char/xilinx_uartlite/xuartlite_l.o
>>+#endif
>>+# ifeq ($(CONFIG_XILINX_ML300),y)
>>+# CFLAGS_xuartlite_tty.o		+= -I$(TOPDIR)/drivers/char/xilinx_uartlite
>>+# EXTRA_CFLAGS			+= -I$(TOPDIR)/arch/ppc/platforms/xilinx_ocp \
>>+# 					-I$(TOPDIR)/drivers/i2c/xilinx_iic
>>+# endif
> 
> 
> Wrong place for this; should be done in:
> drivers/char/xilinx_uartlite/Makefile

	Actually it is commented out and does not belong at all. I breifly
toyed with trying to port the xilinx 2.4 serial drivers to 2.6, and this
represents an early attempt at merging them into the 2.6 tree.
I am still learning proficiency with the configuration/makefile language
of kernel building, and this was an early attempt to migrate the 2.4 stuff.
	At present I am not using the Xilinx UartLite driver. I have a newer
one of my own that was in this patch, and as of a few days ago it
appears to be working.


>> start_:
>>+#if defined(CONFIG_XILINX_ML300) || defined(CONFIG_PICO_E12) /* PPC
>>errata 213: only for Virtex-4 */
>>+	mfccr0	0
>>+	oris	0,0,0x50000000@h
>>+	mtccr0	0
>>+#endif
> 
> 
> ML300 doesn't have this issue.

	I don't have an ML300 or any other Xilinx development board. I borrowed
this from somebody else's code for the ML300.
	I am assuming this should change to defined(CONFIG_VIRTEX_IV) ?

>>+static int MillisecTimeout=1000;
>>+void usleep(int t) {
>>+   int ii, waitTime=100;
>>+    while(t) {
>>+    	for (ii=0; ii < MillisecTimeout*1000/waitTime; ii++){};
>>+	t--;
>>+    }
>>+}
> 
> 
> umm, isn't udelay already defined in the kernel?

	Probably is, and I probably should be using it, but I started with
working code to write to the device standalone, and incorporated it into
the driver. The same code is repeated in the boot serial code - but
there I do not have access to kernel resources.




>>@@ -180,11 +192,16 @@ load_kernel(unsigned long load_addr, int
>> #ifdef CONFIG_CMDLINE_BOOL
>> 	memcpy (cmd_line, compiled_string, sizeof(compiled_string));
>> #else
>>+// INITRAMFS and initrd should be handled the same.
>>+#ifdef CONFIG_INITRAMFS_SOURCE
>>+	memcpy (cmd_line, ramroot_string, sizeof(ramroot_string));
>>+#else
>> 	if ( initrd_size )
>> 		memcpy (cmd_line, ramroot_string, sizeof(ramroot_string));
>> 	else
>> 		memcpy (cmd_line, netroot_string, sizeof(netroot_string));
>> #endif
>>+#endif
> 
> why?
	I think this is a fix for a 2.6/INITRAMFS bug.
	If you use initramfs
		but do not turn on CONFIG_INITRD
		and you do not provide a command line
			(either in the config file,
			or via a boot argument)
	then you get the netroot_string command line

	Which is NOT what you want for INITRAMFS.

	I am sure there is a better way of coding this.
	This was just a quick and dirty solution that got cut in
	when I turned off a config file command line and suddenly discovered I
was trying to boot off the net.








> 
> 
> 
> <--- snip --->
> 
>>diff --git a/arch/ppc/boot/simple/uartlite_tty.c
>>b/arch/ppc/boot/simple/uartlite_tty.c
> 
> 
> Russell King needs to be CC'd on serial stuff; but looks okay from a
> real-quick look
	The uartlite_dbg.c uartlite_tty.c, keyhole_dbg.c, keyhole_dbg.c code
and the CONFIG's controlling them, and the #ifdef's through the boot
code dealing with them are all working fine and have been for atleast
two months. The keyhole_early.c and uartlite_early.c code, once worked,
but when I dicoverd that I could switch pretty much directly from the
reall early stuff to the final serial driver without the _early stuff I
quit work on it, so I probably should discard it.
	I can not tell what use xxxx_early is if there is an xxxx_dbg and xxx_tty.




> This stuff all conflicts with my patches of course; but that's to be
> expected.  :)  Looks okay otherwise

	I will try to pull and apply your patches and see if I can rework things.


> this is just a copy of xilinx_ml300 and modified for the e12; I didn't
> look deep into it; but seems okay.
	Correct, it seems to be working, that is what I care about.
	There are obviously significant similarities. The most fundimental
issue, is that the only certain hardware with the E12 is the PPC405, the
MMU, and the Keyhole (and maybe not that) The PIC, the NIC, almost
everything else may or may not be there.
	Pico has just provided me with new firmware that includes a PIC, but
that is for a specific client application where it is required. I have
to have something that can build with or without it.


>>diff --git a/arch/ppc/syslib/keyhole.h b/arch/ppc/syslib/keyhole.h
>>new file mode 100644
>>index 0000000..4b7a374
>>--- /dev/null
>>+++ b/arch/ppc/syslib/keyhole.h
>>@@ -0,0 +1,17 @@
>>+/*
>>+ * arch/ppc/syslib/keyhole.h
>>+ *
>>+ * keyhole prototypes
>>+ *
>>+ * Matt Porter <mporter@kernel.crashing.org>
> 
> 
> You can add your name to the copyright list.
	The majority of my code started with something borrowed. I have done
very little with the headers yet to make sure credit and blame are
appropriately assigned.

	I found the references in Documentation, and have to make a pass
through to pic those things up.



> 
>>+++ b/arch/ppc/syslib/keyhole_dbg.c
>>@@ -0,0 +1,148 @@
>>+/*
>>+ * arch/ppc/syslib/keyhole_dbg.c
>>+ *
>>+ * Bootloader version of the embedded Xilinx/KEYHOLE driver.
>>+ *
>>+ * Author: David H. Lynch Jr. <dhlii@dlasys.net>
>>+ *
>>+ * 2005 (c) DLA Systems  This file is licensed under
>>+ * the terms of the GNU General Public License version 2.  This program
>>+ * is licensed "as is" without any warranty of any kind, whether express
>>+ * or implied.
>>+ */
>>+
>>+#include <linux/config.h>
>>+#include <linux/serial_keyhole.h>
>>+#include <linux/serial.h>
>>+#include <linux/tty.h>		/* For linux/serial_core.h */
>>+#include <linux/serial_core.h>
>>+#include <linux/serialP.h>
>>+// #include <linux/serial_reg.h>
>>+#include <asm/serial.h>
>>+
>>+
>>+/* SERIAL_PORT_DFNS is defined in <asm/serial.h> */
>>+#ifndef SERIAL_PORT_DFNS
>>+#define SERIAL_PORT_DFNS
>>+#endif
>>+
>>+static struct serial_state rs_table[RS_TABLE_SIZE] = {
>>+	SERIAL_PORT_DFNS	/* defined in <asm/serial.h> */
>>+};
>>+static int MillisecTimeout=1000;
>>+void usleep(int t) {
>>+   int ii, waitTime=100;
>>+    while(t) {
>>+    	for (ii=0; ii < MillisecTimeout*1000/waitTime; ii++){};
>>+	t--;
>>+    }
>>+}
> 
> 
> again; what about udelay?
	I beleive this is either before there is a kernel, or certainly before
the kernel is initialized.

>>+#if defined(CONFIG_PICO_DEBUG)
>>+#define DEBUG_PRINTK(fmt...)	_printk(fmt)
>>+#else
>>+#define DEBUG_PRINTK(fmt...)	do { } while (0)
>>+#endif
>>+#define _printk printk
> 
> 
> The code cleanliness police will probably have something to say about
> you defining your own debug macros.  :)

	I sort of stole these from elsewhere. Further, they do not appear to
always work - but the style guide suguested macros were preferred to
#ifdef's.
	 I guess if you do not like this you are really going to appreciate my
private copy of _printk.
	It is time for it to go away, but it was really useful having a
different and working output device while debugging the serial driver.
	It is unnescacry now.



>>+pico/cross
>>\ No newline at end of file
> 
> 
> ???
	I noticed that too. I have no idea what git diff was talking about.

>>diff --git a/drivers/serial/keyhole.c b/drivers/serial/keyhole.c
>>diff --git a/drivers/serial/keyhole.h b/drivers/serial/keyhole.h
> 
> 
> I didn't review these; sorry
	It does not matter they were close but did not work in the version I
sent to you. They are fixed now.

	The E12 uses its unique KEYHOLE fifo (that eventually will support
multiple ttyS's as well as other communications channels to the
Linux/Windows development host.
	For the moment the only thing that works is using that fifo as a
pseudo serial device for a console or debugging. But it does work.

	The UartLite drivers and the Keyhole drivers are deliberately as nearly
identical as possible. They in turn borrowed heavily from the m32r_sio
driver (for simple answers) and the 8250 driver - because as complex as
it is I assumed it is likely to be the most heavily tested serial driver
in Linux.

>>diff --git a/drivers/serial/printk.c b/drivers/serial/printk.c
>>new file mode 100644
>>index 0000000..5e87489
>>--- /dev/null
>>+++ b/drivers/serial/printk.c
>>@@ -0,0 +1,267 @@
>>+/*
>>+ * arch/ppc/kernel/printf.c
>>+ *
>>+ * early printk code code (almost) all platforms can use
>>+ *
>>+ * Author: David H. Lynch Jr. <dhlii@dlasys.net>
>>+ *
>>+ * Derived heavily from arch/ppc/boot/common/misc-common1.c
>>+ *
>>+ * 20050 (c) DLA Systems This file is licensed under
>>+ * the terms of the GNU General Public License version 2.  This program
>>+ * is licensed "as is" without any warranty of any kind, whether express
>>+ * or implied.
>>+ */
> 
> You'll need to run this stuff by Tom Rini.

	It was solely for debugging. It works well, but it does not need to be
in the kernel.

	Speaking of which. At this point the Keyhole and Uartlite drivers
actually work and are at what I would call an early beta/late alpha
stage. I have debugging disabled but not removed. I am not likely to
remove it until they have had a lot more testing.

	Probably the most broadly useful part of this massive patch it the
UartLite driver - it should work on any Xilinx FPGA implementing the
UartLite. (including uCLinux on the MicroBlaze) I think it is a perfect
candidate for a separate patch.

	I can submit it now - with all the debugging in (but disabled), or
after it has had a month or so of testing at Pico, without debugging.

	The same thing is true of the Keyhole - but it is not broadly useful.
	The E12 stuff is also just about ready for early beta testing, but Pico
already knows who has their board and wants Linux. So except as it might
be useful to others porting to the Virtex IV, I am not sure that needs
pushed.








>> #ifdef CONFIG_40x
>>diff --git a/include/asm-ppc/ocp_ids.h b/include/asm-ppc/ocp_ids.h
>>index 8ae4b31..5a09b94 100644
>>--- a/include/asm-ppc/ocp_ids.h
>>+++ b/include/asm-ppc/ocp_ids.h
>>@@ -27,6 +27,7 @@
>> #define OCP_VENDOR_IBM		0x1014
>> #define OCP_VENDOR_MOTOROLA	OCP_VENDOR_FREESCALE
>> #define	OCP_VENDOR_XILINX	0x10ee
>>+#define	OCP_VENDOR_PICO 	0x10ef				// pseudo ID
>> #define	OCP_VENDOR_UNKNOWN	0xFFFF
	I was hoping for some feedback on OCP_VENDOR_PICO ?

	Is there an official place to register/assign these ?


>>
>> /* device identification */
>>diff --git a/include/asm-ppc/reg_booke.h b/include/asm-ppc/reg_booke.h
>>index 00ad9c7..5221970 100644
>>--- a/include/asm-ppc/reg_booke.h
>>+++ b/include/asm-ppc/reg_booke.h
>>@@ -120,6 +120,11 @@ do {						\
>> #elif defined(CONFIG_BOOKE)
>> #define MSR_KERNEL	(MSR_ME|MSR_RI|MSR_CE)
>> #endif
>>+#if defined (CONFIG_PICO_E12)
>>+// The E12 seems to generate spurious Machine Checks - disable them.
>>+#undef MSR_KERNEL
>>+#define MSR_KERNEL	(MSR_RI|MSR_IR|MSR_DR|MSR_CE)
>>+#endif
> 
> 
> Ugh; this worries me.

	Most of the work of porting Linux to the E12 took about 1 week.
	Tracking this down took three weeks all by itself.
	
	Pico swears that the Machine Check line is not just dangling in space.
But if I turn on Machine Check Exceptions, I never get from Real to
virtual mode. There is an enormous amount of code you tripped over in
head_4xx.S that was primarily to find this problem.

	I do not know what to say here. I do not like this either.
The original E12 firmware had the flash at 0x0 and the ram at 0x8000000
or something like that. My personal suspicion is that when they
re-arranged the memory map to org 0 the ram, they did not get something
right and even though everything else is working, it is causing machine
checks- but that is just a guess. I am not part of Pico. I am a
consultant for them. I have a very close relationship and the respect of
the owner, but he is both brilliant and stubborn and if there is an
actual hardware problem it is not going to get fixed until something
else reveals it. In the meantime disabling Machine Checks allowed me to
finish the port.


>
> 
> 
> Ugh! I'm not doing that again.  Make sure your next patch set is broken
> up into bite size emails.  That was far too long.
> 
> g.
> 

	Thank You.
