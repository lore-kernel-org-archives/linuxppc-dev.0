Message-ID: <38DA42E5.2B80E717@ncal.verio.com>
Date: Thu, 23 Mar 2000 08:14:29 -0800
From: Henry Worth <haworth@ncal.verio.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: PB2000 (pismo) install feedback
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is the old RAMDAC problem of trying to write to the pallete
registers
too soon after setting the index, complicated by an integrated chipset
and
probably PCI I/O write posting as well. It results in the display having
about 8 vertical bands and a big bright spot alternating between them.
It also makes the bubbles in the layers of film making up the LCD show
through so that it looks a bit like when a frame of motion picture film
burns in the projector.

It's very timing sensitive, a slight rearrangment of the code eliminated
the "burnout", but didn't fix the ongoing offb colormap problems. Adding
a small delay between writing the index and the palette value fixed the
colomap problem. I rearranged the code to just set the index once and
then use the palette index register's auto-incrementing to avoid the
index write and delay in the loop, and that worked as well. I think
Ben is planning to use a read back of the index register to ensure the
write is posted and and give enough of a delay.

Does anyone know if any of the ATI chips don't have autoincrementing of
the palette index? That's been a fairly standard feature of RAMDAC's
for a long time. So I was a bit surprised to see the frame buffers
explicitly setting the index on every iteration, especially since
the race between writing the palette index and the data has been
a common problem for a long time.

Henry

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
