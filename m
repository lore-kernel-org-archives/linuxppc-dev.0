Message-ID: <3A01A2FA.8E8E4A0B@execpc.com>
Date: Thu, 02 Nov 2000 11:23:06 -0600
From: "Joseph P. Garcia" <jpgarcia@execpc.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: cl.en@gmx.net, linuxppc-dev@lists.linuxppc.org,
        Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Subject: Re: Lombard Sleep Crash (Was: 2.2.18pre17 again)
References: <20001102160728.B371@olis.north.de> <19340927090721.10201@192.168.1.2>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
> >if you panic'ed with the CD module inserted, would you try to snooze
> >without it?
> >
> >or try this one:
>
> Well, the kernel sleep code is supposed to take care of that, but
> apparently, that code is also causing the panic...

any possibility that the VFS layer causing more serious problems here?  Comments
before cdrom.c:media_changed() seem to hint at a potential race condition, and
if the pmac-ide sleep code tries doing the VFS-sync itself, it might aggrivate
matters.  Should/Is VFS being kicked automagically by the cdrom code, or might
we need some syncing or buffering code in ide-pmac.c to prevent a panic?

Could also be that the wakebay app/hack runs on the drive after DMA was
re-enabled.  I assume there is no problem with the media change acting on a
non-mediabay disk, which it appears to me it would be doing.

BTW, pmud 0.7.1 uses wakebay by default.  my PDQ doesnt have the panic problem
either.

--
Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
