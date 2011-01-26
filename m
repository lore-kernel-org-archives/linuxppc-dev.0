Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id 5344BB7103
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Jan 2011 03:44:02 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP
	id 32231-04 for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 26 Jan 2011 16:37:14 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH V8 03/10] USB/ppc4xx: Add Synopsys DWC OTG CoreInterface
	Layer
Date: Wed, 26 Jan 2011 16:35:05 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AC2C@saturn3.aculab.com>
In-Reply-To: <20110126191734.5dff9641@desktopvm.lvknet>
From: "David Laight" <David.Laight@ACULAB.COM>
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> Also in_le32/out_le32/in_be32/out_be32 are=20
> architecture-specific AFAIK.

Isn't the whole patch architecture-specific ?

> I'd suggest using readl/writel for LE ops and
> __be32_to_cpu(__raw_readl(addr))/__raw_writel(__cpu_to_be32(b),addr)
> for BE ops.

Since the ppc doesn't have a byteswap instruction (and the LE
memory transfers might even be slow!) you really don't want to
be doing software byteswap.

Not to mention the horrific synchronistion instructions
that in_le32() and out_le32() actually contain.

I didn't find __raw_readl() when I was looking for asm
patterns that byteswapped memory transfers.

I did find st_le32() and ld_le32() in arch/powerpc/include/asm/swab.h
but that file is actually quite difficult to #include because
there is another swab.h that gets included instead.

	David
