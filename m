Date: Fri, 10 Aug 2001 16:13:35 -0500
From: Hollis Blanchard <hollis@austin.ibm.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: VGA console endian bug
Message-ID: <20010810161335.A29271@austin.ibm.com>
References: <20010809115233.D23147@austin.ibm.com> <Pine.LNX.4.05.10108101040060.2083-100000@callisto.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.05.10108101040060.2083-100000@callisto.of.borg>; from geert@linux-m68k.org on Fri, Aug 10, 2001 at 10:41:39AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Aug 10, 2001 at 10:41:39AM +0200, Geert Uytterhoeven wrote:
>
> On Thu, 9 Aug 2001, Hollis Blanchard wrote:
> > These two patches came from Daniel Berlin on July 9. They completely resolve
> > the VGA console backwards-endian problem for me on PPC. If they have Geert's
> > seal of approval ;) can they be committed?
> >
> > -Hollis
> >
> > --- linuxppc_2_4_devel/include/asm-ppc/vga.h.old	Thu Aug  9 11:49:23 2001
> > +++ linuxppc_2_4_devel/include/asm-ppc/vga.h	Thu Aug  9 11:49:42 2001
> > @@ -37,6 +37,9 @@
> >
> >  #define VT_BUF_HAVE_MEMCPYW
> >  #define scr_memcpyw	memcpy
> > +#define VT_BUF_HAVE_MEMCPYF
> > +#define scr_memcpyw_to memcpy
> > +#define scr_memcpyw_from memcpy
> >
> >  #endif /* !CONFIG_VGA_CONSOLE && !CONFIG_MDA_CONSOLE */
>
> The first I cannot approve: if scr_{write,read}w() swap bytes, how can it work
> if scr_memcpyw_{to,from}() don't swap bytes?

I have no idea. Perhaps those functions weren't used, and that's why it
appeared to work. I have not tried with only the second patch; perhaps that
will be enough...

> And where's the 3rd patch? I once posted a patch to fix a similar bug in
> drivers/char/console.c.

I can't find it in the linuxppc-dev archives. :(

-Hollis

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
