Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4CEA567BD2
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Sep 2006 07:15:40 +1000 (EST)
Subject: Re: Please pull powerpc.git 'merge' branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609031213310.27779@g5.osdl.org>
References: <17654.26321.851991.285528@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0609031213310.27779@g5.osdl.org>
Content-Type: text/plain
Date: Mon, 04 Sep 2006 07:15:22 +1000
Message-Id: <1157318122.32334.8.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2006-09-03 at 12:16 -0700, Linus Torvalds wrote:
> Hmm.
> 
> I wrote a sparse extension that warns if an initializer tries to 
> initialize the same entry multiple times.
> 
> Look what it found:
> 
>  - arch/powerpc/platforms/powermac/pfunc_base.c:259
> 
> 	static struct pmf_handlers macio_mmio_handlers = {
> 	        .write_reg32            = macio_do_write_reg32,
> 	        .read_reg32             = macio_do_read_reg32,
> 	        .write_reg8             = macio_do_write_reg8,
> 	        .read_reg32             = macio_do_read_reg8,

Yeah, a typo :) Go sparse !

I'll send a fix later today. I don't think the read32 is used that much
in practice, but yeah, that could have cause subtle issues on some
machine....

Ben.
