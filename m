From: Paul Miller <pmiller9@users.sourceforge.net>
To: "Kevin A. Sapp" <Kevin.Sapp@catapult.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Peripherals  Memory Mapping
Date: Sun, 14 Dec 2003 09:28:22 -0600
References: <Pine.GHP.4.58.0311271703390.25225@stud3.tuwien.ac.at> <1070266735.328.5.camel@linpc003.aimsys.nl> <3FCB3969.9010707@catapult.com>
In-Reply-To: <3FCB3969.9010707@catapult.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200312140928.23106.pmiller9@users.sourceforge.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Monday 01 December 2003 6:51 am, Kevin A. Sapp wrote:
> Hello,
>
> Maybe this is a simple question, but I have searched the code
> and played around with no luck.  This is for an 8260 FADS
> board, later to be used on custom H/W.
>
> How and where do I add peripherals memory to the memory
> map?   I have tried adding it in the ads_map_io function but
> when I try to access the 82xx internal memory space there to
> add the memory to the base and option registers it dies.
> io_block_mapping is called successfully for the internal
> space, but appears to be inaccessable at this time.
>
> Is there a function that adds memory ranges to both the Linux
> map and the processor map (Base and Option registers) ?

I recently jumped into the embedded linux world and I've been playing
around with a 405EP from Intrinsyc.  In order to get I/O access to
the peripheral bus, you need to ioremap_nocache() the peripheral
memory in a kernel module, then mmap() it in user space.  For the DCR
registers (e.g., the embedded memory controller (EBC) registers),
you'll need to modify these in kernel space by calling mtdcr() and
mfdcr().

I've been able to communicate with external hardware via peripheral I/
O.  I noticed that memory addresses should lie on a 16 or 32-bit
boundary, otherwise the write pulse occurs too late for single
writes.

Hope this helps,
-Paul

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
