Message-Id: <5.1.0.14.2.20030925131735.03abfab8@mail.ebshome.net>
Date: Thu, 25 Sep 2003 13:25:00 -0700
To: Matt Porter <mporter@kernel.crashing.org>
From: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: Any restrictions on DMA address boundry?
Cc: Bret Indrelee <Bret.Indrelee@qlogic.com>,
	Roland Dreier <roland@topspin.com>,
	Matt Porter <mporter@kernel.crashing.org>,
	Linux PPC Embedded mailing list <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20030925125653.A16002@home.com>
References: <Pine.LNX.4.44.0309251306450.12966-100000@spider.ancor.com>
 <52oex8kb07.fsf@topspin.com>
 <Pine.LNX.4.44.0309251306450.12966-100000@spider.ancor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 12:56 PM 9/25/2003, Matt Porter wrote:
>When a buffer is allocated using the allowed methods (as defined in
>DMA-mapping.txt) to obtain memory for use in DMA, there is
>no guarantee that the buffer is cacheline aligned.

Hmm, I don't think this is true.

DMA-mapping.txt explicitly states that pci_alloc_consistent() returns
aligned memory buffer:

" ... The cpu return address and the DMA bus master address are both
guaranteed to be aligned to the smallest PAGE_SIZE order which
is greater than or equal to the requested size.  This invariant
exists (for example) to guarantee that if you allocate a chunk
which is smaller than or equal to 64 kilobytes, the extent of the
buffer you receive will not cross a 64K boundary..."

I think it's safe to assume that PAGE_SIZE alignment also guarantees
cacheline alignment for all existing CPUs.

Eugene.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
