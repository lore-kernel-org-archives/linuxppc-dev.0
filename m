From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: roger blofeld <blofeldus@yahoo.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Sungem bug or something else?
Date: Thu, 6 Jun 2002 21:45:18 +0200
Message-Id: <20020606194518.27675@smtp.wanadoo.fr>
In-Reply-To: <20020606192510.58822.qmail@web11106.mail.yahoo.com>
References: <20020606192510.58822.qmail@web11106.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I encounter an oops during boot bringing up a sungem
>interface. (smp g4 450/gcc 3.1/glibc 2.2.5) If I defer
>bringing up the network at boot, I can successfully
>start eth0 (sungem) if I start eth1 (tulip) first, so
>it may not be the sungem driver itself. This happens
>on benh 2.4.19-Bpre10, and pre9.

What kind of error is it ? A Machine Check ?

Looking at your backtrace, it looks like the driver is
trying to access the PHY chip. That can sometimes happen
if you have some tool like miitool or ethtool trying to
get at the link status while the chip isn't powered up.

The problem here is that sungem on Apple HW only powers
the chip when the interface is brought up, and powers it
down about 10 seconds after bringing the interface down.

This improve power management, but kills link monitoring
tools.

There may be also a bug in the driver causing it to try
to access the PHY registers when the chip is in down
mode & getting the ethtool ioctl's

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
