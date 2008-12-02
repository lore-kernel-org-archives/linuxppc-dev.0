Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1CDE7DDDE0
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Dec 2008 08:31:15 +1100 (EST)
Subject: Re: [PATCH][for 2.6.28] powerpc: Use physical cpu id when setting
	the processor affinity
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1228246621-25622-1-git-send-email-galak@kernel.crashing.org>
References: <1228246621-25622-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 03 Dec 2008 08:30:23 +1100
Message-Id: <1228253423.7356.195.camel@pasglop>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Linus Torvalds <torvalds@osdl.org>,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-12-02 at 13:37 -0600, Kumar Gala wrote:
> In the CONFIG_SMP case the irq_choose_cpu() code was returning back
> a logical cpu id not the physical id.  We were writing that directly
> into the HW register.
> 
> We need to be calling get_hard_smp_processor_id() so irq_choose_cpu()
> always returns a physical cpu id.

That will probably do for now but if we ever move that routine to
generic code, I'd rather have the caller do the conversion.

Cheers,
Ben.
