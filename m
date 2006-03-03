Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7AF77679E6
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Mar 2006 14:43:22 +1100 (EST)
Subject: Re: Unsafe pte_update() in do_page_fault() (4xx and Book-E)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eugene Surovegin <ebs@ebshome.net>
In-Reply-To: <20060302202634.GA14387@gate.ebshome.net>
References: <20060302202634.GA14387@gate.ebshome.net>
Content-Type: text/plain
Date: Fri, 03 Mar 2006 14:43:02 +1100
Message-Id: <1141357383.3888.19.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> If this happens, pte_update() sets _PAGE_HWEXEC bit in just cleared 
> PTE. Sometime later, another page fault happens for this page, but 
> because of that set bit, pte_none() test in handle_pte_fault() fails, 
> and we continue along the wrong path, thinking that this PTE was 
> swapped out to the swap file, and this triggers swap_dup error I 
> mentioned at the beginning.

Can we preempt at that point ? As tehre is no SMP 4xx that I know of
preempt would be the only cause for such a race ...

Ben.
