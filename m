Return-Path: <hughd@google.com>
Received: from mail-pb0-x231.google.com (mail-pb0-x231.google.com
 [IPv6:2607:f8b0:400e:c01::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5D9862C0098
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 15:47:27 +1000 (EST)
Received: by mail-pb0-f49.google.com with SMTP id rp8so10331906pbb.22
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 May 2013 22:47:23 -0700 (PDT)
Date: Wed, 29 May 2013 22:47:24 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: 3.10-rc ppc64 corrupts usermem when swapping
Message-ID: <alpine.LNX.2.00.1305292148550.9560@eggly.anvils>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Running my favourite swapping load (repeated make -j20 kernel builds
in tmpfs in parallel with repeated make -j20 kernel builds in ext4 on
loop on tmpfs file, all limited by mem=700M and swap 1.5G) on 3.10-rc
on PowerMac G5, the test dies with corrupted usermem after a few hours.

Variously, segmentation fault or Binutils assertion fail or gcc Internal
error in either or both builds: usually signs of swapping or TLB flushing
gone wrong.  Sometimes the tmpfs build breaks first, sometimes the ext4 on
loop on tmpfs, so at least it looks unrelated to loop.  No problem on x86.

This is 64-bit kernel but 4k pages and old SuSE 11.1 32-bit userspace.

I've just finished a manual bisection on arch/powerpc/mm (which might
have been a wrong guess, but has paid off): the first bad commit is
7e74c3921ad9610c0b49f28b8fc69f7480505841
"powerpc: Fix hpte_decode to use the correct decoding for page sizes".

I don't know if it's actually swapping to swap that's triggering the
problem, or a more general page reclaim or TLB flush problem.  I hit
it originally when trying to test Mel Gorman's pagevec series on top
of 3.10-rc; and though I then reproduced it without that series, it
did seem to take much longer: so I have been applying Mel's series to
speed up each step of the bisection.  But if I went back again, might
find it was just chance that I hit it sooner with Mel's series than
without.  So, you're probably safe to ignore that detail, but I
mention it just in case it turns out to have some relevance.

Something else peculiar that I've been doing in these runs, may or may
not be relevant: I've been running swapon and swapoff repeatedly in the
background, so that we're doing swapoff even while busy building.

I probably can't go into much more detail on the test (it's hard
to get the balance right, to be swapping rather than OOMing or just
running without reclaim), but can test any patches you'd like me to
try (though it may take 24 hours for me to report back usefully).

Thanks,
Hugh
