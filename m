Date: Wed, 1 Aug 2001 17:41:58 -0500
From: "Joseph P. Garcia" <jpgarcia@execpc.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: special adb buttons don't survive sleep
Message-Id: <20010801174158.2b4e3d5d.jpgarcia@execpc.com>
In-Reply-To: <3B688167.9010906@hadess.net>
References: <3B688167.9010906@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 01 Aug 2001 23:23:35 +0100
Bastien Nocera <hadess@hadess.net> wrote:
> Joseph's code for the special adb buttons doesn't survive sleep, the
> event device just isn't present anymore when coming back from sleep. All
> the other event devices are present (/dev/input/eventX).

One of my patches attempts to fix this.  Upon wakeup, all adb input devices are deregistered, probed, and registered.  Any device that is open at the time is left safely dangling when deregistered, and if still open upon a register, skipped over.  so if device 2 of 0,1,2,3 is open, post sleep, 2 will be 3, and 3 will be 4 (0,1,_,3,4).

My modification changes it so it re-registers devices when found and are different, registers if new, and lastly, deregisters anything that was there, but wasn't found in the probe.  All still existing hardware is re-inited, but their NIL hooks are untouched.  I don't know if its safe though.  Recently, my keyboard has been vanishing.  X runs fine, but need to login to do anything.  last I tried, a panic right after unmounting fs's.  but I'm using XF4.1, which still seems to have issues with my ati ever since the silken cursor was added. (OT)

It still seems like the best idea.  Better than telling the daemon something happened.  Sleep really shouldn't be in a keyboard event handler's vocabulary imo.

Franz might know of any pitfalls in my method.

--
Joseph P. Garcia
http://www.lycestra.com/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
