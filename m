Message-ID: <3AE08C6C.2D2F3B3F@mvista.com>
Date: Fri, 20 Apr 2001 15:22:20 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Oliver Brown <obrown@adventnetworks.com>
Cc: linuxppc-embedded List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Module support for 8260 in 2.4(.1) kernel
References: <CD5CA14300A9D54A8D13D58CD3C87B422DD731@advcorp-exc01.advent.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Oliver Brown wrote:

> 2. The m8260_cpm_hostalloc() and m8260_cpm_dpalloc do not have deallocs.
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
