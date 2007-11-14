Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 10C07DDE1E
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2007 07:28:55 +1100 (EST)
Subject: Re: [PATCH] [POWERPC] vdso: Fixes for cache line sizes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20071114192405.GA1637@lixom.net>
References: <20071114192405.GA1637@lixom.net>
Content-Type: text/plain
Date: Thu, 15 Nov 2007 07:28:22 +1100
Message-Id: <1195072102.28865.41.camel@pasglop>
Mime-Version: 1.0
Cc: dwmw2@infradead.org, paulus@samba.org, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2007-11-14 at 13:24 -0600, Olof Johansson wrote:
> [POWERPC] vdso: Fixes for cache line sizes
> 
> Current VDSO implementation is hardcoded to 128 byte cachelines, which
> only works on IBM's 64-bit processors.
> 
> Convert it to get the line sizes out of vdso_data instead, similar to
> how the ppc64 in-kernel cache flush does it.

Please call the fields "block size" not "line size". There are subtle
differences and per architecture, it should really be block size.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> 
> ---
> Paul, this is needed to make for example the IBM jvm run on pa6t. Please
> include as bugfix for 2.6.24.

Heh, they use the vdso for flushes ? I didn't know that !

Ben.
