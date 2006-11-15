Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2FB2567D4D
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 05:37:50 +1100 (EST)
Date: Wed, 15 Nov 2006 19:37:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Subject: Re: [PATCH 5/16] hypervisor functions for Celleb
Message-ID: <20061115183746.GC21633@lst.de>
References: <200611150937.kAF9b305001499@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200611150937.kAF9b305001499@toshiba.co.jp>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +extern int64_t beat_errno;

Please don't use a global arrno variable.

> +static inline int64_t beat_allocate_memory(uint64_t __in0, uint64_t __in1, uint64_t __in2, uint64_t __in3,void** __out0,uint64_t* __out1) {
> +	register uint64_t __reg0 __asm__("r3");
> +	register uint64_t __reg1 __asm__("r4");
> +	register uint64_t __reg2 __asm__("r5");
> +	register uint64_t __reg3 __asm__("r6");
> +	register uint64_t __sn __asm__("r11") = (0UL);

No point in declaring this a register variable, gcc ignores the
specifier.  Is there any chance to not duplicate the inline assembly
for every single hypercall but have generic call with n arguments
helper, as for the phyp hvcalls?
