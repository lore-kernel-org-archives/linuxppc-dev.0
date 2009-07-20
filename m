Return-Path: <npiggin@suse.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5104DB70A6
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 20 Jul 2009 18:11:01 +1000 (EST)
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id DF8E5DDD04
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Jul 2009 18:11:00 +1000 (EST)
Date: Mon, 20 Jul 2009 10:10:54 +0200
From: Nick Piggin <npiggin@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH] mm: Pass virtual address to [__]p{te, ud,
	md}_free_tlb()
Message-ID: <20090720081054.GH7298@wotan.suse.de>
References: <20090715074952.A36C7DDDB2@ozlabs.org>
	<20090715135620.GD7298@wotan.suse.de>
	<1247709255.27937.5.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1247709255.27937.5.camel@pasglop>
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

On Thu, Jul 16, 2009 at 11:54:15AM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2009-07-15 at 15:56 +0200, Nick Piggin wrote:
> > Interesting arrangement. So are these last level ptes modifieable
> > from userspace or something? If not, I wonder if you could manage
> > them as another level of pointers with the existing pagetable
> > functions?
> 
> I don't understand what you mean. Basically, the TLB contains PMD's.

Maybe I don't understand your description correctly. The TLB contains
PMDs, but you say the HW still logically performs another translation
step using entries in the PMD pages? If I understand that correctly,
then generic mm does not actually care and would logically fit better
if those entries were "linux ptes". The pte invalidation routines
give the virtual address, which you could use to invalidate the TLB.
 

> There's nothing to change to the existing page table layout :-) But
> because they appear as large page TLB entries that cover the virtual
> space covered by a PMD, they need to be invalidated using virtual
> addresses when PMDs are removed.
