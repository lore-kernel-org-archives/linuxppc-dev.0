Message-ID: <387D8686.EF88134E@dalim.de>
Date: Thu, 13 Jan 2000 09:02:14 +0100
From: Stephane GEORGES <sg@dalim.de>
MIME-Version: 1.0
To: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
CC: iweiny@pacbell.net, linuxdev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: User level Macros for Endianess
References: <E869F6EDBD5F4E50C1256864006C9E10.006C9E4AC1256864@kehl.dalim.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I use my own executable compiled by GNU before compiling anything else:

bigendian.c
-----------

int main()
{
  unsigned short val = 0x0011;
  unsigned char* str = (unsigned char*)&val;
  if ( str[0] == 0x00 )
    return 1;
  else
    return 0;
}

in my GNUmakefile
-----------------

- one rule to compile bigendian.c if exe not compiled
- one rule testing the return value of exe and setting

    MEMORY_IS_LITTLE_ENDIAN or MEMORY_IS_BIG_ENDIAN

That way I do not need to look for the right MACRO on the right SYSTEM.

I compile my code on IRIX (SGI), Solaris (SUN), intel Linux and LinuxPPC.

--

/====================================================================/|
| Stephane GEORGES                     |                             ||
| DALiM SOFTWARE GmbH      R&D         |    Tel: +49 7851 9196 40    ||
| Strassburger Str.6                   |    Fax: +49 7851 7357 6     ||
| D-77696                              |                             ||
| Kehl-Sundheim (Germany)              |    E-mail: sg@dalim.de      ||
|____________________________________________________________________|/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
