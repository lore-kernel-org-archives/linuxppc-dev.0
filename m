Message-ID: <3B953202.E9E8DB54@mvista.com>
Date: Tue, 04 Sep 2001 15:56:50 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Eli Chen <eli@routefree.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Alexander Kolesnikov <akolesni@qualcomm.com>
Subject: Re: USB support in the HardHet Linux 2.4.2 on the IBM Walnut
References: <4.2.2.20010830111127.02d754d0@qisrael.qi.qualcomm.com> <009601c134d5$4bc7aca0$b300000a@foolio1>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Eli Chen wrote:

> We have managed to get the USB ohci driver to work on the Walnut board.  I
> believe one of the problems was that the 405gp platform did not guarantee
> cache coherency for pci-dma.


All of the problems found so far are associated with cache coherency.
One of the changes, which still isn't really correct, is to change the
consistent_sync() function to always writeback and invalidate.  We
seem to be more lucky with this, but the proper solution is to cache
line align all buffers subject to DMA.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
