Return-Path: <dgibson@ozlabs.org>
Date: Wed, 14 Feb 2007 15:43:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 15/19] bootwrapper: Add initrd information to the device
	tree in ft_finalize().
Message-ID: <20070214044335.GA12402@localhost.localdomain>
References: <20070207230017.GA3758@ld0162-tx32.am.freescale.net>
	<20070207230140.GO3849@ld0162-tx32.am.freescale.net>
	<20070209230207.GA12035@mag.az.mvista.com>
	<45D098E5.3090109@freescale.com>
	<20070213042937.GC5345@localhost.localdomain>
	<20070213160723.GC24815@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070213160723.GC24815@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 13, 2007 at 10:07:23AM -0600, Scott Wood wrote:
> On Tue, Feb 13, 2007 at 03:29:37PM +1100, David Gibson wrote:
> > Why is cuboot's malloc() allocating the flat tree in a place that's in
> > danger of being clobbered by the kernel in the first place?
> 
> As the comment in cuboot.c explains, there's not enough room to do it any
> other way and still run on boards with only 8MiB of RAM -- the dts has to
> go above the wrapper image, and the "uncompressed" kernel has to go
> below, but the same heap is used for both.  I believe there are some 8xx
> boards out there with only this much; even if not, 8xx currently only
> maps 8MiB by default.  8xx isn't supported by this patchset, but I'd like
> to support it eventually.

Hrm, ok.  You may have seen in my Ebony patch series there's a patch
adding a bootwrapper platform_ops hook giving the address at which to
load the kernel.  At present the wrapper still decompresses the kernel
to heap-allocated space, then moves it to the specified address,
however I'm hoping to write an improved version which decompresses
directly to the final location.  That should address your problem
here, I believe.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
