Date: Fri, 30 Jul 1999 11:15:45 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: charlie buckheit <buckheit@olg.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: X/CLUT/pixel data format question WRT IMSTT cards
In-Reply-To: <B0011235688@mail.olg.com>
Message-ID: <Pine.LNX.4.10.9907301112400.15232-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 29 Jul 1999, charlie buckheit wrote:
> I was wondering if someone who understands the Xserver code a little better

Which Xserver? Xpmac or XF68_FBDev?

> can first point me in the direction of the code that sets the CLUT for X,
> second if any information on the pixel data formats for the various color
> modes is available, and third if the Xserver runs in true color mode or does
> it only use the color lookup tables. I'm trying to figure out why the IMSTT
> card is still having problems in 16 and 24/32 bpp modes. I pretty much
> proved to myself that its not an endian problem (I've got IXMicro provided
> code and API manuals for the chipsets) as when I write directly to the video
> memory the results on the screen are correct (i.e. in 24/32 bpp writting
> 0x000000ff to the screen results in blue, 0x0000ff00 green, 0x00ff0000 red,
> and 0xff000000 in black as the most significant 8 bits are the alpha data
> which is not used). On my computer the greys are correct (telling me that

OK.

> the RGB registers are probably correct as all three must be the same value
> to get greys in true color mode), and images displayed in GIMP are fine

OK.

> (this can't be pure luck can it???)...its just the gnome/enlightenment stuff
> thats messed up...specifically the icons and window borders. So my thought
> now is that either the X pixel formats are different then the IMSTT card
> expects or the CLUT is not getting set correctly or X doesn't like the true
> color mode.

Perhaps these are accelerated routines?

If you are using XF68_FBDev, does it help if you add

    option "noaccel"

to the `Device' section of your XF86Config?

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
