Return-Path: <hollisb@us.ibm.com>
Subject: Re: common flatdevtree code
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17690.64482.319084.61866@cargo.ozlabs.ibm.com>
References: <20060831184020.GA13494@mag.az.mvista.com>
	<17662.17895.852128.729679@cargo.ozlabs.ibm.com>
	<20060907003625.GA15533@mag.az.mvista.com>
	<1157615011.18137.14.camel@diesel>
	<20060907182717.GC4398@mag.az.mvista.com>
	<1157667816.5220.30.camel@basalt.austin.ibm.com>
	<20060908005630.GA9823@mag.az.mvista.com>
	<17665.28367.380866.565218@cargo.ozlabs.ibm.com>
	<20060919194527.GD11361@mag.az.mvista.com>
	<17690.64482.319084.61866@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Wed, 27 Sep 2006 17:55:43 -0500
Message-Id: <1159397743.7584.63.camel@basalt.austin.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-09-28 at 08:32 +1000, Paul Mackerras wrote:
> Here's the latest version of my version of the flatdevtree code...
> 
> I talked to David Gibson about this and he pointed out that there is a
> problem with using a void * to identify nodes (i.e. returned from
> ft_find_device and passed to ft_set_prop etc.).  The problem is that
> if we reallocate the space for the tree, then any void * handles that
> the user of the library has are then invalid.  Perhaps we have to use
> offsets from the beginning of the struct region instead - the offset
> for a node will be stable across changes of the node or any of its
> descendents, at least.

That is a non-obvious requirement and therefore a poor API.

Using offsets instead of pointers barely helps. All pointers break if
you need to realloc space for the tree. Almost all offsets break in the
exact same way (except for the ancestors of a particular node).

This may be a good reason to go back to the
	ft_set_prop("/node/property", value, len);
interface, instead of
	n = ft_find_node("/node");
	ft_set_prop(n, "property", value, len);

-- 
Hollis Blanchard
IBM Linux Technology Center
