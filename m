Date: Thu, 13 Jan 2000 07:48:53 -0800 (PST)
From: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
To: Stephane GEORGES <sg@dalim.de>
cc: iweiny@pacbell.net, linuxdev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: User level Macros for Endianess
In-Reply-To: <387D8686.EF88134E@dalim.de>
Message-ID: <Pine.LNX.3.96.1000113074712.27859A-100000@deepspace.mklinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 13 Jan 2000, Stephane GEORGES wrote:

> I use my own executable compiled by GNU before compiling anything else:
> 
> bigendian.c
> -----------
> 
> int main()
> {
>   unsigned short val = 0x0011;
>   unsigned char* str = (unsigned char*)&val;
>   if ( str[0] == 0x00 )
>     return 1;
>   else
>     return 0;
> }
> 
> in my GNUmakefile
> -----------------
> 
> - one rule to compile bigendian.c if exe not compiled
> - one rule testing the return value of exe and setting
> 
>     MEMORY_IS_LITTLE_ENDIAN or MEMORY_IS_BIG_ENDIAN
> 
> That way I do not need to look for the right MACRO on the right SYSTEM.
> 
> I compile my code on IRIX (SGI), Solaris (SUN), intel Linux and LinuxPPC.

One worry here is that there are a few obscure (and generally, pretty
out-of-date) architectures that are neither big nor little.  Since this
only checks the first byte against the big value, it will return little
endian on a few oddball machines.  Other than that, though, yes, that
should work.


David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
