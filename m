Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6951EDDF70
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 13:46:46 +1100 (EST)
Subject: Re: [PATCH] powerpc: Add support for using doorbells for SMP IPI
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1234482893-17712-1-git-send-email-galak@kernel.crashing.org>
References: <1234482893-17712-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 13 Feb 2009 13:46:40 +1100
Message-Id: <1234493200.29851.79.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-02-12 at 17:54 -0600, Kumar Gala wrote:
> The e500mc supports the new msgsnd/doorbell mechanisms that were added in
> the Power ISA 2.05 architecture.  We use the normal level doorbell for
> doing SMP IPIs at this point.
> 

Cool stuff. Haven't reviewed in details yet tho :-) But I was
thinking...

We should introduce a special xmon variant of local_irq_save/restore for
use by xmon that masks MSR:CE and use a crit doorbell for xmon IPI, that
would increase significantly the ability of xmon to catch deadlocked
CPUs, and we could use external CRITs as a more generic way of doing
IPIs, no ?

In fact, we should expose a local_crit_irq_save/restore (disable/enable)
too for things like watchdog drivers etc... which may want to use these.

Cheers,
Ben.
