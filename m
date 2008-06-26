Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 52ECFDE558
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 21:55:16 +1000 (EST)
Subject: Re: [PATCH 1/1] powerpc: add 64 bit version of huge_ptep_set_wrprotect
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <1214474158-17870-1-git-send-email-apw@shadowen.org>
References: <1214474158-17870-1-git-send-email-apw@shadowen.org>
Content-Type: text/plain
Date: Thu, 26 Jun 2008 20:51:42 +1000
Message-Id: <1214477502.8011.459.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-06-26 at 10:55 +0100, Andy Whitcroft wrote:
> The implementation of huge_ptep_set_wrprotect() directly calls
> ptep_set_wrprotect() to mark a hugepte write protected.  However this
> call is not appropriate on ppc64 kernels as this is a small page only
> implementation.  This can lead to the hash not being flushed correctly
> when a mapping is being converted to COW, allowing processes to continue
> using the original copy.
> 
> Currently huge_ptep_set_wrprotect() unconditionally calls
> ptep_set_wrprotect().  This is fine on ppc32 kernels as this call is
> generic.  On 64 bit this is implemented as:
> 
> 	pte_update(mm, addr, ptep, _PAGE_RW, 0);
> 
> On ppc64 this last parameter is the page size and is passed directly on
> to hpte_need_flush():
> 
> 	hpte_need_flush(mm, addr, ptep, old, huge);
> 
> And this directly affects the page size we pass to flush_hash_page():
> 
> 	flush_hash_page(vaddr, rpte, psize, ssize, 0);
> 
> As this changes the way the hash is calculated we will flush the wrong
> pages, potentially leaving live hashes to the original page.
> 
> Move the definition of huge_ptep_set_wrprotect() to the 32/64 bit specific
> headers.
> 
> Signed-off-by: Andy Whitcroft <apw@shadowen.org>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Good catch btw !

Cheers,
Ben.
