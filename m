Subject: Re: io.h and I/O port access from user space
From: Hollis Blanchard <hollis@austin.ibm.com>
To: jeffrey.d.kowing1@jsc.nasa.gov
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <15456.16854.183292.343027@igor.jsc.nasa.gov>
References: <15456.16854.183292.343027@igor.jsc.nasa.gov>
Content-Type: text/plain
Date: 05 Feb 2002 15:48:10 -0600
Message-Id: <1012945690.1265.11.camel@granite>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2002-02-05 at 14:34, Jeffrey D. Kowing wrote:
>
> Is there suppose to be a <sys/io.h> for powerpc platforms ?

I guess not. I'm not a glibc person though...

> What include file should I use to get inb/outb defined for a user
> space program.  (This is a linuxppc 2.4.x kernel I'm working with.)

I'm not sure there are any.

> I guess it is still the case for the linuxppc-2.4.x series that I need
> to mmap /dev/mem first as per Geert's advice in
> http://lists.linuxppc.org/linuxppc-dev/200003/msg00076.html advice?

Yes, you certainly need to mmap /dev/mem.

> Has anyone in powerpc land used the isapnptools ?

I guess the obvious question is do you have ISA slots in the system
you're trying to build for? And you don't want to use the in-kernel
stuff? Do you really *need* isapnptools? :)

If you have ISA, it's probably a PReP? I've done user space IO simply by
mmap'ing (offset = 0x80000000), then just doing accesses normally:
	(char *)ioregion = mmap(...)
	ioregion[0x3fc] = 0x1;
etc.

-Hollis


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
