Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <607BF0A2B4F3D411A09500508BC225427E833F@mailctx.datum.com>
From: Geoff Wyche <GWyche@DATUM.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: SELF/busybox problems?
Date: Mon, 5 Nov 2001 15:30:32 -0800 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,

I've posted about these problems before, but I have more details now.  Any
suggestions would be greatly appreciated as I've been wracking my brain on
them for a while.

My embedded 860T system is having two problems, and I can't seem to make
progress on either of them.

I've got a linuxppc_2_4 kernel rsync'd from mvista.com, with some patches
from Wolfgang Denk applied:
PATCH-000-LOCAL          PATCH-009-buzzer-driver
PATCH-014-status-LED-driver  PATCH-019-warning-cleanup
PATCH-004-Board-Support  PATCH-010-82xx-Disable-DCache
PATCH-015-i2c-driver         PATCH-020-UNSORTED-FIXES
PATCH-005-dpfree+uart    PATCH-011-8xx-watchdog-driver   PATCH-016-IDIF-BSP
PATCH-006-lcd823-driver  PATCH-012-IP860-VMEBus-Support  PATCH-017-LWMON-BSP
PATCH-008-flash-driver   PATCH-013-RTC-drivers
PATCH-018-commproc.h

I'm currently using this little patch of my own in arch/ppc/8xx_io/uart.c:

#define CONFIG_SERIAL_CONSOLE_PORT 1
#if 1
static struct serial_state rs_table[] = {
        /* UART CLK   PORT          IRQ      FLAGS  NUM   */
        { 0,     0, PROFF_SCC1, CPMVEC_SCC1,   0,    (NUM_IS_SCC | 0) },
/* SCC1 ttyS0 */
        { 0,     0, PROFF_SCC2, CPMVEC_SCC2,   0,    (NUM_IS_SCC | 1) },
/* SCC2 ttyS1 */
};
#else
...
#endif
(and I'm not using CTS/DTR/etc. signals on either serial port)

First, when I run the SELF distribution with a dynamically linked BusyBox,
it crashes with a "software check" at address 0x30015f78.  I haven't been
able to figure out what's loaded at linear address 0x30000000.  My guess is
there's something wrong with my glibc-2.2.3

If I then recompile busybox with DO_STATIC=true, the CPU seems to hang, but
my debugger (visionCLICK 7.0 under windows NT via BDM port) is no longer
able to communicate with the processor.  If I then issue a CPU reset via the
BDM, the CPU reboots after a bit (software watchdog timeout?) and runs past
where it would hang before.

I then get a proper busybox shell prompt.  This sequence (boot, hang, issue
reset, boot, nohang) happens repeatably.  It hangs very shortly after
starting /sbin/init, but the second time, it runs.  Always.

The second problem is with the serial console line.  Once per second, BB's
init program wakes up and checks for respawns or respawns something.
Whatever that something is (/bin/application?) opens and closes the console.

Every time it opens and closes the console, it somehow steals characters
from the serial port buffer.

For example:
------------------------------------------------------------------
BusyBox v0.51 (2001.11.05-22:57+0000) Built-in shell (lash)
Enter 'help' for a list of built-in commands.

/ # ls
s
bin         ftp         linuxrc     proc        var
dev         home        lost+found  sbin
etc         lib         opt         tmp
/ # ls
s
sh: s: No such file or directory
/ #
------------------------------------------------------------------
In the first case, I typed 'ls' and pressed enter immediately.  I got a
proper listing (but what's that echoed 's' line???)

In the second case, I typed 'l' then waited a few seconds, typed 's' and hit
return, the 'l' got eaten somehow.

More information needed?  I'd be glad to supply it -- like I've said, I've
been banging my head on this one for a while.

--Geoff
gwyche@datum.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
