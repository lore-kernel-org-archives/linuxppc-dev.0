Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <v04011701b2ba429e00af@[209.86.156.161]>
In-Reply-To: <19990106170222.030778@mail.mipsys.com>
References: <199901060601.RAA00588@tango.anu.edu.au>
Date: Thu, 7 Jan 1999 03:12:26 -0800
To: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org,
        Paul.Mackerras@cs.anu.edu.au
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: Great IDE perf (WAS: Strange PMAC IDE performance)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 5:02 PM +0100 1/6/99, Benjamin Herrenschmidt wrote:
>On Wed, Jan 6, 1999, Paul Mackerras <paulus@cs.anu.edu.au> wrote:
>
>>I found a register at 0xf3020200 on my powermac G3 which affects the
>>speed of disk transfers.  This is at offset 0x200 from the base
>>address of the IDE interface and it is a 32-bit little-endian
>>register.  After booting Linux, it has 0x2f8526 in it, but under MacOS
>>it has 0x211025.  Putting 0x211025 in (with xmon) increased the speed
>>reported by hdparm -tT /dev/hda from 1.89MB/s to 9.7MB/s !  The disk
>>is a WDC 24300ACL (as reported by hdparm -i /dev/hda).  The other
>>hdparm settings were -d1 -u1 -m16.
>
>I tried the manipulation with xmon on my wallstreet PowerBook, using
>today's vger 2.2-pre4 and hdparam test jumped from 1.88Mb/s to 6.3MB/s
>!!! (At first, I forgot to flush the caches, so I got 50Mb/s ;-)

Good one, Paul!

This works on the PowerBook 2400 as well.  It so happens that the IDE
controllers also sit at 0xf3020000 and 0xf3021000 on the O'Hare.  The value
of the register at offset 0x200 is slightly different under MacOS:
0x221025.  I tried both values, it didn't seem to make a difference.  I did
a quick hack to ide-pmac.c (it just stuffs the value in, no questions
asked, though it does actually use the correct base address instead of hard
coding 0xf3020000) and that worked.  Performance is up to 5.6 MB/s (was in
the region of 1.6 before).

Right now my cheap hack is using 0x221025, but if somebody wants I will do
0x211025 instead for an extended period to see if there are any problems.

Any guesses about the meaning of this register?  It feels wrong somehow to
just ape MacOS without knowing what's really going on.  :)

  Tim Seufert

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
