Date: Thu, 13 Jan 2000 17:18:39 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
cc: Stephane GEORGES <sg@dalim.de>, iweiny@pacbell.net,
        linuxdev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: User level Macros for Endianess
In-Reply-To: <Pine.LNX.3.96.1000113074712.27859A-100000@deepspace.mklinux.org>
Message-ID: <Pine.HPX.4.10.10001131704560.20852-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Thu, 13 Jan 2000, David A. Gatwood wrote:

> > int main()
> > {
> >   unsigned short val = 0x0011;
> >   unsigned char* str = (unsigned char*)&val;
> >   if ( str[0] == 0x00 )
> >     return 1;
> >   else
> >     return 0;
> > }
> > 
> > in my GNUmakefile
> > -----------------
> > 
> > - one rule to compile bigendian.c if exe not compiled
> > - one rule testing the return value of exe and setting
> > 
> >     MEMORY_IS_LITTLE_ENDIAN or MEMORY_IS_BIG_ENDIAN
> > 
> > That way I do not need to look for the right MACRO on the right SYSTEM.
> > 
> > I compile my code on IRIX (SGI), Solaris (SUN), intel Linux and LinuxPPC.
> 
> One worry here is that there are a few obscure (and generally, pretty
> out-of-date) architectures that are neither big nor little.  Since this
> only checks the first byte against the big value, it will return little
> endian on a few oddball machines.  Other than that, though, yes, that
> should work.

Indeed, I don't think that there are so many PDP around here any more, but
what about cross compiling (for a PDP you would cross compile for sure) ?

The exe runs on the build machine, not the target. And many archs can run
right^Wbig- or wrong^Wlittle-endian: Alpha, ARM, IA64, MIPS, PPC, SH,
SPARC. (I thought HPPA could but gcc only knows the big endian version).

I don't know of any arch switchable between 3 or more different byte
orders, however (from gcc source the 1750 is as weird as the PDP, maybe
they are related).

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
