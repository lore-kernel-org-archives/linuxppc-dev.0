Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9B48CDDF11
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 08:48:10 +1000 (EST)
Message-ID: <466739A3.1070201@freescale.com>
Date: Wed, 06 Jun 2007 17:48:03 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: MPC8349ea Random Device Generator driver
References: <BAY122-F18923A7AA6D3A4D96A360085200@phx.gbl>
	<46672DB4.80504@freescale.com> <20070606220913.GA27820@lixom.net>
	<46673009.6000109@freescale.com> <20070606222456.GA28225@lixom.net>
In-Reply-To: <20070606222456.GA28225@lixom.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: linuxppc-dev@ozlabs.org, sl@powerlinux.fr,
	Philippe Lachenal <philippe.lachenal@hotmail.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:

> 	typedef __u16 __bitwise __le16;
> 	typedef __u16 __bitwise __be16;
> 	typedef __u32 __bitwise __le32;
> 	typedef __u32 __bitwise __be32;
> 	typedef __u64 __bitwise __le64;
> 	typedef __u64 __bitwise __be64;

Wait a minute - why are all the endian-specific types __bitwise?

What if I have a 32-bit MMIO register that just contains a number, but it has to be 
written in big-endian?  I can't use __be32 to designate it.

For instance, I was going to do this for a new memory-mapped device I'm working with:

struct ccsr_dma {
	u8 res0[0x100];
	struct {
		__be32 mr;	/* x00 Mode register */
		__be32 sr;	/* x04 Status register */
		__be32 eclndar; /* x08 Current link descriptor extended address register */
		__be32 clndar;	/* x0C Current link descriptor address register */
		__be32 satr;	/* x10 Source attributes register */
		__be32 sar;	/* x14 Source address register */
...
		u8 res2[0x38];
	} channel[4];
}

The SAR register is defined as:

Bits	Name	Description
0–31	SAD	Source address. This register contains the low-order bits of the 36-bit source 
address of the DMA transfer.  The contents are updated after every DMA write operation 
unless the final stride of a striding operation is less than the stride size, in which 
case it remains equal to the address from which the last stride began.

In other words, the SAR register is just one number, but it must be written as a single 
big-endian number.  So is __be32 the wrong type?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
