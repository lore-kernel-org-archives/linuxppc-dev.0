Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: jtm@smoothsmoothie.com
Date: Wed, 21 Feb 2001 23:18:31 -0600
To: linuxppc-embedded@lists.linuxppc.org
Subject: 8260 console problems
Message-ID: <20010221231831.A19177@shamus.smoothsmoothie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've been trying to get Linux going on an 8260 board (EST's SBC8260 eval
board to be exact) and I have ppcboot starting the kernel. ppcboot sets
up SMC1 at 9600 bps as its console, and when Linux starts up, it
starts running SMC1 at 115200 bps. How do I make Linux keep SMC1
at 9600 bps?

Then, the kernel prints out some stuff, and after the message:
	CPM UART is SMC1
    (The message is from memory, so it might not be exact.)

Output stops for a while, then I get garbage that looks like
it changed baud rates on me again. If I look in log_buf, I can
see that the kernel did continue up to the point where it starts
sending out BOOTP requests. I'm guessing that ouput stops while
the kernel is in rs_8xx_init(), which sets up the SMC.

Is there something that I should be doing that will fix
all of this? I'm using a plain 2.4.1 kernel (from ftp.kernel.org)
and my .config file is a copy of arch/ppc/configs/est8260_defconfig.

Thanks for any help

--
Jay Monkman	    The truth knocks on the door and you say "Go away, I'm
monkman@jump.net    looking for the truth," and so it goes away. Puzzling.
		     - from _Zen_and_the_Art_of_Motorcycle_Maintenance_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
