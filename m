Message-ID: <3F2A21D5.2040204@windriver.com>
Date: Fri, 01 Aug 2003 09:16:21 +0100
From: Richard Danter <richard.danter@windriver.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 750/107 CHRP question
References: <20030731233230.59FBCC602D@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Wolfgang,

I am CC'ing the list as there may be some useful info in here...

Wolfgang Denk wrote:
> In message <3F298CED.8010701@windriver.com> you wrote:
>>Yes, I work for WRS, but this is a little personal project just for the
>>hell of it. I just happen to be using a WRS board and vICE to do the
>>debugging.
>
> Did you try what happens when you disconnect the visionIce?
> Are you 100% sure it understands virtual addresses correctly?

Yes, in fact besides my personal interest in Linux, my job is supporting
visionXXX customers (I worked for EST before it was bought by WR).

There is a command in the vICE-II called "CF MMU LINUX" which turns on
MMU handling (doesn't have to be Linux running) and then you use the
MMUA command to set up the mapping (eg MMUA C0000000 0 F0000000) and hey
presto!

I have been stepping through the kernel source code quite happily. I
tracked the problem down the the point where the 1st write occurs to the
serial port. If I let it run on from there I end up in an inf. loop
which just jumps to itself. When I reach that point I can stop the
target and use the memory window to dump the "log_buf" which is where
all the kprintf messages are going and I can get the back trace from
that and it points to the same offending instruction in serial setup.

I also tried not having a serial port compiled in and everything works
perfectly.

It is fixed now tho as I decided to add a ioremap() call. The other
suggestions I got ware probably more flexible but this was so simple -
just editing 1 line.


Rich


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
