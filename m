In-Reply-To: <Pine.LNX.3.95.990603084043.25461A-100000@pacific.pht.com>
Date: Thu, 3 Jun 1999 20:05:23 +0200
To: Brad Midgley <brad@turbolinux.com>, linuxppc-dev@lists.linuxppc.org
CC: linuxppc-user@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Mac-on-linux is now working...
Message-Id: <19990603200523.030085@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jun 3, 1999, Brad Midgley <brad@turbolinux.com> wrote:

I'm giving you some answers, Samuel is busy this week, he may want to
correct me later however on some points.

>control-c doesn't work to shut mol down any more. maybe i messed something
>up here...

Did you try switching to the debugger VC before pressing control-C ?

>my macos has bootx defaulting to linux but that's not what you want inside
>the virtual machine. i think i'll install a small macos on another drive
>that has bootx and remove bootx from the main mac system. (it IS a trip to
>watch linux boot inside linux however :)

I think I'll have to fix that...

>is there any reason to use hw, 53c94, or mesh over osi?

That depends if OSI works fine for you or not, all this is quite early.
Also, OSI works only with MacOS, not MacOS X nor Linux. But in the
longterm, I beleive OSI will be faster (I didn't bench the current version).

>i have two mice. i have to hold down the button on both mice or dragging
>doesn't work--macos under mol will confuse the other mouse's button-up. 
>linux used to do this, beos did, and regular macos will IF i unplug the
>adb chain and plug it back in so both mice have the same ID. I don't
>understand the level of adb emulation inside mol so i'm not sure why it
>would do that. 

Probably something in the adb emulation. I have some plans in mind to add
better support in the kernel for routing directly ADB datas to MOL.
Currently, MOL reconsitutes ADB datas from the Xpmac pseudo-keycodes send
by the kernel to the front VC.

>is there any reason to fear making volumes read-write? is a regular
>shutdown inside mol enough to make sure the volumes stay coherent? 

It should work, but it's still early and not large-scale tested. I use it
read-write on one machine, but it's a test machines with nothing
important. I didn't crash the disk yet (running MacOS 8.6). I've not
encountered a specific case of data corruption, and I didn't see Samuel
writing about one.

>cpu load is high but i imagine that's just the nature of macos. i won't be
>leaving it running in the background.

This can be improved in the future, especially since MacOS itself
improved that in 8.6 (processor in DOZE mode when idle). But I beleive
MOL will always be a resource eater. Should be fine in MP ;-)

>if you plan to make mol run within an x window, i suggest to write it to
>libGGI. if it was written to libGGI, then full-screen and within-X could
>both be easily achieved with the same binary.

I wrote most of the video driver, so I'm interested in any infos/tips you
have about libGGI (I know nothing about it). Currently MOL maps the
physical frame buffer in mac-os space for efficiency and provides MacOS
with a video drivers thru a fake PCI card expansion ROM. I have few
control over MacOS, I mean MacOS requires access to a complete
framebuffer. When switching VCs, the framebuffer is unmapped and a piece
of memory is mapped instead. 
For GGI/X, I don't know if direct mapping of the fb is possible without
hacks. If not, we either have to blit all the time, add more MacOS hacks
to try to "sense" changes to the screen via JShieldCursor patch or
something like that, or use the MMU to catch writes to the fb.

>FYI I needed the image on my 7500.

What happens if you boot without the images ? (You should keep oftree and
ROM images in sync. If not using the ROM image, don't use the oftree
image neither). Also, avoid using the bundeled nvram image if using a
different ROM than the 8500. Use the debugger command "nvramzap" to zap
it before starting emulation, and "nvramwi" later during boot to write it.

>especially ethernet will be great. how will you do it though? Will the mac
>box get an ip address of its own and have two addresses bound to the card? 
>
>mol couldn't be a dhcp client--imagine how confusing that would get... 
>you could stick with one bound address and have the mac box masqueraded
>maybe.

Hum, I will probably also write the network stuff (actually, I began the
MacOS side) and it will be based on Basilic/Sheepshaver driver for
getting copies of incoming eth packets and inserting outgoing eth
packets. I don't know Linux kernel router well enough to adapt this
driver so that it can be a "branch" of linux router, currently the driver
must be "attached" to a network interface. if linux provides virtual
interfaces, then we could attach the driver to it.

>great work. i'm glad to see Ben has participated.

Thanks ;-)

>I'd like to see more discussion on what issues are giving you problems.
>That's an important way to get more involvement.

You may help for the network, track bug, help supporting more hw with
their own ROMs, etc... There is still a lot to do ;-) I'll let Samuel
give you more details.

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
