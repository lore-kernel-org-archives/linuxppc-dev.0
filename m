Date: Tue, 30 Nov 1999 15:43:46 -0700 (MST)
From: Stephen Edie <sedie@terraplex.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: linuxppc-dev@lists.linuxppc.org, yellowdog-devel@lists.yellowdoglinux.com
Subject: Re: Frame buffer / mmap() weirdness
In-Reply-To: <Pine.LNX.4.05.9911302216440.389-100000@callisto.of.borg>
Message-ID: <Pine.LNX.4.10.9911301528200.7062-100000@newhope.terraplex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert,

According to fbset, it's at:  0x8a008900

I don't want to map /dev/mem if that's what you are talking about.  

So I am assuming that mmap() will start mapping from the first page that
he frame buffer occupies...  So I need to add the following to what
mmap() returns in order to get a valid pointer:

PAGE_ROUND_UP(phys_address) - phys_address

(PAGE_ROUND_UP is assumed to return the beginning of the page that starts
at or after the specified address)

This doesn't entirely make sense.  Just now I tested the program and it
doesn't require re-alignment as I mention above.

(I'm thinking now that it only occurs in 32 bit color mode??)

Furthermore, it makes most sense that mmap() should take care of page
alignment issues for me so that the address returned by mmap() always
points to the data at [lseek(h, 0, SEEK_SET)].  This is not technically
difficult to implement, right?

Stephen

Terra Soft Solutions, Inc.
   Yellow Dog Linux
   "The Ultimate Companion for a Dedicated Server"
   http://www.yellowdoglinux.com/


On Tue, 30 Nov 1999, Geert Uytterhoeven wrote:

> Perhaps the frame buffer memory is not aligned on a page boundary? What does
> `fbset --info' say about the address?
> 
> If it's not aligned to a page boundary, the application has to mmap()
> (address & 0xfffff000) and add (address & 0x00000fff) to the start address of
> the returned region. Make sure to increase the size you pass to mmap(), so the
> whole frame buffer memory is covered and size is a multiple of the page size.
> 
> Gr{oetje,eeting}s,
> --
> Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
> 
> 
> 


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
