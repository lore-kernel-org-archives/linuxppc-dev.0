From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
Subject: Re: patch to get latest XFree 4.0 snapshot (xf3918) to work on ppc with r128
Date: Thu, 24 Feb 2000 17:25:41 -0500
Content-Type: text/plain
Cc: linuxppc-dev@lists.linuxppc.org
References: <Pine.LNX.4.21.0002241917120.2343-100000@idd-01.imbc.gr>
In-Reply-To: <Pine.LNX.4.21.0002241917120.2343-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Message-Id: <00022417315801.00485@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I have been looking at my mouse problems in XF 3.9.18 and put some debug
statements into Xserver/hw/xfree86/input/mouse/mouse.c to look at the raw
characters being read from /dev/usbmouse.

They seemed to pretty much be garabage and out of sync.  Sometimes the head of
the character buffer showed mouse button events and sometimes other buffer
positions showed the events.   Also, the mouse.c driver tries to read 4
characters from the usb mouse while the Xpmac mouse driver I wrote only reads 3
bytes at a time.

So the IMPS/2 protocol is just getting garbage to process into buttons, and dx,
dy, dz.

Is this a known problem?

I looked back to xf3.9.17 and it defaulted to my legacy mouse driver but xf
3.9.18 won't seem to do that  (the mouse module is forcibly loaded by XFree86
Xserver whether you want it to or not).

Any ideas here would be greatly appreciated?

Has anyone been able to get a usb mouse working with xf 3.9.18?

Thanks,

Kevin


--
Kevin B. Hendricks
Associate Professor of Operations and Information Technology
Richard Ivey School of Business, University of Western Ontario
London, Ontario  N6A-3K7  CANADA
khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
