Date: Tue, 5 Oct 1999 07:36:19 -0400 (EDT)
From: Elliot Lee <sopwith@redhat.com>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org, Dave Miller <davem@redhat.com>
Subject: Re: esound for PPC
In-Reply-To: <19991005105431.012853@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.10.9910050733100.1006-100000@lacrosse.corp.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 5 Oct 1999, Benjamin Herrenschmidt wrote:

> I may be wrong, but to me, this looks like a bug in esound. The driver
> seems capable of telling the application about it's current format and
> can be told to change it. If esound does assumptions about the default
> format instead of querying the driver, then esound is broken. (Also
> the driver may have been switched to another format by an application
> before esound takes control anyway. I don't remember which of
> /dev/audio or /dev/dsp will keep the current setting so this may not
> be an issue).
> 
> I agree that the driver lacks a call to query about the native endian,
> so if you really want to, you can add code to esound to force-switch
> to big endian on PowerMac, but at least, it should be fixed to not
> rely on a supposed default setting.

In ftp://people.redhat.com/sopwith/esound-0.2.15.tar.gz (not a final
release), it explicitly sets big-endian mode on big-endian machines, so
things should work a bit better. There is also a related bug in the sound
file playback code fixed, that should help davem's "esdplay plays garbage"
problems. Please try this out and let me know.

-- Elliot					http://developer.gnome.org/
The first thing a programmer needs to admit is that any program is by far
more complex than his own mind. Thats why he partitions it into neat
pieces and avoids complexity.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
