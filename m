Message-Id: <199909292123.RAA09969@picard.cs.ohiou.edu>
To: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
From: "Shawn Ostermann" <ostermann@cs.ohiou.edu>
Subject: linuxppc: TCP throughput problems
Date: Wed, 29 Sep 1999 17:23:55 -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Now that I finally have a working interrupt-driven kernel for my
PB3400, I've been stress testing the driver.  I found something odd
when sending it a lot of TCP data over a mostly idle 10Mb ethernet.  I
used ttcp to both send data TO my laptop and then again to have the
laptop send the data out.

When my linux laptop is SENDING the data, I get:

>> ttcp-t: buflen=8192, nbuf=2048, align=16384/0, port=5001  tcp  -> picard
>> ttcp-t: 16777216 bytes in 15.10 real seconds = 8.48 Mbit/sec +++
>> ttcp-t: 2048 I/O calls, msec/call = 7.55, calls/sec = 135.67
>> ttcp-t: 0.0user 1.0sys 0:15real 7%

I get 8.48 Mbits/sec.  That's pretty good for a nearly idle 10Mb
ethernet.

HOWEVER, when my linuxppc laptop is RECEIVING the data, I get:

>> ttcp-t: buflen=8192, nbuf=2048, align=16384/0, port=5001  tcp  -> defiant
>> ttcp-t: 16777216 bytes in 19.55 real seconds = 6.55 Mbit/sec +++
>> ttcp-t: 2048 I/O calls, msec/call = 9.78, calls/sec = 104.75
>> ttcp-t: 0.0user 0.5sys 0:19real 2%

6.55 Mb/sec is "not so good".  Yes, I repeated these experiments many
times.  I even know what the problem is, but I don't understand why.
In the "linux receiving" case, there were NO retransmitted packets and
NO errors.  HOWEVER, what's happening is that linux is delaying ACK
packets for long periods of time (~10ms) causing the data sender to
stop.  The ACKs show up after the data stops arriving and then things
start up again.

Before I go digging too deeply, I want to know if this has been seen
before.  Could it be:

1) problems in the new interrupt handler (seems unlikely)
2) problems in the de4x5 device driver (possibly)
3) problems in the linux TCP/IP code (may be more likely)

If anybody is curious, the packet trace and analysis tools are here:

http://jarok.cs.ohiou.edu/linuxppc/tcp_problems/

Shawn
-------------------------------------------------------------------------
   Dr. Shawn Ostermann  -  Associate Professor  -  Ohio University
      140 Morton Hall, Ohio University, Athens, Ohio  45701-2979
 ostermann@cs.ohiou.edu -- FAX: (740)593-0406 -- Voice: (740)593-1242
    http://ace.cs.ohiou.edu/~osterman   http://jarok.cs.ohiou.edu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
