Message-ID: <38E45061.2504BA87@iiic.ethz.ch>
Date: Fri, 31 Mar 2000 09:14:41 +0200
From: Michel Dänzer <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
CC: "William H. Schultz" <whschult@uncc.edu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Xinerama Support?
References: <Pine.LNX.4.10.10003301218050.20130-100000@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz wrote:

> > If you only have offb for one head, you might be out of luck :(

I'll add something I forgot: Currently both heads must have the same depth for
Xinerama.


> IIRC the bus ID option is only needed if you have multiple video devices
> to choose from.

No, the X server will deactivate all video devices (it can see) which aren't
claimed. And the fbdev driver can currently only claim the device it uses with
the bus ID specified in the config file.


> If there are multiple devices, and the one using offb maps to the first
> frame buffer device, it should be possible to pass the frame buffer device
> name to the X server for the other one (in the fbdev device option,
> apparently).

Right,

	Option	"fbdev"	"/dev/fb1"

must be added in the Device Section for the second head.


> > > Is there any way to get the fbdev driver to be a bit faster?  I'm not
> > > too thrilled about having to wait 5 minutes watching the screen go gray
> > > so that I can log out.  (I'm not exagerating very much here.)
> >
> > It's a shortcoming in 4.0's brand new lowlevel framebuffer code. I've
> > reported it to the author, don't know if he's (been) working on it...
>
> What's the problem there? It's been annoying as hell, and I'd like to give
> it a try...

The new code is very slim and mostly faster with HW acceleration, but not very
optimized without yet (especially not on big endian :-/) . BTW this is about
xc/programs/Xserver/fb , the author is Keith Packard <keithp@suse.com> .


Michel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
