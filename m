Date: Tue, 20 May 2003 23:34:24 -0500 (CDT)
From: "Milton D. Miller II" <miltonm@realtime.net>
Message-Id: <200305210434.h4L4YOM0063233@sullivan.realtime.net>
To: robin.gilks@tait.co.nz
Subject: Re:  Semi hosting with BDI2000 BDM ? 
Cc: linuxppc-embedded@lists.linuxppc.org
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


If you are looking for a driver to take printf and send it to either
a memory buffer or some other channel to the host, then you might
consider starting with drivers/char/hvc_console.c ... It is a full
linux console driver that gets input and output via polling call
with timer callbacks for normal tty traffic.   The driver calls
two functions (one read, one write), write sinks 0 or upto 16
characters, and read returns 0-16 characters.

I have been using this driver hooked up to a large linear buffer for
write and "if a location is non-zero send 1 byte" for read for a
system where I have alternate access to the memory.  To read the
console just dump the memory, to write I have a script to put one
character and then wait 1/HZ seconds, then write the location again.

milton

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
