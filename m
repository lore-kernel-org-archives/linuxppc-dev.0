Date: Fri, 7 Jan 2000 10:05:49 -0800 (PST)
From: Mark Vojkovich <mvojkovich@varesearch.com>
To: XFree86 Devel <devel@XFree86.Org>
cc: Shuangjun Zhu <r44089@email.sps.mot.com>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Question about the video device driver
In-Reply-To: <Pine.GSO.4.10.10001071005530.10461-100000@dandelion.sonytel.be>
Message-ID: <Pine.LNX.4.04.10001070959040.28797-100000@silicon.su.valinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Fri, 7 Jan 2000, Geert Uytterhoeven wrote:

> On Fri, 7 Jan 2000, Shuangjun Zhu wrote:
> > The video of MPC823 FADS board only support YCbYCr mode,
> > so how can I write a device driver for the video of MPC823 FADS board,
> > to enable the X?
> > 
> > Any suggestion? 
> > Thanks in advanced.
> 
> This sounds like an interesting project.
> 
> How many bits per pixel are available? If it's not too much you can create a
> staticcolor visual and consider it to be a simple paletted video mode (with a
> static palette). However, IIRC, XFree86 doesn't support staticcolor hardware,
> but support for that is probably closer than support for YCbCr.

   We support static color visuals just fine.  But there will be
a problem if the hardware doesn't have a macroblock size of 1x1.
It's required that you can get read the data back without losing
information.  If you are sharing chroma between pixels that's
not going to work.

> 
> I see you write YCbYCr? So the color components are subsampled like digital
> broadcast video? In that case things become more complex because of the
> different resolutions for the luminance and chrominance channels.
> 
> All this combined, I think the best solution is to use the virtual frame buffer
> feature of XFree86 3.9.x (draw in a piece of memory as large as the screen) and
> update the screen image by converting the changed parts from RGB to YCbYCr.

   Yes, shadowfb should work fine for this if the hardware can do the
conversion from RGB data stored in system memory.


				Mark.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
