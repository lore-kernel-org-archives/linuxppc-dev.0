Date: Wed, 6 Jan 1999 17:01:33 +1100
Message-Id: <199901060601.RAA00588@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: tas@mindspring.com, linuxppc-dev@lists.linuxppc.org
In-reply-to: <199901052239.JAA04790@tango.anu.edu.au> (message from Paul
	Mackerras on Wed, 6 Jan 1999 09:39:13 +1100)
Subject: Re: Strange PMAC IDE performance problem
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <v04011700b2b76717bf6b@[209.86.156.101]> <199901052239.JAA04790@tango.anu.edu.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I found a register at 0xf3020200 on my powermac G3 which affects the
speed of disk transfers.  This is at offset 0x200 from the base
address of the IDE interface and it is a 32-bit little-endian
register.  After booting Linux, it has 0x2f8526 in it, but under MacOS
it has 0x211025.  Putting 0x211025 in (with xmon) increased the speed
reported by hdparm -tT /dev/hda from 1.89MB/s to 9.7MB/s !  The disk
is a WDC 24300ACL (as reported by hdparm -i /dev/hda).  The other
hdparm settings were -d1 -u1 -m16.

Paul.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
