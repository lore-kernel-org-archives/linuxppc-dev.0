Message-ID: <F14441D40E5AD3118886005004607AD10BDD7F@MAIL1>
From: "Halfmann, Klaus" <khalfmann@libra.de>
To: "'Matthew Wilcox'" <matthew@wil.cx>, Roman Zippel <roman@augan.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Status of HFS+ support (was hfs support for blocksize != 512)
Date: Tue, 29 Aug 2000 18:40:08 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="windows-1252"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Im currently working on HFS+ support. Im assisted by Brad Boyer
(flar@pants.edu) . I currently target a remake of the hfsutils
originally created by rob@mars.org.

The current status is, that the library for readonly acces looks
fine. I currently work on providing commands like hpmount and
hpls. Since this is a userland project I dont care about race
conditions right now. (Im aware that a kernel module must care ...)
I think I got a good undertstanding of the BTrees by now (it took some
time ...). Updating the btree in a multithreaded environemnt is
a real challenge. One must adopt database like mechanisms like
optimistic locking to update a btree concurrently. (Well databases
_use_ Btrees internally :-).

On the other hand: The hfs acces is normally not needed for heavy
concurrent acces. (Mhh, there might be AFP Servers publishing HFS
partions) For now it should be enough to have a global update
lock on the root of the node. Im not firm with kernel code yet, dont
ask me about the details :-)

I plan to progress on the userland side until most of the the Details
work (almost :) correctly. This way it is at least possible to copy
a kernel to the HFS+ "Side" of the mac to yaboot from it etc.
_After_ that Ill go ahead and write a kernel module. Of course any help
on the modules is welcome. We have a CVS repostiory at Suse and perhaps
(Olaf do you her me ?) there is an rsync acces, too.

I'd really like to know how the concurrency of the kernel filesystem
should work, can anybody feed me with documentations about that ?

Greeting,
	Klaus Halfmann (aka Hasi)

P.S. for HFS+ I dont assume any fixed block size :)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
