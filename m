Return-Path: <grundler@lackof.org>
Received: from colo.lackof.org (colo.lackof.org [198.49.126.79])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.lackof.org", Issuer "ca.lackof.org" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 42B9B68374
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Oct 2005 06:44:58 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by colo.lackof.org (Postfix) with ESMTP id 7B4E3298056
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Oct 2005 14:23:02 -0600 (MDT)
Received: from colo.lackof.org ([127.0.0.1])
	by localhost (colo.lackof.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 26469-07 for <linuxppc-dev@ozlabs.org>;
	Sun, 9 Oct 2005 14:23:01 -0600 (MDT)
Date: Sun, 9 Oct 2005 14:23:01 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: linuxppc-dev@ozlabs.org
Message-ID: <20051009202301.GC21977@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: pmd_alloc() usage incorrect?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,
I stumbled across what looks like incorrect code in
arch/ppc/kernel/dma-mapping.c:

static int __init dma_alloc_init(void)
{
...
        do {
                pgd = pgd_offset(&init_mm, CONSISTENT_BASE);
                pmd = pmd_alloc(&init_mm, pgd, CONSISTENT_BASE);
                if (!pmd) {
...

Doesn't pmd_alloc() want a pud_t * for the second parameter?
ie also need to call pud_alloc() or the equivalent.

I've very little clue how this works...just looking at different
bits of code in my quest to understand it well enough to enable
USE_HPPA_IOREMAP in include/asm-parisc/io.h.

ciao,
grant
