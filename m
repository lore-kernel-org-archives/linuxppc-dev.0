Date: Wed, 21 Jul 1999 15:35:26 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
cc: Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>
Subject: Re: Problems with the atyfb driver on Power Mac G3
In-Reply-To: <Pine.LNX.4.10.9907111312360.392-100000@cassiopeia.home>
Message-ID: <Pine.LNX.4.10.9907211505370.15642-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



[ I typed and sent this mail last monday, but it seems to have gotten lost, so
  I'm retyping and resending it ]

On Sun, 11 Jul 1999, Geert Uytterhoeven wrote:
> On Tue, 6 Jul 1999, Eric Dorland wrote:
> > >What about providing a private ioctl to set those threshold values ? With
> > >a simple command line tool and eventually a pair of sliders on X, this
> > >would allow people to try out and us to collect infos about behaviour of
> > >various values on various configurations, and eventually provide more
> > >conservative default values, and letting the user eventually increase
> > >performances later.
> > 
> > Would anyone be willing to write such I beast? I would be more than willing
> > to lend a hand (having fair C skills), but I know little about kernel
> > hacking and even less about fiddling with video drivers, so I don't know
> > how much help I'd be :)
> 
> It's on my list. Not the GUI thing of course, but just the ioctl() stuff and a
> small program to play with it.

And so I did: not the GUI thing, but a small command line utility. And a patch
for atyfb, of course:

    http://www.cs.kuleuven.ac.be/~geert/bin/atyfb_dsp_debug.tar.gz
	
The things related to the FIFO you can tune with it are

  - DSP loop latency (0-15): SDRAM/SGRAM latency?
  - DSP precision (0-7) for next 3 options, which are actually floating point
    numbers. Atyclk automatically takes care of the conversion, using the
    specified (or current) precision.
  - number of xclocks per display row: this is the ratio between the FIFO
    empty rate (vclk * bpp bits) and the FIFO fill rate (mclk * 64 bits).
  - DSP on threshold: the FIFO starts refilling when less than `on' pixels are
    available in the FIFO.
  - DSP off threshold: the FIFO stops refilling when `off' pixels are
    available in the FIFO.

(this is a combination of the scarse information from the ATI docs and what I
 found out).

`atyclk --help' for a list of options.

Some explanation about how the FIFO works (yes, I really should start writing
a text about graphics board programming, covering topics like

  - The CRT/graphics engine
  - PLL programming
  - The display FIFO
  - Acceleration engine programming (command FIFO, ...)
):

--------------------------------------------------------------------------------
SDRAM/SGRAM are synchronous types of memory. This means they can deliver one
word of data on every clock cycle in burst mode. Unfortunately SDRAM/SGRAM
have high latencies. This means you need s clock cycles to fetch one word of
data, but only s+1 clock cycles for two words, s+2 clock cyles for three
words, and so on. To optimize performance, you better access bursts of many
consecutive words in memory after each other. Random memory access is a
nightmare with SDRAM/SGRAM, since each access takes s clock cycles (s being
much higher than with the old FPM or EDO RAM).

Summarized:

  SDRAM/SGRAM: s/1/1/1
  FPM RAM: s/3/3/3
  EDO RAM: s/2/2/2

The actual numbers may differ, but you can see the point.

The graphics engine has to read from memory to provide the monitor with the
correct display data. But since SDRAM/SGRAM is single-ported memory (unlike
VRAM and WRAM, which are dual-ported), the graphics engine has to share
graphics memory access with the acceleration engine and the CPU.
read/write to that memory.

Graphics engine access has strict `real time' constraints: if it can't read
data when needed, the screen image will be disturbed. To prevent this and to
utilize the burst features of SGRAM, the graphics engine reads from the video
memory through a FIFO. When the FIFO gets empty (below a specified threshold),
data is fetched. When the FIFO gets sufficiently full (above a specified
threshold), video memory access is suspended and the CPU or acceleration
engine are free to do their things.

                  +-------------------------------+
                  |                               |
   w bits at ---> | FIFO with n entries of w bits | ---> bpp bits at
   rate mclk      |                               |      rate vclk
                  +-------------------------------+
                         ^               ^
                         |               |
                      FIFO on         FIFO off
                      threshold       threshold

To get maximum performance, you want a low threshold-empty value and a high
threshold-full value, because SGRAM is optimized for burst accesses, but has a
high latency for the initial access. Higher threshold-empty and lower
threshold-full values are more conservative and more likely to not disturb the
screen, but lower the performance.
--------------------------------------------------------------------------------

For the ATI, we have:

  w = 64 bits
  n = 24 (RAGE/RAGE II/RAGE IIc) or 32 (RAGE PRO) entries
  mclk = memory clock
  vclk = pixel clock

DISCLAIMER: do not use this if you don't understand everything I wrote above!

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
