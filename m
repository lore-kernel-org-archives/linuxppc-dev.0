Return-Path: <James.Bottomley@SteelEye.com>
Received: from hancock.sc.steeleye.com (hancock.steeleye.com [71.30.118.248])
	by ozlabs.org (Postfix) with ESMTP id 39153DDF0A
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 23:34:32 +1000 (EST)
Subject: Re: [patch 5/6] ps3: BD/DVD/CD-ROM Storage Driver
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <Pine.LNX.4.62.0707131518120.18802@pademelon.sonytel.be>
References: <20070704132212.726923000@pademelon.sonytel.be>
	<20070704132346.591348000@pademelon.sonytel.be>
	<1184331741.3402.13.camel@localhost.localdomain>
	<20070713130508.GQ5328@kernel.dk>
	<Pine.LNX.4.62.0707131518120.18802@pademelon.sonytel.be>
Content-Type: text/plain
Date: Fri, 13 Jul 2007 09:34:30 -0400
Message-Id: <1184333670.3402.17.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alessandro Rubini <rubini@vision.unipv.it>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Jens Axboe <jens.axboe@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-07-13 at 15:25 +0200, Geert Uytterhoeven wrote:
> kmap() just returns page_address() on ppc64, as there's no highmem.
> kunmap() is a no-op.

> So technically I could just use page_address() directly, but Christoph
> wanted
> me to keep the kmap()/kunmap() sequence because it's considered a good
> practice.

The point isn't what kmap and kunmap do ... it's the addresses they
return.  By and large, a kernel virtual address for a page is different
from the user virtual address.  If the cache is virtually indexed you
get different cache lines for the same page ... and that sets you up
with aliases you need to resolve.  parisc is the same ... our
kmap/kunmap are nops as well, but our kernel virtual addresses are still
different from the user virtual ones.

James
