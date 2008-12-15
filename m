Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6C880DDF73
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 10:31:39 +1100 (EST)
Subject: Re: [PATCH 11/16] powerpc/mm: Add SMP support to no-hash TLB
	handling v3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <01FA1F1A-0A98-4553-B27D-CBC627E3EC02@kernel.crashing.org>
References: <20081215054554.E883EDDF9D@ozlabs.org>
	<B3FDD472-0720-4454-9329-5A1C8A9BF84A@freescale.com>
	<1229373978.26324.120.camel@pasglop>
	<C0519630-66EF-4860-A27E-15CC749D98DC@freescale.com>
	<1229374984.26324.125.camel@pasglop>
	<B5573CC7-9ED1-48CE-9BE9-51A0BF5CB247@kernel.crashing.org>
	<1229375937.26324.128.camel@pasglop>
	<01FA1F1A-0A98-4553-B27D-CBC627E3EC02@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 16 Dec 2008 10:31:32 +1100
Message-Id: <1229383892.26324.132.camel@pasglop>
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

On Mon, 2008-12-15 at 16:19 -0600, Kumar Gala wrote:
> Ok.  Lets use MMU_FTR_LOCK_BCAST_TLB_OPS and have a comment about  
> locking because bus implementations cant handle multiple ivax and/or  
> multiple syncs.
> 
Hi used MMU_FTR_LOCK_BCAST_INVAL :-) And I put a comment that says:

/* This indicates that the processor cannot handle multiple outstanding
 * broadcast tlbivax or tlbsync. This makes the code use a spinlock
 * around such invalidate forms.
 */

Cheers,
Ben.
