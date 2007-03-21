Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8AE7BDDE3C
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 03:13:49 +1100 (EST)
Date: Wed, 21 Mar 2007 17:13:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: anton@samba.org
Subject: Re: [patch 07/10] Page fault handler should not depend on
	CONFIG_KPROBES
Message-ID: <20070321161342.GA17211@lst.de>
References: <20070321013810.404636000@samba.org>
	<20070321013825.385423000@samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070321013825.385423000@samba.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 20, 2007 at 08:38:17PM -0500, anton@samba.org wrote:
> Like x86-64, change the page fault notifier code to not depend on
> CONFIG_KPROBES and export the handlers.

NACK until the performace implication a fixed.  Martin measured this
costs 300 cycles on s390 even without any notifier activce, and while
ppc might be slightly bad that's still too much to add to the pagefault
handler unconditionally.  Please add a light weight method to check
whether there is any activce user of the notifications.  Also please
move the code into kernel/ at the same time instead of having the exact
same thing duplicated all over, as in my notify_die patches.

> +EXPORT_SYMBOL_GPL(register_page_fault_notifier);

> +EXPORT_SYMBOL_GPL(unregister_page_fault_notifier);

Please drop these exports.  There's not modular users of it, and
the target users (kprobes and debuggers) can't be modular either.
