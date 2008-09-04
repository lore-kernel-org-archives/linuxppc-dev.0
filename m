Return-Path: <raj@semihalf.com>
Received: from semihalf.com (semihalf.com [206.130.101.55])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8EA9DDE26B
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 05:30:10 +1000 (EST)
Message-ID: <48C03439.1000301@semihalf.com>
Date: Thu, 04 Sep 2008 21:17:13 +0200
From: Rafal Jaworowski <raj@semihalf.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3 1/4] powerpc: Introduce local (non-broadcast) forms
	of tlb	invalidates
References: <1220465344-16753-1-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1220465344-16753-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
[...]
> The intent of this change is to handle SMP based invalidates via IPIs instead
> of broadcasts as the mechanism scales better for larger number of cores.

Hi Kumar,

How is the inter-IPI deadlock avoidance designed in this new approach? I don't
know the close details of low-level Book-E VM design in Linux, but am thinking
about a scenario when we have two TLB misses hitting almost immediately on two
different cores and they both want to send a TLB invalidate IPI to each other.
How do you manage this?

The reason I ask is we had similar considerations (and problems) when bringing
SMP to the dual core e500 on FreeBSD and ended up not using IPIs, at least for
now, because of such concerns (and actual problems of this kind).

Rafal
