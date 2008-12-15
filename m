Return-Path: <gknispel@proformatique.com>
Received: from proformatique.com (web.proformatique.com [91.194.179.68])
	by ozlabs.org (Postfix) with ESMTP id 9040ADDF68
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Dec 2008 11:32:55 +1100 (EST)
Date: Mon, 15 Dec 2008 01:32:51 +0100
From: Guillaume Knispel <gknispel@proformatique.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Fix corruption error in rh_alloc_fixed()
Message-ID: <20081215013251.0359db80@xilun.lan.proformatique.com>
In-Reply-To: <18757.30913.736857.463769@cargo.ozlabs.ibm.com>
References: <20081209152834.1d6ff291@xilun.lan.proformatique.com>
	<493E88B7.5020702@freescale.com>
	<20081209161422.5e289e6c@xilun.lan.proformatique.com>
	<493E8BE2.809@freescale.com>
	<20081214195050.677ba7d1@xilun.lan.proformatique.com>
	<18757.30913.736857.463769@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Tjernlund <joakim.tjernlund@transmode.se>,
	Pantelis Antoniou <pantelis@embeddedalley.com>,
	linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 15 Dec 2008 08:21:05 +1100
Paul Mackerras <paulus@samba.org> wrote:

> Guillaume Knispel writes:
> 
> > On Tue, 09 Dec 2008 09:16:50 -0600
> > Timur Tabi <timur@freescale.com> wrote:
> > 
> > > Guillaume Knispel wrote:
> > > 
> > > > blk = NULL; at the end of the loop is what is done in the more used
> > > > rh_alloc_align(), so for consistency either we change both or we use
> > > > the same construction here.
> > > > I also think that testing for &info->free_list is harder to understand
> > > > because you must have the linked list implementation in your head
> > > > (which a kernel developer should anyway so this is not so important)
> > > 
> > > Fair enough.
> > > 
> > > Acked-by: Timur Tabi <timur@freescale.com>
> > > 
> > 
> > Kumar, can this go into your tree ?
> > (copying the patch under so you have it at hand)
> > 
> > There is an error in rh_alloc_fixed() of the Remote Heap code:
> > If there is at least one free block blk won't be NULL at the end of the
> > search loop, so -ENOMEM won't be returned and the else branch of
> > "if (bs == s || be == e)" will be taken, corrupting the management
> > structures.
> > 
> > Signed-off-by: Guillaume Knispel <gknispel@proformatique.com>
> > ---
> > Fix an error in rh_alloc_fixed() that made allocations succeed when
> > they should fail, and corrupted management structures.
> 
> What's the impact of this?  Can it cause an oops?
> 
> Is it a regression from 2.6.27?  Should we be putting it in 2.6.28?
> 
> Paul.

The problem obviously only affect people that make use of
rh_alloc_fixed(), which is the case when you program an MCC or a QMC
controller of the CPM. Without the patch cpm_muram_alloc_fixed()
succeed when it should not, for example when trying to allocate out of
range areas or already allocated areas, so it is possible that buffer
descriptors or other control structures used by other controllers get
corrupted.

Digging into ooooold Linux (like 2.6.9, I haven't checked before),
the problem seems to always have been present.

Without this patch I experienced oops (sometimes panic, sometimes not)
in various unrelated part (probably an indirect result of either
corruption of rheap management structures or corruption caused by the
CPM using crazy overwritten data) and also initialization of
multi-channel control structures putting other communication
controllers out-of-order.

The only risk I can think off is that it could break some out of tree
kernel space code which worked because of luck and a double error - for
example when doing a single DPRam allocation from offset 0 while
leaving an area reserved at the base of the DPRam. So I think it should
be put in 2.6.28.

Guillaume Knispel
