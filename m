In-Reply-To: <199910071828.UAA02976@simul.biophys.uni-duesseldorf.de>
Date: Fri, 8 Oct 1999 12:08:51 +0200
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: ADB probing
Message-Id: <19991008120851.018835@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Oct 7, 1999, Michael Schmitz
<schmitz@opal.biophys.uni-duesseldorf.de> wrote:

>?? I found the reset (and implicit rescan) in adb.c, is there a hook from
>mac_keyb.c? (I meant 'force a reset via /dev/adb, which will in turn cause a
>rescan)

There is a notifier that the devices can attach to the adb core. I added
this when working on the sleep code.

>Yep, that will work as long as all drivers receiving data from ADB get
>notified. Might be problematic for user space apps that open /dev/adb and
>talk to a specific device directly. In case of ID collosions, we might have
>a different device occupy that ID after a reset. As long as handler IDs and
>original IDs (better: address) are unique, there should be no problems. 
>
>BTW: opening /dev/adb to read from a specific device is cumbersome, right?
>You can send listen and talk requests to the device but there's no way to
>get autopoll data to user space. What about using minor 1-16 for that (now
>that bus probing is implemented)? 

That's something I've been thinking about for a long time, I also want
this to send ADB codes directly to mac-on-linux. Basically, it would end
up this way (please comment) :

 - minor 0 is the "control" channel where you can send bus resets, raw
commands, etc... I'll add this new ioctl for querying things like the
original address. It will be backward compatible.

 - each minor >0 correspond to an address. Open is exclusive. When
opened, the original handler (if any) is replaced by a special one that
sends autopoll datas to a ring buffer that can be read(). Optionally, we
can provide a few ioctls to set this buffer's size and to flush it. In
case a bus reset happens, all those opened minor are marked "dead" and
return an error to any read or ioctl call. (The user is then expected to
close the file, use minor 0 to re-probe the device, and reopen an
"autopoll" minor if the device is still there).

I beleive this is enough for anything we might want to do with ADB, and
things like tablet drivers could be 100% userland.



-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
