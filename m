Date: Fri, 4 Feb 2000 23:56:13 -0600 (CST)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Brad Midgley <brad@turbolinux.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [patch] little-endian dmasound silently fails
In-Reply-To: <Pine.LNX.4.20.0002041952120.32666-100000@mail.turbolinux.com>
Message-ID: <Pine.LNX.3.96LJ1.1b7.1000204221814.20504A-100000@ofey.inetnebr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 4 Feb 2000, Brad Midgley wrote:

> > How does it write "little-endian data"?  Does the program take care of CPU
> > being big-endian in some way?  If not, I'd think it's the program's fault.
>
> the api provides for a way for clients to set the driver to accept
> little-endian data. worse than simply not implementing it, dmasound also
> makes it *appear* that it implements it.

Maybe because it does support it?  Well, seriously, I've just checked the
driver is okay wrt *S16_LE/BE at least on AWACS rev. 2.

First, I wrote an app to play a sound file correctly when AFMT_S16_BE is
specified.  Then, I modified the app so that it will byte swap the 16-bit
data but still with AFMT_S16_BE.  As expected, it made some annoying
noise when it was asked to play the same sound file.  Now, I modified the
code again to let it specify AFMT_S16_LE instead.  Well, it played the
sound file correctly just as hoped.

I know a lot of people are not happy about our sound driver, but I
don't think this is dmasound's fault.  Luckily for us, many "broken"
OSS-compatible apps tend to work just fine if we simply modify them to ask
for AFMT_S16_NE not *_LE, though performance critical apps should be fixed
with more effort.


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
