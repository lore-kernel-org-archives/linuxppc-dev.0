Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3FBD6775.C471A57B@ghs.com>
Date: Thu, 20 Nov 2003 17:16:37 -0800
From: Jeff Mintz <jmintz@ghs.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Network problem when using jtag debugger on EP8260
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am attempting to debug the Linux Kernel on an Embedded Planet 8260
board,
using a COP JTAG debugger.  I am encountering a behavior where when I
halt
the kernel, and resume, the kernel's ability to access the network seems
to
be disturbed.  I am wondering if anyone has seen something like this
before.

Let me clarify the problem:

[Case 1]
- I boot the Linux kernel (version 2.4.22, obtained from Embedded
Planet)
- When I get to the prompt, I halt the target using the debugger.  The
target always seems to halt at address 0x904.
- I resume the target.  A network access (such as "ls") takes about 7
seconds, instead of being instantaneous.  (I'm not using a ramdisk, so
ls
uses NFS).
- If I halt and resume again, network access is slowed down even
further, certainly to the point of being unusable.

[Case 2]
- When I get to the prompt, I issue the command "while(true); do true;
done" which sets the kernel off and running infinitely (until I stop it
with Ctrl-C).
- Using the debugger, I halt the target.  I am not at 0x904, but
somewhere else, either in the kernel code, or in what seems to be a user

application page.
- I can stop, singlestep, resume, set and hit breakpoints using the
debugger.  When I finally stop the while loop, the network is fine.  All

of my debugging activity did nothing to disturb network access.

[Case 3]
- Same as Case 2.  This time, after halting the target, I set a
breakpoint on the first line in the function fcc_enet_rx.  I resume the
target.  This breakpoint is hit about 15 times, and then it is not hit
anymore.  When I attempt to stop the while loop, the network access has
been disturbed.

[Case 4]
- Same as Case 1.  This time, before I halt the target using the
debugger,
I unplug the ethernet cable.  Then I halt the target, and it is again
at 0x904.
- Now I resume the target using the debugger.
- Now I plug in the ethernet cable to the target again.
- Network accesses (i.e. ls) works fine.


My primary goal is to fix Case 1.  I do not want to lose network access
when I halt the kernel when it is idle.  Case 2 gives me hope that this
is possible, because this is a case where I can halt the Linux kernel
without disturbing the network access.

The JTAG debugger I am using is a Green Hills Probe.  I have also tried
with
an Agilent E5900B Emulation Probe and seen similar behavior.

Some questions:
- Has anyone seen this before?  If so, is there a known remedy or
workaround?  (For example, is there a kernel patch?  Is there a way to
recover from this slowed network state?)  If not, does anyone have
a theory to explain why I am seeing this behavior?
- Does this occur on the BDI2000 debugger?  I don't have access to one
of
those, but I hear that is the best JTAG debugger for Linux.  If anyone
can
easily try some of these test cases on other debuggers and let me know
the
results, that would be helpful.
- Is there any reason to think that the scenario I described in Case 1,
halting the target while at the shell prompt, is something that users
typically don't do (and hence, I shouldn't worry about it)?


Thanks in advance,
Jeff Mintz
Green Hills Software


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
