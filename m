MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: HOWTO: Creating a root file system < 32 MB 
Date: Fri, 31 Aug 2001 09:35:28 -0500
Message-ID: <3A494DE356A49A40B37442E1E0D9F3B5063438@ptah.ad.newisys.com>
From: "Navin Boppuri" <navin.boppuri@newisys.com>
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I agree with Wolfgang on this. Look at Linux BootDisk HOWTO doc. There
is a striaght forward approach to creating a ext2 file system from
scratch. They also talk about small tricks you can do to cut down on the
size of the file system. The target file system from Mvista is just a
collection of all the binaries and libraries for the 8xx. You dont need
to start from this target, you may just copy the bins and libs into your
own small file system.

http://www.linuxdoc.org/HOWTO/Bootdisk-HOWTO/buildroot.html

Navin.
-----Original Message-----
From: Wolfgang Denk [mailto:wd@denx.de]
Sent: Friday, August 31, 2001 8:19 AM
To: diekema_jon
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: HOWTO: Creating a root file system < 32 MB



Jon,

in message <m15cnZX-001SysC@bucks> you wrote:
>
> Objective:
>     Create a Linux root file system that is under 32MB for a MPC8260
target.

Ummm... 32 MB? That's HUGE!!! Most of the systems I see  in  products
have root filesystems in the size of 2...8 MB.

> Direction:
...
>     board.  We will start with all the packages in HHL 1.2, and
>     removed the fluff until we hit our target size.

I  disagree  with  this  method  in  general.  Taking  any  "standard
distribution" and removing things will always be a poor way to design
an   embedded   system.   You  will  always  get  caught  in  strange
interdependencies, where you cannot remove A (which you don't  need),
because  it's  needed  for  some  function of B (which you also don't
need), but another function of B is used by C, which is important  to
you.

If you want to build a lean system you have to do it  the  other  way
round: bottom up.

See also: .sig below :-)

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Perfection is reached, not when there is no longer anything  to  add,
but when there is no longer anything to take away.
- Antoine de Saint-Exupery


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
