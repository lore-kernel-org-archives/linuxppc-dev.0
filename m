Date: Wed, 1 Dec 1999 12:12:09 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
cc: Momchil Velikov <velco@fadata.bg>, Stephen Edie <sedie@terraplex.com>,
        linuxppc-dev@lists.linuxppc.org,
        yellowdog-devel@lists.yellowdoglinux.com
Subject: Re: Frame buffer / mmap() weirdness
In-Reply-To: <Pine.GSO.4.10.9912011012361.16291-100000@dandelion.sonytel.be>
Message-ID: <Pine.LNX.4.10.9912011030340.17990-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > > I think it will make munmap() more difficult to implement. Furthermore I see no
> > > provisions for this in the current mmap() code. And it will break backwards
> > > compatibility.
> > 
> > Don't know for mmap(), but it seems the only change to munmap() is
> > to clear the appropriate number of low-order bits in its first argument
> > ( addr & 0xfffff000 for 32-bit machines with 4k page size).
> 
> You are right. Since I guess the other mmap()s in the kernel are POSIX
> compliant, I feel silly now.

It will still break backwards compatibility (i.e. old X servers). We can
catch the case of old kernels used with new X servers but not the other
way. 

Either way - I recall getting errors from the generic mmap code when
passing not page aligned addresses back from fb_mmap. Has something
changed in the mmap code to remove this restriction? 

	Michael

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
