Message-ID: <3802DE1E.37E49762@chpc.utah.edu>
Date: Tue, 12 Oct 1999 01:07:10 -0600
From: Lou Langholtz <ldl@chpc.utah.edu>
MIME-Version: 1.0
To: mlan@cpu.lu
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: controlfb.c bug in VRAM bank2 check if bank1
References: <199909131813.UAA00324@piglet.cpu.lu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners wrote:

> Hmm... official 2.2.12 does detect my 4 MB... and this is a 7600, so the same
> motherboard as the 7500...
> Michel

Something is wrong then. Using AC's 2.2.13pre15 on my 7500 the driver just doesn't
recognize 4MB of VRAM unless I hack the bank2 check. So either you're not really
getting all 4MB VRAM detected or the 7600 uses a different hardware configuration
than my 7500/100. What does "fbset -i" tell you for size of the frame buffer
device? That the 8500 operates as Andrew Fyfe <bandr@best.com> claimed according
to the comments in one of the patches that someone sent out make sense. The
relevant part of that patch reads:

+       /* According to Andrew Fyfe <bandr@best.com>, the VRAM behaves like so: */

+       /* afyfe: observations from an 8500:
+        * - with 2M vram in bank 1, it appears at offsets 0, 2M and 4M
+        * - with 2M vram in bank 2, it appears only at offset 6M
+        * - with 4M vram, it appears only as a 4M block at offset 0.
+        */

What you're seeing with your 7600 then just doesn't make sense unless it's video
hardware is somehow different than the 7500/100 that I have. The 7500/100 that
I have has only four slots where each slot holds a 1MB VRAM memory module. Is that
the same on the 7600? If the 7600 really has the control video card and yours
really has 4MB VRAM then according to sources the memory must be detectable at
both offset 0, and 6M where the second VRAM bank can actually also handle itself
in a contiguous 4MB block from offset 0. That seems very odd indeed.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
