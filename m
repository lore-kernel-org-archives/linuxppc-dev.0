Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: hemphill@drea.dnd.ca
Subject: Re: Help from Gurus on modes and timing and frame buffers needed!
Date: Fri, 9 Nov 2001 13:47:34 -0500
References: <v04003a0eb8110c4666ff@[24.70.162.28]> <20011109132150.FHFJ13234.tomts8-srv.bellnexxia.net@there> <3BEBE4FA.10509@drea.dnd.ca>
In-Reply-To: <3BEBE4FA.10509@drea.dnd.ca>
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Message-Id: <20011109184538.FWGO21717.tomts13-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi

> 	When you do get all this figured out, could you please post a summary.
> I think there's quite a few people who would love to be able to
> interpret this stuff :-)

I think I am now there.  It seems that the interpret_edid.c code that
comes with XFree86 4.1.0 in the xc/programs/Xserver/hw/xfree86/ddc/ is
incorrectly interpreting the sync flags.  They are shifting right one bit
too many (why "and" a byte value with 0x18 and then >> 4 ... it makes no
sense - they should have just done >> 3).

The EDID SYNC_T of 3 means SYNC_SEPARATE.  Once that is the case, you can
use other bits in the word (part of MISC which is also over shifted right)
to determine the flags of +/- HSYNC, VSYNC.

So with fixes to that code, EDID data can easily tell you all you need to
know to make your own mode lines.

I will try and summarize it all up in a readme of some sort and send it to
the mailing list.

Thanks for eveyone's help.

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
