Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/3] spufs: remove need for struct page for SPEs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20070207142112.e7856c3f.akpm@linux-foundation.org>
References: <1170823850.450936.293648942401.qpush@grosgo>
	<20070207045055.295F3DDE46@ozlabs.org>
	<20070207142112.e7856c3f.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Thu, 08 Feb 2007 10:15:51 +1100
Message-Id: <1170890152.2620.313.camel@localhost.localdomain>
Mime-Version: 1.0
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

On Wed, 2007-02-07 at 14:21 -0800, Andrew Morton wrote:
> On Wed, 07 Feb 2007 15:50:52 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > This patch removes the need for struct page for SPE local store
> > and registers from spufs. It also makes the locking much more
> > obvious and no longer relying on the truncate logic black magic
> > for protecting against races between unmap_mapping_range() and
> > new pages faulted in. It does so by switching to a nopfn() handler
> > and using the new vm_insert_pfn() to setup the PTEs itself while
> > holding a lock on the SPE.
> 
> Some of this patch seems to already be in Paul's tree.  Or something.
> I'll duck this patch.

Yeah, the vm_insert_pfn from nick and my NOPFN_REFAULT are in -mm
already (though not via paulus tree).

Only the 3rd patch in the serie is "new". Duck it for now, I posted it
mostly for review/comments, if it goes it, it will go through Paulus
though I will need Nick's vm_insert_pfn and and my NOPFN_REFAULT in
first and that's where you get involved :-)

Ben.
