From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
Subject: Re: patch to get latest XFree 4.0 snapshot (xf3918) to work on ppc with r128
Date: Thu, 24 Feb 2000 22:19:34 -0500
Content-Type: text/plain
Cc: linuxppc-dev@lists.linuxppc.org
References: <Pine.LNX.4.21.0002241917120.2343-100000@idd-01.imbc.gr> <00022417315801.00485@localhost.localdomain>
In-Reply-To: <00022417315801.00485@localhost.localdomain>
MIME-Version: 1.0
Message-Id: <00022422322102.01256@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Kostas,

> I have been looking at my mouse problems in XF 3.9.18 and put some debug
> statements into Xserver/hw/xfree86/input/mouse/mouse.c to look at the raw
> characters being read from /dev/usbmouse.

Well I have been looking at xfree86/input/mouse/mouse.c

The problem was in MouseReadInput().

What a HUGE KLUDGE!

This is some of the most whacked code I have ever seen.  Setting up tables with
wierd parameters just to try and use the exact same routine to handle all mice
regardless of how many characters they return, whether serial or bus or
whatever.

This in just simply incredibly bad coding.  It is unmaintainable since any
change will have to impact other mice or simply need another bad hack to work
around it.

The code they were using deliberately resulted in out of sync characters after
the very first call.

I hacked away most of the MouseReadInput() code and now things work as expected.

I will try to clean up my changes and put back most of what I hacked out so
that they can be integrated into the xfree86 tree in time for xfree 4.0 but
someone should really simplify it and stop trying to make one routine work for
every case (the tables simply could have pointed to individual routines).

Kevin

--
Kevin B. Hendricks
Associate Professor of Operations and Information Technology
Richard Ivey School of Business, University of Western Ontario
London, Ontario  N6A-3K7  CANADA
khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
