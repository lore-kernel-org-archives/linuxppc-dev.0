To: a sun <asun@saul9.u.washington.edu>
Cc: linuxppc-dev@lists.linuxppc.org, Roy Wood <roy@centricsystems.ca>,
        "David A. Gatwood" <marsmail@globegate.utm.edu>,
        Dave Weis <djweis@plconline.com>, bh40@calva.net
Subject: Re: Resurrecting mkLinux
References: <199904070826.BAA23922@saul9.u.washington.edu>
From: Jesper Skov <jskov@cygnus.co.uk>
Date: 07 Apr 1999 15:15:42 +0100
In-Reply-To: a sun's message of "Wed, 7 Apr 1999 01:26:40 -0700 (PDT)"
Message-ID: <ooyak4ikj4.fsf@lassi.cygnus.co.uk>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> once a working boot loader is done, it actually shouldn't be too
>> difficult to get things working. the hairiest part will probably be
>> the tweaking that head.S needs. however, the apus code actually
>> fiddles with the exception table and copies its virttophys constant
>> into a specific memory location. i think we should be able to do
>> something similar with the nubus powermac code as well to deal with
>> memory holes if need be.

I decided to skip support for multiple memory segments on APUS since
memory other than the one on the main board is horrendously slow
(comparatively).  People use the Amiga Zorro device which allows other
memory segments to be used as a swap device.

>> beyond that, using the m68k drivers should pretty much work as the
>> apus stuff needs to do that anyway. from my look at the code, we
>> should be able to replace CONFIG_APUS with a CONFIG_M68KPPC.

Sounds good to me.

>> anyways, feel free to dive in if you have time. i've been using the
>> absence of a working boot loader as an excuse not to do much with
>> it. just create a mach_m68k directory in arch/ppc, stick the amiga
>> directory in there, create a mac subdirectory and maybe a common
>> directory, and merge away. the more files that end up being links
>> to a slightly modified m68k code base the better.

I am waiting for 2.3.x to be unleashed so I can start working
again. 

My top priority is to get away from having an Amiga directory under
arch/ppc (or arch/ppc/mach_m68k). I would prefer to move all mach
drivers into a new mach hierarchy (so there would be e.g. mach/amiga
in the root of the kernel sources just as we now have arch/m68k).

The main motivation is obviously to avoid maintaining two different
sets of sources that do the same thing. Most of the ppc/amiga sources
are just 

 #include "../../m68k/amiga/foobar.c"

which works OK, but is a bit daft. 

Also, the files that do not look like that are so because Jes (m68k
maintainer) didn't like '#ifdef __powerpc__' or CONFIG_APUS in
arch/m68k specific files... Which I agree with (kind of). With the
mach hierarchy, though, both arguments becomes moot and I'll fix up
the sources to my liking ;)

Jesper

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
