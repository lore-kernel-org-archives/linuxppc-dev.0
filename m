Date: Fri, 15 Jan 1999 02:27:54 -0500 (EST)
From: Ty Hedrick <thedrick@netspace.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Powerbase IDE: DMA & ohare-ata
Message-ID: <Pine.LNX.4.05.9901150212250.26871-100000@netspace.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I just noticed the thread from a few days ago on greatly speeding up IDE
transfer rates by poking at ohare and thought I'd give it a shot
on my Powerbase. The first thing I noticed is that my IDE drive was still
operating in PIO mode, even with BenH.'s latest test kernel.  

It seems that even though the Powerbase is perfectly capable of DMA, the
test in ide-pmac.c to setup DMA 

#ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
                if (np->n_addrs >= 2 && np->n_intrs >= 2) {

fails because n_intrs is 0.  Risking my mostly worthless IDE drive I
removed the test and recompiled.  DMA appears to work without a hitch -
transfer rates are almost identical to those under PIO, but cpu usage was 
much lower.

After looking at DMA I decided to enable the ohare register mentioned
earlier, stuffing the new value in also resulted in a working system, and
approximately doubled the IDE transfer rate as measured by hdparm - to a
whopping 3.7 MB/s.

Is there any way to be kind to all the Powerbase owners out there and
enable DMA by default without breaking any other systems?  Also, the mod
to ohare and heathrow does seem to help lots of platforms.

Ty    


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
