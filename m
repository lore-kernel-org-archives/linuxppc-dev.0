Mime-Version: 1.0
Message-Id: <v04220800b6bbb8f01525@[10.0.0.42]>
In-Reply-To: <3A76769B.87242FAA@valinux.com>
References: <3A76769B.87242FAA@valinux.com>
Date: Thu, 22 Feb 2001 23:07:31 -0800
To: Gareth Hughes <gareth@valinux.com>
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: r128 DRI driver now fully functional on PPC
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 7:08 PM +1100 1/30/01, Gareth Hughes wrote:
>I've just committed the last of the updates required to get full hardware
>accelerated 3D rendering with the ATI Rage 128 on PowerPC.  Many
>thanks to Paul
>Mackerras for allowing me to hack away on his machine over the last week!
>
>The code is available on the ati-pcigart-0-0-1-branch in the DRI CVS
>repository.  Please feel free to check it out and report any
>problems you have.

Gareth (& everybody on the ppc dev list),

I've been trying to get this to work on a B&W G3 with a 100 MHz R128
PCI OEM card.

I'm getting things to build OK, but I did experience a couple
problems along the way.  The first was an old distribution /
compiler; when compiled by it, the X server would crash during
startup.  Reinstalling with LinuxPPC 2000 Q4 cured that.

The second is that the DRM kernel modules fail to build against the
2.2.18 headers.  A function in vm.c (I think) tries to access a field
named 'virtual' in struct page, which simply isn't there in 2.2.18.
The #if statements surrounding the code seem to be deliberately
compiling it only if the kernel is a 2.2 series, so I'm not sure what
is going on.  So I shifted over to the PPC 2.4 BK kernels and got
everything to build OK that way.

Where I'm at now is that the X server loads and runs (quite well I
might add), automatically loads the r128.o kernel module, and (in the
logfile) claims to have enabled direct rendering.  However, both
windowed and fullscreen GL apps are very clearly not being
accelerated.  Frame rates are obviously software renderer type frame
rates, and apps which check for multitexture capability complain that
it isn't there.

Any suggestions?  If anybody wants to see some logs from the server
starting up, I'll supply 'em.  Also, if anybody out there has gotten
this working, could you send me your XF86Config so I can make sure I
didn't do something silly to mine?

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
