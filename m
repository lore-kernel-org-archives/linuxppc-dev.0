Date: Thu, 3 Jun 1999 11:28:26 -0600 (MDT)
From: Brad Midgley <brad@turbolinux.com>
Reply-To: Brad Midgley <brad@turbolinux.com>
To: Samuel Rydh <samuel@ibrium.se>
cc: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
Subject: Re: Mac-on-linux is now working...
In-Reply-To: <19990510213309.43528@ibrium.se>
Message-ID: <Pine.LNX.3.95.990603084043.25461A-100000@pacific.pht.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Samuel,

I am SO impressed with mol. I remember you saying a while back that you
were interacting with OF in a virtualized session and POOF now MacOS runs!

The few problems I've encountered are intriguing... I'm also touching on a
lot of issues I've thought of.

control-c doesn't work to shut mol down any more. maybe i messed something
up here...

my macos has bootx defaulting to linux but that's not what you want inside
the virtual machine. i think i'll install a small macos on another drive
that has bootx and remove bootx from the main mac system. (it IS a trip to
watch linux boot inside linux however :)

is there any reason to use hw, 53c94, or mesh over osi?

i have two mice. i have to hold down the button on both mice or dragging
doesn't work--macos under mol will confuse the other mouse's button-up. 
linux used to do this, beos did, and regular macos will IF i unplug the
adb chain and plug it back in so both mice have the same ID. I don't
understand the level of adb emulation inside mol so i'm not sure why it
would do that. 

is there any reason to fear making volumes read-write? is a regular
shutdown inside mol enough to make sure the volumes stay coherent? 

cpu load is high but i imagine that's just the nature of macos. i won't be
leaving it running in the background.

i'd suggest larger swap partitions for people who plan to run mol. what
used to be fine for x + netscape + etc. isn't high enough if you want mol
to commit 32M or 64M. mol effectively reduces your swap available by the
amount of ram you give it. mol didn't thrash however--it just wants to
commit the memory up front. i love the idea of using REAL virtual memory
inside today's macos.

once mol is solid i'd like to see the user experience changed a little--a
flag to mol to have it not launch the debugger and making shutdown inside
macos stop mol would improve it vastly.

i wrote a script to help with launching mol. it should be run from the
console:

#!/bin/sh
vmode 17 32
echo Starting Mac-on-Linux emulator...
echo
MOLHOME=/usr/share/mol
cd $MOLHOME
if [ $? -ne 0 ]; then
 echo "Couldn't change to $MOLHOME (the directory may be missing)"
 exit
fi
if [ ! -f data/rom/ROM-image ]; then
 echo "Couldn't find ${MOLHOME}/data/rom/ROM-image"
 echo "You should copy your ROM-image to ${MOLHOME}/data/rom/"
 exit
fi
umount -a -thfs
if [ $? -ne 0 ]; then
 echo
 echo "Warning: At least one hfs filesystem couldn't be unmounted."
 echo "Make sure you don't use any volume concurrently in mol"
 echo "and as a mounted Linux filesystem unless they're BOTH read-only."
 echo
 sleep 10 
fi
nice ./mol $*
mount -a -thfs

if you plan to make mol run within an x window, i suggest to write it to
libGGI. if it was written to libGGI, then full-screen and within-X could
both be easily achieved with the same binary.

> Currently Mac OS boots on the 7200 and 8500
> without a ROM-image. Other machines should be 
> able to run the software using a ROM-image 
> from one of those two computers (G3 machines may
> or may not boot Mac OS).

FYI I needed the image on my 7500.

> floppy:		working

I couldn't find floppy support documented...

> sound:		not implemented
> ethernet:	not implemented (yet)

especially ethernet will be great. how will you do it though? Will the mac
box get an ip address of its own and have two addresses bound to the card? 

mol couldn't be a dhcp client--imagine how confusing that would get... 
you could stick with one bound address and have the mac box masqueraded
maybe.

great work. i'm glad to see Ben has participated.

I'd like to see more discussion on what issues are giving you problems.
That's an important way to get more involvement.

Brad
brad@pht.com | http://www.pht.com/~brad/






[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
