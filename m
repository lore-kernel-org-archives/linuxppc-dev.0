Date: Tue, 31 Aug 1999 11:04:05 +0200
Message-Id: <199908310904.LAA02843@lxp02.cern.ch>
From: Jes Sorensen <Jes.Sorensen@cern.ch>
To: Paul.Mackerras@cs.anu.edu.au
Cc: ddkilzer@computer.org, schmitz@opal.biophys.uni-duesseldorf.de,
        linux-mac68k@mac.linux-m68k.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: mac-2.3.14.diff: adb
In-Reply-To: <199908310721.RAA17352@tango.anu.edu.au>
References: <199908301552.RAA23128@lxp03.cern.ch>
	<v03130327b3ebecbebbd3@[192.168.1.1]>
	<199908270917.LAA04250@lxp03.cern.ch>
	<v03130308b3ec440550d3@[192.168.1.1]>
	<199908271414.QAA24261@lxp03.cern.ch>
	<37CAA6F5.D93A168B@biophys.uni-duesseldorf.de>
	<v03130302b3f1013159dd@[192.168.1.1]>
	<199908310721.RAA17352@tango.anu.edu.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "Paul" == Paul Mackerras <paulus@cs.anu.edu.au> writes:

Paul> David D. Kilzer <ddkilzer@computer.org> wrote:
>> The issue at hand is that Jes believes drivers/macintosh should not
>> exist

Paul> I still haven't heard why.  I personally would like something more
Paul> compelling than "Jes doesn't like it" before changing an
Paul> arrangement that is working just fine AFAICS.

Heh, I have been wanting to clean up the driver hierachy for a very long
time, it is really silly that we keep copying old drivers and change 50
lines of code to make them run on a new machine. This is the case with
the 8530 driver, but even worse for the Lance Ethernet one.

>> I would appreciate it if Jes and Paul would come to an agreement on
>> where the code belongs so we can get on with the ADB merger.  :^)

Paul> Jes is more of a "theoretician" than I am, I tend to be more
Paul> pragmatic, so this could be a problem. :-) I will accept patches
Paul> for drivers/macintosh from the m68k mac folks.  I have some
Paul> reservations about the current adb merge patches, though, which
Paul> I'll mention once I've had a closer look at the patches.  In
Paul> general I'm happy with a drivers/adb directory but I don't think
Paul> drivers/macintosh should go away.

Hmmm, refusing is such a strong term, however I consider you to be the
owner of drivers/macintosh and prefer not to make changes to it since if
I have to keep them around for a while it's a nightmare to maintain
since I cannot test the code.

I always refused to create drivers/amiga and drivers/atari because I
knew it would mean I would get things past Linus quickly but they would
then stay isolated forever and we would never get things merged like we
did with the fbcon code after a long time. I always consider
drivers/sbus/char a result of Dave not being willing to spend any time
arguing with Linus over things - though I might be wrong, I don't want
to talk about Dave behind his back. Oh and don't get me started on
drivers/acorn ;-)

I don't know that much about the Mac hardware, however I know they do
have an ADB bus and that in principle it's not Mac specific. We now
created drivers/{pci,zorro,dio,sbus,...} for specific bus handling code
and it seems to me to be a good idea to do that for ADB as well (I might
be wrong, it's happend before). The Mac serial driver really should go
in drivers/char (or maybe even have a drivers/serial created at some
point to make it easier to deal with) - trying to merge the multiple
8530 drivers we have now would be a positive long term goal, though of
course it should not be holding back real development. If there are
things which are truly Mac specific I agree they should stay in
drivers/macintosh, I didn't notice all the things you listed when I did
an ls drivers/macintosh in my tree.

Jes

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
