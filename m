Date: Thu, 22 Jun 2000 15:00:02 -0400 (EDT)
From: "Mark S. Mathews" <mark@absoval.com>
To: Dan Malek <dan@netx4.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Can't mmap the top 1MB of /dev/mem?
In-Reply-To: <39525027.A7343F66@embeddededge.com>
Message-ID: <Pine.LNX.3.96.1000622144244.10709D-100000@tristar.cc.absoval.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sorry, I should have been more specific....aren't you all mind-readers?
;-)

The mmap is failing w/ errno=EINVAL.  Here's the call:

mem_fd = open("/dev/mem", ORDWR);

p = mmap( NULL, (16*1024*1024),
          (PROT_READ|PROT_WRITE), MAP_SHARED, mem_fd, 0xff000000UL);

15MB works just fine.  I just tried a test w/ offset 0xff800000 and size
of 8MB.  That failed too.  Here's a couple of other tests I just tried:

offset      len        result
-----------------------------------
0xfff00000, 1MB        failed
0xffe00000, 1MB        success

So it looks like it's specifically related to the top 1MB, not the size.

BTW: Dan, I think you may have run into this before.  The sample code you
once sent me only mmaps the lower 7MB of an 8MB flash setup.

This whole thing isn't really a critical issue for me.  More of a
curiosity.  I'm not using those sectors anyway.  ;-)

If it _were_ extremely  important I could always trace the mmap system
call.
_That's_ why Linux is so cool.

Thanks to everyone for the responses,
-Mark

On Thu, 22 Jun 2000, Dan Malek wrote:

> "Mark S. Mathews" wrote:
>
>
> > ...... One thing I've noticed is that it won't let me mmap the
> > top 1MB of the address space.
>
> That should work, I do this quite regularly.  What actually fails,
> the mmap() or your access to the mapped region?
>
> There is what I do:
>
> 	mem_addr = (u_char *)mmap(NULL, FLASH_MEM_SIZE,
> 			(PROT_READ | PROT_WRITE), MAP_SHARED,
> 			mem_fd, FLASH_MEM_ADDR);
>
> #define FLASH_MEM_SIZE and FLASH_MEM_ADDR accordingly.  I hope there
> isn't some weird arithmetic rounding problem when we hit the top.  I
> just usually tell this to map the upper 8M bytes.
>
> The MMU doesn't care, if the generic Linux VM subsystem creates the PTEs
> it just loads them.  I don't remember any code in the mem driver that
> would prevent this either.  None of this is unique to the 8xx.
>
>
> 	-- Dan
>


Mark S. Mathews

AbsoluteValue Systems      Web:    http://www.linux-wlan.com
P.O. Box 941149            e-mail: mark@linux-wlan.com
Maitland, FL 32794-1149    Phone:  407.644.8582
USA                        Fax:    407.539.1294


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
