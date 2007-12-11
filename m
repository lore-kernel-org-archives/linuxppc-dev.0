Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E71D0DDE30
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 10:38:29 +1100 (EST)
Subject: Re: [RFC][POWERPC] Provide a way to protect 4k subpages when using
	64k pages
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20071211155305.GA28055@lst.de>
References: <18264.58263.818005.757831@cargo.ozlabs.ibm.com>
	<20071211155305.GA28055@lst.de>
Content-Type: text/plain
Date: Wed, 12 Dec 2007 10:38:08 +1100
Message-Id: <1197416288.8385.21.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2007-12-11 at 16:53 +0100, Christoph Hellwig wrote:
> All these process would use plain mmap/
> mprotect to deal with the subpage protections.

That seems very hard to do ... all of the generic code here only knows
about the base page size, so except if we're going to fully re-implement
the mmap/mprotect logic from scratch, it's going to hurt, or am I
missing something ?

I suppose we could add wrappers to those syscalls that always set the
protection map to "no access" over the target area (from within
get_unmapped_area for mmap as we don't know the area yet), and then,
update it after the successful call.

But mprotect seems a clumsy way to control the per-sub-page permission
in that case as we don't want to change the underlying real 64k page
permission.

Ben.
 
