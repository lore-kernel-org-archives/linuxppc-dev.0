Message-ID: <3D61C719.4050607@embeddededge.com>
Date: Tue, 20 Aug 2002 00:35:37 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: kas turi <inox_kas@yahoo.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: BD allocation and IDMA driver question
References: <20020820033306.23695.qmail@web21006.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


kas turi wrote:

>  I would like to know what is the difference between
> m8260_cpm_hostalloc and m8260_dp_alloc.

The 'hostalloc' allocates from a small pool of host memory.
This is usually used for small FIFOs as there is only a
page or so for use by the entire system.  The 'dp_alloc'
allocates from the CPM dual ported memory.

> .... The FCC driver
> uses the former API and the serial driver uses the
> latter API.

If you would read the comment in the FCC driver, you may
understand why :-)

> ..... When I try to use m8260_cpm_hostalloc to
> allocate buffer descriptor for the SPI driver the
> timesys 2.4 kernel hangs. When I use m8260_dp_alloc
> the SPI driver works.

The 'hostalloc' returns a kernel virtual address.  You
have to convert this to a physical address for the CPM DMA.

>   Has anybody developed a IDMA driver for 8260 for 2.4
> kernel?

There have been discussions about it on this mailing list.
You may wish to search the archives for more information.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
