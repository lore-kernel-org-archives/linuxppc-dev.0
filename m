Return-Path: <R65777@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0561CB6F9F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2012 10:46:26 +1000 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: David Miller <davem@davemloft.net>, "benh@kernel.crashing.org"
 <benh@kernel.crashing.org>, Andrea Arcangeli <aarcange@redhat.com>
Subject: RE: [PATCH] powerpc: Fix assmption of end_of_DRAM() returns end
 address
Date: Wed, 6 Jun 2012 00:46:17 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D03D68F08@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1338904504-2750-1-git-send-email-bharat.bhushan@freescale.com>
 <1338934659.7150.113.camel@pasglop>
 <20120605.152058.828742127223799137.davem@davemloft.net>
In-Reply-To: <20120605.152058.828742127223799137.davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: David Miller [mailto:davem@davemloft.net]
> Sent: Wednesday, June 06, 2012 3:51 AM
> To: benh@kernel.crashing.org
> Cc: Bhushan Bharat-R65777; linuxppc-dev@lists.ozlabs.org; linux-
> kernel@vger.kernel.org; galak@kernel.crashing.org; Bhushan Bharat-R65777
> Subject: Re: [PATCH] powerpc: Fix assmption of end_of_DRAM() returns end =
address
>=20
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Wed, 06 Jun 2012 08:17:39 +1000
>=20
> > On Tue, 2012-06-05 at 19:25 +0530, Bharat Bhushan wrote:
> >> memblock_end_of_DRAM() returns end_address + 1, not end address.
> >> While some code assumes that it returns end address.
> >
> > Shouldn't we instead fix it the other way around ? IE, make
> > memblock_end_of_DRAM() does what the name implies, which is to return
> > the last byte of DRAM, and fix the -other- callers not to make bad
> > assumptions ?
>=20
> That was my impression too when I saw this patch.

Initially I also intended to do so. I initiated a email on linux-mm@  subje=
ct "memblock_end_of_DRAM()  return end address + 1" and the only response I=
 received from Andrea was:

"
It's normal that "end" means "first byte offset out of the range". End =3D =
not ok.
end =3D start+size.
This is true for vm_end too. So it's better to keep it that way.
My suggestion is to just fix point 1 below and audit the rest :)
"

Thanks
-Bharat
