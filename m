Date: Fri, 10 Aug 2001 12:27:40 -0700
From: Matt Porter <mporter@mvista.com>
To: Karsten Jeppesen <kj-list@jeppesens.com>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 1 GigaByte memory problem on BriQ (memory limits?)
Message-ID: <20010810122740.A9688@cx258813-a.chnd1.az.home.com>
References: <B799A471.A093%kj-list@jeppesens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <B799A471.A093%kj-list@jeppesens.com>; from kj-list@jeppesens.com on Fri, Aug 10, 2001 at 02:47:14PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Aug 10, 2001 at 02:47:14PM -0700, Karsten Jeppesen wrote:
>
> Any comments on this here is greatly appreciated:
>
> I am having trouble with Linux accepting 1G memory.
> 512M works fine, but at 1G Linux gets all the way through the initialization
> until the partition check.
>
> At this point Linux (checking hda) reports:
> Unable to handle kernel NULL pointer at virtual address 000)
>
> And then the registerdump.
>
> Before I send all the other debug output I would like to know if anybody
> knows of any memory limits in Linux?

2.2 768MB max standard.  I had trouble with >512MB though.  With
some board specific rearranging of I/O you can get ~968MB on some
platforms using the stock KERNELBASE.  Drop KERNELBASE to something
lower than 0xc0000000 and you can get 1GB or more.  This approach
sacrifices some user virtual space but for most apps I work
with 3GB user VM is a waste.

2.4 has highmem support so max lowmem is 512MB, highmem can go
well below that.  Depending on your application the highmem
approach may or may not be useful.  Some applications of Linux
(especially high-end embedded apps) are better suited to the
lower KERNELBASE approach since it allows access to a lot more
permanently mapped memory.  Imagine a system with a custom driver
that uses _huge_ kernel buffers or a legacy OS running as a
client of Linux in kernel space.

> I don't see any compile switches (which is good).
> Currently running 2.2.19 kernel.org kernel added support for the BriQ. I am
> not done porting the 2.4.x kernel yet - sorry for that.

I suggest you do your port against linuxppc_2_4_devel.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
