Message-ID: <38FFF416.6DBB01A7@wanadoo.fr>
Date: Fri, 21 Apr 2000 08:24:22 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Chris Gehlker <canyonrat@mac.com>
CC: Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Problems with building Paul's Stable Release
References: <38FF8897.D80916CC@mac.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Chris Gehlker wrote:
>
> This is a tiny bug report and a plea for help. I grabbed the latest
> stable release, 2.2.15pre19, from Paul's tree to build for a Sawtooth.
> Reading the archives of this list I see I'm supposed to disable PowerMac
> Keyboard and I'm enabling usb hubs, keyboards and mice but no joy. My
> usb devices are DOA.

Where did you read that you have to disable PowerMac Keyboard? This
doesn't seem right to me. Or do you have a PC keyboard?

> The tiny bug is that the little pearl file mkmap in /drivers/usb has the
> wrong permissions. Please excuse me if I'm violating etiquette by
> reporting such a nit.

This is a longstanding bug in a particular version of the usb drivers.
Both scripts mkmap and mkmap.adb should be executable, but aren't. In
Paul's tree it is half fixed, i.e. mkmap.adb is executable, but mkmap
isn't.

Now for the Macs this should be sufficient, because they need the keymap
made by mkmap.adb (even if you don't have an ADB keyboard!). But for
this you have to have CONFIG_MAC_KEYBOARD=y. If you do this, then mkmap
should never be used.

If you really have to chmod mkmap, then you also need to rm keymap.c
(same goes for mkmap.adb and keymap-mac.c), because in the first
attempt, it probably got created with length zero, and afterwards make
thinks it doesn't have to redo it.

All these are very ugly hacks, and they have rightly disappeared from
more recent usb drivers.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
