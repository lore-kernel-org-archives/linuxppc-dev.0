Message-ID: <3A22B484.F4551876@mvista.com>
Date: Mon, 27 Nov 2000 14:22:44 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Konstantin Sabodash <konstantin.sabodash@fnc.fujitsu.com>
CC: linuxppc-embedded@lists.linuxppc.org, wg@world.std.com
Subject: Re: Memory map
References: <3A22B028.6182249F@fnc.fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Konstantin Sabodash wrote:

>  "paddr2 = mmap(0,size,PROT_READ|PROT_WRITE,MAP_SHARED,fd,0x50000000);"
>
> But  page size is 1K and their start addresses  appears in address
> space  with increment 0x1000.

No, the Linux page size is 4K.

> So if I put 0x50000400 address it give me segmentation fault. It works
> fine in region 0x50000000 ...  0x500003ff  next 0x50001000 ...
> 0x500103ff and so on.
> Question : how can we increase page size to eliminate these holes.

Fix your hardware.  I don't know what "size" is in your mmap() example,
but just because you map a large space doesn't mean you necessarily have
access to all of it.   If the underlying hardware doesn't respond to
the access, you will get a bus timeout error which is reported to your
program as a segmentation violation (or bus fault violation depending
upon how we map the error today).  It looks to me like your hardware
responds to the first 1K of a selected address space, and the memory
controller is programmed to wrap this on 4K boundaries.

What kind of system is this?  What kind of device is mapped to this
address?


	-- Dan

--

	I like MMUs because I don't have a real life.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
