Message-ID: <7283DE19D141D111AD0E00A0C95B195502C5F607@mail2.aiinet.com>
From: "Whitney, John" <johnw@aiinet.com>
To: "'Scott Anderson'" <sanders@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: ext2fs or ramdisk problems......
Date: Mon, 28 Aug 2000 10:27:26 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Well, I'd believe that, but...

If I copy a file, such as /bin/vim, into new files until they fill up
the unused ramdisk space, delete the copies, and start copying them
again, I get the "out of space" error (actually, I don't think I even
have to fill up the space before I can get this to happen).  If it were
inode related, I'd think that it was the *number* of files and that for
each file I deleted, I could create a new one (which isn't the case).

I saw the problem in each kernel from the standard 2.2.13 up to 2.2.15
(I was trying to see if newer kernels fixed the problem).  I'm not sure
what is causing it or if anyone else has been troubled by it, but I
thought I'd bring it up to the group.

John Whitney
johnw@aiinet.com

-----Original Message-----
From: Scott Anderson [mailto:sanders@mvista.com]
Sent: Friday, August 25, 2000 1:35 PM
To: Whitney, John
Cc: 'greyham@research.canon.com.au'; kd@flaga.is;
linuxppc-embedded@lists.linuxppc.org
Subject: Re: ext2fs or ramdisk problems......



"Whitney, John" wrote:
>
> I have had odd results using ext2 on the ramdisk (in my case, a 16MB
> ramdisk).  Using the 2.2.13, ramdisks I created using ext2 would boot
> up just fine on the system, but after use the filesystem would declare
> that it was out of space, even though "df" showed several megabytes
> free on that filesystem.

My guess is that you ran out of inodes.  Examine the output of dumpe2fs
and see if it gives you any clues.

    Scott Anderson
    scott_anderson@mvista.com	MontaVista Software Inc.
    (408)328-9214		490 Potrero Ave.
    http://www.mvista.com	Sunnyvale, CA  94086


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
