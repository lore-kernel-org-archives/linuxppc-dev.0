Date: Sat, 10 Nov 2001 01:45:27 -0500
From: Joseph Manojlovich <manojlov@cse.psu.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Various RS/6k 43p 150 Issues
Message-ID: <20011110014527.B28196@cardassian.cse.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hey all. I've been spending this week tracking down a real head smasher
of a bug in the open framebuffer code. My card, the ever-annoying
gxt2000p, only works through framebuffer. Now, the kernel Suse 7.1
ships with works for the console -- it's a stock 2.4.2 kernel patched
up to almost linuxppc (at that time). I've been trying the newer
kernels, in an attempt to get X working, but it seems that anything
above 2.4.6 breaks the framebuffer code for me.

The problem: the offb_init_fb call, in drivers/video/offb.c, was
prematurely returning instead of initializing. The first 2 lines of
real code in the function:

if (!request_mem_region(res_start, res_size, "offb"))
        return;

request_mem_region starting with newer kernels returns 0 for me. A
quick hack, removing the if statement surrounding the
request_mem_region call, fixed the code for my card.

Tracking down the problem deeper, it turns out that in __request_region
(inside kernel/resource.c) the framebuffer device is never not
IORESOURCE_BUSY. So, I guess in my case the framebuffer is conflicting
with itself??

I'm not exactly sure how to fix this yet, aside from the quick hack,
which does work. I'd offer a real patch, but I'm pretty new to this
deep level kernel work and admittedly clueless. But I'm open to any
suggestions.

Also, is the pci code totally broken? 2.4.2 worked fine for my system.
Now, I get lots of

"PCI: Cannot allocate resource region 0 of device 00:0d.0"

and

"PCI: Failed to allocate resource 0(c00000-bfffff) for 00:0b.1"

and then none of my PCI devices work. Needless to say, this makes the
system unbootable, as the SCSI card is never initialized and the root
filesystem is never mounted. 2.4.2 worked however.

Any ideas? I've gotten all of these problems in 2.4.6 and above, and
with the linuxppc branches hosted on source.mvista.com.

--
Joe Manojlovich
manojlov@cse.psu.edu
"And a thermostat on a home furnace... is that supposed to go to
 5000 degrees, do you think?"

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
