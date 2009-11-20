Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E26ECB6EFE
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Nov 2009 20:04:01 +1100 (EST)
Subject: RE: [RFC] powerpc/mm: honor O_SYNC flag for memory map
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Li Yang-R58472 <r58472@freescale.com>
In-Reply-To: <3A45394FD742FA419B760BB8D398F9EDCBC1F2@zch01exm26.fsl.freescale.net>
References: <1258441832-20133-1-git-send-email-leoli@freescale.com>
	<8543954E-619A-4A78-A934-CDC326027FD2@kernel.crashing.org>
	<3A45394FD742FA419B760BB8D398F9EDCBC1F2@zch01exm26.fsl.freescale.net>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 20 Nov 2009 20:03:53 +1100
Message-ID: <1258707833.2140.865.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-11-20 at 11:00 +0800, Li Yang-R58472 wrote:
> Because there is no way to set mapped memory as cacheable if the
> memory
> is not managed by Linux kernel.  While, it's not rare in real system
> to
> allocate some dedicated memory to a certain application which is not
> managed by kernel and then mmap'ed the memory to the application.  The
> memory should be cacheable but we can't map it to be cacheable due to
> this intelligent setting.  And it is a big hit to the performance.
> Moreover, the standard O_SYNC flag suggest that user has the control
> over cacheablity, but actually we had not.

You need to be a bit more careful tho. You must not allow RAM managed by
the kernel to be mapped non-cachable.

Cheers,
Ben.
