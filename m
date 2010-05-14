Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A9D28B7E45
	for <linuxppc-dev@ozlabs.org>; Fri, 14 May 2010 13:42:43 +1000 (EST)
Subject: RE: [PATCH] pte_fsl_booke: fix instruction TLB error permission check
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Liu Dave-R63238 <r63238@freescale.com>
In-Reply-To: <D7CCA83BB0796C49BC0BB53B6AB12089B974F9@zch01exm21.fsl.freescale.net>
References: <1273221514-8683-1-git-send-email-leoli@freescale.com>
	<0710E9DF-66DF-4D24-95DE-A04E6D869826@kernel.crashing.org>
	<D7CCA83BB0796C49BC0BB53B6AB12089B974F9@zch01exm21.fsl.freescale.net>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 14 May 2010 13:42:34 +1000
Message-ID: <1273808554.21352.494.camel@pasglop>
Mime-Version: 1.0
Cc: Jin Qing-B24347 <B24347@freescale.com>, linuxppc-dev@ozlabs.org,
	Li Yang-R58472 <R58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-05-14 at 08:53 +0800, Liu Dave-R63238 wrote:
> > I've updated the commit message to be a bit more clear on why 
> > we need to do this.
> 
> I'm curious why the _PAGE_EXEC have different definition in pte-book3e.h
> and pte-fsl-booke.h?
> 
> It is UX permission in pte-book3e, but is SX permission in
> pte-fsl-booke.h.

Oh well, there's a whole history here :-)

I'm not 100% sure of the "old" fsl-booke, but pte-book3e uses UX since
that's what _PAGE_EXEC really represents from a kernel standpoint,
user-execute.

On book3e, we need to account for the HW tablewalk, which means that the
PTE can be loaded as-is by the HW. We thus don't get a chance to test
whether we are user or supervisor or change the bits accordingly. We
thus need _PAGE_EXEC to fall right into UX since that's really what the
kernel manipulates it for.

It also means that user pages will not get execute permission in
supervisor mode which is a good thing :-)

For kernel-execute, we have a specific permission, which should be
obtained via PAGE_KERNEL_EXEC in vmalloc_exec().

Cheers,
Ben.
