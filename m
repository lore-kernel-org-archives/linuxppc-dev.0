Date: Thu, 2 Nov 2000 23:18:47 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: "Joseph P. Garcia" <jpgarcia@execpc.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Lombard Sleep Crash (Was: 2.2.18pre17 again)
In-Reply-To: <19340927113820.10453@192.168.1.2>
Message-ID: <Pine.LNX.4.10.10011022245140.8669-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> The sleep code in via-pmu.c does a sync, and the sleep code ide-pmac.c
> locks the IDE request queue preventing any other request from coming in
> until it's unlocked on wakeup. I did this part. Michael did the VFS
> stuffs, I must admit I didn't look at the VFS layer in depth myself.

I've looked at other uses of check_disk_change and there are no special
precautions (the function is called at mount or open time and doesn't seem
critical). I don't interpret the comment before media_changed() to
indicate a race, rather the unit attention signaling a media change isn't
persistent and the CD driver must keep track of the change condition
separately. Unit attention not being persistent is the reason why the
DRIVER(drive)->media_change(drive) call has to be the first command the
drive sees after wakeup. Otherwise the drive status gets reset and the IDE
driver never really checks for sense info...

First causing the low level media change check, and then kicking the VFS
check_disk_change() is what we do now, and we do indeed need both in order
to avoid a panic and later error messages from VFS (leaving out the
check_disk_change() call still requires you to issue that call later via
ioctl before you can access the disk again).

> >Could also be that the wakebay app/hack runs on the drive after DMA was
> >re-enabled.  I assume there is no problem with the media change acting on a
> >non-mediabay disk, which it appears to me it would be doing.
>
> Well, the devices beeing powered down, it can't harm to send them a media
> change.

The wakebay app runs on the drive only after all kernel based wakeup
(including the revalidate kicked by check_disk_change()). If the drive
wasn't a mediabay device we would need separate code to wake it, if it was
never powered down there would be no disk change status pending.

With the full revalidate done in the kernel we don't really need the
wakebay app anymore.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
