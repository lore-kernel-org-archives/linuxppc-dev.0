Date: Wed, 30 Dec 1998 02:02:30 -0700 (MST)
From: Jeff Rugen <jrugen@primenet.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: fbcon + X Server + Cirrus/Powerstack
In-Reply-To: <Pine.LNX.4.03.9812281946552.1425-100000@mercator.cs.kuleuven.ac.be>
Message-ID: <Pine.BSI.3.96.981230014039.29906A-100000@usr05.primenet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 28 Dec 1998, Geert Uytterhoeven wrote:

> Try
> 
>     fb_info->fbmem_phys = 0xC0000000;
> 
> instead, i.e. use the address you passed to ioremap()[*].
> 

Ok, I've gotten this to work, but it required me to add some modifications
to the PReP kernel so it is more like the APUS kernel.  However, I don't
know if this is the 'correct' way we should go about fixing this or not.

The ultimate effect of what I've done is to make virt_to_phys and
phys_to_virt work the on PReP the way they do on the APUS.

I had to make modifications to 2 files that I haven't been modifying:

include/asm-ppc/io.h -- virt_to_phys and phys_to_virt, I made the
conditional lines treat APUS and PReP the same ->

    #ifndef CONFIG_APUS

becomes

    #if !defined(CONFIG_APUS) && !defined(CONFIG_PREP)

I didn't do the bus_to_virt or virt_to_bus function however.

arch/ppc/kernel/prep_setup.c
I copied mm_ptov() from apus_setup.c (removing the Zorro stuff).
I sorta copied kernel_map() from the apus file also, but called ioremap() to
do all the work, merely saving a mapping of virtual to physical memory.

Finally, I modified clgenfb.c (some more) to call kernel_map instead of
ioremap.

What this gives me:

Calling kernel_map(0xC0000000, size) in clgenfb copiled in the kernel
returns 0xC8000000, which is fbmem.

fbmem_phys is set to 0xC000000 -> this is returned as smem_start of the
fb_fix_screeninfo so the X68_FB server works fine (well, considering I
haven't set up the config file well).

In the kernel for the fb console (fbgen.c), 
    phys_to_virt((unsigned long)fix.smem_start);
sets screen_base to 0xC8000000, which is where the screen memory was mapped.
phys_to_virt() is the function that calls mm_ptov().  If there was an easy
way to write an inverse of iopa(), that would be better, but from the looks
of things, the mapping in the page tables is one-way (virtual -> physical)
and an inverse of iopa would be more slow than worth the effort.

Should I post or send someone a patch?  Is there a better/easier way to do
this that I'm missing?

----------------------------------------------------------------------------
Jeff Rugen                      jrugen@primenet.com

...Had this been an actual emergency, we would have fled in terror, and you 
would not have been informed.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
