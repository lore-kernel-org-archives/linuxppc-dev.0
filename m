Date: Wed, 1 Dec 1999 10:26:55 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
cc: Stephen Edie <sedie@terraplex.com>, linuxppc-dev@lists.linuxppc.org,
        yellowdog-devel@lists.yellowdoglinux.com
Subject: Re: Frame buffer / mmap() weirdness
In-Reply-To: <Pine.GSO.4.10.9912010822250.16291-100000@dandelion.sonytel.be>
Message-ID: <Pine.LNX.4.10.9912011018590.17990-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > According to fbset, it's at:  0x8a008900
> > Furthermore, it makes most sense that mmap() should take care of page
> > alignment issues for me so that the address returned by mmap() always
> > points to the data at [lseek(h, 0, SEEK_SET)].  This is not technically
> > difficult to implement, right?
> 
> I think it will make munmap() more difficult to implement. Furthermore I see no
> provisions for this in the current mmap() code. And it will break backwards
> compatibility.

And returning a different address than the one the kernel actually used
for the mapping isn't tecnically correct either. 

The problem (if I understood your problem right) did occur for m68k Mac
framebuffers earlier, and we tried a few things (passing back the
address+offset, passing the offset into the first page in fb_info, ...) 
and finally agreed on the current implementation. The corresponding code
should be in the fbdev X server since sometime last year (I hope; Geert
should have gotten the patch or made his own version). 

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
