Date: Thu, 29 Nov 2001 19:27:07 -0300
From: Ricardo Scop <scop@digitel.com.br>
Reply-To: scop@digitel.com.br
Message-ID: <9810.011129@digitel.com.br>
To: linuxppc-embedded@lists.linuxppc.org
Cc: <andy_lowe@mvista.com>
Subject: Re: Kernel oops while routing
In-reply-To: <01112619541903.01018@scop.digitel.com.br>
References: <01112619541903.01018@scop.digitel.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi everybody,

Ok, time for an update on the problem bellow.

First of all, many thanks to Andy Lowe for his patch. The problem was
gone with it, but with some performance penalties that I would like to
discuss.

Even before applying the patch, we found out that the crash was caused
by a memory leak in the system. When the memoty was exhauted, the
kernel crashed. Furthermore, we discovered that
turning CONFIG...MMAP off decreased considerably the leakage rate, at
least in our test setup.

Then, applying the patch stopped the leak. But, just as I mentioned
before, the performance of our routing test decreased a lot. Best
throughput rates dropped to 15 Mbps, against 46 Mbps before patching.

I'm kind of lost with this performance variations. As far as I could
see, the patch did not insert much processing overhead, so...

Tips, commentaries, pointers on what to seek for... everything will be
appreciated.

[]'s, Scop                            mailto:scop@digitel.com.br

------------------------------------------------------------------
"What's money? A man is a success if he gets up in the morning and
goes to bed at night and in between does what he wants to do."
~Bob Dylan

Monday, November 26, 2001, 1:54:19 PM, Ricardo Scop wrote:

RS> Hi,

RS> I'm doing some performance tests with a proprietary Linuxppc-based box
RS> configured as a routing system. The processor is  MPC8255 @ 133 MHz (33Mhz on
RS> the bus) and Linux revision is 2.4.15pre8 rsync'ed from MVista linuxppc_2_4
RS> repository.

RS> We are using two other Linux workstations to exercise the router, both
RS> running Netpipe 2.4, one as a client application, the other as a server. Each
RS> one is connected to a different fast ethernet port of our router  box
RS> (100MHz, full-duplex mode) using cross cables.

RS> We're achieving throughputs around 40 Mbps with this setup, which is enough
RS> for our purposes.

RS> But, when we try a 30 MBytes' block in Netpipe,  the kernel in our Linux box
RS> crashes big time (trace bellow, including ksymoops decode). We also tryed
RS> Linux 2.4.4 version, but then the performance slows down to around 13 Mbps.

RS> My questions are:

RS> Has anyone observed this kind of crash?
RS> Is there any workaround?

RS> Any pointers or suggestions will be greatly appreciated.

RS> Regards,

RS> ~Ricardo
RS> R SCOP Consulting.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
