Return-Path: <hch@lst.de>
Date: Fri, 9 Feb 2007 15:56:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [PATCH] spufs: Fix bitrot of the SPU mmap facility
	(#2)
Message-ID: <20070209145620.GA15548@lst.de>
References: <20070209045848.6304FDDE37@ozlabs.org>
	<1171000330.2620.425.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1171000330.2620.425.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 09, 2007 at 04:52:10PM +1100, Benjamin Herrenschmidt wrote:
> spufs: Fix bitrot of the SPU mmap facility
> 
> It looks like we've had some serious bitrot there mostly due to tracking
> of address_space's of mmap'ed files getting out of sync with the actual
> mmap code. The mfc, mss and psmap were not tracked properly and thus
> not invalidated on context switches (oops !)
> 
> I also removed the various file->f_mapping = inode->i_mapping;
> assignments that were done in the other open() routines since that
> is already done for us by __dentry_open.
> 
> One improvement we might want to do later is to assign the various
> ctx-> fields at mmap time instead of file open/close time so that we
> don't call unmap_mapping_range() on thing that have not been mmap'ed
> 
> Finally, I added some smp_wmb's after assigning the ctx-> fields to make
> sure they are visible to other CPUs. I don't think this is really
> necessary as I suspect locking in the fs layer will make that happen
> anyway but better safe than sorry.


Looks good to me.
