Return-Path: <dgibson@ozlabs.org>
Date: Tue, 21 Oct 2008 12:49:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Mike Ditto <mditto@consentry.com>
Subject: Re: device tree variations
Message-ID: <20081021014928.GB3058@yookeroo.seuss>
References: <48F7E1E6.4040701@consentry.com>
	<20081017012604.GA22213@yookeroo.seuss>
	<48F9466D.8060603@consentry.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48F9466D.8060603@consentry.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 17, 2008 at 07:14:05PM -0700, Mike Ditto wrote:
> David Gibson wrote:
> > Deleting the irrelevant parts or picking a device tree to pass to
> > fdt_init() are both reasonable solutions.  libfdt which is included in
> > the bootwrapper has functions for removing unwanted nodes: either
> > fdt_nop_node() or fdt_del_node() will suffice.  There isn't currently
> > a dt_ops hook to call though to those functions though.  You could
> > either add one, or (knowing that your platform always has a flat dt)
> > bypass the dt_ops hooks and call libfdt directly.
> 
> Thanks.  The fdt_del_node approach works pretty nicely.  I added a
> dt_ops hook since fdt is static in libfdt-wrapper.c.
> 
> At first I tried fdt_nop_node, fearing that find_node_by_prop_value()
> and fdt_del_node() would interact badly when deleting in
> mid-traversal,

Ah, yes, it would.

> but it turns out that fdt_nop_node() upsets find_node_by_prop_value()
> anyway.

Oh... it shouldn't, I think that's a bug.  I'll try to look into that
and fix it.

>  Plus, the kernel prints harmless but strange messages when
> there are NOPs in the tree.

We should probably fix that too.

>  So I use fdt_del_node() and rescan from
> the top each time I delete a node and it works fine.

Kind of ugly, but ok.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
