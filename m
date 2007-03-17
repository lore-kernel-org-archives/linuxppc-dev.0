Return-Path: <dgibson@ozlabs.org>
Date: Sat, 17 Mar 2007 23:59:05 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH 6/15] zImage: Add more flexible gunzip convenience
	functions
Message-ID: <20070317125905.GA5268@localhost.localdomain>
References: <20070305032452.4DCDBDDF1B@ozlabs.org>
	<45FAC4A2.4060207@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45FAC4A2.4060207@am.sony.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 16, 2007 at 09:24:02AM -0700, Geoff Levand wrote:
> David Gibson wrote:
> > This patch adds a new set of more flexible convenience wrappers around
> > zlib, moving them to their own file, gunzip_util.c, in the process.
> > These wrappers allow decompressing sections of the compressed image to
> > different locations.  In addition, they transparently handle
> > uncompressed data, avoiding special case code to handle uncompressed
> > vmlinux images.
> 
> Hi.
> 
> I was waiting for the zimage churn to settle before looking into this
> change, but I though I would let you know so you can keep it in mind
> if you do any work here.
> 
> As I mentioned in another mail, the PS3's 1st stage loader (in the
> hypervisor) supports loading a gzipped binary memory image from flash.
> So for Linux, that would be a gzipped zImage.  Since the entire zImage
> is uncompressed by the loader, there is no need to have the kernel image
> compressed on its own, nor to include the zlib code in the wrapper.
> 
> Here is a functional expression of what we have now, and what would
> be ideal:
> 
> zImage.gz = gzip(wrapper bits + zlib + gzip(vmlinx) + dtb)
> 
> zImage.gz = gzip(wrapper bits + vmlinx + dtb)

Ok.  The only bit of that we don't do already is omitting zlib from an
zImage with a decompressed kernel.  I imagine that's a fairly marginal
gain, and slightly fiddly to achieve, but we can probably arrange it
if we want.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
