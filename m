Date: Tue, 17 Oct 2000 10:05:45 -0500 (CDT)
From: Tilmann Bitterberg <tibit-ibm@bitterberg.de>
To: Paul Mackerras <paulus@linuxcare.com.au>
cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: HIGHMEM now working
In-Reply-To: <14827.56089.260884.298273@argo.linuxcare.com.au>
Message-ID: <Pine.LNX.4.21.0010170938440.3939-100000@karl.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 17 Oct 2000, Paul Mackerras wrote:

> Where did you get the version you tried?  I recently got a kernel
> going with highmem on a 44p/170 but I haven't pushed all the changes
> into bk.  I had to make several changes to the python code as well as
> arch/ppc/mm/init.c and my changes are somewhat different to what is
> being done in the linuxppc_2_5 tree.  My changes are available in the
> rsync tree at ppc.samba.org::linux-pmac-devel but that is

I tried test10-pre2 with the bitkeeper patch yesterday. Now I
upgraded to test0-pre3 with the bitkeeper patch. Both kernels
are only working (without HIGHMEM) when I revert the setbat
setting back to its original behaviour (0xf8000000-0xffffffff).
I understand what you did, but its not working right now.

> > Why not just lower PKMAP_BASE to 0xf6000000, will this break
> > someone?
>
> Everyone, potentially. :-)  You're lucky it worked.
>
> The way the code is at the moment, we divide up the space between the
> end of RAM and the end of the address space (0xffffffff) like this:
>
>     end of RAM ... end of RAM + VMALLOC_OFFSET:	    not used
>     end of RAM + VMALLOC_OFFSET ... ioremap_bot:    vmalloc & ioremap
>     ioremap_bot ... ioremap_base:		    early ioremaps
>     ioremap_base ... 0xffffffff:		    ioremap virt = phys

I know, that I take space away from the VMMALLOC area. But is
this a Bad Thing(TM)?

So my map look like this:
     end of RAM + VMALLOC_OFFSET ... Highmem start (0xf6000000)
     Highmem end (0xf8000000) ... ioremap_bot
     ioremap_bot ... ioremap_base
     ioremap_base (0xf8000000) ... 0xfffffffff virt=phys with BAT

> In other words all of the address space from end of RAM +
> VMALLOC_OFFSET is potentially used by ioremap (which is a bit greedy
> of it really).

OK, now I see.

> I personally think that the code in ioremap which assigns virt
> = phys for phys >= ioremap_base should go away.  For now I
> have added an extra check in the highmem case so that it only
> uses virt = phys for ioremap_base <= phys <= PKMAP_BASE.  This
> shows up one or two missing ioremaps in the chrp code which I
> have fixed in my version.

I don't like the virt=phys mapping, but it seems some drivers
depend on that.

I'll try to rsync and see if I can merge the python changes into
my stuff.

Thanks
Tilmann


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
