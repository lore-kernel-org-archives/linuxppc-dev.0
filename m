From: Benjamin Herrenschmidt <bh40@calva.net>
To: "Joseph P. Garcia" <jpgarcia@execpc.com>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Lombard Sleep Crash (Was: 2.2.18pre17 again)
Date: Thu, 2 Nov 2000 19:06:36 +0100
Message-Id: <19340927113820.10453@192.168.1.2>
In-Reply-To: <3A01A2FA.8E8E4A0B@execpc.com>
References: <3A01A2FA.8E8E4A0B@execpc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> Well, the kernel sleep code is supposed to take care of that, but
>> apparently, that code is also causing the panic...
>
>any possibility that the VFS layer causing more serious problems here?
>Comments
>before cdrom.c:media_changed() seem to hint at a potential race
condition, and
>if the pmac-ide sleep code tries doing the VFS-sync itself, it might
aggrivate
>matters.  Should/Is VFS being kicked automagically by the cdrom code, or
might
>we need some syncing or buffering code in ide-pmac.c to prevent a panic?

The sleep code in via-pmu.c does a sync, and the sleep code ide-pmac.c
locks the IDE request queue preventing any other request from coming in
until it's unlocked on wakeup. I did this part. Michael did the VFS
stuffs, I must admit I didn't look at the VFS layer in depth myself.

>Could also be that the wakebay app/hack runs on the drive after DMA was
>re-enabled.  I assume there is no problem with the media change acting on a
>non-mediabay disk, which it appears to me it would be doing.

Well, the devices beeing powered down, it can't harm to send them a media
change.

>BTW, pmud 0.7.1 uses wakebay by default.  my PDQ doesnt have the panic
problem
>either.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
