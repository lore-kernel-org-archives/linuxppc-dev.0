Date: Fri, 15 Nov 2002 15:10:01 -0600
From: "William A. Gatliff" <bgat@billgatliff.com>
To: GOTZON ASTONDOA <gastondoa@fagorautomation.es>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Fast shutdown
Message-ID: <20021115151001.I5906@saturn.billgatliff.com>
Reply-To: bgat@billgatliff.com
References: <CA78D1B723D8D411AF0300508BDCF74FF0C566@NTCORREO>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA78D1B723D8D411AF0300508BDCF74FF0C566@NTCORREO>; from gastondoa@fagorautomation.es on Tue, Nov 12, 2002 at 04:04:39PM +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Nov 12, 2002 at 04:04:39PM +0100, GOTZON ASTONDOA wrote:
>
> Hi all:
>
> 	Our custom board has to microprocessors: 68K and PowerPC. We have
> instaled Linux in the PowerPc side.
> 	When the user suddenly shutdowns the board, the 68K sends an
> interrupt to the PowerPC.We have more or less 8 mSeg to close all the Linux
> system (it has hard disk, ethernet, ftp and our own application).
>
> 	Can somebody tell me any idea to close the Linux system in the
> fastest way? We are thinking in capture the interrupt signal, but, is it
> enough fast?


You'll probably want to dump /sbin/init, at least.

Just throwing something out for starters....

You could have an interrupt handler watching the signal from the 68k,
and sending a message via named pipe (perhaps) to a userspace program.
The userspace program would signal all your other programs, sync(),
then wait for powerdown.

I think you'll want all your processes doing synchronous i/o, so that
you don't have much in the way of unwritten disk data to worry with.
You'll probably also want a journaled filesystem, for those times when
8ms just isn't enough...

Hope this gives you a good starting point,


b.g.
--
Bill Gatliff
Embedded systems and Free Software.  Yea, it *is* all that!
See http://billgatliff.com for details.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
