To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: BAT mapping exported to user-space
References: <10A74DE9-DFF7-11D8-96F8-003065F9B7DC@embeddededge.com>
From: "Linh Dang" <linh@linhdang.home>
Date: Tue, 27 Jul 2004 15:32:47 -0400
In-Reply-To: <10A74DE9-DFF7-11D8-96F8-003065F9B7DC@embeddededge.com> (Dan
 Malek's message of "Tue, 27 Jul 2004 14:02:03 -0400")
Message-ID: <wn58yd5p7og.fsf@linhd-2.ca.nortel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek <dan@embeddededge.com> wrote:

>
> On Jul 27, 2004, at 1:34 PM, Dang, Linh [CAR:2X23:EXCH] wrote:
>
>>> cat /proc/ppc_htab
>> PTE Hash Table Information
>
> You misunderstand.  This is the PPC Hash table, not Linux PTEs.
> There are lots and lots and lots of Linux PTEs are are eventually
> loaded into the PPC hash table for the processor to fetch.

Thanx for pointing that out. I have to dig further. I guess it would
come down to how much pressure using pages for mapping our asics
(instead of BATs) would have on the TLBs.

Just to clarify things, I'm trying to sell Linux to management (we're
a VxWorks shop) and trying to tell them that Linux's
RT-performance/efficiency is adequate and Linux would bring in a lot
more robustness/stability.


> What processor are you using?

7447 at 1 GHz (the bottle of the system is the I/O to the
memory-mapped ASICs)

>
>> I though the kernel (2.6) only use pages for vmalloc.
>
> There is lots of kernel space allocated through vmalloc(), plus
> other specialized spaces depending upon the processor core
> that are allocated through page tables.

Hmm, i though most of kernel's objects (socket's buffer included) are
allocated thru the slab-allocator. slab, AFAIK, doesn't use neither
vmalloc nor pages.


--
Linh Dang

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
