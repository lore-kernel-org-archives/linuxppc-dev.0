Message-ID: <3E8C562B.5090709@paulidav.org>
Date: Thu, 03 Apr 2003 07:41:31 -0800
From: Vladimir Gurevich <vag@paulidav.org>
MIME-Version: 1.0
To: Donald White <dbwhite@asu.edu>
Cc: linux-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Question about porting VxWorks driver
References: <3E8BECA6.6060709@asu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Donald,

Is it one of Hifn chips by any chance? If yes, then I can
tell you that their drivers do not know about cache flushes
and invalidates at all, which presents a real challenge on
PowerPC.

Writeback cache usually won't work. You have to manually
flush it before sending a message to the board and invalidate
it after you receive the encrypted (decrypted) message back.
If you do the transformation "in-place" then you can use
flush-and-invalidate before seding the message. Using uncached
memory is another option, but if you want to do further
processing without copying data to a cached buffer, you
performance will likely suffer.

In general you keep data buffers in cached memory and
do manual flushes/invalidates when needed, but keep
buffer descriptors and other similar structures (as
well as chip's registers and chip's private memory)
in uncached space.

Best regards,
Vladimir


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
