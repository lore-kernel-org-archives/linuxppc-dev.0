Date: Wed, 16 Apr 2003 14:12:45 -0700
From: Matt Porter <porter@cox.net>
To: Vladimir Gurevich <vag@paulidav.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Are big pages really been used?
Message-ID: <20030416141245.A15466@home.com>
References: <3E9D9A19.3010106@paulidav.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3E9D9A19.3010106@paulidav.org>; from vag@paulidav.org on Wed, Apr 16, 2003 at 10:59:53AM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Apr 16, 2003 at 10:59:53AM -0700, Vladimir Gurevich wrote:
>
> Hello,
>
> Some time ago, during the discussion about module efficiency,
> Dan Malek wrote the following:
>
> > The other thing people probably don't realize is the added overhead
> > of using modules.  They are placed in dynamically allocated memory,
> > wasting memory space and causing addtional MMU overhead on processors
> > where you really want to minimize such things.  When compiled into the
> > kernel and covered with a large page mapping, you are likely to see
> > lower interrupt latencies and less jitter, along with a more compact
> > memory footprint.
>
> I was looking at TLB entries on my 405GP-based system running 2.4.17-based
> kernel by executing "tlb 0 63" command in BDI-2000 and could not see any
> big page mappings. All page entries were 4K in size (and I could see many
> that were clearly covering portions of kernel code)
>
> My questions are:
>    a) Does the abovementioned quote apply to 4xx CPUs

Sort of.

>    b) If yes, where can I get the patches
>    c) If no, how difficult might it be to do the modification
>    d) Are there provisions in Linux VM to use variable-sized pages to cover
>       big contiguous memory regions in order to reduce TLB reloading.

40x offers a simple pinning option.  440 pins by default since it is
a Book E processor and must always keep exception vectors in the tlb.

The linuxppc-2.5 tree has large page support on 40x kernel lowmem
pages.

These are these only things implemented (at least shown publicly) on
PPC.

The VM supports large dynamic pages where they are used as a default
page size (ia64 has selectable default page sizes).  There is also
support for explicit user requests of large pages via the hugetlb
support, see Docmentation/vm/hugetlbpage.txt in 2.5.  At one point,
I saw a patch for large page support in for modules/vmalloc space
for ia32.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
