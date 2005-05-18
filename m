Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3EEE367A03
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 May 2005 00:14:46 +1000 (EST)
In-Reply-To: <20050518102103.GB32493@gate.ebshome.net>
References: <20050518102103.GB32493@gate.ebshome.net>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <55497ec3de50301c9f568be24ed3edac@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Wed, 18 May 2005 10:14:46 -0400
To: Eugene Surovegin <ebs@ebshome.net>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] ppc32: fix CONFIG_TASK_SIZE handling on 44x
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 18, 2005, at 6:21 AM, Eugene Surovegin wrote:

> This patch fixed CONFIG_TASK_SIZE handling on 44x.

Paul suggested to me and I've been contemplating changing
the page table management on PowerPC to something similar
to other platforms.  At first, I was only going to do this on 8xx,
but I think I'll do it for PowerPC in general so all boards can
take advantage if they choose to do so.

Other ports populate the user page tables with the kernel pmd
entries upon kernel faults, then we don't have to distinguish
among page tables during the TLB exceptions.  I'm hoping we
can populate the init page table entries at boot time, and then
everyone will inherit them, eliminating all faults unless the kernel
vmalloc space grows to need a new pmd entry.

This would be a generic solution to selecting task size, among
other advanced memory mapping options.

I'll keep you posted.

Thanks.


	-- Dan
