Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3E9FD84F.2C40F0ED@doremilabs.com>
Date: Fri, 18 Apr 2003 10:49:51 +0000
From: Jeff H Zhong <jeff@doremilabs.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: debugging using bdi2000, unable to proceed.
References: <20030418160238.8EB5BC58B9@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The problem is this:

When I use bootp/tftp boot, on the host if I do arp then I can get
root@Jeff linuxppc_2_4_develubpatch<366>arp
Address                  HWtype  HWaddress           Flags
Mask            Iface
7.1.1.5                  ether   00:40:49:FA:43:59
C                     eth1
7.1.1.6                  ether   00:04:AC:E3:1D:62
C                     eth1
10.1.1.171               ether   00:A0:C5:E0:C4:EC
C                     eth0

Which 7.1.1.5 is my BDI2000 and is not part of our discussion.

But if I bootm directly from flash, it will be
root@Jeff linuxppc_2_4_develubpatch<366>arp
Address                  HWtype  HWaddress           Flags
Mask            Iface
7.1.1.5                  ether   00:40:49:FA:43:59
C                     eth1
7.1.1.6
(incomplete)                              eth1
10.1.1.171               ether   00:A0:C5:E0:C4:EC
C                     eth0

I doubt that when kernel brings up eth0, it doesn't broadcast MAC
address?

I am still hacking the kernel code.... and getting headache on this
problem...

--Jeff

Wolfgang Denk wrote:
>
> in message <3E9FB7FD.93947BE5@doremilabs.com> you wrote:
> >
> > Could you give me a hand to help me figure out this issue on ebony?
>
> I've read your story before, but I cannot help.
>
> > If I use "bootp" or "tftp" to load kernel image(linuxppc_2_4_devel from
> > BK) at address 0x01000000 and then issue "bootm", everything works fine.
> > I have also programmed the image into flash at 0xffe00000, but each time
> > when I issue "bootm 0xffe00000", it will get stuck at when trying to
> > mount NFS.
>
> Technically there is absolutely no difference between both cases:  in
> either  case  U-Boot  will  copy  and  uncompress  the  kernel to RAM
> starting at physical adress 0x0000, and start it there.  I  have  not
> the slightest idea whaty could cause a behaviour as described by you,
> nor have I ever seen anything like that before.

--
Jeff H. Zhong
-------------
Doremi Labs, Inc.
306 East Alameda Avenue
Burbank, CA 91502

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
