Date: Mon, 24 Jul 2000 16:20:35 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: John Grimes <jpgrimes@johngrimes.dyndns.org>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Xfree86 version 4.01
In-Reply-To: <Pine.LNX.4.21.0007240959001.1920-100000@johngrimes.dyndns.org>
Message-ID: <Pine.LNX.4.10.10007241613520.26700-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> For some reason I can not get any other mode to work
> (i.e. 640x480,1024x768, 800x600).  If any would fail I would expect it to
> be 1280x1024 not the smaller modes.  I have no modelines defined, just
> letting XF86 decided which modes to use.  Any ideas why the defaults don't
> work?

The default does work, and it's the only one that works. Missing any mode
lines, XFree queries the kernel frame buffer driver for the current mode
line (at least it does that for Mach64 which heavily uses the fbdevhw
module) and uses that.

Try setting the console video mode to a variety of other modes you'd like
to use in X (man vmode), then run fbset -x on each mode (this prints
the XFree mode definition that corresponds to the current video mode) and
append the output to a file. When done, edit the modes in that file to
give each a unique meaningful name, and include these mode definitions in
/etc/X11/XF86Config.

> Next is getting multiple monitors (Xinema) to work.  I know there has
> been
> discussion of this on the list.

Xinerama, and you'll need multiple video cards for this as I don't think
any kernel or user space driver knows how to drive f.e. the LCD and VGA
out at the same time, with different displays on it.

> First how do I find out the bus address of my internal video?  It doesn't
> show up in /proc/pci although it is in /proc/fb.  This is on a
> highly upgraded powercenter.

lspci -vv should show your PCI video device.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
