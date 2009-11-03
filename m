Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 47C09B7C2F
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  3 Nov 2009 12:22:39 +1100 (EST)
Subject: Re: Filtering bits in set_pte_at()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hugh Dickins <hugh.dickins@tiscali.co.uk>
In-Reply-To: <Pine.LNX.4.64.0911022342070.30581@sister.anvils>
References: <1256957081.6372.344.camel@pasglop>
	<Pine.LNX.4.64.0911021256330.32400@sister.anvils>
	<1257200367.7907.50.camel@pasglop>
	<Pine.LNX.4.64.0911022342070.30581@sister.anvils>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 03 Nov 2009 12:22:26 +1100
Message-ID: <1257211346.7907.60.camel@pasglop>
Mime-Version: 1.0
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>, linuxppc-dev@lists.ozlabs.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-11-02 at 23:45 +0000, Hugh Dickins wrote:
> > IE. update_mmu_cache() would be more generally useful if it took the
> > ptep instead of the pte. Of course, I'm sure some embedded archs are
> > going to cry for the added load here ... 
> > 
> > I like your idea. I'll look into doing a patch converting it and
> will
> > post it here.
> 
> Well, I wasn't proposing
> 
>                 update_mmu_cache(vma, address, ptep);
> but
>                 update_mmu_cache(vma, address, *ptep);
> 
> which may not meet your future idea, but is much less churn for now
> i.e. no change to any of the arch's update_mmu_cache(),
> just a change to some of its callsites. 

I see... but if we go that way, I think we may as well do the whole
churn... I'll have a look at how bad it is.

Cheers,
Ben.
