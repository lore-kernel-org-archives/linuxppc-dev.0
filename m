Return-Path: <dgibson@ozlabs.org>
Date: Tue, 20 Feb 2007 10:46:31 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Subject: Re: [PATCH 0/2] libfdt: problems with real life blobs
Message-ID: <20070219234631.GD17818@localhost.localdomain>
References: <45D9E5D9.6060704@smiths-aerospace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45D9E5D9.6060704@smiths-aerospace.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Feb 19, 2007 at 01:00:57PM -0500, Jerry Van Baren wrote:
> Hi David,
> 
> I've been trying to use your libfdt in u-boot and my first step, get a 
> value from the blob, failed terminally.  After poking about a bit, it 
> appears that your libfdt and Jon Loeliger's dtc (-V 16) disagree with 
> respect to the format of the blob - libfdt won't traverse the path.

That's certainly bad.

> I've created two patches:

Ug.  Damn.  Trouble is, for IBM paranoid procedural reasons, I'm not
really in a position to accept patches for libfdt from outside at
present.  I'm already working on fixing that, but there being a
ponderous bureaucracy involved, it's going to take a little while.

Oh, plus I want to relicense libfdt (so it can be used in non-GPL
firmware), so for that reason also I can't accept random patches at
present.

> 1) Make the libfdt tests use "fdt endian" so that dtc can be used.

That sounds sensible, I was always pretty dubious about using a
different endianness for the framing and content in the tests.

> 2) Create a minimal test tree and compile it with dtc.
> 
> The first patch is clean, the second patch is a bit of a hack job, I did 
> just enough to check this out and confirm/deny my suspicions that libfdt 
> doesn't like the dtc format.  Running the tests on the dtc-compiled blob 
> shows the same problems with traversing paths.
> 
> I think I created the correct tree in test_tree1.dts (I didn't do the 
> truncated node, but that is immaterial for my primary objective) but I 
> could be wrong...
> 
> Supporting using dtc in the long run as well as the assembly-generated 
> blob would be nice so that regression tests can be done on different 
> versions of the blob format (both supported and unsupported) and to make 
> sure libfdt and dtc stay in sync.

Yes, absolutely.  I want to merge libfdt and dtc into a single
package, so they can be used to test each other.  Again, planning to
do that just as soon as I get the bureaucratic hurdles out of the way.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
