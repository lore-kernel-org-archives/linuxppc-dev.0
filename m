Date: Sun, 9 Jan 2000 18:22:56 -0800 (PST)
From: Mark Vojkovich <mvojkovich@varesearch.com>
To: Shuangjun Zhu <r44089@email.sps.mot.com>
cc: XFree86 Devel <devel@XFree86.Org>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Question about the video device driver
In-Reply-To: <009201bf5b0b$01e4c140$73f102de@sjzhu>
Message-ID: <Pine.LNX.4.04.10001091810530.25394-100000@silicon.su.valinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Mon, 10 Jan 2000, Shuangjun Zhu wrote:

> >   What format is the hardware buffer in?  What macroblock
> >size?
> > 
> 
> 
> For the MPC823 FADS board, video controller is in the CPM, part of 
> the CPU, and video encoder is ADV7176, video memory is map to 
> the system memory.  It can support NTSC/PAL display.
> 
> MPC823 can support RGB and YCr Cb, but for Analog Devices ADV7176
> video encoder,  it can only support 4:2:2 YCr Cb(CCIR 601) format.
> 
> I do not know what the macroblock's meaning is.
> 

  I meant the Cr and Cb sampling intervals.  It's 4:2:2 so it's
2x1 pixel blocks.  That means you have to do some sort of
shadowfb method since X requires that you can read back
the data without loss.  If there were Cb and Cr samples for each
luma, then you could have used a StaticColor visual and rendered
directly into the framebuffer.  StaticColor is like pseudocolor
but with a fixed lookup table.


			Mark.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
