From: stevenj@gil-galad.mit.edu
Date: Wed, 22 Mar 2000 14:30:40 -0500 (EST)
Reply-To: stevenj@alum.mit.edu
To: linuxppc-dev@lists.linuxppc.org
cc: roikawa@rr.iij4u.or.jp
Subject: Small patch for Xpmac mouse button keys
Message-ID: <Pine.LNX.4.10.10003221412090.847-100000@gil-galad.mit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dear Linux/PPC developers,

I thought I'd pass along a trivial patch for Xpmac (from the
XFree86-3.3.6-8a package in LinuxPPC 2000) that corrects a problem that
was bugging me on my Lombard laptop.

I like to set X so that the option and command keys to the left of the
space bar are mapped to emulate buttons 2 and 3 (this is much more
convenient to me than option-1 and option-2).  This worked fine in
LinuxPPC 1999 under XF68_FBDev, but when I installed LinuxPPC 2000
yesterday and switched to (the default) Xpmac, I discovered that I could
no longer do this.

The basic problem is that Xpmac gets confused if you want the option key
to be one of the mouse buttons but still want to set -nooptionmouse (so
that the unmodified command-key is button 3, in my case).  If you set
-nooptionmouse and click the option key for button 2, it doesn't recognize
it because it wants the option key to be up when the mouse keys are
pressed.

The fix is simple: if the mouse button key is the option key, ignore the
setting for -nooptionmouse.  The patch, for
XFree86-3.3.6/xc/programs/Xserver/hw/powermac/pmacIo.c, is equally
trivial:

280a281,283
> 		int optionOK = (optionDown != noOptionMouse ||
> 				IS_OPTION_KEY(*me) ||
> 				IS_RIGHT_OPTION_KEY(*me));
284c287
< 		    if (optionDown != noOptionMouse || keyUp && rightDown) {
---
> 		    if (optionOK || keyUp && rightDown) {
289c292
< 		    if (optionDown != noOptionMouse || keyUp && middleDown) {
---
> 		    if (optionOK || keyUp && middleDown) {

I hope this is useful, although perhaps future Linux/PPC releases will
standardize on XFree-4.0 so this won't be an issue any more (assuming that
the same mistake isn't made)...

Cordially,
Steven G. Johnson


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
