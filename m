Date: Wed, 26 May 1999 14:50:32 -0400 (EDT)
From: Tom Rini <tmrini@ntplx.net>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ioctl 0x7667 in Xpmac
In-Reply-To: <Pine.LNX.4.10.9905261743420.7373-100000@mercator.cs.kuleuven.ac.be>
Message-ID: <Pine.LNX.4.05.9905261445580.26691-100000@pc.wackyland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 26 May 1999, Geert Uytterhoeven wrote:

> On Wed, 26 May 1999, Tom Rini wrote:
> > It's easy enough to do, but doesn't APUS have a framebuffer? (Currently
> > if you don't have a readable /dev/fb0, it assumes MkL and uses Xpmac.  A
> > more elegant fix would be to check machine type and use that to install
> > Xbh on PReP and ??? on APUS)
> 
> Hmmm... APUS does have a frame buffer, but it doesn't have the Pmac
> compatibility mode. Since lots of people are complaining, it looks like it does
> install Xpmac instead of XF68_FBDev on APUS.

Ok, now that is odd.  I assume when the installer is being run, it says
Name: Xpmac when doing the inital X setup?  The code that's failing would
seem to be:
+#ifdef __powerpc__
+    int i, fh, rc = 0;
+    const char * name = "/dev/fb0";
+    char *server_name = "XF68_FBDev";
+
+    if (!(fh = open(name, O_RDONLY)))
+       rc = 2; /* Failure */
+
+    if (!rc && ioctl(fh, FBIOGET_FSCREENINFO, &fix))
+       rc = 2; /* Failure */

Which means no frame buffer, and most likely MkL.  We should begin working
on the installer changes to support APUS in a day or two.  Mind sending me
privatly the emails of a few people that would wish to test things out?
(or would the linux-apus list be interested?  I could subscribe for a
little while.. :))

---
Tom Rini (TR1265)
http://gate.crashing.org/~trini/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
