In-Reply-To: <Pine.LNX.4.10.9910061626290.10804-100000@opus.bloom.county>
Date: Thu, 7 Oct 1999 18:15:41 +0200
To: Tom Rini <trini@kernel.crashing.org>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: ADB probing
Message-Id: <19991007181541.031811@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Oct 6, 1999, Tom Rini <trini@kernel.crashing.org> wrote:

>I've run into a wierd problem with ADB stuff, and I wonder if anyone has
>an idea on how to work/fix this.  What I'm trying to do right now is fix
>up kudzu so it can probe for things on the ADB bus.  Right now it does
>what all the other old config tools did, and pokes at /dev/adbmouse.  The
>problem is right now this works if there's any adb device present (one of
>the machines I checked only has an adb kbd, tho adbmouse suport is
>compiled in).  Also, is there any way to see if the machine has an adb
>keyboard installed?  Thanks..

Look at my trackpad tool source code, you'll find an example of probing
the devices. That's not an ideal way since part of the "device type"
information is the original address of the device before relocation, and
you can't ask the device about this. You should be able to handle most
cases with just the handlerID, but I'll look into adding a couple of
ioctls to /dev/adb so you can also get the original address. (I'll do
this next week end, ping me if I forget, I'm doing too many things at the
same time those last few weeks).

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
