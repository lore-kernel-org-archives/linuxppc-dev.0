Message-ID: <38DF48EB.9F8286AD@iiic.ethz.ch>
Date: Mon, 27 Mar 2000 13:41:31 +0200
From: Michel Dänzer <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
        Gabriel Paubert <paubert@iram.es>,
        Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
References: <Pine.LNX.4.10.10003271147390.31775-100000@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz wrote:

> Currently the X server refuses to start up if the RGB weights don't add up
> to the screen depth, and depth 32 isn't supported at all. 24 bpp works but
> it's really slower than 32 bpp before.

There's now a distinction between 'depth' and 'framebuffer bpp'. There is no
depth 32.

You can set framebuffer bpp with the -fbbpp command line option (there
certainly is an XF86Config option as well, but I don't remember it). You have
to add a Display Subsection like this:

    SubSection "Display"
        Depth       24
        fbbpp       32
        Modes       "1152x864" "1024x768" "640x480"
        Virtual     1152 864
    EndSubSection


> Plus the X server refuses to cooperate with xscreensaver and consistently
> kicks me out after 10 minutes.

Hm. Can you build a static server and try to track it down in gdb?


Michel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
