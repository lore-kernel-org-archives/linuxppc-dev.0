Subject: RE: Module support for 8260 in 2.4(.1) kernel
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Fri, 20 Apr 2001 16:00:15 -0500
Message-ID: <CD5CA14300A9D54A8D13D58CD3C87B422DD733@advcorp-exc01.advent.com>
From: "Oliver Brown" <obrown@adventnetworks.com>
To: "Dan Malek" <dan@mvista.com>
Cc: "linuxppc-embedded List" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan,

I am evaluating Linux for use in a network gateway product. I agree that
the Ethernet driver would be best compiled into the kernel. However, I
need to make a custom driver for one of the FCC's using a loadable
module. I hacked up the FCC driver into a loadable module only to test
if this was possible. Also, it would be nice have loadable CPM modules
support in the kernel so the kernel doesn't have to be recompiled and
loaded for every change.

If you have any patches for the m8260_cpm_hostalloc() and
m8260_cpm_dpalloc dealloc's, I'd be happy to test them.

Regards,
Oliver

-----Original Message-----
From: Dan Malek [mailto:dan@mvista.com]
Sent: Friday, April 20, 2001 2:22 PM
To: Oliver Brown
Cc: linuxppc-embedded List
Subject: Re: Module support for 8260 in 2.4(.1) kernel


Oliver Brown wrote:

> 2. The m8260_cpm_hostalloc() and m8260_cpm_dpalloc do not have
deallocs.
> I can load my module, but I can't unload it.

Yep....I have some patches and someday I may fix it.


> I've added an init_module and cleanup_module to the fcc_enet.c from
> (bitkeeper 2.5 tree).

Since it won't work properly as a module, I would prefer you didn't
do this.  One of the reasons the CPM drivers aren't modules is there
are configuration dependencies built into the drivers.  You don't
have the flexibility to arbitrarily select any I/O configuration
at any time, the drivers have to know what may be conflicting and
avoid these configurations.  While there is an academic challenge
to make this extremely flexible, I haven't seen any production value
to this feature in use by people building real products.  If you
really need the driver, you have to build it in with consideration
of other drivers.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
