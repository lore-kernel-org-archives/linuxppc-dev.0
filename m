Message-ID: <37D929E4.205A04B8@chpc.utah.edu>
Date: Fri, 10 Sep 1999 09:55:16 -0600
From: Lou Langholtz <ldl@chpc.utah.edu>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: controlfb.c bug in VRAM bank2 check if bank1
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've posted before about this problem but to a different audience. As
I'm hoping to get this resolved (fixed) though in the main source tree
but don't have the chance to test this entirely myself I'm resending
here hoping someone else can test things out...

After getting an extra 2MB VRAM for my PowerMac7500 and seeing that only
2MB were still being recognized (despite having just added the 2MB to
total to 4MB VRAM), I dug into the controlfb.c code from 2.2.11 and
2.2.12 and made the following changes to get all 4MB VRAM recognized:

diff controlfb.c.orig controlfb.c
714,719c714,719
<  out_8(&p->frame_buffer[0x600000], 0xa5);
<  out_8(&p->frame_buffer[0x600001], 0x38);
<  asm volatile("eieio; dcbi 0,%0" : : "r" (&p->frame_buffer[0x600000])
: "memory" );
<  bank2 = (in_8(&p->frame_buffer[0x600000]) == 0xa5)
<   && (in_8(&p->frame_buffer[0x600001]) == 0x38);
<
---
>  out_8(&p->frame_buffer[0x200000], 0xa5);
>  out_8(&p->frame_buffer[0x200001], 0x38);
>  asm volatile("eieio; dcbi 0,%0" : : "r" (&p->frame_buffer[0x200000])
: "memory" );
>  bank2 = (in_8(&p->frame_buffer[0x200000]) == 0xa5)
>       && (in_8(&p->frame_buffer[0x200001]) == 0x38);
>
720a721
>  printk(KERN_INFO "Total VRAM = %dMB\n", (int) (p->total_vram / 1024 /
1024));
724,725c725,726
<   p->frame_buffer += 0x600000;
<   p->frame_buffer_phys += 0x600000;
---
>   p->frame_buffer += 0x200000;
>   p->frame_buffer_phys += 0x200000;

What I've heard though is that bank2 is indeed found at 0x600000 at
least when bank1 is not there. That seems pretty strange to me but this
info was from a reputable source. If I had the time I'd just add some
code to check in 1MB increments to confirm this and try rebooting with
various VRAM cards in and figure out exactly where things are
recognized. Unfortunately I don't have the time and as the above changes
makes 4MB VRAM work now that's good enough for me. But it'd be a shame
if this didn't get fixed once and for all for everyone with the control
graphics card found on PowerMac 7500's (and perhaps some others too).

So hopefully someone else on this list has a spare 7500 to check this
out on and get the fix into the main tree.

Cheers ;-)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
