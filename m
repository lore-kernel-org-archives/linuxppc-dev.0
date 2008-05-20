Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1695ADDE05
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 08:02:27 +1000 (EST)
Subject: Re: [PATCH] [POWERPC] Improve (in|out)_beXX() asm code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <483344C0.3020703@freescale.com>
References: <1211316025-29069-1-git-send-email-tpiepho@freescale.com>
	<1211318219.8297.177.camel@pasglop>  <483344C0.3020703@freescale.com>
Content-Type: text/plain
Date: Tue, 20 May 2008 18:02:18 -0400
Message-Id: <1211320938.8297.179.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Trent Piepho <tpiepho@freescale.com>,
	linux-kernel@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-05-20 at 16:38 -0500, Scott Wood wrote:
> It looks like we rely on -fno-strict-aliasing to prevent reordering 
> ordinary memory accesses (such as to DMA descriptors) past the I/O 
> access.  It won't prevent reordering of memory reads around an I/O
> read, 
> though, which could be a problem if the I/O read result determines
> the 
> validity of the DMA buffer.  IMHO, a memory clobber would be better.

We probably want a full "memory" clobber then...

Ben.
