Return-Path: <torvalds@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id AF6D267BA4
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Sep 2006 05:16:50 +1000 (EST)
Date: Sun, 3 Sep 2006 12:16:44 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Please pull powerpc.git 'merge' branch
In-Reply-To: <17654.26321.851991.285528@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.64.0609031213310.27779@g5.osdl.org>
References: <17654.26321.851991.285528@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hmm.

I wrote a sparse extension that warns if an initializer tries to 
initialize the same entry multiple times.

Look what it found:

 - arch/powerpc/platforms/powermac/pfunc_base.c:259

	static struct pmf_handlers macio_mmio_handlers = {
	        .write_reg32            = macio_do_write_reg32,
	        .read_reg32             = macio_do_read_reg32,
	        .write_reg8             = macio_do_write_reg8,
	        .read_reg32             = macio_do_read_reg8,
	        .read_reg32_msrx        = macio_do_read_reg32_msrx,
	        .read_reg8_msrx         = macio_do_read_reg8_msrx,
	        .write_reg32_slm        = macio_do_write_reg32_slm,
	        .write_reg8_slm         = macio_do_write_reg8_slm,
	        .delay                  = macio_do_delay,
	};

Can anybody see anything suspicious there?

		Linus
