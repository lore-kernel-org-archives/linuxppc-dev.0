Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <v04011702b2914dc3594d@[209.86.156.28]>
Date: Mon, 7 Dec 1998 01:52:04 -0800
To: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org,
        paulus@cs.anu.edu.au, daveray@wellsfargo.com
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Partial fix for 2400 16-bit video problem
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The Problem: In recent kernels, the chipsfb driver for the C&T 65550
chipset has been broken for 16-bit modes.

The Solution: I did some poking around, and discovered some lines related
to turning palettes on and off missing from the 16/8-bit mode switch code
in chipsfb.c.  These were present in 2.1.115 but disappeared somewhere
along the road to 2.1.130.

With the lines restored, the 2/3400 accelerated version of Xpmac works in
16-bit mode again.  I haven't been trying XF68FBDev, so I don't know if it
was ever broken, but I suspect it would be as this shouldn't be specific to
any one X server.

The console is still broken for 16-bit mode, and I have no idea why.
Fortunately, 16-bit color is not a necessity on the console.  For whatever
reason, the fb console driver does not seem to be capable of writing
anything to a chipsfb display; it doesn't even manage to clear the frame
buffer when the switch to 16-bit is made, so you get to see leftover
garbage from when it was 8-bit.

Here is the diff relative to the version of chipsfb.c in the latest vger
kernel that I synced with:

----------cut here-----------
360a361
> 			write_xr(0x82, 0x00);		// disable palettes
381a383
> 			write_xr(0x82, 0x08);		// Graphics gamma
>enable
----------cut here-----------

If your chipsfb.c is different from mine, here is the context:  The first
line should be inserted after the line containing "write_xr(0x81, 0x14)"
and the second line should be inserted after the line containing
"write_xr(0x81, 0x12)".

  Tim Seufert

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
