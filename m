Return-Path: <dgibson@ozlabs.org>
Date: Thu, 15 Mar 2007 12:38:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jerry Van Baren <gerald.vanbaren@comcast.net>
Subject: Re: [dtc] Add support for flat device tree format version 17
Message-ID: <20070315013833.GA14061@localhost.localdomain>
References: <20070313062240.GA22737@localhost.localdomain>
	<45F863DF.5050709@freescale.com>
	<45F864E8.40501@smiths-aerospace.com>
	<45F86C25.1070301@freescale.com> <45F8A229.7040602@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45F8A229.7040602@comcast.net>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 14, 2007 at 09:32:25PM -0400, Jerry Van Baren wrote:
> Timur Tabi wrote:
> > Jerry Van Baren wrote:
> > 
> >> The best solution, which I'm making progress on but slowly, is to pull 
> >> David Gibson's libfdt utilities into u-boot and use them to manipulate 
> >> the tree.  I very much want v17 blobs because that removes my 
> >> "write-in-place" restrictions on changing the properties.
> > 
> > Here's an alternative idea I got from a colleage (Scott Wood).
> > 
> > Allow U-Boot to accept V17 DTBs.  When it modifies the DTB, it should change the version 
> > to 16, since that's the only version that it really knows.  U-Boot currently does not have 
> > the infrastructure to support multiple DTB versions.
> > 
> > The DTB that U-Boot passes to the kernel will say V16, but it will have the extra length 
> > field in the header.  Therefore, we need to update the documentation to say that 
> > compatibility implies that any DTB will still be able to read the DTB if the DTB version 
> > number has been changed to another compatible version.  So if your DTB is V17, and it has 
> > V17 data, any code that assumes a V16 DTB should still be able to read it.  That seems 
> > obvious, but is should be documented.
> 
> Actually, I believe that is how the existing code works: it opens the 
> original blob and copies it to a newly created dft.  It then augments 
> the new dft with a "chosen" node and optionally additional nodes (bd_t, 
> env variables) and passes the new dft blob to linux.  Theoretically, the 
> existing code will read a v17 blob and create a new v16 blob from it 
> (without the additional v17 length field - the header would be created, 
> not copied).
> 
> Trivia: the current code is kinda dumb about it: if the original blob 
> had a "chosen" node, the code *adds another* "chosen" node.
> 
> Back to libdft: with a v16 blob, libdft has to either modify in place 
> (no size change) or you have to create a new blob and copy the original 
> data over (like the existing code).  With the v17 blob, libdft is able 
> to expand and contract the contents of the blob (with limitations, I'm 
> sure).

In fact, with a v16 blob, libfdt is suppose to allow expansion and
contraction by first converting it to a v17 blob.  I just haven't
implemented that yet.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
