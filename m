In-Reply-To: <199910081233.OAA03575@simul.biophys.uni-duesseldorf.de>
Date: Fri, 8 Oct 1999 15:06:17 +0200
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: ADB probing
Message-Id: <19991008150617.016099@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Oct 8, 1999, Michael Schmitz
<schmitz@opal.biophys.uni-duesseldorf.de> wrote:

>Thanks, I forgot that sleeping will power down all ADB devices. That still
>doesn't force a bus reset but a bus reset may not be what we want anyway. 

Yes, sleep powers down all ADB devices, and that's why the ADB code
contains a sleep notifier which will do a bus reset on wakeup. The adb
code will then re-do the probing and re-adressing and notify it's own
clients (mac_keyb.c drivers) via it's own notifier that the bus was reset
so they get a chance to re-initialize their various devices.
The /dev/adb code will also catch bus reset commands and do the same
thing. I still think that we should try to do something more complex than
a reset+reprobe.

>Can we add a SysRQ code for this? Speaking of which, what is the magic sysrq 
>key on a Lombard, or the shutdown key combo? I couldn't find that in the
>keyboard driver ...

>That's about what I've been discussing with some (including Paul and hpa)
>about two years ago. We could add adbkeyb (raw keyboard data) and adbmouse
>(the busmouse device) and possibly adbtablet for good measure and give up 
>that hijacked misc minor 10, finally. 
>
>I can help writing and testing this on a Powerbook, I just don't have a
>desktop Mac to connect multiple ADB devices to. 

My idea was to work on this this Sunday, but if you want to write it now,
feel free to do so ;) I can test it on various configurations at work.

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
