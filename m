Message-Id: <200110111541.f9BFfFf02772@ashley.ivey.uwo.ca>
Date: Thu, 11 Oct 2001 11:37:43 -0400
From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Content-Type: text/plain;
	format=flowed;
	charset=us-ascii
Subject: Re: bug in XFree86 4.1.0 with Rage 128 driver?
Cc: Olaf Hering <olh@suse.de>, linuxppc-dev@lists.linuxppc.org,
	Herbert Duerr <duerr@sun.com>
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michdaen@iiic.ethz.ch>
In-Reply-To: <1002814351.12609.408.camel@pismo>
Mime-Version: 1.0 (Apple Message framework v388)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Michel,

> So what's in CVS only works for fbdev, Kevin's patch is needed for r128?

I went and used cvsweb on Xfree86.org to see what keithp actually
committed.

The bug I found was actually *already* fixed by XF4 guys  soon after
XF410 was released (they simply removed the || !xFormat in the "if")
(given the dates on the Xrender.c changes).

So all keithp had to add was the code to check to make sure xData
malloced okay (i.e put back in || !xData in the "if").

So what is in cvs head right now for this code snippet turns out to be
exactly what my  patch will do for XF 4.1.0.

I assume the r128 versus framebuffer issue was only due to random memory
being tested so the results were/are random.

The patch is needed for all 4.1.0 respins since the bug only exists in
4.1.0 but anything based on cvs recently should be okay as is.

Hope this helps.

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
