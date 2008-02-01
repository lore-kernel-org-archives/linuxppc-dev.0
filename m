Return-Path: <ssh@sgi.com>
Received: from relay.sgi.com (relay1.sgi.com [192.48.171.29])
	by ozlabs.org (Postfix) with ESMTP id AA597DE071
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Feb 2008 05:52:27 +1100 (EST)
Received: from bryce.americas.sgi.com (bryce.americas.sgi.com [137.38.224.20])
	by relay1.corp.sgi.com (Postfix) with ESMTP id 81E608F81DE
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Feb 2008 10:52:26 -0800 (PST)
Received: from [137.38.88.32] (lnx-ssh.americas.sgi.com [137.38.88.32])
	by bryce.americas.sgi.com (Postfix) with ESMTP id 2FA1070008E3
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Feb 2008 12:52:26 -0600 (CST)
Message-ID: <47A36A69.1010809@sgi.com>
Date: Fri, 01 Feb 2008 12:52:25 -0600
From: Steven Hein <ssh@sgi.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: 8360 custom board, ucc_geth TX errors on longer(?) packets
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All:

For our custom 8360-based board that is based fairly closely
on the MPC8360-MDS board, I'm working on moving from a 2.6.16
kernel (Timesys distro) to 2.6.24.   I didn't use the device
tree in my old kernel, so I've had the learning experience
of tweaking the dts file for my custom board.  I've got it 99%
working  (I think!).   But I'm running into a really odd ethernet
problem that I don't understand.

I have two boards:  our custom 8360 board, and a MPC8360E-MDS
dev board.    I can build a kernel for the MDS board and
ethernet works perfectly.    When I build that kernel using the
same config, but changing the platform to my custom board
(and not changing any other options), everything works right
except for ethernet:    it won't get an IP address using DHCP
(udhcpc)...    I check the ifconfig output, and I see that
the TX error count is increasing, and there are very few TX
packets being sent.   I verified that this isn't a timeout--
it's being caused by the UCCE[TXE] bit being set   (I don't see
any other error indications in dmesg).

As another test, I configured the address manually.   When I do
that, I can ping the board with a normal ping; but if I use
the -s option to increase the packet size, then the pings will
fail when I use a size of about 250 or greater, and with a size
of about 300 or greater I get no successful ping packets.

The one main difference in this board is how eth0 is wired.
We have a Broadcom GbE switch part, and UCC1 eth is wired
directly to that switch (no PHY).   (This where I needed to
use the fixed-link option that I had asked about a couple of
days ago!).   In my 2.6.16-based kernel, I had created a
dummy "null" PHY to force the link speed to 1000, and that
worked well.    I am using the same Broadcom network
switch software with both kernels, so the switch side of the
config should be the same.

I created my custom board config from the MPC8360E-MDS board
configs (starting with that defconfig, dts, and platform .c
file), and matched my GPIO pin configs in the dtb file to what
I had used in the 2.6.16 kernel......  I'm not sure where to
look for this problem, as I've never seen UCCE[TXE] set
before.    Based on my experience in this move so far, I'd
guess that I've got something configured wrong somewhere,
but I just don't know where to look.

Does anyone have any ideas/suggestions?
Any help would be MUCH appreciated!!

Thanks,
Steve

-- 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Steve Hein (ssh@sgi.com)              Engineering Diagnostics/Software
Silicon Graphics, Inc.                          
1168 Industrial Blvd.                 Phone: (715) 726-8410
Chippewa Falls, WI 54729              Fax:   (715) 726-6715
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
