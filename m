Return-Path: <SRS0+0ce65aaf38edc7aeca5c+982+infradead.org+hch@pentafluge.srs.infradead.org>
Date: Tue, 2 May 2006 14:45:36 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH 11/13] cell: split out board specific files
Message-ID: <20060502134536.GB26704@infradead.org>
References: <20060429232812.825714000@localhost.localdomain>
	<20060429233922.167124000@localhost.localdomain>
	<F989FA67-91B5-493B-9A12-D02C3C14A984@kernel.crashing.org>
	<445690F7.5050605@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <445690F7.5050605@am.sony.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	cbe-oss-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 01, 2006 at 03:51:35PM -0700, Geoff Levand wrote:
> makefiles don't have as rich a set of logical ops as the
> config files.  Its easy to express 'build A if B', but not
> so easy to do 'build A if not C'.  To make this work
> cleanly I made PPC_CELL denote !SOME_HYPERVISOR_THING,
> so I can have constructions like this in the makefile:
> 
> obj-$(CONFIG_PPC_CELL)	+= ...
> 
> I also got rid of SPUFS_PRIV1_MMIO, since SPUFS_PRIV1_MMIO
> just meant spufs with !SOME_HYPERVISOR_THING.

The Kconfig files has lots of nice operators.

Anyway, until we actually have the cell common hypervisor interface
out in the public adding any support for it in Kconfig or the
Makefile is completely pointless, and a patch like this even when
done correctly shouldn't go in.


> Split the Cell BPA support into generic and platform
> dependant parts.
> 
> Creates new config variable CONFIG_PPC_IBM_CELL_BLADE.

That's wrong.  Most of these files will be needed to support
the PS3 when running on bare hardware.  The right option will
be CELL_SPIDER_HARDWARE, which is right now the only cell
hardware generation supported.  It'll become meaningfull when
adding axon support.
