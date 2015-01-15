Return-Path: <borntraeger@de.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5B9661A0D7F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 19:58:19 +1100 (AEDT)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Thu, 15 Jan 2015 08:58:15 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4DA6C17D8059
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 08:58:51 +0000 (GMT)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0F8wCWT58785968
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 08:58:12 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0F8wB0R009575
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 01:58:12 -0700
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] current ACCESS_ONCE patch queue
Date: Thu, 15 Jan 2015 09:58:26 +0100
Message-Id: <1421312314-72330-1-git-send-email-borntraeger@de.ibm.com>
Cc: linux-arch@vger.kernel.org, kvm@vger.kernel.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org,
 kvm-ppc@vger.kernel.org, linux-mm@kvack.org, xen-devel@lists.xenproject.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Folks,

fyi, this is my current patch queue for the next merge window. It
does contain a patch that will disallow ACCESS_ONCE on non-scalar
types.

The tree is part of linux-next and can be found at
git://git.kernel.org/pub/scm/linux/kernel/git/borntraeger/linux.git linux-next


Christian Borntraeger (7):
  ppc/kvm: Replace ACCESS_ONCE with READ_ONCE
  ppc/hugetlbfs: Replace ACCESS_ONCE with READ_ONCE
  x86/xen/p2m: Replace ACCESS_ONCE with READ_ONCE
  x86/spinlock: Leftover conversion ACCESS_ONCE->READ_ONCE
  mm/gup: Replace ACCESS_ONCE with READ_ONCE
  kernel: tighten rules for ACCESS ONCE
  kernel: Fix sparse warning for ACCESS_ONCE

Guenter Roeck (1):
  next: sh: Fix compile error

 arch/powerpc/kvm/book3s_hv_rm_xics.c |  8 ++++----
 arch/powerpc/kvm/book3s_xics.c       | 16 ++++++++--------
 arch/powerpc/mm/hugetlbpage.c        |  4 ++--
 arch/sh/mm/gup.c                     |  2 +-
 arch/x86/include/asm/spinlock.h      |  2 +-
 arch/x86/xen/p2m.c                   |  2 +-
 include/linux/compiler.h             | 21 ++++++++++++++++-----
 mm/gup.c                             |  2 +-
 8 files changed, 34 insertions(+), 23 deletions(-)

-- 
1.9.3
