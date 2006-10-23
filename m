Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net
	[151.189.21.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3DA8B67B70
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Oct 2006 04:46:50 +1000 (EST)
In-Reply-To: <453D097D.6090603@freescale.com>
References: <11892067.4322551161617453238.JavaMail.root@vms069.mailsrvcs.net>
	<F886CBFA-4710-4185-AA99-92EDEE3F2FE8@kernel.crashing.org>
	<453D097D.6090603@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C1AE0A40-F5B4-485F-8644-8EF5F0CA6A3A@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] qe_ic: Do a sync when masking interrupts.
Date: Mon, 23 Oct 2006 20:46:01 +0200
To: Scott Wood <scottwood@freescale.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> If a sync after an MMIO write is enough, then (in almost all
>> cases) so is an eieio.
>
> In this case, the spurious interrupts still happen with eieio, but  
> not with sync.  It's probably synchronizing the MMIO write with  
> some unrelated load from memory (such as reading the stack frame to  
> return from the mask function, or reading action->flags to  
> determine whether to check for IRQ_DISABLED).

Yes, it sure sounds like the only reason the sync insn helps
is that it causes a (small) delay.  If you document this (and
also that it isn't required for correctness) in the code, I
don't think anyone will complain / be curious about it anymore.


Segher
