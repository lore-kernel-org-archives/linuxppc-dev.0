Message-ID: <397C5502.4825FF94@student.ethz.ch>
Date: Mon, 24 Jul 2000 16:38:58 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: John Grimes <jpgrimes@johngrimes.dyndns.org>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Xfree86 version 4.01
References: <Pine.LNX.4.21.0007240959001.1920-100000@johngrimes.dyndns.org>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


John Grimes wrote:

> For some reason I can not get any other mode to work (i.e. 640x480,1024x768,
> 800x600).  If any would fail I would expect it to be 1280x1024 not the
> smaller modes.  I have no modelines defined, just letting XF86 decided which
> modes to use.  Any ideas why the defaults don't work?

Look at the log. There should be a reason for every rejected mode.


> First how do I find out the bus address of my internal video?  It doesn't
> show up in /proc/pci although it is in /proc/fb.  This is on a highly
> upgraded powercenter.

If it's not in /proc/pci, the server probably doesn't bother about it either,
so you shouldn't have to care.

> Also, I seem to have not saved it as I had thought, but does anyone have
> an example XF86Config file for multiple monitors?

You have to add Device and Screen (and maybe Monitor) Sections for the
internal video (I suppose it needs the fbdev driver?). And then you have to
add a Layout Section, something like this:

Section "ServerLayout"
    Identifier	"Main Layout"
    Screen	"Screen 1"
    Screen	"Screen 2" RightOf "Screen 1"
    InputDevice	"Mouse1" "CorePointer"
    InputDevice "Keyboard1" "CoreKeyboard"
EndSection


Good luck,

Michel


--
Nice little planet you've got there. Shame if anything were to happen to it.
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
