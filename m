Date: Thu, 9 Oct 2003 23:53:03 -0800
From: Ethan Benson <erbenson@alaska.net>
To: LinuxPPC Developers <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Time precision, adjtime(x) vs. gettimeofday
Message-ID: <20031010075302.GT2828@plato.local.lan>
References: <20031010011254.078c84a8.billfink@mindspring.com>
Mime-Version: 1.0
In-Reply-To: <20031010011254.078c84a8.billfink@mindspring.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Oct 10, 2003 at 01:12:54AM -0400, Bill Fink wrote:
>
> This discussion prompted me to finally ask about another clock related
> problem I see on the 867 MHz G4 systems at work. The clocks on
> these systems continuously run 0.2% slow (about 3 minutes per day).
> Apparently this is more than ntp can adjust for (using scaling), as I
> get many of these error messages in the log:

is it a quicksilver G4?  i maintain one of those and its time goes off
much faster then that (3 minutes within a couple hours).

the fix is rather simple:

--- linux.old/arch/ppc/platforms/pmac_time.c.orig	Sat Nov 30 02:33:49 2002
+++ linux/arch/ppc/platforms/pmac_time.c	Sat Nov 30 02:33:22 2002
@@ -262,7 +262,9 @@
 	 * calibration. That's better since the VIA itself seems
 	 * to be slightly off. --BenH
 	 */
+#if 0
 	if (!machine_is_compatible("MacRISC2"))
+#endif
 		if (via_calibrate_decr())
 			return;

in the case of the quicksilver VIA is FAR better then whatever it uses
instead.

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
