From: "Dale Farnsworth" <Dale.Farnsworth@mvista.com>
Date: Thu, 21 Nov 2002 16:18:55 -0700
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: __copy_tofrom_user fails on unaligned read faults
Message-ID: <20021121231855.GF6090@cuzco.az.mvista.com>
References: <20021121215050.GD6090@cuzco.az.mvista.com> <3DDD5924.3030506@embeddededge.com> <20021121221241.GE6090@cuzco.az.mvista.com> <3DDD5DE9.4030404@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3DDD5DE9.4030404@embeddededge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Nov 21, 2002 at 05:27:53PM -0500, Dan Malek wrote:
> Dale Farnsworth wrote:
>
> >The 16-byte copy is aligned on the destination address.
> >It is unaligned with respect to the source address.
>
> I see, so do the semantics of a copy_to/from allow this behavior?
> If you still return an error, how does the caller know how many
> bytes were transferred?  I always thought if you handled a SEG/BUS
> fault exception the contents of the buffer were undefined.
>
> 	-- Dan

copy_from_user is supposed to transfer as much data as is
valid and then to return the number of bytes not tranferred.
That's how it works on x86.  On ppc it can be as much as 15
bytes short.

I initially saw the problem with the mount system call.  Here's
a partial strace:

# strace mount -t jffs2 /dev/mtdblock0 /xx
execve("/bin/mount", ["mount", "-t", "jffs2", "/dev/mtdblock0", "/xx"], [/* 7 vars */]) = 0
<deleted lots of stuff>
stat("/dev/mtdblock0", {st_mode=S_IFBLK|0644, st_rdev=makedev(31, 0), ...}) = 0
brk(0x1005e000)                         = 0x1005e000
brk(0x1005f000)                         = 0x1005f000
mount("/dev/mtdblock0", "/xx", "jffs2", 0xc0ed0000, 0x1005eff8) = -1 EFAULT (Bad address)

Note that the fifth argument to mount is an address 8 bytes from the end
of user data space.  There is a null byte at that address, since no mount
options are being passed.

In the kernel, sys_mount() allocates a page for the options and
does copy_from_user(new_page, 0x1005eff8, PAGE_SIZE).  copy_from_user
should copy 8 bytes and return (PAGE_SIZE-8).  Instead, on ppc it reads
8 bytes, faults, writes no bytes, and returns PAGE_SIZE, which causes the
EFAULT to be erroneously reported.

-Dale

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
