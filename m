Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 16596DDED2
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 07:17:11 +1000 (EST)
Subject: Re: [PATCH] [POWERPC] Improve (in|out)_beXX() asm code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Trent Piepho <tpiepho@freescale.com>
In-Reply-To: <1211316025-29069-1-git-send-email-tpiepho@freescale.com>
References: <1211316025-29069-1-git-send-email-tpiepho@freescale.com>
Content-Type: text/plain
Date: Tue, 20 May 2008 17:16:59 -0400
Message-Id: <1211318219.8297.177.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
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


On Tue, 2008-05-20 at 13:40 -0700, Trent Piepho wrote:
> There was some discussion on a Freescale list if the powerpc I/O accessors
> should be strictly ordered w.r.t.  normal memory.  Currently they are not.  It
> does not appear as if any other architecture's I/O accessors are strictly
> ordered in this manner.  memory-barriers.txt explicitly states that the I/O
> space (inb, outw, etc.) are NOT strictly ordered w.r.t. normal memory
> accesses and it's implied the other I/O accessors (e.g., writel) are the same.
> 
> However, it is somewhat harder to program for this model, and there are almost
> certainly a number of drivers using coherent DMA which have subtle bugs because
> the do not include the necessary barriers.
> 
> But clearly and change to this would be a subject for a different patch.

The current accessors should provide all the necessary ordering
guarantees...

Ben.
