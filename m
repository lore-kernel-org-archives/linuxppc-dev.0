Date: Sat, 26 Jan 2002 23:30:49 +0100 (CET)
From: Gabriel Paubert <paubert@iram.es>
To: Troy Benjegerdes <hozer@drgw.net>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Broken asm/div64.h macro
In-Reply-To: <20020126103720.Z14725@altus.drgw.net>
Message-ID: <Pine.LNX.4.33.0201262317380.24672-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 26 Jan 2002, Troy Benjegerdes wrote:

>
> Our div64.h macro is quite broken, and causes printk to not be able to do
> a long long format.
>
> Is there a 'fast' generic C algorithm we can replace it with, instead of
> mucking with ASM?

If depends on what you want from do_div. If you guarantee that in
do_div(n,base) base will be constant it's fairly easy (provided GCC does
proper constant propagation). I also have the expanded code for 10
explicitly somewhere in prepboot, I just wrote it for fun for my own
printb(==printk for bootloader). I also wrote a generic 64 by 32 divide
for the x86 ROM BIOS emulator (stupid looping, slow but ok for this, I
short-circuit it for 32/32 divides which are the most common).

On a somewhat relared topic, there is also an inverse estimator to use
mulhwu somewhere in the time code (mulhwu_scale_factor IIRC what I
wrote:-)), but it's deliberately compact and slow.

Which flavour would you prefer ? (The one in do_div is only for 64 bit
targets, someone clearly goofed on that one).

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
