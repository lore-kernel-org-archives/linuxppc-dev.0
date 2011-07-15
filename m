Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E8E55B6F67
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Jul 2011 19:07:37 +1000 (EST)
Subject: Re: [PATCH 0/1] Fixup write permission of TLB on powerpc e500 core
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: MailingLists <haishan.bai@gmail.com>
In-Reply-To: <4E1FFC7B.4000209@gmail.com>
References: <1310717238-13857-1-git-send-email-haishan.bai@gmail.com>
	<1310718056.2586.275.camel@twins>  <4E1FFC7B.4000209@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 15 Jul 2011 19:07:15 +1000
Message-ID: <1310720835.4968.311.camel@pasglop>
Mime-Version: 1.0
Cc: tony.luck@intel.com, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	linux-kernel@vger.kernel.org, cmetcalf@tilera.com,
	dhowells@redhat.com, paulus@samba.org, tglx@linutronix.de,
	walken@google.com, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-07-15 at 16:38 +0800, MailingLists wrote:
> A page could be set to read only by the kernel (supervisor in the
> powerpc
> literature) on the e500, and that's what the kernel do. Set
> SW(supervisor
> write) bit in the TLB entry to grant write permission to the kernel on
> a
> page.
> 
> And further the SW bit is set according to the DIRTY flag of the PTE,
> PTE.DIRTY is set in the do_page_fault(), the futex_lock_pi() disabled
> page fault, the PTE.DIRTY never can be set, so do the SW bit,
> unbreakable
> COW occurred, infinite loop followed. 

That would be it ... the SW dirty and young tracking relies on faults to
fixup things in handle_pte_fault(). If the "disable page fault" thingy
happens before we get there, then we have a pretty nasty bug. Note that
this will hit more than just e500 (and in fact any architecture that
relies on SW to do dirty and young tracking).

Cheers,
Ben.
