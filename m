Message-ID: <20020220033028.94337.qmail@web14911.mail.yahoo.com>
Date: Tue, 19 Feb 2002 19:30:28 -0800 (PST)
From: M S <ms01sg@yahoo.com>
Subject: framebuffer : scrolling problem
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



I am trying to implement the framebuffer driver for
a particular graphics chip in an embedded system using
MPC860. I am using HardHat linux-2.4.2_hhl20.

But I am experiencing some problem with the scrolling.
I intend to use software scrolling and I have disabled
hardware panning by setting disp->scrollmode =
SCROLL_YREDRAW, and my xxfb_pan_display returns
-EINVAL directly.

But whenever I use Pageup (or Up arrow key) or
Pagedown, I get the “Oops: kernel access of bad area,
sig: 11” error. Also my right and left arrow keys work
fine, as long as the cursor can jump over the
characters. But if I am at the end of the command line
and then I press right arrow key, I get the same
error. Similar problem, when I press backspace or left
arrow key, after having reached the beginning of the
command line.

Could there be some problem with the buffer memory or
the problem is in the console code side?

Thanks in advance.


 Oops: kernel access of bad area, sig: 11

 NIP: C0087160 XER: 00000000 LR: C0087154 SP:
C1B0FCA0 REGS: c1b0fbf0
TRAP: 0300

 MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11

 DAR: 00000061, DSISR: 00000409

 TASK = c1b0e000[82] 'bash' Last syscall: 4

 last math 00000000 last altivec 00000000

 GPR00: C0087154 C1B0FCA0 C1B0E000 00000000 00001032
00000007 00000001
00000000

 GPR08: 000004C0 00000061 FFFFFFFF 00000000 C1CD4000
100A9A4C C1B0FD88
C0160000

 GPR16: 00000001 00000000 00000000 FFFFFFFF C1CD4000
00000000 00000000
C1B0FD89

 GPR24: 00000000 00000000 C015BD78 C015BD78 C0120000
C0120000 0000000C
00000636

 Call backtrace:

 C0087154 C008E24C C008F838 C0090010 C007EF78
C00815DC C007C3D8

 C00337EC C000259C 0FE74644 0FE8F4E4 0FE8F3F0
0FE8F8E8 0FE84934

 1007241C 1006F730 1005FE04 1005FDF8 1005FDF8
1005FA54 1005FBA0

 1005FBD4 1005F6DC 10014758 1001460C 100151F8
10015F88 100158F8

 10013824 10013534 10013628 100132F8 10011080


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
