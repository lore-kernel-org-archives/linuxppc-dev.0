From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bastien Nocera <hadess@hadess.net>,
	LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Kernel sound problems (and misc)
Date: Sun, 13 May 2001 19:05:55 +0200
Message-Id: <20010513170555.17579@smtp.wanadoo.fr>
In-Reply-To: <989768459.4941.0.camel@kara>
References: <989768459.4941.0.camel@kara>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>OK, there goes the main problem: mixer problems. There are 3 ways to
>output sound on this iMac DV summer 2000 (OF tree still available from
>tidbit.org).
>- the front speakers: the preferred way obviously. Main volume is of no
>use (doesn't do anything), the speakers volume goes from mute, or loud
>to very loud.

I think on those models, we must set the sound chip volume to a fixed
value and control the "SRS" amplifier using I2C. I don't have all the
details in mind yet however.

>- the front audio sockets: there aren't independant of the front
>speakers, doesn't really matter, but that means it's not possible to
>shut the sound of the speakers and listen to the music with a headphone.
>It might be a hardware problem.

Probably related to the above problem.

>- the audio socket for external speakers on the left handside of the
>machine: there's no volume control for them. Bringing down all the
>volume controls shut off the front speakers (good), but there's no way
>to raise or lower the sound on this output either.

Well, if it's a "line" output, it can be considered normal. (the line
output of a portable CD player has no volume control for example). You
should look at what happens with MacOS.

>So, to sum it up, the main volume control does absolutely nothing on
>this machine, and the speaker volume control is either mute, loud, or
>very loud. I'd be glad to help on finding out the problem.
>
>The misc problem is, while trying to compile paulus' kernel, the vmlinux
>target fails to link with rwsem_down_write_failed and rwsem_wake
>undefined references.

Use my tree for pmac.

>I hope somebody can help me tackle these.

The main issue is that almost each Apple motherboard has a different
wiring of the sound chips. Some of them (the newer ones) seem to
describe things in the OF tree, older ones need us to hard code
the layout. Our current driver doesn't cope with that very well
yet. Also, some boards have external hardware (like amplifiers,
SRS module, ...) that need to be controlled with the I2C bus, for
which we don't have drivers for all machines.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
