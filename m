From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: howarth@bromo.med.uc.edu (Jack Howarth)
Subject: Re: patch to get latest XFree 4.0 snapshot (xf3918) to work on ppc with r128
Date: Fri, 3 Mar 2000 17:14:23 -0500
Content-Type: text/plain
References: <200003031924.LAA72531@bromo.med.uc.edu>
In-Reply-To: <200003031924.LAA72531@bromo.med.uc.edu>
Cc: Kostas Gewrgiou <gewrgiou@imbc.gr>, linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Message-Id: <00030317250700.01446@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Jack,

>     I am not sure if this may become a problem but be aware that the
> usb code from linux-pmac-devel is broken on the Sawtooth G4's and the
> newer portables. So you may want to be careful when you backport any
> of that into the linux-pmac-stable tree.

Actually, I won't actually backport anything from 2.3.X.  The problem is that
the XFree 4.0 Xservers expect bit 3 to always be set in the first character
read from the input buffer of the mouse doing IMPS/2 otherwise it assumes
something got out of sync and throws that character out.

So to make XF 4.0 work with linuxpmac 2.2.X kernels all we have to do in "or" in
0x8 (to set bit 3) on the first character so that it correctly does IMPS/2
(2.3.X already has this fix in place).

--- drivers/usb/mouse.c.prev    Fri Mar  3 17:18:37 2000
+++ drivers/usb/mouse.c Fri Mar  3 17:19:56 2000
@@ -183,6 +183,7 @@
                switch (state) {
                case 0: { /* buttons and sign */
                        int buttons = mouse->buttons;
+                        buttons = buttons | 0x08; // set bit 3 to fit imps/2
                        mouse->buttons = 0;
                        if (mouse->dx < 0)
                                buttons |= 0x10;


I still need to recompile and check this with an unpatched XFree 4.0 Xserver
but this should do the trick.

Thanks,

Kevin

 --
Kevin B. Hendricks
Associate Professor of Operations and Information Technology
Richard Ivey School of Business, University of Western Ontario
London, Ontario  N6A-3K7  CANADA
khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
