Message-ID: <38581FEA.9E970D7A@ctam.com.au>
Date: Thu, 16 Dec 1999 10:10:35 +1100
From: Brendan Simon <bsimon@ctam.com.au>
Reply-To: bsimon@ctam.com.au
MIME-Version: 1.0
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: linuxppc-embedded: memory map question.
References: <19991215055541.23843.qmail@web301.mail.yahoo.com> <385725A3.A1C110DF@ctam.com.au> <385774B8.3405494B@iname.com> <3857EAF8.491F842@netx4.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:

> As I have explained before, the IMMR and possibly a few other
> board control registers must have physical addresses above
> 0x80000000.  This is because the early kernel initialization
> will map these 1:1 virtual to physical.  They are needed before
> the kernel VM allocator has been initialized.  If they are
> below this address, they clash with the user virtual space,
> so depending upon the loading of programs and libraries, you
> left a big virtual hole into kernel managed hardware.

My IMMR is 0xFF000000.  I basically followed the BSE-IP stuff when I ported
linuxppc to our own board.  This is above 0x80000000 so this should be fine,
but I do have some peripherals (LEDs, etc) mapped to memory lower than
0x8000000 (eg 0x20000000).  Is this good or bad ?
Would it be better if I memory mapped everything above 0x80000000 (except
DRAM of course) ?

Brendan Simon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
