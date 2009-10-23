Return-Path: <memorylost@tin.it>
Received: from smtp-out01.alice.it (smtp-out01.alice.it [85.33.2.12])
	by ozlabs.org (Postfix) with ESMTP id 6CADCB7BC3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Oct 2009 18:24:52 +1100 (EST)
Message-ID: <4AE1585E.60002@tin.it>
Date: Fri, 23 Oct 2009 09:16:46 +0200
From: LD <memorylost@tin.it>
MIME-Version: 1.0
To: Linux ppc mailing list <linuxppc-dev@lists.ozlabs.org>,
	Lucio Dona' <memorylost@tin.it>
Subject: MPC5121e DIU driver - kernel crash writing alpha component
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all,
I am working on Freescale MPC5121e evaluation board ADS512101 rev. 3 (M34K
processor stepping), developing a graphical application.
Just switched to ADS512101 rev. 4, 0M36P processor stepping.

I have problems with the video framebuffer driver, try to explain:

- - app is based on microwindows+fltk, framebuffer driver. On rev3 board working ok.
- - rev4 board: using the kernel from ltib 2009/06/02, just adapted fsl-diu-fb.c
and .h to support resolution and timings of my lcd panel.

The board is booting ok (NFS), but my user space app keeps crashing the kernel.

I noticed that in 0M36P processor stepping there are many changes about the
video interface (DIU), correcting some bugs of the previous stepping ; seems
that when I write to the ram area which is mapped to Panel0 of the DIU the
system randomly hangs.

After some debugging...
800x480, 32 bits per pixel, using plane1 (first plane, as described in the
processor's reference manual).
If, from user space, I write some alpha component != 0 in this plane then I have
a complete system crash.
The reference pdf says "There is no alpha component defined for plane1 because
there are no planes behind it."

I did not yet investigate about writing in other planes ; time is short...
For now, patched microwindows driver for writing 0x00 in alpha components, no
more hangs.
Reported to Freescale FAE, waiting for some answers.

Meanwhile: some suggestions about filtering alpha components in the video driver ?
I was thinking about some sort of double buffering : user space app
(fltk--->microwindows) writes in a buffer,
then the driver clears alpha to 0x00 and memcpy to the real video buffer.

Problems:
- - driver / user space sync. Vertical retrace ? ioctl ?
- - waste of memory, needs double video buffers


Any suggestions are welcome,
work in progress.

Regards
Lucio Dona'
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFK4VhdvxHCsvXy9okRAtrtAKCaAectSfrHOfzcbTR7KfF9lHCY1QCeOcND
HC9fMyGUATKeDL9z9IEzAWc=
=ofjv
-----END PGP SIGNATURE-----
