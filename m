Date: Mon, 24 Jul 2000 10:41:52 -0400 (EDT)
From: John Grimes <jpgrimes@johngrimes.dyndns.org>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Xfree86 version 4.01
In-Reply-To: <Pine.LNX.4.10.10007241613520.26700-100000@opal.biophys.uni-duesseldorf.de>
Message-ID: <Pine.LNX.4.21.0007241035230.1920-100000@johngrimes.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Mike,
	Will trying using fbset to create the modelines, that would
certainly explain why only 1280x1024 works.
	Yes i have 2 video cards, I have the pci rage128gl and the
internal (platinum I think) video that comes with all powercenters.  An
lspci does not show the internal video.  Could this be a kernel build
config issue?  I thought I included support for the internal apple
video.  I off course have this working in the MacOS.
				Thanks,
				John


On Mon, 24 Jul 2000, Michael Schmitz wrote:

> > For some reason I can not get any other mode to work
> > (i.e. 640x480,1024x768, 800x600).  If any would fail I would expect it to
> > be 1280x1024 not the smaller modes.  I have no modelines defined, just
> > letting XF86 decided which modes to use.  Any ideas why the defaults don't
> > work?
>
> The default does work, and it's the only one that works. Missing any mode
> lines, XFree queries the kernel frame buffer driver for the current mode
> line (at least it does that for Mach64 which heavily uses the fbdevhw
> module) and uses that.
>
> Try setting the console video mode to a variety of other modes you'd like
> to use in X (man vmode), then run fbset -x on each mode (this prints
> the XFree mode definition that corresponds to the current video mode) and
> append the output to a file. When done, edit the modes in that file to
> give each a unique meaningful name, and include these mode definitions in
> /etc/X11/XF86Config.
>
> > Next is getting multiple monitors (Xinema) to work.  I know there has
> > been
> > discussion of this on the list.
>
> Xinerama, and you'll need multiple video cards for this as I don't think
> any kernel or user space driver knows how to drive f.e. the LCD and VGA
> out at the same time, with different displays on it.
>
> > First how do I find out the bus address of my internal video?  It doesn't
> > show up in /proc/pci although it is in /proc/fb.  This is on a
> > highly upgraded powercenter.
>
> lspci -vv should show your PCI video device.
>
> 	Michael
>

--
           John Grimes - Mission Planner for Chandra X-Ray Telescope
Phone 	(H) 617-591-1393	(W) 617-496-7663	(Fax) 617-495-7356
Email 	me@johngrimes.com	Web	http://www.johngrimes.com
Pager	1-800-473-6312 		Alphanumeric  4736312@mobilecomm.net)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
