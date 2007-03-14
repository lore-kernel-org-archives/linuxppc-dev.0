Return-Path: <dgibson@ozlabs.org>
Date: Thu, 15 Mar 2007 10:07:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [dtc] Add support for flat device tree format version 17
Message-ID: <20070314230712.GA12573@localhost.localdomain>
References: <20070313062240.GA22737@localhost.localdomain>
	<45F863DF.5050709@freescale.com>
	<45F864E8.40501@smiths-aerospace.com>
	<45F8671D.1010905@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45F8671D.1010905@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 14, 2007 at 04:20:29PM -0500, Timur Tabi wrote:
> Jerry Van Baren wrote:
> 
> > The best solution, which I'm making progress on but slowly, is to pull 
> > David Gibson's libfdt utilities into u-boot and use them to manipulate 
> > the tree.  
> 
> I don't think that will help, because the problem is how do you
> update a device tree that you don't know everything about?
> 
>  > I very much want v17 blobs because that removes my
> > "write-in-place" restrictions on changing the properties.
> 
> Another idea which just came to light is to have the compatibility
> field be only useful to code that just *reads* the DTB.  Any code
> that *writes* the DTB should look it.

Yes, that's always been true for the compatibility version field
(version 3 had exactly the same problem, for example).  Code which
writes the dtb has to understand everything it writes.  Or to put it
another way, the 'version' field records the version of the writer,
'last_comp_version' field records the version of the reader.

But a program which manipulates a tree, like u-boot is both a reader
and a writer.  It *can* take in a higher compatible version and alter
it as long as it downgrades the version on its output to the highest
thing it fully understands.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
