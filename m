Message-ID: <3A7023E6.516580F@relog.ch>
Date: Thu, 25 Jan 2001 14:02:30 +0100
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: michdaen@iiic.ethz.ch
MIME-Version: 1.0
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
        Petr Vandrovec <VANDROVE@vc.cvut.cz>,
        Ani Joshi <ajoshi@shell.unixbox.com>, debian-powerpc@lists.debian.org,
        linuxppc-dev@lists.linuxppc.org, linux-fbdev@vuser.vu.union.edu
Subject: Re: [linux-fbdev] Matrox and XFree86 4.0.2 update
References: <Pine.LNX.4.30.0101251245400.17598-100000@idd-01.imbc.gr>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kostas Gewrgiou wrote:
>
> On Thu, 25 Jan 2001, Geert Uytterhoeven wrote:
>
> > On Thu, 25 Jan 2001, Kostas Gewrgiou wrote:
>
> > > Changing the endian to little is the *right* thing, big-endian mode
> > > doesn't offer us anything beyond problems in matroxfb 8/16 bit accesses
> > > become a nightmare there...
> >
> > 8/16 bit accesses? I assume you're talking about the frame buffer, not
> > about the register accesses?
>
> No i am talking about register accesses, for example
> the mga driver in xfree86 uses
>  #define MGAISBUSY() (INREG8(MGAREG_Status + 2) & 0x01)
> SDL uses
>  #define mga_wait(space)  {                                             \
>         while ( mga_in8(MGAREG_FIFOSTATUS) < space );                   \
>  }
>
> Both will fail under big-endian mode in PPC, the addressing is changed
> so you have to use something like *(addr + (3-addr%4) to get the right
> byte (i hope i got it right, its still early here)

What about adapting the macros then?


Michel


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
