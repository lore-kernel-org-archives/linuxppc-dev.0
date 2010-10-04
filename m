Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 023F5B70CB
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Oct 2010 07:38:48 +1100 (EST)
Received: from mail176-tx2 (localhost.localdomain [127.0.0.1])	by
	mail176-tx2-R.bigfish.com (Postfix) with ESMTP id C637682049B	for
	<linuxppc-dev@ozlabs.org>; Mon,  4 Oct 2010 20:38:44 +0000 (UTC)
Received: from TX2EHSMHS035.bigfish.com (unknown [10.9.14.242])	by
	mail176-tx2.bigfish.com (Postfix) with ESMTP id 6E04A17980DF	for
	<linuxppc-dev@ozlabs.org>; Mon,  4 Oct 2010 20:37:57 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o94KbslD002719	for <linuxppc-dev@ozlabs.org>;
	Mon, 4 Oct 2010 13:37:54 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o94KbsjS025799	for <linuxppc-dev@ozlabs.org>;
	Mon, 4 Oct 2010 15:37:54 -0500 (CDT)
Date: Mon, 4 Oct 2010 15:37:53 -0500
From: Scott Wood <scottwood@freescale.com>
To: Nick Piggin <npiggin@kernel.dk>, <linuxppc-dev@ozlabs.org>
Subject: Re: in_atomic() check in page_cache_get_speculative()
Message-ID: <20101004153753.2cda1abf@udp111988uds.am.freescale.net>
In-Reply-To: <20101004152259.25c56ad2@udp111988uds.am.freescale.net>
References: <20101004152259.25c56ad2@udp111988uds.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[Updated with Nick's current address; previous one bounced]

On Mon, 4 Oct 2010 15:22:59 -0500
Scott Wood <scottwood@freescale.com> wrote:

> I'm seeing the in_atomic() check in page_cache_get_speculative()
> (linux/pagemap.h:138) fail when running e500 KVM with .  

Sorry, that should finish as "with CONFIG_DEBUG_VM."

> It's coming
> from get_user_pages_fast(), from KVM's hva_to_pfn().  This is on kvm.git
> plus a few local patches that should be completely unrelated, but it
> looks like this code hasn't changed much in a couple years.
> 
> Interrupts are disabled by get_user_pages_fast(), but apparently
> preemption was not separately disabled.  The comment in
> page_cache_get_speculative() says that preemption disabling is done by
> rcu_read_lock(), and that "this function must be called inside the same
> rcu_read_lock() section as has been used to lookup the page in the
> pagecache radix-tree (or page table)".
> 
> Where is this RCU lock supposed to be acquired?  I don't see any RCU in
> arch/powerpc/mm/gup.c.  Is it buried in some macro or function call?
> 
> -Scott
