Message-ID: <36750901.A3E0E6D1@siemens.at>
Date: Mon, 14 Dec 1998 13:48:01 +0100
From: Helmut Buchsbaum <helmut.buchsbaum@siemens.at>
MIME-Version: 1.0
To: LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Problems starting up system on a MPC823FADS
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I try to get a linux system up and running on a Motorola MPC823FADS
board. Here is how far I could get up till now:
 
1) I download the boot code with the compressed kernel image with
MPC8BUG to my board. I only adopted the boot code slightly to feed the
correct board info data, set up the correct clocks, etc., since my board
has no boot prom.

2) The boot code decompresses the image properly and starts it.

3) Setting up MMU works fine, the kernel initializes SMC1 (my console)
and SMC2 for UART and SCC2 for ethernet (I adopted Dan's drivers for the
MPC823, wasn't a big deal ;-) 

4) After resolving some trouble in our local network, I managed to mount
root via nfs.

But:

Now the kernel tries to load & exec /sbin/init and /lib/ld.so.1. Loading
via nfs seems to work fine (haven't had any trouble with this part) but
when the kernel sets up the memory for this process I realized a strange
behaviour after executing the SET_PAGE_DIR macro: after setting the
M_TWB register, the CPU never again reacts on any additional breakpoints
I set! This prevents me from tracking down the problem why /sbin/init is
obviously not started (but nevertheless the kernel becomes idle!).

BTW, why must the M_TWB be set in SET_PAGE_DIR ?

I switched from gcc-2.8.1 to egcs-1.1b as a cross compiler (x86 -->
PPC), but without any success. Probably one of you can give me even the
slightest hint, how I could get any futher!


-- Helmut Buchsbaum


*********************************************************
* Helmut Buchsbaum               * Siemens AG Austria   *
* Tel:   ++43-1-1707-36686       * EZE PN 5             *
* Fax:   ++43-1-1707-55169       * Erdberger Laende 26  *
*                                * A-1030 Vienna/Europe *
*********************************************************
* mailto:Helmut.Buchsbaum@siemens.at                    *
*        buc@eze22.siemens.co.at                        *
*********************************************************

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
