Date: Thu, 15 Jul 1999 13:44:24 -0500 (CDT)
From: Joseph Palani Garcia <jpgarcia@execpc.com>
To: Jerry Quinn <jquinn@nortelnetworks.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Broken sound?
In-Reply-To: <14222.9603.505701.976724@gargle.gargle.HOWL>
Message-ID: <Pine.SOL.4.10.9907151334160.21552-100000@earth.execpc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


this is a known endian problem.  ppc archetecure is big endian, while most
other linux-running platforms are little endian.  recent setups, like R5
implement sound as little endian.  not everyone has caught up with this
yet, so many programs still assume that we mac users need to have endians
switched, so those little endian files we now can play, get reversed so
that the older systems play fine, but not the newer ones.  Though i think
there is inconsistency in this decision.  MacOS .au files are still big
endian.  if we try to play them straight to the device like you are doing,
it is assumed little endian.  whoops.  if i have this correct, then i
think it is better the other way.  what is being done is file -> kernel ->
device.  since the device cant be changed, and we shouldn't dictate more
standards in audio files, it seems to me that having the kernel assume
input is correct as is makes more sense.  let the PC users have thier
little endian.  dont give us static about macs being big endian.

sorry bout the rant. as for a fix, i think the au might have to be created
on a PC for it to be little endian, so that the newer system can convert
it back to big endian and waste some processing time.  Its all a mess.
why do we want our big endian's to emulate little?  anyone?

---                                                                     ---
Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
CS Undergraduate                      Student Employee - Systems Programmer
Univeristy of Wisconsin - Madison                            UW Lidar Group


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
