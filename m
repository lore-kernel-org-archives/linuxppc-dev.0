Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 98D9BB70C4
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 20 Jul 2009 20:11:08 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E39CCDDD04
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Jul 2009 20:11:07 +1000 (EST)
Subject: Re: [RFC/PATCH] mm: Pass virtual address to [__]p{te,ud,md}_free_tlb()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nick Piggin <npiggin@suse.de>
In-Reply-To: <20090720081054.GH7298@wotan.suse.de>
References: <20090715074952.A36C7DDDB2@ozlabs.org>
	<20090715135620.GD7298@wotan.suse.de>
	<1247709255.27937.5.camel@pasglop>
	<20090720081054.GH7298@wotan.suse.de>
Content-Type: text/plain
Date: Mon, 20 Jul 2009 20:00:41 +1000
Message-Id: <1248084041.30899.7.camel@pasglop>
Mime-Version: 1.0
Cc: Linux-Arch <linux-arch@vger.kernel.org>,
	Linux Memory Management <linux-mm@kvack.org>,
	Hugh Dickins <hugh@tiscali.co.uk>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-07-20 at 10:10 +0200, Nick Piggin wrote:
> 
> Maybe I don't understand your description correctly. The TLB contains
> PMDs, but you say the HW still logically performs another translation
> step using entries in the PMD pages? If I understand that correctly,
> then generic mm does not actually care and would logically fit better
> if those entries were "linux ptes". 

They are :-)

> The pte invalidation routines
> give the virtual address, which you could use to invalidate the TLB.

For PTEs, yes, but not for those PMD entries. IE. I need the virtual
address when destroying PMDs so that I can invalidate those "indirect"
pages. PTEs are already taken care of by existing mechanisms.

Cheers,
Ben.
 
