In-Reply-To: <199901060601.RAA00588@tango.anu.edu.au>
Date: Wed, 6 Jan 1999 12:51:10 +0100
To: linuxppc-dev@lists.linuxppc.org, Paul.Mackerras@cs.anu.edu.au
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Strange PMAC IDE performance problem
Message-Id: <19990106125110.032576@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jan 6, 1999, Paul Mackerras <paulus@cs.anu.edu.au> wrote:

>I found a register at 0xf3020200 on my powermac G3 which affects the
>speed of disk transfers.  This is at offset 0x200 from the base
>address of the IDE interface and it is a 32-bit little-endian
>register.  After booting Linux, it has 0x2f8526 in it, but under MacOS
>it has 0x211025.  Putting 0x211025 in (with xmon) increased the speed
>reported by hdparm -tT /dev/hda from 1.89MB/s to 9.7MB/s !  The disk
>is a WDC 24300ACL (as reported by hdparm -i /dev/hda).  The other
>hdparm settings were -d1 -u1 -m16.

I confirm, I have the same values in this register here on PowerMac
G3/300 desktop (without any IDE device plugged in) and in PowerBook G3
Series. I didn't check the iMac yet but it looks like an heathrow thing. 

if you don't find a similar thing on O'Hare, I suggest checking the
"compatible" property of mac-io against heathrow before putting anything here.

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
