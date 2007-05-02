Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 371F8DDF9F
	for <linuxppc-dev@ozlabs.org>; Wed,  2 May 2007 10:54:58 +1000 (EST)
In-Reply-To: <20070501165542.GA31285@ld0162-tx32.am.freescale.net>
References: <20070501165542.GA31285@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <65f0b79871a670eb595cca7d78e2f4e9@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] gianfar: Add I/O barriers when touching buffer descriptor
	ownership.
Date: Wed, 2 May 2007 02:54:40 +0200
To: Scott Wood <scottwood@freescale.com>
Cc: netdev@vger.kernel.org, jgarzik@pobox.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> The hardware must not see that is given ownership of a buffer until it 
> is
> completely written, and when the driver receives ownership of a buffer,
> it must ensure that any other reads to the buffer reflect its final
> state.  Thus, I/O barriers are added where required.
>
> Without this patch, I have observed GCC reordering the setting of
> bdp->length and bdp->status in gfar_new_skb.

The :::"memory" in the barriers you used prevent GCC
from reordering accesses around the barriers.

AFAICS you need stronger barriers though; {w,r,}mb(),
to prevent _any_ reordering of those memory accesses,
not just the compiler-generated ones.


Segher
