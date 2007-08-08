Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0E2B8DDE30
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Aug 2007 02:55:28 +1000 (EST)
Message-ID: <46B9F57A.9070604@freescale.com>
Date: Wed, 08 Aug 2007 11:55:22 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Yoni Levin <yoni.l@slyde-tech.com>
Subject: Re: how the bytes ordered in mpc8313
References: <CE785D12544843B49C5D1315CAE61C23.MAI@mail.livedns.co.il>
In-Reply-To: <CE785D12544843B49C5D1315CAE61C23.MAI@mail.livedns.co.il>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Yoni Levin wrote:
> I have mpc83xx,
> 
> I saw that I need to use swab32 to any read\write operation from registers,

BTW, you should be using in/out_le32() (or for PCI MMIO, readl/writel) 
rather than swab32().  This will be more efficient since it can use the 
lwbrx/stwbrx instructions, and it will keep working even if the code is 
run little-endian.

-Scott
