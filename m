Message-ID: <3C4C7C4E.4020506@embeddededge.com>
Date: Mon, 21 Jan 2002 15:38:38 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Mark Pilon <mpilon@midrivers.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: KERNELBASE & large memory systems
References: <3C4A96D7.9010501@embeddededge.com> <3C4C2EB6.6F3ACADE@midrivers.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark Pilon wrote:

> I've heard that one shouldn't modify the definition of KERNELBASE
> as it screws up the MM code;

That was true until yesterday.  Matt Porter checked in some configuration
changes that if you know what you are doing will change the virtual
mapping windows on most processors (not 4xx or 8xx yet).  They are
in the linuxppc_2_4_devel kernel.

> I'm wondering how people out there are handling designing systems
> (and getting linux running) on large pools of memory -- like
> 1 - 2 Gb or so.

The only general answer to that question is the solution depends upon
your configuration.  A combination of highmem and kernel address base
changes are used.  This will also affect drivers if you have some custom
application and you are trying to use a driver that makes assumptions
about the "normal" kernel mapping.

The "know what you are doing" is critical to your success :-).

Good Luck.

	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
