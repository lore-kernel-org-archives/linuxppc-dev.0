Message-ID: <3B3B634F.E6B9FBFC@mvista.com>
Date: Thu, 28 Jun 2001 10:03:11 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Neil Wilson <NWILSON@Airspan.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Sandpoint 3 + MPC7450 + HHL2
References: <E69FF45ADA3BD511A25900047623CC4F12AA76@JUPITER>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Neil Wilson wrote:

> Got it working now....
>
> Not sure if these fixes are just Sandpoint3 or MPC7450 or the combination,
> but...
>
> 1) The openpic_init call in sandpoint_init_IRQ needs the offset argument to
> get the SIO int setup.

Are you sure you want to do this???  The intsenses stuff in sandpoint_setup.c
is the way it is for a very good reason.  Can you send me your patch so I can
take a look?  Also, can you send the switch settings that you are using.

> 2) I also needed to add a enable of the TBEN in HID0 (bit 0x04000000) just
> to get the kernel to think about booting at all - I put this in the
> decompress_kernel function.

I think that your sandpoint-specific boot head.S or somewhere else like that
would be a much better choice than the ppc-generic decompress_kernel routine.

> Do these sort of changes need pushing into the source tree ?, and if so
> would anyone care to explain how a newcommer does this, thanks.

Let's hold off on this until people who have sandpoints can take a look.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
