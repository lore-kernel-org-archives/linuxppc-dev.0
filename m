From: "Henry A. Worth" <haworth@ncal.verio.com>
Date: Tue, 7 Mar 2000 13:56:12 -0800 (PST)
Message-Id: <200003072156.NAA24304@ shell1.ncal.verio.com>
To: schmitz@biophys.uni-duesseldorf.de
cc: bh40@calva.net
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC200 is incompatible on New PowerBook ?
In-Reply-To: <tac-0203001358540001@powerpc1.elec.kitami-it.ac.jp> <38be0116$0$225@nntp1.ba.best.com> <tac-0303000941340001@powerpc1.elec.kitami-it.ac.jp> <38bf274d$0$213@nntp1.ba.best.com> <38BFD329.E2876106@biophys.uni-duesseldorf.de> <RlTv4.192$eU4.7467@nuq-read.news.verio.net> <38C013F1.4CC4D94D@biophys.uni-duesseldorf.de> <GOVv4.203$eU4.7902@nuq-read.news.verio.net> <38C50D98.33EE62A0@biophys.uni-duesseldorf.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Micheal, I'm cc BenH, and the linuxppc-dev list.

In article <38C50D98.33EE62A0@biophys.uni-duesseldorf.de> you wrote:
> [...]
>> A polled driver would at least allow a more functional kernel for
>> debugging, perhaps cutting the timeouts down and suppressing the
>> error message? I'll have to look into setting up a cross-compile
>> environment on an x86.

> You could build a polling driver by first installing a modified version
> of the IDE timer routine that uses a fairly short timeout, and dosn't
> print any error message in case it's called and finds the disk already
> in ready status. If that 'fast' timer still doesn't find the disk ready,
> it can start the real IDE timer routine to initiate correct error
> handling after the timeout proper has expired.

> Careful with the timer routines though. I think you'll have to delete
> the old timer before scheduling a new one, or bad things will happen.

It's looking like I might not need to go to such drastic measures, your
catch of the IDE bus-id 2 discrepency was the key, now I need to get
a clean build of a cross-compiler so I can build a test kernel...

The root of the hard disk enablement problem is that the current
ide-pmac.c code has hard-coded assumptions about the new-world
(keylargo I/O) ide bus topology. The iMac/iBook/Sawtooth(?)
map the ATA-3 IDE bus-id0 to the hard disk and ATA-3 IDE bus-id1
to the media-bay, ide-pmac.c assumes that topology.

The Pismo does not follow that topoplogy as it uses a third ide
port, bus-id 2, which is the new ATA-4 port, for the hard-disk
and uses the ATA-3 bus-id 0 for the media bay. With what I've seen
in the OF dev-tree, I hope it will be straight forward to change ide-pmac
to hard-code for the Pismo topology for testing. Once the problem
is confirmed the interesting bit will be changing the code to derive
the topology from the OF device-tree probe, for a more general
fix. I hope this will also fix the problem with the DVD drive not
being recognized. BTW, the OF dev-tree shows the keylargo chip
to be rev. 2, did the earlier new-world Macs have rev. 1?

Of, course that still leaves getting the ADB keyboard to work and
some other initialization problems. Particularly when booting from
OF with yaboot, where even the USB keyboard won't work.

>
>> Will be trying to modify the ramdisk image's rc scripts to mount the
>> HFS partition and dump kmsgs and other /proc data. That would allow
>> collecting data in the non-USB kbd cases. Would also be nice if I
>> can also get eth0 and some services like ftpd going as well. A
>> working eth0 would allow the option of net booting and running
>> diskless for debugging.

> But it requires working interrupts or it'll be too slow to be useful I
> think.

The USB interrupts are working, so I hope it is not a general problem.
But what I have found is that the kernel is not enabling access to
the GMAC chip, so unless eth0 was active in MAC/OS before booting via
Bootx, the GMAC PHY access is broken (USB has similiar problems).
Otherwise, the installer is able to ifconfig without returned error,
but whether eth0 will actually connect is still unknown (I'm not
set up for Bootp or tftp).

>[...]

> 	Michael

Henry

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
