From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
Subject: Re: patch to get latest XFree 4.0 snapshot (xf3918) to work on ppc with r128
Date: Fri, 3 Mar 2000 15:51:20 -0500
Content-Type: text/plain
Cc: linuxppc-dev@lists.linuxppc.org
References: <Pine.LNX.4.21.0002280213230.19278-100000@idd-01.imbc.gr>
In-Reply-To: <Pine.LNX.4.21.0002280213230.19278-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Message-Id: <00030316025300.01310@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Kostas,

On Sun, 27 Feb 2000, Kostas Gewrgiou wrote:
> On Sat, 26 Feb 2000, Kevin B. Hendricks wrote:
>
>  Thats the responces i got back from the xfree list about the usb mouse
> problems in 3.9.18, the bit about drivers/usb/mouse.c not setting the
> the bit 3 correctly in the first data byte seems intresting, maybe the
> problem is in our side ?
>
>   Kostas

Okay, I have done some digging and sure enough Paul's latest stable tree (rsync
today) uses usb mouse.c (backported from an earlier version of 2.3.X?) and it
does *NOT* properly set bit 3 correctly (i.e. 0x8 is never or'd in (assuming
that is correct!)). So my current mouse patch for xf 3.9.18 is needed for the
2.2.X kernel series.

Next I went and looked at Paul's 2.3.XX development tree (rsynced as I write
this) and the mousedev.c file does literally or in 0x8 to the first character.

So this looks like a ppc specific kernel bug in the stable tree in that it does
not properly meet the imps/2 mouse specifications.  Interestingly, until the
change from XFree 3.9.17 to XFree 3.9.18, the old way of checking the first
character for out of sync worked fine for us, it is only the new way (since
they added extra buttons) that has become a problem.

So the key is to get a patch into Paul's stable tree that simply "or's in" 0x8
into the first character (the one showing buttons pressed) so that it matches
what is being done in the 2.3.X series.

I will try to get a patch that does just that and send it to Paul.

Also, I will look at the Xpmac usb mouse code and the Mac-On-Linux mouse code
(which is what I based the Xpmac code) to make sure any kernel change does not
mess up Mac-On-Linux and Xpmac.

I still think the XFree 86 mouse code is a nightmare but the problem does seem
to lie in our stable kernel series.

Thanks for you help resolving this!!!!

Take care,

Kevin


--
Kevin B. Hendricks
Associate Professor of Operations and Information Technology
Richard Ivey School of Business, University of Western Ontario
London, Ontario  N6A-3K7  CANADA
khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
