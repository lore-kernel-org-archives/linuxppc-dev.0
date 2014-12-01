Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8CC0F1A05EA
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Dec 2014 16:25:06 +1100 (AEDT)
Date: Mon, 1 Dec 2014 16:24:48 +1100
From: Paul Mackerras <paulus@samba.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2] slab: Fix nodeid bounds check for non-contiguous node
 IDs
Message-ID: <20141201052448.GC11234@drongo>
References: <20141201042844.GB11234@drongo>
 <1417410134.16178.2.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1417410134.16178.2.camel@concordia>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 01, 2014 at 04:02:14PM +1100, Michael Ellerman wrote:
> On Mon, 2014-12-01 at 15:28 +1100, Paul Mackerras wrote:
> > The bounds check for nodeid in ____cache_alloc_node gives false
> > positives on machines where the node IDs are not contiguous, leading
> > to a panic at boot time.  For example, on a POWER8 machine the node
> > IDs are typically 0, 1, 16 and 17.  This means that num_online_nodes()
> > returns 4, so when ____cache_alloc_node is called with nodeid = 16 the
> > VM_BUG_ON triggers, like this:
> ...
> > 
> > To fix this, we instead compare the nodeid with MAX_NUMNODES, and
> > additionally make sure it isn't negative (since nodeid is an int).
> > The check is there mainly to protect the array dereference in the
> > get_node() call in the next line, and the array being dereferenced is
> > of size MAX_NUMNODES.  If the nodeid is in range but invalid (for
> > example if the node is off-line), the BUG_ON in the next line will
> > catch that.
> 
> When did this break? How come we only just noticed?

Commit 14e50c6a9bc2, which went into 3.10-rc1.

You'll only notice if you have CONFIG_SLAB=y and CONFIG_DEBUG_VM=y
and you're running on a machine with discontiguous node IDs.

> Also needs:
> 
> Cc: stable@vger.kernel.org

It does.  I remembered that a minute after I sent the patch.

Paul.
