Message-ID: <3E3157BF.7060804@embeddededge.com>
Date: Fri, 24 Jan 2003 10:11:59 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: [PATCH] m8xx_setup.c and PCMCIA
References: <3E30F363.1020501@imc-berlin.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steven Scholz wrote:
> Hi there,
>
> I reckon that (almost) all MPC8xx boards that use PCMCIA CS have to call
> io_block_mapping() with _IO_BASE anyway....

Well, _almost_ isn't good enough :-)

I hope some of the more PCMCIA literate folks speak up here, because I
think placing IO_BASE into the mix, and certainly io_block_mapping it
is quite wrong.  It may be necessary for your board, but it certainly
isn't something that is going to work on many others.  All you need is
an 860 with a Tundra PCI bridge and all of these patches will fail to work.
The pcmcia register mapping for you board should take these things
into consideration when that mapping and register configuration is
done, it's not something that should be part of global set up.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
