Message-ID: <3C569C1A.38BBF76F@etx.ericsson.se>
Date: Tue, 29 Jan 2002 13:56:58 +0100
From: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
MIME-Version: 1.0
To: Alex Zeffertt <ajz@cambridgebroadband.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>,
	"mtd@infradead.org" <mtd@infradead.org>
Subject: Re: JFFS2: strange output
References: <3C5673A4.662CC3E6@cambridgebroadband.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I think you used up all free blocks and now you basically is in a state where
you have to wait for one to get free before anything can happen. If you just
wait a while when things start to get slow then repeat the test do you get a
few runs that are fast again?

Alex Zeffertt wrote:
>
> Hi all,
>
> I'm using a linux-2.4.4-2001-11-24 kernel on an MPC862 based board.
>
> I've been playing with JFFS2 and getting some strange results.
>
> First I erase /dev/mtd2 (a 6 MB FLASH partition).  Then I mount the same partition
>
> > mount -t jffs2 /dev/mtdblock2 /mnt
>
> Then I copy file1 (a 500K file) to /mnt and repeat the following over and over:
>
> > cp /mnt/file1 /mnt/file2; rm /mnt/file1; mv /mnt/file2 /mnt/file1
>
> After 10 of the above I get the following message in /var/log/messages:
>
> Dec 24 00:04:58 gonzo kernel: Waiting for chip to read, status = 4
> Dec 24 00:05:40 gonzo last message repeated 2 times
>
> After 11 of the above I get the following message in /var/log/messages:
>
> Dec 24 00:05:55 gonzo kernel: Waiting for chip to read, status = 4
> Dec 24 00:05:55 gonzo kernel: Waiting for chip to read, status = 7
> Dec 24 00:06:26 gonzo last message repeated 2841 times
>
> By this point the copies are progressing painfully slowly.
>
> I repeated the same test with JFFS1 and had no problems.  I repeated the above command 100 times,
> with no strange output in /var/log/messages, and with no slowing down.
>
> Has anybody had similar problems with JFFS2?
>
> Alex
>

--
Kenneth Johansson
Ericsson Telecom                  Tel: +46 8 404 71 83
Viderögatan 3                     Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@etx.ericsson.se

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
