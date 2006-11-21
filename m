Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0596D67C0A
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 00:45:47 +1100 (EST)
Date: Tue, 21 Nov 2006 14:45:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 7/16] powerpc: add support for ps3 platform
Message-ID: <20061121134529.GA18620@lst.de>
References: <4554DACB.8060809@am.sony.com>
	<17762.59947.937875.546225@cargo.ozlabs.ibm.com>
	<20061121132253.GA17530@lst.de> <200611211442.31667.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200611211442.31667.arnd@arndb.de>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Olof Johansson <olof@lixom.net>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 21, 2006 at 02:42:30PM +0100, Arnd Bergmann wrote:
> On Tuesday 21 November 2006 14:22, Christoph Hellwig wrote:
> > The whole port is hypervisor-specific. ?It should be called ps3hv or
> > sonyhv (in case the plan for more hardware that's crippled by this
> > hypervisor) 
> 
> The hypervisor has a name, it's called 'lv1', and the port already
> uses that identifier for the low-level interfaces.
> If the platform is named after the hypervisor, we should not make up
> a new name but use the one that is already there.

Actually that makes even more sense, yes.

> > ps3 should be left for a bare metal port that people may or may not do 
> 
> If there will ever be a native port, that will not need its platform
> directory but can simply go into into common platforms/cell/ and sysdev
> directories, with a small file for the ppc_md instance. All the interesting
> files (page table, iommu, interrupt handling) would be shared with native
> ports to different hardware.

I guess so, yes.  We'd still add a CONFIG_PS3 for it to not bloat
kernels that don't want support.
