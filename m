Date: Fri, 14 Jan 2000 08:51:22 -0700
From: Kevin Buettner <kev@primenet.com>
Message-Id: <1000114155122.ZM26031@saguaro.lan>
In-Reply-To: Robert Roebling <roebling@ruf.uni-freiburg.de>
        "X11 pixel value on bigendian PPC" (Jan 13,  7:01pm)
References: <387E2122.4D258AF0@ruf.uni-freiburg.de>
To: Robert Roebling <roebling@ruf.uni-freiburg.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: X11 pixel value on bigendian PPC
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Jan 13,  7:01pm, Robert Roebling wrote:

> I'm the main authour of the Linux port of the 
> wxWindows GUI library and I need help from one
> of you to make wxWindows work on LinuxPPC as
> well as elsewhere. I'm sure that 99.9% of the
> library will work equally as on my intel, but
> I have one lingering problem, and that is that
> PowerPC are probably bigendian. Not much of a
> problem in most cases, but when converting image
> data under X11 (or GTK for that matter) this
> plays a role. I had no problem to write image
> conversion routines for 8-bit displays (no change
> in big vs. little endian) and on 24-bit systems
> (just exchange RGB bytes), but for 15 and 16 bit
> visuals, I'm stuck with no machine I could test
> this on (the Suns I can use have either 8-bit or
> 24-bit) and no info either. Do you have any info
> on the meaning of bits on a big-endian computer
> in the pixel value, that is returned by an XGetPixel()
> call ona 16- and on a 15-bit visual? If not, maybe
> someone who has access to a big-endian machine with
> such a visual could have a look at the relevant
> source in wxWindow and see what happens?

The XVisualInfo structure gives you the information
you need.  (The red_mask, green_mask, and blue_mask
fields should be used to tell you how to [de]compose
a pixel.)

The way the pixels are laid out varies between X
servers, so you definitely do not want to hard code
this.  I.e, I've seen some X servers which use only
5 bits per pixel and others which did 5-6-5.  (And
other combinations certainly are possible.)

In the past, I've found Xvnc to be a useful tool for
testing this type of code.  It lets you create custom
visuals at different depths with different mask values
for the pixels.  See

    http://www.uk.research.att.com/vnc/xvnc.html

for more information on VNC.

Kevin

-- 
Kevin Buettner
kev@primenet.com, kevinb@cygnus.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
