From: Benjamin Herrenschmidt <bh40@calva.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Going from 2.2.12 to 2.2.17pre10
Date: Wed, 12 Jul 2000 15:31:07 +0200
Message-Id: <20000712133107.23409@mailhost.mipsys.com>
In-Reply-To: <Pine.LNX.4.10.10007112110350.1244-100000@cassiopeia.home>
References: <Pine.LNX.4.10.10007112110350.1244-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Well, some (control/platinum/valkyrie) will keep on using OF probing since
>they're used on PowerMac only. But their initialization routine will no
longer
>be called by offb.
>
>Prepare to see an (untested, as usual :-) patch for this RSN...

BTW. I didn't look in details yet what's wrong, but I noticed that with
the current bk 2.4test3:

 - video=ofonly doesn't work. We need to find some kludge to get this one
back, as it's useful on some setup with broken video (and can be the only
way to get the machine up)

 - aty128fb doesn't intialize console_fb_info (the Xpmac compat stuff).
This is easily fixed by copy&pasting code from another driver, I'll have
a fix for this in bk tonight

 - More annoying: I couldn't get XF4 to work on the Pismo with this
kernel. I tried with or without aty128fb in the kernel, I tried XF4 with
the plain fbdevhw driver, with the r128 driver without fbdev, and with
the r128 driver on top of fbdev, and all I could get is a hung XFree on a
black screen (I found no way to get the screen back with a console, but
the machine still answer to telnet).
The exact same XF4 binary works nicely on 2.2

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
