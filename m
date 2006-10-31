Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D78ED67BBC
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Nov 2006 01:22:18 +1100 (EST)
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id k9VEMDWv010188
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Oct 2006 15:22:13 +0100
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id k9VEMDhB010186
	for linuxppc-dev@ozlabs.org; Tue, 31 Oct 2006 15:22:13 +0100
Date: Tue, 31 Oct 2006 15:22:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: linuxppc-dev@ozlabs.org
Subject: build problems with powerpc allmodconfig
Message-ID: <20061031142213.GA9275@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When trying to build an allmodconfig kernel on powerpc I run into
three errors, all related to the integeration of iseries support
into the main kernel image:

 - vicocons.c can't be compiled at the same time as CONFIG_VT, but
   instead of expressing that in the Kconfig it errors out in that
   case.  This should at least be a Kconfig dependency, but long
   term viocons must work at the same time as the normal vt code
   to have a single ppc64 image
 - vioscsi linkage fails because iseries_vscsi.c and rpa_vscsi.c.
   This needs some trivial indirection via function vectors, but
   how can we find out which one to use from the driver?  Both
   seem to look the same in the device tree
 - arch/powerpc/platforms/iseries/setup.c references rd_size
   when CONFIG_INITRD is set.  But rd_size is defined drivers/block/rd.c
   which can me modular (and is selected by CONFIG_BLK_DEV_RAM).
   This same bug is repeated in the arm amd arm26 code, but except
   for those no one outside of rd.c uses this symbol.  I don't see
   a point why arch code should modify this as it's already big enough.
