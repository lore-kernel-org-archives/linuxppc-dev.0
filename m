Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2CB2D6893D
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Jan 2006 07:56:25 +1100 (EST)
Subject: Re: [PATCH] Remove powermac support from ARCH=ppc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17352.57423.119068.737164@cargo.ozlabs.ibm.com>
References: <17352.57423.119068.737164@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Sun, 15 Jan 2006 07:56:16 +1100
Message-Id: <1137272177.4855.6.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-01-14 at 22:28 +1100, Paul Mackerras wrote:
> This patch makes it possible to build kernels for PReP and/or CHRP
> with ARCH=ppc by removing the (non-building) powermac support.
> It's now also possible to select PReP and CHRP independently.
> Powermac users should now build with ARCH=powerpc instead of
> ARCH=ppc.

Any reason not to remove CHRP too ?

> This patch doesn't actually remove all the powermac files under
> arch/ppc, but they could go.

OK, we can do that in a second step.

> This means, BTW, that it will no longer be possible to build 32-bit
> kernels for Apple G5 machines.  Also, miboot users (are there any
> still?) are out of luck until I move the miboot stuff over to
> arch/powerpc/boot.

32 bits kernel on g5 were unuspported for ages and I announced the death
of that support long enough in advance. miboot works with plain vmlinux,
the only thing those miboot images are useful for is if you need a
compressed image due to lack of space and/or if you need an embedded
initrd. Hopefully, that should be trivial to add back though.

Ben.
