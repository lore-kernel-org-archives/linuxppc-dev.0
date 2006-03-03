Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0650467A03
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Mar 2006 14:55:14 +1100 (EST)
Date: Thu, 2 Mar 2006 19:55:12 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Unsafe pte_update() in do_page_fault() (4xx and Book-E)
Message-ID: <20060303035512.GB19115@gate.ebshome.net>
References: <20060302202634.GA14387@gate.ebshome.net>
	<1141357383.3888.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1141357383.3888.19.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 03, 2006 at 02:43:02PM +1100, Benjamin Herrenschmidt wrote:
> 
> > If this happens, pte_update() sets _PAGE_HWEXEC bit in just cleared 
> > PTE. Sometime later, another page fault happens for this page, but 
> > because of that set bit, pte_none() test in handle_pte_fault() fails, 
> > and we continue along the wrong path, thinking that this PTE was 
> > swapped out to the swap file, and this triggers swap_dup error I 
> > mentioned at the beginning.
> 
> Can we preempt at that point ? As tehre is no SMP 4xx that I know of
> preempt would be the only cause for such a race ...

Yes, as I mentioned in the original post, I'm running preempt enabled 
kernel.

-- 
Eugene
