Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 673D267BC5
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Oct 2006 04:27:15 +1000 (EST)
Message-ID: <453D097D.6090603@freescale.com>
Date: Mon, 23 Oct 2006 13:27:09 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] qe_ic: Do a sync when masking interrupts.
References: <11892067.4322551161617453238.JavaMail.root@vms069.mailsrvcs.net>
	<F886CBFA-4710-4185-AA99-92EDEE3F2FE8@kernel.crashing.org>
In-Reply-To: <F886CBFA-4710-4185-AA99-92EDEE3F2FE8@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
> If a sync after an MMIO write is enough, then (in almost all
> cases) so is an eieio.

In this case, the spurious interrupts still happen with eieio, but not 
with sync.  It's probably synchronizing the MMIO write with some 
unrelated load from memory (such as reading the stack frame to return 
from the mask function, or reading action->flags to determine whether to 
check for IRQ_DISABLED).

-Scott
