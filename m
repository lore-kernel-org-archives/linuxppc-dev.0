Date: Wed, 7 Apr 1999 01:26:40 -0700 (PDT)
Message-Id: <199904070826.BAA23922@saul9.u.washington.edu>
From: a sun <asun@saul9.u.washington.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Resurrecting mkLinux
CC: Roy Wood <roy@centricsystems.ca>,
        "David A. Gatwood" <marsmail@globegate.utm.edu>,
        Dave Weis <djweis@plconline.com>, bh40@calva.net
In-Reply-To: <Pine.LNX.3.95.990406200339.14652L-100000@catbert.desm.plconline.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



   We got around a lot of this in the linux-ma68k port. I think these
   series of powermacs are pretty similar to the top-of-the-line
   68k's. I've put more comments below.

benh and i have been talking about this off and on. both of our
schedules have been pretty busy though. anyways, here's the scoop on
what's been happening:
  1) bootx needs to be modified to boot on nubus powermacs and pass in
     chunks of memory (ala the m68k booter) either because memory is
     discontiguous or video memory is sitting at 1MB. 

  2) the APUS code needs modifications to allow use by the
     powermac. in case you don't already know, the APUS platform is
     basically an m68k platform with a PPC card in it. sound familiar?
     as a result, things just need to be generalized a bit for
     powermacs. for example, i already have some of the interrupt
     glue. 

     so, most of the work essentially ends up being changes to the
     m68k code base to add in "newer" models. in addition, the mm code
     needs to be a little less restrictive. it already handles memory
     chunks, but the apus code doesn't use it that way.

once a working boot loader is done, it actually shouldn't be too
difficult to get things working. the hairiest part will probably be
the tweaking that head.S needs. however, the apus code actually
fiddles with the exception table and copies its virttophys constant
into a specific memory location. i think we should be able to do
something similar with the nubus powermac code as well to deal with
memory holes if need be.

beyond that, using the m68k drivers should pretty much work as the
apus stuff needs to do that anyway. from my look at the code, we
should be able to replace CONFIG_APUS with a CONFIG_M68KPPC.

anyways, feel free to dive in if you have time. i've been using the
absence of a working boot loader as an excuse not to do much with
it. just create a mach_m68k directory in arch/ppc, stick the amiga
directory in there, create a mac subdirectory and maybe a common
directory, and merge away. the more files that end up being links to a
slightly modified m68k code base the better.

-a
asun@u.washington.edu

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
