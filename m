Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6DC7EDDF02
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 16:15:11 +1000 (EST)
Subject: Re: [PATCH v2] Parameterize EMAC Multicast Match Handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <C48F0E18.101F1%gerickson@nuovations.com>
References: <C48F0E18.101F1%gerickson@nuovations.com>
Content-Type: text/plain
Date: Tue, 01 Jul 2008 16:14:59 +1000
Message-Id: <1214892899.20711.95.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Stefan and/or Ben:
> 
> Any thoughts on this?

I was hesitating a bit... do we really need to be -that- flexible ?

That is, either that or use some new compatible entry to detect the new
reg layout and whack that as a feature bit instead ? The advantage
of the later is that we have the possibility of doing conditional
compile for kernels that support only a given processor or set of
processors (not that we have implemented much of it, but it just
becomes Kconfig mumbo jumbo and a little bit of defines in the .h
by turning the feature test into a compile-time 0 or 1.

But this isn't a hot path and not a lot of code so maybe not worth
bothering... however, it does add 3 properties to the DT and I know
embedded people (especially Xilinx) are a bit concerned about the size
of the DT when they try to fit it in block RAM...

Cheers,
Ben.
