From: "Taylor Holliday" <wtholliday@ucdavis.edu>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        "linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
Subject: RE: state of SMP on daystar quad-604 board
Date: Sun, 14 Jan 2001 02:55:44 -0800
Message-ID: <BHEOKMKGNHLELMKKJJIGOEBPCAAA.wtholliday@ucdavis.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <19341208021106.28653@smtp.wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello again

	That patch improved the situ - I now see 4 penguins - unfortunately the
machine stalls right where INIT should load (???) - no kernel panic - the
cursor just sits there blinking. I played around with smp_software_tb_sync
(commenting it out, etc.) as suggested, it didn't seem to help. So how do I
start remote-debugging this beast? Is there ANY documentation for these quad
boards? Let me know if there's any way I can help.

thanks
- Taylor


-----Original Message-----
From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]
Sent: Saturday, January 13, 2001 12:39 AM
To: Taylor Holliday; linuxppc-dev
Subject: Re: state of SMP on daystar quad-604 board

There are 2 different things:

 - The old Apple/Daystar 2 CPUs cards. Those should work
 - The old but slightly newer Daystar 2 and 4 CPUs card (using a different
   mecanism from the previous ones). For those I added support, but the
   current _2_4 code is slightly bogus.

First, apply this patch:

.....

Also, if you have >2 CPUs, you may have to comment out the software TB
sync code, I've been told it didn't work with more than 2 CPUs.

We are working on a fix.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
