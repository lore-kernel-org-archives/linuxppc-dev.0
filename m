Date: Fri, 29 Jun 2001 10:46:18 -0700
From: John Cagle <jcagle@kernel.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: 405GP network receive problem
Message-ID: <20010629104618.A22541@kernel.org>
References: <Pine.LNX.3.95.1010627084008.2380C-100000@november.bhjjh.erols.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.3.95.1010627084008.2380C-100000@november.bhjjh.erols.com>; from ghurwitz@dyndns.com on Wed, Jun 27, 2001 at 08:43:16AM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am debugging a custom board design based on the 405GP and have a problem
receiving lots of TCP/IP traffic (like FTP).  We're using a 2.4 kernel based
on Monta Vista's CDK 1.2.  UDP traffic (like TFTP) works very well, but it
doesn't ever have back-to-back receives, typically.  The problem occurs
at both 10mbit and 100Mbit.

I have narrowed the problem down (using ttcp) to the following:

During back-to-back receives (within microseconds) of two large (1500 bytes)
TCP packets, the second packet is usually dropped by the 405GP.  When I
check ifconfig statistics, it shows the 1 lost packet, but also shows 2
framing errors.

Has anyone else seen this type of problem with the 405GP or does anyone
know what the problem might be?

Thanks,
John
------------------------------
John Cagle <jcagle@kernel.org>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
