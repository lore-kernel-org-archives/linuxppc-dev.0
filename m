Mime-Version: 1.0
Message-Id: <v04220804b56f910f22ca@[10.0.0.42]>
In-Reply-To: <3949DDBD.331E255F@wanadoo.fr>
References: <Pine.LNX.4.05.10006142236120.5007-100000@callisto.of.borg>
 <3949DDBD.331E255F@wanadoo.fr>
Date: Fri, 16 Jun 2000 01:12:14 -0700
To: Martin Costabel <costabel@wanadoo.fr>
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: Interrupt hick ups
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 9:56 AM +0200 6/16/00, Martin Costabel wrote:
>Geert Uytterhoeven wrote:
>>
>>  On Tue, 13 Jun 2000, Geert Uytterhoeven wrote:
>>  > Since a few kernel versions (late 2.3.x), I see interrupt hick
>>ups when doing
>>  > disk access on my Sym53c875. I.e. when I'm typing something and the disk
>>  > shows a lot of activity, keystrokes and mouse moves happen in
>>burst with some
>>  > delay (ca. 2 seconds).
>>  >
>>  > Anyone seeing a similar thing? This is on a CHRP LongTrail.
>
>Do you still see this in -ac16 or later? I had this, too, and from
>linux-kernel I understand that everyody had it, but it's gone now.
>
>What is gone too, unfortunately, is the phenomenal IDE speed
>improvement. In late 2.3.99/early 2.4.0-test1, I had a "hdparm
>-t"-measured throughput more than 3 times as high (almost 6MB/sec,
>sometimes more) as with 2.2.x (1.90MB/sec). It diminished in -ac15
>(3.25MB/sec), and in -ac16 it is almost back down (2.30MB/sec) to the
>2.2.x values.

Have you made sure your HD is set up for DMA, etc.?  For example, do
"hdparm -d1 -u1 -m16 -p4 /dev/hda" and then run the -t throughput
test.  (Use the man pages to make sure those are sane options, that's
all from memory.)

I remember similar fluctuation in 2.2.x as automatic negotiation of
DMA and so forth was first put in then taken out of the IDE driver.

Also, to make sure buffers get flushed before a test (for repeatable
results) you should do hdparm -Tt, not just hdparm -t.

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
