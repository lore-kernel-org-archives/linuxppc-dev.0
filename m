Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8B90ADDF6B
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 06:40:27 +1000 (EST)
Message-ID: <4638F734.2040809@freescale.com>
Date: Wed, 02 May 2007 15:40:20 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] gianfar: Add I/O barriers when touching buffer
	descriptor ownership.
References: <20070502195712.GA16541@ld0162-tx32.am.freescale.net>
	<F1B250DD-A472-470F-B3D0-EBB2F042E454@kernel.crashing.org>
	<4638F0C4.2000406@freescale.com>
	<FA9554A4-5A7D-4E03-BE28-C4B6B80D9DB9@kernel.crashing.org>
In-Reply-To: <FA9554A4-5A7D-4E03-BE28-C4B6B80D9DB9@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: netdev@vger.kernel.org, jgarzik@pobox.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> On May 2, 2007, at 3:12 PM, Scott Wood wrote:
>> wmb() is a sync, smp_wmb() is an eieio.  Andy told me he would not  
>> accept a sync in those spots.
> 
> 
> Sorry, was looking at the iobarrier code.
> 
>> And the driver is already ppc-specific; it uses in/out_be32.
> 
> 
> True, but its hidden behind the gfar_read/write accessors.
> 
> Your change is a bit more blatant.

Well, Segher doesn't want me to use iobarrier (because it's not I/O). 
Andy doesn't want me to use wmb() (because it's sync).  I don't think 
something like gfar_wmb() would be appropriate.  So the remaining 
options are either eieio(), or a new non-arch-specific, 
non-driver-specific mem_wmb() (or whatever).

While I like the latter option, I don't think this bugfix should have to 
wait for it.

-Scott
