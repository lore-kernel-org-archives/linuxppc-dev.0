Date: Fri, 16 Jul 1999 10:57:48 +1000
Message-Id: <199907160057.KAA23996@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: jpgarcia@execpc.com
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <Pine.SOL.4.10.9907151334160.21552-100000@earth.execpc.com>
	(message from Joseph Palani Garcia on Thu, 15 Jul 1999 13:44:24 -0500
	(CDT))
Subject: Re: Broken sound?
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.SOL.4.10.9907151334160.21552-100000@earth.execpc.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Joseph Palani Garcia <jpgarcia@execpc.com> wrote:

> this is a known endian problem.  ppc archetecure is big endian, while most
> other linux-running platforms are little endian.  recent setups, like R5
> implement sound as little endian.  not everyone has caught up with this

Not so.  The kernel driver can handle either big-endian or
little-endian 16-bit data.  The default is 8-bit data, though, for
which endianness doesn't matter.

The AFMT_S16_NE symbol, which says what the native endianness is, is
defined to be the same as AFMT_S16_BE on big-endian platforms like the
PPC.  There is a potential problem though because the
linux/soundcard.h include file checks for the existence of the symbol
`PPC' (among others) to test whether the platform is big-endian.  If
you compile your program with the -ansi switch to gcc, it defines
__PPC__ and __PPC but not PPC so then you get AFMT_S16_NE defined to
be equal to AFMT_S16_LE. :-(

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
