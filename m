Return-Path: <benh@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8B89D2C0084
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 17:00:46 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Thu, 30 May 2013 16:52:00 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 45EB22CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 17:00:39 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4U6kCrv26148986
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 16:46:12 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4U70bNi029803
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 17:00:38 +1000
Message-ID: <1369897236.3928.93.camel@pasglop>
Subject: Re: 3.10-rc ppc64 corrupts usermem when swapping
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Hugh Dickins <hughd@google.com>
Date: Thu, 30 May 2013 17:00:36 +1000
In-Reply-To: <alpine.LNX.2.00.1305292148550.9560@eggly.anvils>
References: <alpine.LNX.2.00.1305292148550.9560@eggly.anvils>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@au1.ibm.com>,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-05-29 at 22:47 -0700, Hugh Dickins wrote:
> Running my favourite swapping load (repeated make -j20 kernel builds
> in tmpfs in parallel with repeated make -j20 kernel builds in ext4 on
> loop on tmpfs file, all limited by mem=700M and swap 1.5G) on 3.10-rc
> on PowerMac G5, the test dies with corrupted usermem after a few hours.
> 
> Variously, segmentation fault or Binutils assertion fail or gcc Internal
> error in either or both builds: usually signs of swapping or TLB flushing
> gone wrong.  Sometimes the tmpfs build breaks first, sometimes the ext4 on
> loop on tmpfs, so at least it looks unrelated to loop.  No problem on x86.
> 
> This is 64-bit kernel but 4k pages and old SuSE 11.1 32-bit userspace.
> 
> I've just finished a manual bisection on arch/powerpc/mm (which might
> have been a wrong guess, but has paid off): the first bad commit is
> 7e74c3921ad9610c0b49f28b8fc69f7480505841
> "powerpc: Fix hpte_decode to use the correct decoding for page sizes".

Ok, I have other reasons to think is wrong. I debugged a case last week
where after kexec we still had stale TLB entries, due to the TLB cleanup
not working.

Thanks for doing that bisection ! I'll investigate ASAP (though it will
probably have to wait for tomorrow unless Paul beats me to it)

> I don't know if it's actually swapping to swap that's triggering the
> problem, or a more general page reclaim or TLB flush problem.  I hit
> it originally when trying to test Mel Gorman's pagevec series on top
> of 3.10-rc; and though I then reproduced it without that series, it
> did seem to take much longer: so I have been applying Mel's series to
> speed up each step of the bisection.  But if I went back again, might
> find it was just chance that I hit it sooner with Mel's series than
> without.  So, you're probably safe to ignore that detail, but I
> mention it just in case it turns out to have some relevance.
> 
> Something else peculiar that I've been doing in these runs, may or may
> not be relevant: I've been running swapon and swapoff repeatedly in the
> background, so that we're doing swapoff even while busy building.
> 
> I probably can't go into much more detail on the test (it's hard
> to get the balance right, to be swapping rather than OOMing or just
> running without reclaim), but can test any patches you'd like me to
> try (though it may take 24 hours for me to report back usefully).

I think it's just failing to invalidate the TLB properly. At least one
bug I can spot just looking at it:

static void native_hpte_invalidate(unsigned long slot, unsigned long vpn,
				   int psize, int ssize, int local)

   .../...

	native_lock_hpte(hptep);
	hpte_v = hptep->v;

	actual_psize = hpte_actual_psize(hptep, psize);
	if (actual_psize < 0) {
		native_unlock_hpte(hptep);
		local_irq_restore(flags);
		return;
	}

That's wrong. We must still perform the TLB invalidation even if the
hash PTE is empty.

In fact, Aneesh, this is a problem with MPSS for your THP work, I just
thought about it.

The reason is that if a hash bucket gets full, we "evict" a more/less
random entry from it. When we do that we don't invalidate the TLB
(hpte_remove) because we assume the old translation is still technically
"valid".

However that means that an hpte_invalidate *must* invalidate the TLB
later on even if it's not hitting the right entry in the hash.

However, I can see why that cannot work with THP/MPSS since you have no
way to know the page size from the PTE anymore....

So my question is, apart from hpte_decode used by kexec, which I will
fix by just blowing the whole TLB when not running phyp, why do you need
the "actual" size in invalidate and updatepp ? You really can't rely on
the size passed by the upper layers ?

Cheers,
Ben.
