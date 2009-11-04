Return-Path: <dgibson@ozlabs.org>
Date: Wed, 4 Nov 2009 14:22:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Filtering bits in set_pte_at()
Message-ID: <20091104032242.GC27772@yookeroo.seuss>
References: <1256957081.6372.344.camel@pasglop>
	<Pine.LNX.4.64.0911021256330.32400@sister.anvils>
	<1257200367.7907.50.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1257200367.7907.50.camel@pasglop>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
	Hugh Dickins <hugh.dickins@tiscali.co.uk>, linuxppc-dev@lists.ozlabs.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 03, 2009 at 09:19:27AM +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2009-11-02 at 13:27 +0000, Hugh Dickins wrote:
> > On Sat, 31 Oct 2009, Benjamin Herrenschmidt wrote:
> > 
> > > Hi folks !
> > > 
> > > So I have a little problem on powerpc ... :-)
> > 
> > Thanks a lot for running this by us.
> 
> Heh, I though you may have been bored :-)
> 
> > I've not looked to see if there are more such issues in arch/powerpc
> > itself, but those instances you mention are the only ones I managed
> > to find: uses of update_mmu_cache() and that hugetlb_cow() one.
> 
> Right, that's all I spotted so far
> 
> > The hugetlb_cow() one involves not set_pte_at() but set_huge_pte_at(),
> > so you'd want to change that too?  And presumably set_pte_at_notify()?
> > It all seems a lot of tedium, when so very few places are interested
> > in the pte after they've set it.
> 
> We need to change set_huge_pte_at() too. Currently, David fixed the
> problem in a local tree by making hugetlb_cow() re-read the PTE . 

Well, actually I have another cleanup patch in the queue which makes
set_huge_pte_at() equal to set_pte_at() on powerpc, and I was using
that on the tree where this problem became apparent.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
