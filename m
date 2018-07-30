Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41f8qg6L9jzF12j
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2018 16:31:59 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/mobility: Fix node detach/rename problem
In-Reply-To: <c2fba52a-baac-25fb-c26b-c84b25c3178c@linux.vnet.ibm.com>
References: <c2fba52a-baac-25fb-c26b-c84b25c3178c@linux.vnet.ibm.com>
Date: Mon, 30 Jul 2018 16:31:57 +1000
Message-ID: <8736w1jkte.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Bringmann <mwb@linux.vnet.ibm.com> writes:

> During LPAR migration, the content of the device tree/sysfs may
> be updated including deletion and replacement of nodes in the
> tree.  When nodes are added to the internal node structures, they
> are appended in FIFO order to a list of nodes maintained by the
> OF code APIs.

That hasn't been true for several years. The data structure is an n-ary
tree. What kernel version are you working on?

> When nodes are removed from the device tree, they
> are marked OF_DETACHED, but not actually deleted from the system
> to allow for pointers cached elsewhere in the kernel.  The order
> and content of the entries in the list of nodes is not altered,
> though.

Something is going wrong if this is actually happening.

When the node is detached it should be *detached* from the tree of all
nodes, so it should not be discoverable other than by having an existing
pointer to it.

That's what __of_detach_node() does:

	parent = np->parent;
	if (WARN_ON(!parent))
		return;

	if (parent->child == np)
		parent->child = np->sibling;
	else {
		struct device_node *prevsib;
		for (prevsib = np->parent->child;
		     prevsib->sibling != np;
		     prevsib = prevsib->sibling)
			;
		prevsib->sibling = np->sibling;
	}

ie. the node must already have a NULL parent, and then it is spliced out
of its parent's child list.


Please give us more info so we can work out what's actually happening.

cheers
