From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
Subject: Some issues to resolve with XFree 4.0 yet
Date: Wed, 22 Mar 2000 23:46:34 -0500
Content-Type: text/plain
Cc: linuxppc-dev@lists.linuxppc.org
References: <Pine.LNX.4.21.0003151544550.3091-100000@idd-01.imbc.gr>
In-Reply-To: <Pine.LNX.4.21.0003151544550.3091-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Message-Id: <00032223534800.00840@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Kostas,

I have set up my XF86Config file to allow mode switching (with valid mode info)
by hitting the Cntl-Alt-KeyPad- and Cntl-Alt-KeyPad+ keys.  Unfortunately,
although the mode seems to switch the screen is very messed up.  Luckily, if I
keep hitting the key combo I get back to a good resolution.  I tracked this
back to fbdevxxxSwitchMode which uses a framebuffer ioctl (FBIOPUT_VSCREENINFO)
which in turn is handled in linux/drivers/video/fbmem.c and eventually calls
aty128fb.c set_var routine.

Something here is broken but I can't put my finger on what yet.  Does using the
key combo to switch modes on the fly under R128 work for you on your x86
machine?

Also, I tried to test this under the XFree86 running fbdev as its driver.  Each
time I tried this I ended up with a complete hard lockup (kernel went boom).  I
tried connecting from other machines on my home network but I got no response
at all.

This used to work fine under xf 3.9.17.   Have you tried this recently?

Thanks,

Kevin


--
Kevin B. Hendricks
Associate Professor of Operations and Information Technology
Richard Ivey School of Business, University of Western Ontario
London, Ontario  N6A-3K7  CANADA
khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
