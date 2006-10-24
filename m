Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E4B4467B89
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Oct 2006 12:24:14 +1000 (EST)
Subject: Re: [RFC]: map 4K iommu pages even on 64K largepage systems.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <453D635B.20405@am.sony.com>
References: <20061024002540.GA6360@austin.ibm.com> <453D635B.20405@am.sony.com>
Content-Type: text/plain
Date: Tue, 24 Oct 2006 12:23:59 +1000
Message-Id: <1161656640.10524.527.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> This is a step in the right direction.  Cell allows each device to
> have its own io pagesize, from among those that the io controller
> supports (4k, 64k, 1m,16m).  This limitation of the current iommu
> code that you try to address here has caused me to use platform
> specific dma alloc routines.

Are devices -actually- using different page sizes ? AFAIK, for your
platform, you are using a 4k base page size, thus there is very little
point (in fact, it's more like a problem) to have an IO mapping using
larger page sizes.

In any case, read my reply to Linas, I'm proposing a scheme where each
iommu_table instance could have its own page size, in which case you can
just create a table instance per device.

Ben.
