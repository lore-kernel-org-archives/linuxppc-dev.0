Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17746.52343.815568.368590@cargo.ozlabs.ibm.com>
Date: Thu, 9 Nov 2006 17:36:39 +1100
From: Paul Mackerras <paulus@samba.org>
To: Christoph Raisch <RAISCH@de.ibm.com>
Subject: Re: [PATCH 2.6.19 2/4] ehca: hcp_phyp.c: correct page mapping in 64k
	page mode
In-Reply-To: <OF60EFC2CD.F8FB1D23-ONC1257220.00315F90-C1257220.0038B8E3@de.ibm.com>
References: <aday7qngiuf.fsf@cisco.com>
	<OF60EFC2CD.F8FB1D23-ONC1257220.00315F90-C1257220.0038B8E3@de.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Roland Dreier <rdreier@cisco.com>,
	linux-kernel@vger.kernel.org, openib-general@openib.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Christoph Raisch writes:

> ioremap maps 4k pages on 4k kernels and on 64k pages on 64k kernels. So far
> the theory.
> 
> This is true for memory.

And for I/O. :)  ioremap updates the (Linux) page tables that map the
vmalloc/ioremap area, and that is at page granularity.  So there is in
fact no difference in the end result in the page tables whether you
ask to map a small amount inside a page, or the whole page.

> On POWER the ebus memory is mapped by H_ENTER.
> The hypervisor checks for 4k page size on H_ENTER, reason see above.

The next part of the story is that the low-level MMU code on System-P
(pSeries) machines only does the H_ENTER when you access an I/O
mapping.  It does H_ENTER for 4k pages for non-cacheable mappings,
and it only does the H_ENTER for the 4k subpages of a 64k page that
the kernel actually accesses.

So Roland is correct in his comment about how ioremap is called.

Regards,
Paul.
