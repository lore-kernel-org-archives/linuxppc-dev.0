Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3AB63E12.6D38973E@esd-electronics.com>
Date: Mon, 19 Mar 2001 18:12:50 +0100
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: losing interrupts - printk is bad
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I got a nice problem: I am working on an embedded PPC board (IBM405CR)
with a serial console (115200 baud). While I was testing some new driver
code, I made a lot of prink debugging output - as we all like to do :-)
My problem is, that I always lose some bytes on an other serial port. I
found out that printk waits until the complete format string is send
through the console. That takes about 5 ms for 40 bytes. During this
time printk blocks the interrupts !!! That means some incomming data on
the other serial port can be (and is) lost. This is a very strange
problem.

Well first would be glad to get a good workaround. Well, a 'klogd -c 1'
turn off all the debuggin and printk is much faster, but I need the
debugging output.

Second, could anybody explain t ome, what klogd is doing ? It would be
glad to get klogd read all the debugging output from the kernel and
output the data from user space (well buffered and not blocking the
whole system). It seems that klogd cannot do that, am I right ?

Matthias

--
-------------------------------------------------
\ Matthias Fuchs                                 \
 \ esd electronic system design Gmbh              \
  \ Vahrenwalder Straﬂe 205                        \
   \ D-30165 Hannover                               \
    \ email: matthias.fuchs@esd-electronics.com      \
     \ phone: +49-511-37298-0                         \
      \ fax:   +49-511-37298-68                        \
       --------------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
