Message-ID: <20011015012627.50367.qmail@web20108.mail.yahoo.com>
Date: Sun, 14 Oct 2001 18:26:27 -0700 (PDT)
From: John Francis <johnfrancsis@yahoo.com>
Subject: Software watchdog timer doesn't work for 860P , using ppcboot and 2.4 linux
To: ppcboot-users@lists.sourceforge.net,
	linuxppc-embedded@lists.linuxppc.org
Cc: roelensj@agcs.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I am having a problem using the software watchdog
feature. My board has 860 running at 80Mhz.

When I enable software watchdog using CONFIG_WATCHDOG
in my board config*.h file for PPCBoot, the system
resets while decompressing the ramdisk.

I have used the patch that modifies the 2.4.X kernel
that was posted while back. on ppcboot mailing list.

Ref. url -

http://www.geocrawler.com/archives/3/4205/2001/7/50/6264938/


If I use the patch mentioned above, but don't enable
the software watchdog, in bootrom, I can see that the
timer interrupt is getting called and everything in
patch above looks like it works.

It seems like some where before the timer_interrupt is
installed/enabled in 2.4.x kernel watchdog is going
off.

Before I go and look into hacking away at head_8xx.S
file in directory linux/arch/ppc/kernel
I thought I would ask folks who know more. Should code
in mpc_8xx.S take more than 1.5 seconds to execute on
80Mhz 8xx?

I tried inserting code that "resets" the software
watchdog in start_kernel routine, but that too didn't
help.


Now if I want to insert the code that resets the
software watchdog timer, what is the most "time
consuming" operation?

Any help pointers will be much appreciated.

John.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
