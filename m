Message-ID: <374EB8F0.120EEA95@jlc.net>
Date: Fri, 28 May 1999 11:40:32 -0400
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Hollis R Blanchard <hollis+@andrew.cmu.edu>
CC: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Sound stuff (was Re: G3 sound recording)
References: <Pine.LNX.3.96L.990528094356.1314B-100000@unix47.andrew.cmu.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hollis R Blanchard wrote:

> First, that's awesome Dan. =)

Thanks.  I haven't seen my CVS update mail message yet, so I don't
know where the bits really are :-).  I did enough to help out my
other projects.  I am doing lots of embedded audio projects, and
just needed a way to record various samples on my PowerBook.  This
works for me, and unless I find some bugs in this basic feature I
probably won't be making any more updates.

> Second, this reminded me of two sound things, both about the CD...

When you are playing mp3, it is using the dma sound driver to send
those bits to the AWACS and out the audio port.  The play functions
(which I didn't touch and hopefully didn't break :-), give precedence
to the data you are writing.  Any kernel generated audio (like beeps)
are discarded.

The audio driver is an exclusive use device (play and record are
separate).  If multiple programs are trying to open, the later ones
wait until the current program closes and then the later program
starts running.  Now, keep in mind you can separately open the read
and write.  When you get around to making ioctl()'s, the driver
doesn't track anything so you could have two threads or programs
fighting each other for capabilities.

When you are playing an audio CD, the analog sound from the CD is
just mixed in the output stage along with the samples you are playing
from any program.  This is why you can play an audio CD without any
processing overhead, and why you also get the kernel (or program)
generated audio samples.  If you want, you can now switch the CD to
become an recording input, read the data into a program, and then
write it back out.  Lots of cycles I would rather spend on something
else :-).

The kernel certainly doesn't do any kind of audio mixing.  It is
more then just adding the bits and should be done by an application
program that knows this.  The sound drivers just enable hardware
capability, and provide a buffering path for PCM samples to
applications.


> The other thing was, does anyone remember the CD audio volume...

I played around with volumes and gains from my test program.  If
you send the right parameters through the ioctl() it seems to
work.  I didn't download any player/mixer sources to see how this
is done.

By the way, I thought someone (Cort?) has a program that would
intercept the volume/mute buttons on the PowerBook and perform the
volume operation.  If not, I can write this.  Maybe I can do
something similar to the screen brightness and intercept these in
the kernel and just "make it happen".  This value must also be
stored in NVRAM someplace.  Anyone know where?


	-- Dan

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
