Date: Fri, 7 Jan 2000 10:12:38 +0100 (MET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Shuangjun Zhu <r44089@email.sps.mot.com>
cc: XFree86 Devel <devel@XFree86.Org>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Question about the video device driver
In-Reply-To: <00bc01bf58e1$2bf49b80$73f102de@sjzhu>
Message-ID: <Pine.GSO.4.10.10001071005530.10461-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 7 Jan 2000, Shuangjun Zhu wrote:
> The video of MPC823 FADS board only support YCbYCr mode,
> so how can I write a device driver for the video of MPC823 FADS board,
> to enable the X?
> 
> Any suggestion? 
> Thanks in advanced.

This sounds like an interesting project.

How many bits per pixel are available? If it's not too much you can create a
staticcolor visual and consider it to be a simple paletted video mode (with a
static palette). However, IIRC, XFree86 doesn't support staticcolor hardware,
but support for that is probably closer than support for YCbCr.

I see you write YCbYCr? So the color components are subsampled like digital
broadcast video? In that case things become more complex because of the
different resolutions for the luminance and chrominance channels.

All this combined, I think the best solution is to use the virtual frame buffer
feature of XFree86 3.9.x (draw in a piece of memory as large as the screen) and
update the screen image by converting the changed parts from RGB to YCbYCr.

Does the MPC823 FADS have accelerated graphics? Accelerated RGB to YCbYCr
conversion?

I'm moving the discussion to XFree86 Devel <devel@XFree86.Org>.

> -----Original Message-----
> From: Geert Uytterhoeven <geert@linux-m68k.org>
> To: Shuangjun Zhu (r44089) <r44089@email.sps.mot.com>
> Cc: linuxppc-dev@lists.linuxppc.org <linuxppc-dev@lists.linuxppc.org>
> Date: Tuesday, January 04, 2000 6:09 PM
> Subject: Re: Question about the video device driver
> 
> 
> >
> >On Tue, 4 Jan 2000, Shuangjun Zhu wrote:
> >> If the data format in the video memory is CbYCrY,
> >> the above layer application like Xserver can handle this?
> >
> >XFree86 doesn't do YCbCr.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ----------------- Sony Suprastructure Center Europe (SUPC-E)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248632 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
