Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 62813DDEFA
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Feb 2009 15:33:33 +1100 (EST)
Subject: Re: PCI reading without endian conversion
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ira Snyder <iws@ovro.caltech.edu>
In-Reply-To: <20090220235054.GA27349@ovro.caltech.edu>
References: <b5e2fc790902201057of113946yea9ccc7405e31926@mail.gmail.com>
	<20090220191108.GA21163@ovro.caltech.edu>
	<b5e2fc790902201205t4bd03373w7e7624fce60f5eb0@mail.gmail.com>
	<20090220210744.GB21163@ovro.caltech.edu>
	<b5e2fc790902201356v7e01b17al3ecd7e06ac59af3d@mail.gmail.com>
	<20090220235054.GA27349@ovro.caltech.edu>
Content-Type: text/plain
Date: Sat, 21 Feb 2009 15:33:17 +1100
Message-Id: <1235190797.8805.202.camel@pasglop>
Mime-Version: 1.0
Cc: PowerPC dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > Am I correct in saying that cpu_to_le32 and le32_to_cpu are the
> > functions/macros I need to use to do byte swapping to make everything
> > go little endian (and back again when I read them back in the kernel)?
> > 
> > Or is there some cleverer way already implemented in the kernel?
> > 
> 
> I would say that the __raw_readl() reads in cpu order. If you wanted to
> convert that to le32, you'd use cpu_to_le32().

Beware that __raw_* forms also don't have memory barriers.

In general, you know what byte order your device uses (which is often
little endian) and you use the appropriate ioread32{be}. Now, for
userspace, you simply need to mimmic those accessors.

Ben.
