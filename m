Date: Mon, 24 Jul 2000 11:00:21 -0400 (EDT)
From: John Grimes <jpgrimes@johngrimes.dyndns.org>
To: Michel Dänzer <daenzerm@student.ethz.ch>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Xfree86 version 4.01
In-Reply-To: <397C5502.4825FF94@student.ethz.ch>
Message-ID: <Pine.LNX.4.21.0007241055570.1920-100000@johngrimes.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 24 Jul 2000, Michel [iso-8859-1] Dänzer wrote:

> John Grimes wrote:
>
> > For some reason I can not get any other mode to work (i.e. 640x480,1024x768,
> > 800x600).  If any would fail I would expect it to be 1280x1024 not the
> > smaller modes.  I have no modelines defined, just letting XF86 decided which
> > modes to use.  Any ideas why the defaults don't work?
>
> Look at the log. There should be a reason for every rejected mode.

There aren't any rejected modes.  I think the suggestion taht I use fbset
to create modelines is right on.

>
>
> > First how do I find out the bus address of my internal video?  It doesn't
> > show up in /proc/pci although it is in /proc/fb.  This is on a highly
> > upgraded powercenter.
>
> If it's not in /proc/pci, the server probably doesn't bother about it either,
> so you shouldn't have to care.
>
> > Also, I seem to have not saved it as I had thought, but does anyone have
> > an example XF86Config file for multiple monitors?
>

ahh, i think i see now.  By defining a fb device the fbdev driver will
figure it wou, unlike the r128 driver which wanted a bus id.  Will give it
a try, how do I do fbset -x to see the modelines on the second monitor?


> You have to add Device and Screen (and maybe Monitor) Sections for the
> internal video (I suppose it needs the fbdev driver?). And then you have to
> add a Layout Section, something like this:
>
> Section "ServerLayout"
>     Identifier	"Main Layout"
>     Screen	"Screen 1"
>     Screen	"Screen 2" RightOf "Screen 1"
>     InputDevice	"Mouse1" "CorePointer"
>     InputDevice "Keyboard1" "CoreKeyboard"
> EndSection
>
>
> Good luck,
>
> Michel
>
>
>


				thanks a lot,
				john

--
           John Grimes - Mission Planner for Chandra X-Ray Telescope
Phone 	(H) 617-591-1393	(W) 617-496-7663	(Fax) 617-495-7356
Email 	me@johngrimes.com	Web	http://www.johngrimes.com
Pager	1-800-473-6312 		Alphanumeric  4736312@mobilecomm.net)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
