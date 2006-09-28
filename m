Return-Path: <mgreer@mvista.com>
Date: Thu, 28 Sep 2006 12:34:43 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: common flatdevtree code
Message-ID: <20060928193443.GA993@mag.az.mvista.com>
References: <20060907003625.GA15533@mag.az.mvista.com>
	<1157615011.18137.14.camel@diesel>
	<20060907182717.GC4398@mag.az.mvista.com>
	<1157667816.5220.30.camel@basalt.austin.ibm.com>
	<20060908005630.GA9823@mag.az.mvista.com>
	<17665.28367.380866.565218@cargo.ozlabs.ibm.com>
	<20060919194527.GD11361@mag.az.mvista.com>
	<17690.64482.319084.61866@cargo.ozlabs.ibm.com>
	<6897081F-DDAC-462A-8D4D-EE613231CA4B@kernel.crashing.org>
	<1159401139.7584.82.camel@basalt.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1159401139.7584.82.camel@basalt.austin.ibm.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 27, 2006 at 06:52:19PM -0500, Hollis Blanchard wrote:
> On Thu, 2006-09-28 at 01:41 +0200, Segher Boessenkool wrote:
> > > I talked to David Gibson about this and he pointed out that there is a
> > > problem with using a void * to identify nodes (i.e. returned from
> > > ft_find_device and passed to ft_set_prop etc.).  The problem is that
> > > if we reallocate the space for the tree, then any void * handles that
> > > the user of the library has are then invalid.  Perhaps we have to use
> > > offsets from the beginning of the struct region instead - the offset
> > > for a node will be stable across changes of the node or any of its
> > > descendents, at least.
> > 
> > Or unpack the tree before you operate on it.  You can pack it
> > again later if you need to pass it as a flat tree again (or the
> > bootwrapper could implement a real OF client interface, which
> > is useful for many more things!)
> > 
> > A flat contiguous blob of bytes is convenient to pass around,
> > but not such a great data structure for basically anything else ;-)
> 
> I agree; I think this data structure's design is explicitly static, and
> now we're trying to dynamically edit it.
> 
> We essentially need to do unpack/pack now whenever the size of the
> structure changes (e.g. changing a property size, adding or removing
> anything). Making that explicit (and one-time) might be a good idea:
>         tree = ft_unpack(blob);
>         n = ft_find_node(tree, "/node");
>         ft_set_prop(n, "property", value, len);
>         ...
>         blob = ft_pack(tree);

FWIW, this makes a lot of sense to me.

Mark
