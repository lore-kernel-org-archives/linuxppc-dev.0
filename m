Date: Fri, 02 Apr 2004 13:33:07 -0500
From: Jeff Tucker <jeff@jltnet.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Need help booting linux on IBM 405EP eval board
Message-ID: <5357473.1080912787@[192.168.0.230]>
In-Reply-To: <1866383.1080909296@[192.168.0.230]>
References: <1866383.1080909296@[192.168.0.230]>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--On Friday, April 02, 2004 12:34 PM -0500 Jeff Tucker <jeff@jltnet.com>
wrote:

>
> Hi, guys.
>
> I sent a message like this to the U-Boot mailing list last night. I've
> been
> told this is definitely not a U-Boot problem, so I'm hoping that the
> people
> on this list can help me.
>
> I'm having a hard time getting U-Boot to boot Linux on an IBM 405EP
> evaluation board. Here's what I've tried:
>

Just to follow up to my own posting. I've found that in my linux-2.4.18
kernel, there is a file arch/ppc/platforms/evb405ep.h which does include a
board_info struct which is quite a bit different from the struct in
u-boot.h. I've made those match and re-built the kernel, still with no luck.

I've re-built U-Boot in debug mode so I can see what is going on. Here's
what it spits out before the board locks up:

=> iminfo 500000

## Checking Image at 00500000 ...
   Image Name:   Linux-2.4.18_mvl30-405ep_eval
   Created:      2004-04-02  17:59:23 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    733690 Bytes = 716.5 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
=> bootm 500000
## Booting image at 00500000 ...
   Image Name:   Linux-2.4.18_mvl30-405ep_eval
   Created:      2004-04-02  17:59:23 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    733690 Bytes = 716.5 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Current stack ends at 0x07FB0598 => set upper limit to 0x00800000
## cmdline at 0x007FFC00 ... 0x007FFC1B
bd address  = 0x07FB0F8C
memstart    = 0x00000000
memsize     = 0x08000000
flashstart  = 0xFFF80000
flashsize   = 0x00080000
flashoffset = 0x00027F00
sramstart   = 0x00000000
sramsize    = 0x00000000
bootflags   = 0x0000A000
procfreq    = 266.666 MHz
plb_busfreq = 133.333 MHz
pci_busfreq = 33.333 MHz
ethaddr     = 00:04:AC:E3:24:A7
IP addr     = 192.168.0.91
baudrate    =   9600 bps
No initrd
## Transferring control to Linux (at address 00000000) ...

Any ideas?

Thanks
Jeff

--
Jeff Tucker
jeff@jltnet.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
