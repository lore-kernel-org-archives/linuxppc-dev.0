Date: Thu, 25 Jan 2001 13:08:24 +0200 (EET)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, Ani Joshi <ajoshi@shell.unixbox.com>,
        <debian-powerpc@lists.debian.org>, <linuxppc-dev@lists.linuxppc.org>,
        <linux-fbdev@vuser.vu.union.edu>
Subject: Re: [linux-fbdev] Matrox and XFree86 4.0.2 update
In-Reply-To: <Pine.LNX.4.05.10101251235590.18764-100000@callisto.of.borg>
Message-ID: <Pine.LNX.4.30.0101251245400.17598-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 25 Jan 2001, Geert Uytterhoeven wrote:

> On Thu, 25 Jan 2001, Kostas Gewrgiou wrote:
> > On Wed, 24 Jan 2001, Petr Vandrovec wrote:
> >
> > Nope it won't cause any problems, none of the XF[86][68]_FBDev servers where
> > accelerated for matrox, other libs (SDL etc) that have accel for matroxfb
> > don't work correctly for ppc either.
>
> XF68_FBDev is accelerated for matroxfb, at least on the PPC platform.

Ops i forgot about it, it will be easy to change it though, although
backwards compatibility will be a nightmare :(

> > Changing the endian to little is the *right* thing, big-endian mode doesn't
> > offer us anything beyond problems in matroxfb 8/16 bit accesses become a
> > nightmare there...
>
> 8/16 bit accesses? I assume you're talking about the frame buffer, not about
> the register accesses?

No i am talking about register accesses, for example
the mga driver in xfree86 uses
 #define MGAISBUSY() (INREG8(MGAREG_Status + 2) & 0x01)
SDL uses
 #define mga_wait(space)  {                                             \
        while ( mga_in8(MGAREG_FIFOSTATUS) < space );                   \
 }

Both will fail under big-endian mode in PPC, the addressing is changed
so you have to use something like *(addr + (3-addr%4) to get the right
byte (i hope i got it right, its still early here)

> Currently XF68_FBDev needs a big-endian frame buffer on big-endian machines.

And i don't expect it to change ;P

 Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
