To: linuxppc-dev@lists.linuxppc.org
Subject: Re: I2C module problem on 8260 
In-Reply-To: Message from Wolfgang Denk <wd@denx.de>
   of "Wed, 13 Feb 2002 00:18:08 BST." <20020212231813.2D906109D7@denx.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 13 Feb 2002 17:43:57 +1100
Message-ID: <1037.1013582637@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@cmst.csiro.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 13 Feb 2002 00:18:08 +0100, Wolfgang Denk <wd@denx.de> writes:
>I've sent such patches to Tom Rini many months ago (starting  29  Aug
>2001),  and  in some iterations again and again. It's for 8xx only so
>far, but adaption for 82xx is just a small exercise.

Well, I have an i2c driver for the CPM which supports both 8xx and 8260
(and potentially anything else that has a CPM) in the same source (although
I still haven't got around to testing the 8xx code). I avoid the issue raised
here by using kmalloc(). The code works fine as a loadable module, and it
only allocates the dual port ram once, the first time the module is loaded.
Of course, it is called drivers/i2c/i2c{-algo,}cpm.c.

These patches (amongst a whole lot of others) were also submitted around that
same time. After much back and forth I was asked to post the patches to this
list, which I have been meaning to do for many months now.

Initially, I was asked to submit the i2c changes via the i2c driver people,
but I countered this by pointing out that they really couldn't care less
about driver code for embedded powerpc (CPM), since it will never run on
anything else (as opposed to a driver for a PCI card which may work on
multiple platforms). We really only submit our code back to them for the
sake of completeness.

>Unfortunately, this patch was always ignored (as some  others,  too),
>so I finally gave up.

Hmm.. I wonder if we are being too careful about allowing stuff into the
_devel tree - isn't that what its for? Development stuff that might break
things? Besides, there are already some changes that make it in that severely
break things for some platforms - we all just put up with it and fix the
problems as they arise (witness the recent change in operation of the get_irq
function - the 8260 platform hung during boot the first time interrupts were
enabled, and it stayed that way for many months until I finally decided to
track the problem down).

Now, I'm not criticising anyone's effort, decisions or contributions here,
simply discussing our operational policy in a calm manner in the hope that
things might be freed up a bit (of course I recognise the chaos that could
arise if all changes were simply immediately incorporated without question,
but there has to be a happy medium somewhere).

Anyway, I should get off my arse and post those patches - I think there
is some good stuff in them (but then I would, wouldn't I). Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing Sci & Tech,         Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@cmst.csiro.au  (old address was mjj@mlb.dmt.csiro.au)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
