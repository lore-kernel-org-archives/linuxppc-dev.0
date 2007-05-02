Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B0B67DDF82
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 07:30:26 +1000 (EST)
Message-ID: <463902EB.8070401@freescale.com>
Date: Wed, 02 May 2007 16:30:19 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] gianfar: Add I/O barriers when touching buffer
	descriptor ownership.
References: <20070502195712.GA16541@ld0162-tx32.am.freescale.net>
	<F1B250DD-A472-470F-B3D0-EBB2F042E454@kernel.crashing.org>
	<4638F0C4.2000406@freescale.com>
	<FA9554A4-5A7D-4E03-BE28-C4B6B80D9DB9@kernel.crashing.org>
	<4638F734.2040809@freescale.com>
	<41B347BE-06AA-4346-BEFB-19DFB52AC533@kernel.crashing.org>
In-Reply-To: <41B347BE-06AA-4346-BEFB-19DFB52AC533@kernel.crashing.org>
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
> Why doesn't marking the bdp pointer volatile resolve the issue in  
> gfar_clean_rx_ring() to ensure load ordering?

Because that only addresses compiler reordering (and does so in a rather 
clumsy way -- not all accesses need to be strongly ordered), not 
hardware reordering.

-Scott
