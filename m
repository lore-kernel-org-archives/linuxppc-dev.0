From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Message-Id: <199910081233.OAA03575@simul.biophys.uni-duesseldorf.de>
Subject: Re: ADB probing
In-Reply-To: <19991008120851.018835@mailhost.mipsys.com> from Benjamin Herrenschmidt at "Oct 8, 1999 12:08:51 pm"
To: bh40@calva.net (Benjamin Herrenschmidt)
Date: Fri, 8 Oct 1999 14:33:18 +0200 (CEST)
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >?? I found the reset (and implicit rescan) in adb.c, is there a hook from
> >mac_keyb.c? (I meant 'force a reset via /dev/adb, which will in turn cause a
> >rescan)
> 
> There is a notifier that the devices can attach to the adb core. I added
> this when working on the sleep code.

Thanks, I forgot that sleeping will power down all ADB devices. That still
doesn't force a bus reset but a bus reset may not be what we want anyway. 

Can we add a SysRQ code for this? Speaking of which, what is the magic sysrq 
key on a Lombard, or the shutdown key combo? I couldn't find that in the
keyboard driver ...

>  - minor 0 is the "control" channel where you can send bus resets, raw
> commands, etc... I'll add this new ioctl for querying things like the
> original address. It will be backward compatible.
> 
>  - each minor >0 correspond to an address. Open is exclusive. When
> opened, the original handler (if any) is replaced by a special one that
> sends autopoll datas to a ring buffer that can be read(). Optionally, we
> can provide a few ioctls to set this buffer's size and to flush it. In
> case a bus reset happens, all those opened minor are marked "dead" and
> return an error to any read or ioctl call. (The user is then expected to
> close the file, use minor 0 to re-probe the device, and reopen an
> "autopoll" minor if the device is still there).
> 
> I beleive this is enough for anything we might want to do with ADB, and
> things like tablet drivers could be 100% userland.

That's about what I've been discussing with some (including Paul and hpa)
about two years ago. We could add adbkeyb (raw keyboard data) and adbmouse
(the busmouse device) and possibly adbtablet for good measure and give up 
that hijacked misc minor 10, finally. 

I can help writing and testing this on a Powerbook, I just don't have a
desktop Mac to connect multiple ADB devices to. 

	Michael

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
