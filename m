Return-Path: <tmarri@apm.com>
Received: from exprod5og101.obsmtp.com (exprod5og101.obsmtp.com [64.18.0.141])
	by ozlabs.org (Postfix) with SMTP id EACF1B711C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Feb 2011 05:45:51 +1100 (EST)
Received: by mail-vw0-f53.google.com with SMTP id 8so3338669vws.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 07 Feb 2011 10:45:48 -0800 (PST)
From: Tirumala Marri <tmarri@apm.com>
References: <20110126191734.5dff9641@desktopvm.lvknet>
	<AE90C24D6B3A694183C094C60CF0A2F6D8AC2C@saturn3.aculab.com>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AC2C@saturn3.aculab.com>
MIME-Version: 1.0
Date: Mon, 7 Feb 2011 10:45:45 -0800
Message-ID: <0a93b035a8cae3d1bcc7dae9f31e3adc@mail.gmail.com>
Subject: RE: [PATCH V8 03/10] USB/ppc4xx: Add Synopsys DWC OTG CoreInterface
	Layer
To: David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

-----Original Message-----
From: linuxppc-dev-bounces+tmarri=amcc.com@lists.ozlabs.org
[mailto:linuxppc-dev-bounces+tmarri=amcc.com@lists.ozlabs.org] On Behalf
Of David Laight
Sent: Wednesday, January 26, 2011 8:35 AM
Cc: linux-usb@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
Subject: RE: [PATCH V8 03/10] USB/ppc4xx: Add Synopsys DWC OTG
CoreInterface Layer


> Also in_le32/out_le32/in_be32/out_be32 are
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

[marri] Initial version of DWC-IP did not have feature to swap endianness.
Whereas next versions have it.
