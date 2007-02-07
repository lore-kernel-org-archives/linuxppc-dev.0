Return-Path: <hch@lst.de>
Date: Wed, 7 Feb 2007 15:52:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [PATCH 3/3] spufs: remove need for struct page for
	SPEs
Message-ID: <20070207145226.GA14458@lst.de>
References: <1170823850.450936.293648942401.qpush@grosgo>
	<20070207045055.295F3DDE46@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070207045055.295F3DDE46@ozlabs.org>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 07, 2007 at 03:50:52PM +1100, Benjamin Herrenschmidt wrote:
> This patch removes the need for struct page for SPE local store
> and registers from spufs. It also makes the locking much more
> obvious and no longer relying on the truncate logic black magic
> for protecting against races between unmap_mapping_range() and
> new pages faulted in. It does so by switching to a nopfn() handler
> and using the new vm_insert_pfn() to setup the PTEs itself while
> holding a lock on the SPE.
> 
> The nice thing is that this patch actually removes a lot more code
> than it adds :-)

Looks good to me.
