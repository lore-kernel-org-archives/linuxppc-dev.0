Date: Thu, 25 Sep 2003 13:41:12 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Eugene Surovegin <ebs@ebshome.net>
Cc: Matt Porter <mporter@kernel.crashing.org>,
	Bret Indrelee <Bret.Indrelee@qlogic.com>,
	Roland Dreier <roland@topspin.com>,
	Linux PPC Embedded mailing list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Any restrictions on DMA address boundry?
Message-ID: <20030925134112.A17028@home.com>
References: <Pine.LNX.4.44.0309251306450.12966-100000@spider.ancor.com> <52oex8kb07.fsf@topspin.com> <Pine.LNX.4.44.0309251306450.12966-100000@spider.ancor.com> <20030925125653.A16002@home.com> <5.1.0.14.2.20030925131735.03abfab8@mail.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5.1.0.14.2.20030925131735.03abfab8@mail.ebshome.net>; from ebs@ebshome.net on Thu, Sep 25, 2003 at 01:25:00PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Sep 25, 2003 at 01:25:00PM -0700, Eugene Surovegin wrote:
> At 12:56 PM 9/25/2003, Matt Porter wrote:
> >When a buffer is allocated using the allowed methods (as defined in
> >DMA-mapping.txt) to obtain memory for use in DMA, there is
> >no guarantee that the buffer is cacheline aligned.
>
> Hmm, I don't think this is true.
>
> DMA-mapping.txt explicitly states that pci_alloc_consistent() returns
> aligned memory buffer:
>
> " ... The cpu return address and the DMA bus master address are both
> guaranteed to be aligned to the smallest PAGE_SIZE order which
> is greater than or equal to the requested size.  This invariant
> exists (for example) to guarantee that if you allocate a chunk
> which is smaller than or equal to 64 kilobytes, the extent of the
> buffer you receive will not cross a 64K boundary..."
>
> I think it's safe to assume that PAGE_SIZE alignment also guarantees
> cacheline alignment for all existing CPUs.

Yes, that's correct.  However, I was alluding to kmalloc()'ed
buffers that are to be used with the streaming calls in the
DMA API.

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
