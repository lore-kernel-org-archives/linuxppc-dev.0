Message-ID: <3833C328.CD5AA36D@wanadoo.fr>
Date: Thu, 18 Nov 1999 10:13:12 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Dev-Linux <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Kernel debugging??
References: <Pine.LNX.4.05.9911172207200.25661-100000@callisto.of.borg> <38333EDA.D5DA1F47@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Martin Costabel wrote:
> 

> (*) Correction. I ran rsync while typing this letter. It's 2.3.28 now. I
> am curious to see how this will run.

Followup: Paul's 2.3.28 runs very well on my 6400.

One curious thing, though: I played with hdparm for the internal IDE
disk. Turns out that it is faster with DMA turned OFF (I did a PIO
autotune hdparm -p  before):

root[90]#hdparm -d0 /dev/hda
/dev/hda:
 setting using_dma to 0 (off)
 using_dma    =  0 (off)
root[91]#hdparm -tT /dev/hda
/dev/hda:
 Timing buffer-cache reads:   64 MB in  2.91 seconds =21.99 MB/sec
 Timing buffered disk reads:  32 MB in  5.62 seconds = 5.69 MB/sec
root[92]#hdparm -d1 /dev/hda
/dev/hda:
 setting using_dma to 1 (on)
 using_dma    =  1 (on)
root[93]#hdparm -tT /dev/hda
/dev/hda:
 Timing buffer-cache reads:   64 MB in  2.91 seconds =21.99 MB/sec
 Timing buffered disk reads:  32 MB in 10.21 seconds = 3.13 MB/sec

This is repeatable. And there is still some strange swapping going on
that shouldn't be necessary (no high charge, just some window switching
in X). But now that I went back to BootX-1.1.3, the overall speed is OK.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
