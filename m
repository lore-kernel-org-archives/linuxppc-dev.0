In-Reply-To: <19991122150653.A13066@hq.fsmlabs.com>
Date: Tue, 23 Nov 1999 11:44:59 +0100
To: Cort Dougan <cort@fsmlabs.com>, linuxppc-dev@lists.linuxppc.org,
        paulus@linuxcare.com
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: bootloader & head.S weirdness (patch)
Message-Id: <19991123114459.026069@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Nov 22, 1999, Cort Dougan <cort@fsmlabs.com> wrote:

>I applied the patch (with some changes necessary to get it into
>2.2.14pre7).  It breaks pmac netboot during the jump from
>__secondary_stat() to clear_bats(). 

You mean netbooting the kernel image directly from OF without going thru
a bootloader ? Or are you talking about the xcoff piggyback bootstrap ?

>There must be some I mappings we need
>to preserve in order to get to non-pc relative code.  It's worth noting
>that OF loads us and gives us mappings for 0xc000000 since that's where
>we're linked at. 

I never managed to get OF load the kernel image directly. How did you
acheive this result (OF setting up such a mapping ?). In this specific
case, it's always possible to ask OF about our physical address and use
it for the return address of mmu_off. It should be returned by prom_init
in r3. This would be cleaner anyway. I'll look into fixing that but I'd
like to know how you did this netboot stuff so I can reproduce it here.
(Could you send me your bootptab ?)

>BootX and Quik don't do that so that's probably why they
>work.  Netboot is really useful so I'd prefer to not break it (definitely
>not in 2.2).  Any ideas for workarounds?

Yes, as I wrote before, OF can tell us the real physical address and we
can return it from prom_init so that mmu_off does the right thing.

>Chrp and prep netboot works fine.  Boot via quik on chrp works, too.

Great.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
